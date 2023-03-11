import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';

import 'package:gamicolpaner/model/score.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/scoreCards.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*NIVEL TIPO GAMIDROP
  Este nivel consiste en leer y arrastrar un concepto a su enunciado correspondiente.
  El jugador deberá situar correctamente cada elemento para ganar puntos.

  El sistema validará la respuesta seleccionada aumentando el puntaje iterativo.

*/

class level4 extends StatefulWidget {
  const level4({Key? key}) : super(key: key);

  @override
  State<level4> createState() => _level4State();
}

//font code: https://youtu.be/KOh6CkX-d6U

class _level4State extends State<level4> {
  String _modulo = '';

  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  final Map<String, bool> score = {};

  final Map choices = {
    'GET': 'realiza una petición a un recurso específico',
    'POST': 'puede enviar datos al servidor por medio del cuerpo (body)',
    'PUT': 'puede ser ejecutado varias veces y tiene el mismo efecto',
    'DELETE': ' permite eliminar un recurso específico',
    'PATCH':
        'se emplea para modificaciones parciales de un recurso en particular',
    'HEAD': ' no retorna ningún contenido HTTP Response',
    'GETU': 'realiza una petición a un recurso específico',
    'POSTE': 'puede enviar datos al servidor por medio del cuerpo (body)',
    'PUTA': 'puede ser ejecutado varias veces y tiene el mismo efecto',
    'DELETEWE': ' permite eliminar un recurso específico',
  };

  Map<String, String> sixChoices = {};

  @override
  void initState() {
    super.initState();
    _startCountdown();
    final List<MapEntry<String, String>> choicesList = choices.entries
        .map((entry) => MapEntry(entry.key.toString(), entry.value.toString()))
        .toList();

    final Random random = Random();
    sixChoices = Map.fromEntries(List.generate(
      6,
      (_) => choicesList[random.nextInt(choicesList.length)],
    ));
  }

  int seed = 0;

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

  int intentos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //divider
          Positioned(
            top: -470,
            left: 5,
            right: 5,
            bottom: 100,
            child: Container(
              child: const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
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
                    Navigator.pop(context);
                    Navigator.push(
                        context,
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
                            }));
                  },
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                height: 82.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    scoreBoard1("Intentos", "$intentos/6"),
                    scoreBoard1("Puntos", "${score.length}")
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(1, 120, 1, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: sixChoices.keys.map((conceptoAfirmacion) {
                      return Draggable<String>(
                        data: conceptoAfirmacion,
                        feedback: ConceptoAfirmacion(
                          conceptoAfirmacion: conceptoAfirmacion,
                        ),
                        childWhenDragging:
                            const ConceptoAfirmacion(conceptoAfirmacion: '🧐'),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            ////  ////  ////  //// CONCEPT INSIDE CARD LEFT
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                            color: colors_colpaner.oscuro,
                            child: ConceptoAfirmacion(
                                //if concept is correct at draw, then show check emoti in left cards
                                conceptoAfirmacion:
                                    score[conceptoAfirmacion] == true
                                        ? '✅'
                                        : conceptoAfirmacion),
                          ),
                        ),
                      );
                    }).toList()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: sixChoices.keys
                      .map((conceptoAfirmacion) =>
                          _buildDragTarget(conceptoAfirmacion))
                      .toList()
                    ..shuffle(Random(seed)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragTarget(conceptoAfirmacion) {
    return DragTarget<String>(
        builder: (BuildContext context, List<String?> incoming, List rejected) {
          if (score[conceptoAfirmacion] == true) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                color: Colors.green,
                alignment: Alignment.center,
                height: 80,
                width: 200,
                child: const Text(
                  'Correcto!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'BubblegumSans'),
                ),
              ),
            );
          } else {
            ////  ////  //////text cards answers
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                color: colors_colpaner.claro,
                height: 100,
                width: 200,
                child: Text(
                  sixChoices[conceptoAfirmacion]!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'BubblegumSans'),
                ),
              ),
            );
          }
        },
        onWillAccept: (data) => data == conceptoAfirmacion,
        onAccept: (data) {
          setState(() {
            score[conceptoAfirmacion] = true;
            //game over, si el usuario complet+o las 5 palabras, se genera su score y se cierra el nivel
            if (score.length == 5) {
              DialogHelper.showDialogGameOver(
                  context, 6); //gana 5 puntos si alcanzó a completar || SCORE
            }
          });
        },
        onLeave: (data) {});
  }
}

class ConceptoAfirmacion extends StatelessWidget {
  const ConceptoAfirmacion({Key? key, required this.conceptoAfirmacion})
      : super(key: key);

  final String conceptoAfirmacion;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          alignment: Alignment.centerLeft,
          height: 50,
          padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              conceptoAfirmacion,
              style: const TextStyle(
                  //color text left csrds
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'BubblegumSans'),
            ),
          )),
    );
  }
}
