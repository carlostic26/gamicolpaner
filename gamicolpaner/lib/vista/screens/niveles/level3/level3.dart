import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/modulo.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/scoreCards.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/utils/level3_game.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/widget/letter.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/widget/level3_figure_image.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class level3 extends StatefulWidget {
  const level3({Key? key}) : super(key: key);
  @override
  State<level3> createState() => _level3State();
}

/*NIVEL TIPO AHORCADO
  Este nivel consiste en hacer leer un enunciado y escribir cada letra de forma correcta
  El jugador deberá adivinar el concepto completo.

  El sistema validará la respuesta seleccionada pintando en pantalla cada parte del personaje.

*/

TextStyle customTextStyle = const TextStyle(
  fontFamily: 'BubblegumSans',
  fontSize: 24,
  color: Colors.white,
);

class _level3State extends State<level3> {
  String modulo = '';

  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      modulo = prefs.getString('modulo') ?? '';
    });
  }

  String _message = "";
  int _timeLeft = 6;

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_timeLeft > 1) {
        setState(() {
          _timeLeft--;
          switch (_timeLeft) {
            case 4:
              _message = "Comenzamos en";
              break;
            case 3:
              _message = "3...";
              break;
            case 2:
              _message = "2...";
              break;
            case 1:
              _message = "1...";
              break;
            default:
              _message = "¿Preparado?";
          }
        });
        _startCountdown();
      } else {
        setState(() {
          _message = "¡Empecemos!";
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _message = "";
          });
        });
      }
    });
  }

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

  String afirmacion = "";
  String word = "entidad".toUpperCase();

  int numIntentosMax = 0;
  int numIntentos = 0;
  bool gameover = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    afirmacion =
        'En la arquitectura modelo-vista-controlador (MVC) los objetos del mundo del problema se representan mediante clases de tipo';
    //El siguiente string, contendrá la palabra clave que será la que tendra que adivinar e ingresar el usuario en el juego

    Set wordSinRepetidos = Set.from(word.split(''));
    int countWordSinRepetidos = wordSinRepetidos.length;

    //numero de intentos es el numero de letras sin repetir + 3
    numIntentosMax = countWordSinRepetidos + 3;

    _startCountdown();
    gameover = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Stack(
        children: [
          SizedBox(
            //dimension de ancho y alto de pantalla
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Center(
                        child: Text(
                          "El Ahorcado",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontFamily: 'BubblegumSans',
                            fontWeight: FontWeight.bold,
                            color: colors_colpaner.claro,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          scoreBoard1(
                              "Intentos", "$numIntentos/$numIntentosMax"),
                          scoreBoard1("Puntos", "${Game3.succes}")
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      //texto de afirmación
                      Positioned(
                        top: 20,
                        left: -10,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
                          child: Text(
                            afirmacion,
                            style: const TextStyle(
                                color: colors_colpaner.claro,
                                fontSize: 15,
                                fontFamily: 'BubblegumSans'),
                          ),
                        ),
                      ),

                      Center(
                        child: Stack(
                          //corresponde a cada imagen de parte de cuerpo del personaje de ahorcado
                          children: [
                            figureImage(Game3.tries >= 0,
                                "assets/games/level3/hang.png"),
                            figureImage(Game3.tries >= 1,
                                "assets/games/level3/head.png"),
                            figureImage(Game3.tries >= 2,
                                "assets/games/level3/body.png"),
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
                      const SizedBox(
                        height: 20.0,
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
                          padding: const EdgeInsets.all(8.0),
                          children: alphabets.map((e) {
                            return RawMaterialButton(
                                onPressed: Game3.selectedChar.contains(e)
                                    ? null // Se valida si no se ha seleccionado el botón anterior
                                    : () {
                                        setState(() {
                                          numIntentos++;

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

                                          //si falla mas de lo debido
                                          if (numIntentos == numIntentosMax) {
                                            //Opcional, enviar como parametro respuesta correcta y mostrar en ese dialogo
                                            DialogHelper.showDialogGameOver(
                                                context,
                                                Game3.succes
                                                    .toString()); //gana 0 puntos si perdió el nivel || SCORE

                                            //guarda puntaje de nivel en firestore
                                            _guardarPuntajeNivel3(Game3.succes);

                                            setState(() {
                                              numIntentos = 0;
                                              gameover = true;
                                              Game3.tries = 0;
                                              Game3.succes = 0;
                                              Game3.selectedChar.clear();
                                            });
                                          }

                                          // y si se logra el llenado de las letras minimas completas entonces
                                          // if Game3.succes >= afirmacion.length
                                          if (Game3.succes == word.length - 1) {
                                            //guarda puntaje de nivel en firestore
                                            _guardarPuntajeNivel3(Game3.succes);

                                            DialogHelper.showDialogGameOver(
                                                context,
                                                Game3.succes
                                                    .toString()); //gana 5 puntos si alcanzó a completar || SCORE

                                            setState(() {
                                              numIntentos = 0;
                                              gameover = true;
                                              Game3.tries = 0;
                                              Game3.succes = 0;
                                              Game3.selectedChar.clear();
                                            });
                                          }
                                        });
                                      },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Game3.selectedChar.contains(e)
                                    ? colors_colpaner.base
                                    : colors_colpaner.oscuro,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                      //COLOR TEXT BOARD
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BubblegumSans'),
                                )); //color red normal
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          //flecha atras
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: ShakeWidgetX(
                child: IconButton(
                  icon: Image.asset('assets/flecha_left.png'),
                  iconSize: 3,
                  onPressed: () {
                    setState(() {
                      numIntentos = 0;
                      gameover = true;
                      Game3.tries = 0;
                      Game3.succes = 0;
                      Game3.selectedChar.clear();
                    });

                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                          transitionDuration: const Duration(seconds: 1),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimation,
                              Widget child) {
                            animation = CurvedAnimation(
                                parent: animation, curve: Curves.elasticOut);

                            return ScaleTransition(
                              alignment: Alignment.center,
                              scale: animation,
                              child: child,
                            );
                          },
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimattion) {
                            return const world_game();
                          }),
                    );
                  },
                ),
              ),
            ),
          ),

          if (_message != "")
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: 1,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                    child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      _message,
                      style: customTextStyle,
                    ),
                  ),
                )),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _guardarPuntajeNivel3(int score) async {
    final user = FirebaseAuth.instance.currentUser;
    final puntaje = score; // Puntaje obtenido

    //obtiene el modulo del shp
    String modulo = await getModulo();

    if (modulo == 'Matemáticas') {
      //guarda puntaje en firestore
      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('matematicas')
          .collection('nivel3')
          .doc(user!.uid);

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (modulo == 'Inglés') {
      //guarda puntaje en firestore
      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ingles')
          .collection('nivel3')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }
  }
}
