import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/model/dbhelper.dart';
import 'package:gamicolpaner/model/score.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/utils/level3_game.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/widget/letter.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/widget/level4_figure_image.dart';
import 'package:soundpool/soundpool.dart';

class level3 extends StatefulWidget {
  final String modulo;
  const level3({required this.modulo, Key? key}) : super(key: key);
  @override
  State<level3> createState() => _level3State();
}

/*NIVEL TIPO AHORCADO
  Este nivel consiste en hacer leer un enunciado y escribir cada letra de forma correcta
  El jugador deberá adivinar el concepto completo.

  El sistema validará la respuesta seleccionada pintando en pantalla cada parte del personaje.

*/

class _level3State extends State<level3> {
  //El siguiente string, contendrá la palabra clave a ingresar en el juego
  String word = "entidad".toUpperCase();

  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "Ñ",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  bool gameover = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gameover = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 233, 230),
      body: SizedBox(
        //dimension de ancho y alto de pantalla candy crush
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            //flecha atras
            Positioned(
                top: 20,
                left: -10,
                child: ShakeWidgetX(
                  child: IconButton(
                    icon: Image.asset('assets/flecha_left.png'),
                    iconSize: 50,
                    onPressed: () {
                      _soundBack();
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: const Duration(seconds: 1),
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secAnimation,
                                  Widget child) {
                                animation = CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.elasticOut);

                                return ScaleTransition(
                                  alignment: Alignment.center,
                                  scale: animation,
                                  child: child,
                                );
                              },
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secAnimattion) {
                                return const entrenamientoModulos();
                              }));
                    },
                  ),
                )),

            //banner superior
            Positioned(
              top: -195,
              left: 90,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 180,
                    height: 500,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/games/general/bannerGamiAhorcado.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Positioned(
                  top: 20,
                  left: -10,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 70, 20, 2),
                    child: Text(
                      'En la arquitectura modelo-vista-controlador (MVC) los objetos del mundo del problema se representan mediante clases de tipo',
                      style: TextStyle(fontSize: 21, fontFamily: 'ZCOOL'),
                    ),
                  ),
                ),

                Center(
                  child: Stack(
                    children: [
                      figureImage(
                          Game3.tries >= 0, "assets/games/level3/hang.png"),
                      figureImage(
                          Game3.tries >= 1, "assets/games/level3/head.png"),
                      figureImage(
                          Game3.tries >= 2, "assets/games/level3/body.png"),
                      figureImage(
                          Game3.tries >= 3, "assets/games/level3/ra.png"),
                      figureImage(
                          Game3.tries >= 4, "assets/games/level3/la.png"),
                      figureImage(
                          Game3.tries >= 5, "assets/games/level3/rl.png"),
                      figureImage(
                          Game3.tries >= 6, "assets/games/level3/ll.png"),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: word
                      .split('')
                      .map((e) => letter(e.toUpperCase(),
                          !Game3.selectedChar.contains(e.toUpperCase())))
                      .toList(),
                ),

                //building the Game keyboard
                SizedBox(
                  width: double.infinity,
                  height: 250.0,
                  child: GridView.count(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    padding: EdgeInsets.all(8.0),
                    children: alphabets.map((e) {
                      return RawMaterialButton(
                          onPressed: Game3.selectedChar.contains(e)
                              ? null // Se valida si no se ha seleccionado el botón anterior
                              : () {
                                  setState(() {
                                    Game3.selectedChar.add(e);
                                    print(Game3.selectedChar);
                                    if (!word
                                        .split('')
                                        .contains(e.toUpperCase())) {
                                      Game3.tries++;
                                    }

                                    //si la palabra escrita está en las cajas entonces aumenta numero de exitos
                                    if (word
                                        .split('')
                                        .contains(e.toUpperCase())) {
                                      Game3.succes++;
                                    }

                                    //GAME OVER

                                    //si se tienen mas de 6 intentos fallidos
                                    if (Game3.tries >= 6) {
                                      String puntoPartida = 'ds';
                                      //Opcional, enviar como parametro respuesta correcta y mostrar en ese dialogo
                                      DialogHelper.showDialogGameOver(
                                          context,
                                          0,
                                          puntoPartida); //gana 0 puntos si perdió el nivel || SCORE
                                    }

                                    //GAMEOVER Se carga la información de puntaje a la base de datos logrando actualizar todo el campo del registro de puntaje correspondiente al nivel
                                    var handler = DatabaseHandler();
                                    handler.updateScore(scoreColpaner(
                                        id: 'DS4',
                                        modulo: 'DS',
                                        nivel: '4',
                                        score: 0.toString()));

                                    // y si se logra el llenado de las letras minimas completas entonces
                                    if (Game3.succes >= 6) {
                                      //Opcional, enviar como parametro respuesta correcta y mostrar en ese dialogo
                                      String puntoPartida = 'ds';
                                      DialogHelper.showDialogGameOver(
                                          context,
                                          Game3.succes.toString(),
                                          puntoPartida); //gana 5 puntos si alcanzó a completar || SCORE

                                      // Se carga la información de puntaje a la base de datos logrando actualizar todo el campo del registro de puntaje correspondiente al nivel
                                      var handler = DatabaseHandler();
                                      handler.updateScore(scoreColpaner(
                                          id: 'DS4',
                                          modulo: 'DS',
                                          nivel: '4',
                                          score: Game3.succes.toString()));
                                    }
                                  });
                                },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            e,
                            style: const TextStyle(
                              //COLOR TEXT BOARD
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          fillColor: Game3.selectedChar.contains(e)
                              ? const Color.fromARGB(
                                  255, 61, 13, 4) //color red dark
                              : const Color.fromARGB(
                                  255, 199, 55, 30)); //color red normal
                    }).toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _soundBack() async {
  Soundpool pool = Soundpool(streamType: StreamType.notification);
  int soundId = await rootBundle
      .load("assets/soundFX/buttonBack.wav")
      .then((ByteData soundData) {
    return pool.load(soundData);
  });
  int streamId = await pool.play(soundId);
}
