import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/puntajes_shp.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/niveles/level1/level1_quiz.dart';
import 'package:gamicolpaner/vista/screens/niveles/level10/simulacro.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/level2.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/level3.dart';
import 'package:gamicolpaner/vista/screens/niveles/level4/level4.dart';
import 'package:gamicolpaner/vista/screens/niveles/level5/level5_quiz.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class world_game extends StatefulWidget {
  const world_game({Key? key}) : super(key: key);

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

  //recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  String _imageUrl =
      'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw';

  //recibe el avatar imageUrl guardado anteriormente en sharedPreferences
  void _getAvatarFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageUrl = prefs.getString('imageUrl') ??
          'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw';
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getAvatarFromSharedPrefs();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getModuloFromSharedPrefs();
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
    //----- INGLES
    getPuntajeIngles1_firestore();
    getPuntajeIngles2_firestore();
    getPuntajeIngles3_firestore();
    //----- MATEM
    getPuntajeMat1_firestore();
    getPuntajeMat2_firestore();
    getPuntajeMat3_firestore();
  }

  //funcion que busca el nivel 1, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat1_firestore() async {
    int puntajeMatNivel1 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel1')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel1 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_1', puntajeMatNivel1.toString());

    return puntajeMatNivel1;
  }

//----2
  //funcion que busca el nivel 2, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat2_firestore() async {
    int puntajeMatNivel2 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel2')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel2 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_2', puntajeMatNivel2.toString());

    return puntajeMatNivel2;
  }

  //--3
  //funcion que busca el nivel 2, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat3_firestore() async {
    int puntajeMatNivel3 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel3')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel3 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_3', puntajeMatNivel3.toString());

    return puntajeMatNivel3;
  }

  //----------------------------- INGLES ----------------------------------
  //funcion que busca el nivel 1, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles1_firestore() async {
    int puntajeIngNivel1 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel1')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel1 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ingles_1', puntajeIngNivel1.toString());

    return puntajeIngNivel1;
  }

  //funcion que busca el nivel 2, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles2_firestore() async {
    int puntajeIngNivel2 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel2')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel2 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('puntaje_ingles_2', puntajeIngNivel2.toString());
      }
    }

    return puntajeIngNivel2;
  }

  //funcion que busca el nivel 3, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles3_firestore() async {
    int puntajeIngNivel3 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel3')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel3 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('puntaje_ingles_3', puntajeIngNivel3.toString());
      }
    }

    return puntajeIngNivel3;
  }

  @override
  Widget build(BuildContext context) {
    _getAvatarFromSharedPrefs();
    final double totalWidth = MediaQuery.of(context).size.width;
    final double cellWidth = (totalWidth - 16) / 3;
    final double cellHeight = 40 / 3 * cellWidth;
    return Scaffold(
        appBar: null,
        body: Center(
          child: Stack(
            children: [
              //img fondo
              CachedNetworkImage(
                fadeInDuration: Duration.zero,
                imageUrl:
                    'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg5Q4hvD_1Mg-3b4w0_w4rnkdo8iHWn1Pp2hLCbKLnnW4eUPY1LnmKF20V0zcIMNSJHSDUgqvVBNJqOodIeVRG87TewfsawutA9AdVEJpYxFVhBCoSpo6sVGKGe6uOLXG2KyuxYYR218nXHid185Agcdc-RkbrYrnw0FB3WWX7HBgs8kxesCJCf8k0/s16000/solo%20ruta%203.png',
                height: MediaQuery.of(context).size.height * 1.0,
                width: MediaQuery.of(context).size.width * 1.0,
                fit: BoxFit.fill,
              ),

              //banner superior
              Positioned(
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

                      //image avatar
                      Positioned(
                        top: 372,
                        left: MediaQuery.of(context).size.width * 0.40,
                        child: Container(
                            padding: const EdgeInsets.all(1.0),
                            width: 70,
                            height: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                width: cellWidth,
                                height: cellHeight,
                                child: CachedNetworkImage(
                                  imageUrl: _imageUrl,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      ),
                      Positioned(
                        left: totalWidth * 0.12,
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
                            /*  Text(
                              loggedInUser.tecnica.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'BubblegumSans',
                                fontSize: 13,
                              ),
                            ), */
                            Text(
                              _modulo,
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
                              FutureBuilder<int>(
                                future: _modulo == 'Matemáticas'
                                    ? getPuntajesTotal_MAT()
                                    : _modulo == 'Inglés'
                                        ? getPuntajesTotal_ING()
                                        : getPuntajesTotal_MAT(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<int> snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'BubblegumSans',
                                        fontSize: 13,
                                      ),
                                    );
                                  } else {
                                    return const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child:
                                            CircularProgressIndicator()); // O cualquier otro indicador de carga
                                  }
                                },
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
                                transitionDuration: const Duration(seconds: 1),
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

                      showDialogLevel(10);
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
                      showDialogLevel(5);
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
                      showDialogLevel(4);
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
    String imageLvl4 =
        'https://developer.android.com/static/images/guide/topics/ui/drag-and-drop-between-apps.gif?hl=es-419';
    String imageLvl5 =
        'https://blogger.googleusercontent.com/img/a/AVvXsEjTy5Oytt0iwUvfxK4rm2nGlFjPENSj1kk-2bwqYAM1rzPtncL68VR9eUYTK9vbyByREPPtdGUAUupeM8f_CD5KsmgZbJe8k3WAw4--qhFxpcpFgGqsq1u2saxiui1FfP704AjtaBlGlSOsrpi31Upev6OA5612vSGY23eh7wAS24TGlS8hUHxHa6s=s16000';

    String imageLvl6 = '';
    String imageLvl7 = '';
    String imageLvl8 = '';
    String imageLvl9 = '';
    String imageLvl10 =
        'https://blogger.googleusercontent.com/img/a/AVvXsEj_3Z1kqIpcWZZpGfyXAb9t0fEB0CLZ3jWyVyOZn_jgvYnocpT3Ayj8YKWio-LnlYr0MODwboL1397Cnjs8XVHFHnpAK7nALOPyP-GmWbBVhxg8nc3DHopcHtYluoPBV0no2U7EoZofmi8tH2K8Q3XG6-Fp39XnoZhKX0L-2zMqtNnbW0TpuZzwcmg';

    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: NetworkGiffDialog(
                image: CachedNetworkImage(
                  imageUrl: level == 1
                      ? imageLvl1
                      : level == 2
                          ? imageLvl2
                          : level == 3
                              ? imageLvl3
                              : level == 4
                                  ? imageLvl4
                                  : level == 5
                                      ? imageLvl5
                                      : level == 6
                                          ? imageLvl6
                                          : level == 7
                                              ? imageLvl7
                                              : level == 8
                                                  ? imageLvl8
                                                  : level == 9
                                                      ? imageLvl9
                                                      : level == 10
                                                          ? imageLvl10
                                                          : imageLvl10,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                title: level == 1
                    ? const Text(
                        'Nivel 1',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'BubblegumSans',
                            fontWeight: FontWeight.w600),
                      )
                    : level == 2
                        ? const Text(
                            'Nivel 2',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'BubblegumSans',
                                fontWeight: FontWeight.w600),
                          )
                        : level == 3
                            ? const Text(
                                'Nivel 3',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'BubblegumSans',
                                    fontWeight: FontWeight.w600),
                              )
                            : level == 4
                                ? const Text(
                                    'Nivel 4',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'BubblegumSans',
                                        fontWeight: FontWeight.w600),
                                  )
                                : level == 5
                                    ? const Text(
                                        'Nivel 5',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'BubblegumSans',
                                            fontWeight: FontWeight.w600),
                                      )
                                    : level == 6
                                        ? const Text(
                                            'Nivel 6',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'BubblegumSans',
                                                fontWeight: FontWeight.w600),
                                          )
                                        : level == 7
                                            ? const Text(
                                                'Nivel 7',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'BubblegumSans',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : level == 8
                                                ? const Text(
                                                    'Nivel 8',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'BubblegumSans',
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
                                                            fontFamily:
                                                                'BubblegumSans',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    : level == 10
                                                        ? const Text(
                                                            'Simulacro',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'BubblegumSans',
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
                            fontSize: 15, fontFamily: 'BubblegumSans'),
                      )
                    : level == 2
                        ? const Text(
                            'En este nivel tendrás que prestar mucha atencion a la afirmación de cada tarjeta. Tu tarea es entenderlas y hacer que coincidan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'BubblegumSans'),
                          )
                        : level == 3
                            ? const Text(
                                'En este nivel tendrás que leer una afirmación y escribir la palabra exacta que la define. Tienes un número limitado de intentos.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'BubblegumSans'),
                              )
                            : level == 4
                                ? const Text(
                                    'En este nivel tendrás que leer conceptos y asociarlos con la respuesta correcta. Tienes un numero limite de intentos.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'BubblegumSans'),
                                  )
                                : level == 5
                                    ? const Text(
                                        'En este nivel realizarás un quiz intermedio sobre la usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'BubblegumSans'),
                                      )
                                    : level == 6
                                        ? const Text(
                                            'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'BubblegumSans'),
                                          )
                                        : level == 7
                                            ? const Text(
                                                'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        'BubblegumSans'),
                                              )
                                            : level == 8
                                                ? const Text(
                                                    'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            'BubblegumSans'),
                                                  )
                                                : level == 9
                                                    ? const Text(
                                                        'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'BubblegumSans'),
                                                      )
                                                    : level == 10
                                                        ? const Text(
                                                            'Este es el último nivel de GamiColpaner.\n\n Realizarás el simulacro del modulo correspondiente pero esta vez no podrás ver al instante las opciones correctas o incorrectas. \n\nTienes x minutos para terminar.',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'BubblegumSans'),
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
                          int scoreTot = 0;

                          return level == 1
                              ? const level1Quiz()
                              : level == 2
                                  ? const level2()
                                  : level == 3
                                      ? const level3()
                                      : level == 4
                                          ? const level4()
                                          : level == 5
                                              ? const level5Quiz()
                                              : level == 6
                                                  ? const level1Quiz()
                                                  : level == 7
                                                      ? const level1Quiz()
                                                      : level == 8
                                                          ? const level1Quiz()
                                                          : level == 9
                                                              ? const level1Quiz()
                                                              : level == 10
                                                                  ? const simulacro()
                                                                  : const world_game();
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
