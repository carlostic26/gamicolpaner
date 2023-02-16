import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/model/dbhelper.dart';
import 'package:gamicolpaner/model/score.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundpool/soundpool.dart';

/*NIVEL TIPO GAMIDROP
  Este nivel consiste en leer y arrastrar un concepto a su enunciado correspondiente.
  El jugador deberá situar correctamente cada elemento para ganar puntos.

  El sistema validará la respuesta seleccionada aumentando el puntaje iterativo.

*/

class level4 extends StatefulWidget {
  final String modulo;
  const level4({required this.modulo, Key? key}) : super(key: key);

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
  };

  int seed = 0;

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
                              return world_game(
                                modulo: _modulo,
                              );
                            }));
                  },
                ),
              ),
            ),
          ),
          //banner superior
          Positioned(
            top: -43,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(1.0),
                  width: 160,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("assets/games/general/bannerGamiDrop.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),

//Puntaje de juego respectivo
          Positioned(
            top: 83,
            child: Container(
              width: 300,
              alignment: Alignment.topRight,
              child: Text(
                'Score: ${score.length} / 6',
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'BubblegumSans',
                    color: colors_colpaner.oscuro),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(1, 105, 1, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: choices.keys.map((conceptoAfirmacion) {
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
                  children: choices.keys
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
                      fontSize: 25,
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
                  choices[conceptoAfirmacion],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
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
              DialogHelper.showDialogGameOver(context, 5,
                  'ds'); //gana 5 puntos si alcanzó a completar || SCORE
              // Se carga la información de puntaje a la base de datos logrando actualizar todo el campo del registro de puntaje correspondiente al nivel
              var handler = DatabaseHandler();
              handler.updateScore(scoreColpaner(
                  id: 'DS6',
                  modulo: 'DS',
                  nivel: '6',
                  score: score.length.toString()));
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
                  fontSize: 20,
                  fontFamily: 'BubblegumSans'),
            ),
          )),
    );
  }
}
