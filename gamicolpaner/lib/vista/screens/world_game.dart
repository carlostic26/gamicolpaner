import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/niveles/level1/level1_quiz.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/level2.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/level3.dart';
import 'package:giff_dialog/giff_dialog.dart';

class world_game extends StatefulWidget {
  final String modulo;

  const world_game({required this.modulo, Key? key}) : super(key: key);

  @override
  State<world_game> createState() => _world_gameState();
}

class _world_gameState extends State<world_game> {
  String _modulo = '';

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late Image button1,
      button2,
      button3,
      button4,
      button5,
      button6,
      button7,
      button8,
      button9,
      button10;

  Image buttonPressed = Image.asset(
    'assets/button/button_pushed.png',
  );
  Image buttonUnpressed = Image.asset(
    'assets/button/button_unpushed.png',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modulo = widget.modulo;
    button1 = buttonUnpressed;
    button2 = buttonUnpressed;
    button3 = buttonUnpressed;
    button4 = buttonUnpressed;
    button5 = buttonUnpressed;
    button6 = buttonUnpressed;
    button7 = buttonUnpressed;
    button8 = buttonUnpressed;
    button9 = buttonUnpressed;
    button10 = buttonUnpressed;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Center(
          child: Expanded(
            child: Stack(
              //alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  //imagen de fonto
                  imageUrl:
                      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg5Q4hvD_1Mg-3b4w0_w4rnkdo8iHWn1Pp2hLCbKLnnW4eUPY1LnmKF20V0zcIMNSJHSDUgqvVBNJqOodIeVRG87TewfsawutA9AdVEJpYxFVhBCoSpo6sVGKGe6uOLXG2KyuxYYR218nXHid185Agcdc-RkbrYrnw0FB3WWX7HBgs8kxesCJCf8k0/s16000/solo%20ruta%203.png',
                  //height: 1000,

                  //dimension de llenado ancho y alto de pantalla candy crush
                  height: MediaQuery.of(context).size.height * 1.0,
                  width: MediaQuery.of(context).size.width * 1.0,

                  fit: BoxFit.fill,
                ),

                //banner superior
                Positioned(
                    //height: MediaQuery.of(context).size.height * 1.0,
                    top: -320,
                    child: ShakeWidgetY(
                      child:
                          Stack(alignment: Alignment.center, children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(1.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/banner_user.png"),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 374,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(1, 50, 1, 1),
                            width: 58,
                            height: 60,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'http://gamilibre.com/imagenes/user.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                loggedInUser.fullName.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 14),
                              ),
                              Text(
                                loggedInUser.tecnica.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'BubblegumSans',
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 60,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 1, 1),
                            child: Column(
                              children: [
                                const Text(
                                  "Puntaje total",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'BubblegumSans',
                                      fontSize: 13),
                                ),
                                //SizedBox(height: 5),
                                Text(
                                  loggedInUser.sumScoreDS.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    )),

                //btn regresar
                Positioned(
                    bottom: 20,
                    left: -5,
                    child: ShakeWidgetX(
                      child: IconButton(
                        icon: Image.asset('assets/flecha_left.png'),
                        iconSize: 50,
                        onPressed: () {
                          //_soundBack();
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(seconds: 1),
                                  transitionsBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secAnimation,
                                      Widget child) {
                                    animation = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.elasticInOut);

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

                //btn 10
                Positioned(
                  top: 110,
                  right: 115,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 100,
                    height: 100,
                    child: GestureDetector(
                      child: button10, //color of button
                      onTapDown: (tap) {
                        //_soundbutton();
                        setState(() {
                          // when it is pressed
                          button10 = buttonPressed;
                        });
                      },
                      onTapUp: (tap) {
                        setState(() {
                          // when it is released
                          button10 = buttonUnpressed;
                        });

                        //DialogHelper.showDialoglevel10DS(context);
                      },
                    ),
                  ),
                ),

                //btn 9
                Positioned(
                  top: 200,
                  left: 65,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 65,
                    height: 65,
                    child: GestureDetector(
                      child: button9, //color of button
                      onTapDown: (tap) {
                        //_soundbutton();
                        setState(() {
                          // when it is pressed
                          button9 = buttonPressed;
                        });
                      },
                      onTapUp: (tap) {
                        setState(() {
                          // when it is released
                          button9 = buttonUnpressed;
                        });

                        //DialogHelper.showDialogLevel9DS(context);
                      },
                    ),
                  ),
                ),

                //btn 8
                Positioned(
                  top: 275,
                  left: 90,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 70,
                    height: 70,
                    child: GestureDetector(
                      child: button8, //color of button
                      onTapDown: (tap) {
                        //_soundbutton();
                        setState(() {
                          // when it is pressed
                          button8 = buttonPressed;
                        });
                      },
                      onTapUp: (tap) {
                        setState(() {
                          // when it is released
                          button8 = buttonUnpressed;
                        });

                        //DialogHelper.showDialogLevel8DS(context);
                      },
                    ),
                  ),
                ),

                //btn 7
                Positioned(
                  top: 275,
                  right: 90,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 72,
                    height: 72,
                    child: GestureDetector(
                      child: button7, //color of button
                      onTapDown: (tap) {
                        //_soundbutton();
                        setState(() {
                          // when it is pressed
                          button7 = buttonPressed;
                        });
                      },
                      onTapUp: (tap) {
                        setState(() {
                          // when it is released
                          button7 = buttonUnpressed;
                        });

                        //DialogHelper.showDialogLevel7DS(context);
                      },
                    ),
                  ),
                ),

                //btn 6
                Positioned(
                  top: 330,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 78,
                    height: 78,
                    child: GestureDetector(
                      child: button6, //color of button
                      onTapDown: (tap) {
                        //_soundbutton();
                        setState(() {
                          // when it is pressed
                          button6 = buttonPressed;
                        });
                      },
                      onTapUp: (tap) {
                        setState(() {
                          // when it is released
                          button6 = buttonUnpressed;
                        });

                        //DialogHelper.showDialogLevel6DS(context);
                      },
                    ),
                  ),
                ),

                //btn 5
                Positioned(
                  bottom: 330,
                  left: 150,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 85,
                    height: 85,
                    child: GestureDetector(
                      child: button5,
                      onTapDown: (tap) {
                        //_soundbutton();
                        setState(() {
                          // when it is pressed
                          button5 = buttonPressed;
                        });
                      },
                      onTapUp: (tap) {
                        setState(() {
                          // when it is released
                          button5 = buttonUnpressed;
                        });

                        //DialogHelper.showDialogLevel4DS(context);
                      },
                    ),
                  ),
                ),

                //btn 4
                Positioned(
                  bottom: 320,
                  left: 25,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 87,
                    height: 87,
                    child: GestureDetector(
                      child: button4, //color of button
                      onTapDown: (tap) {
                        //_soundbutton();
                        setState(() {
                          // when it is pressed
                          button4 = buttonPressed;
                        });
                      },
                      onTapUp: (tap) {
                        setState(() {
                          // when it is released
                          button4 = buttonUnpressed;
                        });

                        //DialogHelper.showDialogLevel5DS(context);
                      },
                    ),
                  ),
                ),

                //btn 3
                Positioned(
                  bottom: 215,
                  left: 65,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 95,
                    height: 95,
                    child: GestureDetector(
                      child: button3,
                      onTapDown: (tap) {
                        //_soundbutton();
                        setState(() {
                          // when it is pressed
                          button3 = buttonPressed;
                        });
                      },
                      onTapUp: (tap) {
                        setState(() {
                          button3 = buttonUnpressed;
                        });

                        showDialogLevel(3);
                        //DialogHelper.showDialogLevel3DS(context);
                      },
                    ),
                  ),
                ),

                //btn 2
                Positioned(
                  bottom: 120,
                  right: 115,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 100,
                    height: 100,
                    child: GestureDetector(
                      child: button2,
                      onTapDown: (tap) {
                        //_soundbutton();
                        setState(() {
                          // when it is pressed
                          button2 = buttonPressed;
                        });
                      },
                      onTapUp: (tap) {
                        setState(() {
                          // when it is released
                          button2 = buttonUnpressed;
                        });

                        //DialogHelper.showDialogLevel2DS(context);
                        showDialogLevel(2);
                      },
                    ),
                  ),
                ),

                //btn inicial 1
                Positioned(
                  right: 75,
                  bottom: -15,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 10,
                    height: 150,
                    child: GestureDetector(
                      child: button1,
                      onTapDown: (tap) {
                        setState(() {
                          // when it is pressed
                          button1 = buttonPressed;
                        });
                      },
                      onTapUp: (tap) {
                        //_soundbutton();

                        setState(() {
                          // when it is released
                          button1 = buttonUnpressed;
                        });

                        showDialogLevel(1);

                        //DialogHelper.showDialoglevel1DS(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  bool btn1Pressed = false;

  // ignore: non_constant_identifier_names
  void ChangedImageFunction() {
    Image.asset("assets/button_pushed.png");

    setState(() {
      btn1Pressed = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      Image.asset("assets/button_unpushed.png");
    });
  }

  void showDialogLevel(int level) {
    String imageLvl1 =
        'https://blogger.googleusercontent.com/img/a/AVvXsEjTy5Oytt0iwUvfxK4rm2nGlFjPENSj1kk-2bwqYAM1rzPtncL68VR9eUYTK9vbyByREPPtdGUAUupeM8f_CD5KsmgZbJe8k3WAw4--qhFxpcpFgGqsq1u2saxiui1FfP704AjtaBlGlSOsrpi31Upev6OA5612vSGY23eh7wAS24TGlS8hUHxHa6s=s16000';
    String imageLvl2 =
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2Z-aZWSpJfAT6p1ki7lhQrWW-qO5hRj6T4p0DDxrvx9WxNH5pH2a0CSRmYa4POVjKp4J5khGE17BmDhaNUsGo0QMpRPoL3HoDgc0WIqFxCsktAr9_s1D8oIVvlUoNs9_5tiNR3XcJvOqEWRBmEAbQK-BuypAjMRLUYIXj23MUK02i0uUNVMXprjs/s1600/MajesticIdioticArachnid-max-1mb.gif';
    String imageLvl3 =
        'http://pa1.narvii.com/6625/e90f6237ad16279bb59f3b3dea459eae44b831b5_00.gif';
    String imageLvl4 = '';
    String imageLvl5 = '';
    String imageLvl6 = '';
    String imageLvl7 = '';
    String imageLvl8 = '';
    String imageLvl9 = '';
    String imageLvl10 = '';

    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: NetworkGiffDialog(
                image: level == 1
                    ? Image.network(
                        imageLvl1,
                        fit: BoxFit.cover,
                      )
                    : level == 2
                        ? Image.network(
                            imageLvl2,
                            fit: BoxFit.cover,
                          )
                        : level == 3
                            ? Image.network(
                                imageLvl3,
                                fit: BoxFit.cover,
                              )
                            : level == 4
                                ? Image.network(
                                    imageLvl4,
                                    fit: BoxFit.cover,
                                  )
                                : level == 5
                                    ? Image.network(
                                        imageLvl5,
                                        fit: BoxFit.cover,
                                      )
                                    : level == 6
                                        ? Image.network(
                                            imageLvl6,
                                            fit: BoxFit.cover,
                                          )
                                        : level == 7
                                            ? Image.network(
                                                imageLvl7,
                                                fit: BoxFit.cover,
                                              )
                                            : level == 8
                                                ? Image.network(
                                                    imageLvl8,
                                                    fit: BoxFit.cover,
                                                  )
                                                : level == 9
                                                    ? Image.network(
                                                        imageLvl9,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : level == 10
                                                        ? Image.network(
                                                            imageLvl10,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.network('',
                                                            fit: BoxFit.cover),
                title: level == 1
                    ? const Text(
                        'Nivel 1',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )
                    : level == 2
                        ? const Text(
                            'Nivel 2',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        : level == 3
                            ? const Text(
                                'Nivel 3',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              )
                            : level == 4
                                ? const Text(
                                    'Nivel 4',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  )
                                : level == 5
                                    ? const Text(
                                        'Nivel 5',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : level == 6
                                        ? const Text(
                                            'Nivel 6',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : level == 7
                                            ? const Text(
                                                'Nivel 7',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : level == 8
                                                ? const Text(
                                                    'Nivel 8',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                : level == 9
                                                    ? const Text(
                                                        'Nivel 9',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    : level == 10
                                                        ? const Text(
                                                            'Nivel 10',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        : const Text(''),
                description: level == 1
                    ? const Text(
                        'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    : level == 2
                        ? const Text(
                            'En este nivel tendrás que prestar mucha atencion a la afirmación de cada tarjeta. Tu tarea es entenderlas y hacer que coincidan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        : level == 3
                            ? const Text(
                                'En este nivel tendrás que leer una afirmación y escribir la palabra exacta que la define. Tienes un número limitado de intentos.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            : level == 4
                                ? const Text(
                                    'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  )
                                : level == 5
                                    ? const Text(
                                        'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      )
                                    : level == 6
                                        ? const Text(
                                            'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          )
                                        : level == 7
                                            ? const Text(
                                                'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              )
                                            : level == 8
                                                ? const Text(
                                                    'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                : level == 9
                                                    ? const Text(
                                                        'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      )
                                                    : level == 10
                                                        ? const Text(
                                                            'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          )
                                                        : const Text(''),
                buttonOkText: const Text(
                  'Ir',
                  style: TextStyle(color: Colors.white),
                ),
                buttonCancelText: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white),
                ),
                buttonOkColor: Colors.green,
                onOkButtonPressed: () async {
                  // Acciones al presionar el boton OK

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
                              parent: animation, curve: Curves.elasticInOut);

                          return ScaleTransition(
                            alignment: Alignment.center,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secAnimattion) {
                          return level == 1
                              ? level1Quiz(
                                  modulo: _modulo,
                                )
                              : level == 2
                                  ? level2(
                                      modulo: _modulo,
                                    )
                                  : level == 3
                                      ? level3(
                                          modulo: _modulo,
                                        )
                                      : level == 4
                                          ? level1Quiz(
                                              modulo: _modulo,
                                            )
                                          : level == 5
                                              ? level1Quiz(
                                                  modulo: _modulo,
                                                )
                                              : level == 6
                                                  ? level1Quiz(
                                                      modulo: _modulo,
                                                    )
                                                  : level == 7
                                                      ? level1Quiz(
                                                          modulo: _modulo,
                                                        )
                                                      : level == 8
                                                          ? level1Quiz(
                                                              modulo: _modulo,
                                                            )
                                                          : level == 9
                                                              ? level1Quiz(
                                                                  modulo:
                                                                      _modulo,
                                                                )
                                                              : level == 10
                                                                  ? level1Quiz(
                                                                      modulo:
                                                                          _modulo,
                                                                    )
                                                                  : world_game(
                                                                      modulo:
                                                                          _modulo);
                        }),
                  );
                }),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }
}
