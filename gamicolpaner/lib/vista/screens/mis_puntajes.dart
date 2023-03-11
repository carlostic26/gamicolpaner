import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/puntajes_shp.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/avatars_female.dart';
import 'package:gamicolpaner/vista/screens/avatars_male.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_screen.dart';

class misPuntajes extends StatefulWidget {
  const misPuntajes({super.key});

  @override
  State<misPuntajes> createState() => _misPuntajesState();
}

class _misPuntajesState extends State<misPuntajes> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  String _imageUrl = '';

  //recibe el avatar imageUrl guardado anteriormente en sharedPreferences
  void _getAvatarFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageUrl = prefs.getString('imageUrl') ??
          'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw';
    });
  }

  bool isAvatar = false;

  Future<bool> getIsAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    isAvatar = prefs.getBool('isAvatar') ?? false;
    setState(() {
      this.isAvatar = isAvatar;
    });
    return isAvatar;
  }

  String gender = '';

  Future<String> getGender() async {
    final prefs = await SharedPreferences.getInstance();
    String gender = prefs.getString('gender') ?? 'none';
    setState(() {
      this.gender = gender;
    });

    return gender;
  }

  final colors = [Colors.blue[800], Colors.blue[200]]; // Lista de colores

  int puntos_mat = 0;
  int puntos_ing = 0;
  int puntos_test = 5;
  final int puntosMaximos_test = 100;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //recibe el puntaje total del modulo mat y lo establece en variable para estitmar procentaje de progreso
    getPuntajesTotal_MAT().then((value) {
      setState(() {
        puntos_mat = value ?? 0;
      });
    });

    //recibe el puntaje total del modulo ming y lo establece en variable para estitmar procentaje de progreso
    getPuntajesTotal_ING().then((value) {
      setState(() {
        puntos_ing = value ?? 0;
      });
    });
  }

  @override
  void initState() {
    getIsAvatar();
    getGender();
    _getAvatarFromSharedPrefs();

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

    super.initState();
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
    final double porcentaje_mat =
        puntos_mat / puntosMaximos_test; // Calcular el porcentaje de progreso

    final double porcentaje_ing =
        puntos_ing / puntosMaximos_test; // Calcular el porcentaje de progreso

    final double porcentaje_test =
        puntos_test / puntosMaximos_test; // Calcular el porcentaje de progreso

    return Scaffold(
      backgroundColor: colors_colpaner.base,
      appBar: AppBar(
        title: const Text(
          "Mis Puntajes",
          style: TextStyle(
            fontSize: 16.0,
            color: colors_colpaner.claro,
            /*fontWeight: FontWeight.bold*/
            fontFamily: 'BubblegumSans',
          ),
        ),
        centerTitle: true,
        backgroundColor:
            Colors.transparent, // establece el color de fondo transparente
        elevation: 0, // elimina la sombra
        iconTheme: const IconThemeData(
            color: colors_colpaner
                .claro), // cambia el color del icono del botón de menú lateral a negro
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              //Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const misPuntajes()));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Puntos",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'BubblegumSans',
                      fontWeight: FontWeight.bold,
                      color: colors_colpaner.oscuro,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              //--- MIS PUNTAJES
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          const Text(
                            'Matemáticas',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          Row(
                            children: [
                              FutureBuilder<int>(
                                future: getPuntajesTotal_MAT(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<int> snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'BubblegumSans',
                                        fontWeight: FontWeight.bold,
                                        color: colors_colpaner.claro,
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
                              const Text(
                                '/100',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.claro,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          const Text(
                            'Inglés',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          Row(
                            children: [
                              FutureBuilder<int>(
                                future: getPuntajesTotal_ING(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<int> snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'BubblegumSans',
                                        fontWeight: FontWeight.bold,
                                        color: colors_colpaner.claro,
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
                              const Text(
                                '/100',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.claro,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: const [
                          Text(
                            'Inglés',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          Text(
                            '10/100',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: const [
                          Text(
                            'Inglés',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          Text(
                            '10/100',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: const [
                          Text(
                            'Inglés',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          Text(
                            '10/100',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: const [
                          Text(
                            'Inglés',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          Text(
                            '10/100',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Divider(
                thickness: 1,
                color: colors_colpaner.oscuro,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Progreso",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'BubblegumSans',
                      fontWeight: FontWeight.bold,
                      color: colors_colpaner.oscuro,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              //--- PROGRESO
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        children: [
                          const Text(
                            'Matemáticas',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          //SE MUESTRA UN CIRCULO PROGRESS BAR
                          const SizedBox(height: 10),
                          Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    strokeWidth:
                                        8, // Ancho del borde del círculo
                                    value: porcentaje_mat, // Valor de progreso
                                    backgroundColor: Colors.grey[
                                        300], // Color del fondo del círculo
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.blue), // Color del progreso
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      '${(porcentaje_mat * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: colors_colpaner.claro,
                                          fontFamily: 'BubblegumSans'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          const Text(
                            'Inglés',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          //SE MUESTRA UN CIRCULO PROGRESS BAR
                          const SizedBox(height: 10),
                          Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    strokeWidth:
                                        8, // Ancho del borde del círculo
                                    value: porcentaje_ing, // Valor de progreso
                                    backgroundColor: Colors.grey[
                                        300], // Color del fondo del círculo
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.blue), // Color del progreso
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      '${(porcentaje_ing * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: colors_colpaner.claro,
                                          fontFamily: 'BubblegumSans'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          const Text(
                            'Ciudadanas',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          //SE MUESTRA UN CIRCULO PROGRESS BAR
                          const SizedBox(height: 10),
                          Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    strokeWidth:
                                        8, // Ancho del borde del círculo
                                    value: porcentaje_test, // Valor de progreso
                                    backgroundColor: Colors.grey[
                                        300], // Color del fondo del círculo
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.blue), // Color del progreso
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      '${(porcentaje_test * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: colors_colpaner.claro,
                                          fontFamily: 'BubblegumSans'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          const Text(
                            'Naturales',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          //SE MUESTRA UN CIRCULO PROGRESS BAR
                          const SizedBox(height: 10),
                          Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    strokeWidth:
                                        8, // Ancho del borde del círculo
                                    value: porcentaje_test, // Valor de progreso
                                    backgroundColor: Colors.grey[
                                        300], // Color del fondo del círculo
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.blue), // Color del progreso
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      '${(porcentaje_test * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: colors_colpaner.claro,
                                          fontFamily: 'BubblegumSans'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          const Text(
                            'Matemáticas',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          //SE MUESTRA UN CIRCULO PROGRESS BAR
                          const SizedBox(height: 10),
                          Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    strokeWidth:
                                        8, // Ancho del borde del círculo
                                    value: porcentaje_test, // Valor de progreso
                                    backgroundColor: Colors.grey[
                                        300], // Color del fondo del círculo
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.blue), // Color del progreso
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      '${(porcentaje_test * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: colors_colpaner.claro,
                                          fontFamily: 'BubblegumSans'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          const Text(
                            'Matemáticas',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          //SE MUESTRA UN CIRCULO PROGRESS BAR
                          const SizedBox(height: 10),
                          Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    strokeWidth:
                                        8, // Ancho del borde del círculo
                                    value: porcentaje_test, // Valor de progreso
                                    backgroundColor: Colors.grey[
                                        300], // Color del fondo del círculo
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.blue), // Color del progreso
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      '${(porcentaje_test * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: colors_colpaner.claro,
                                          fontFamily: 'BubblegumSans'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              const Divider(
                thickness: 1,
                color: colors_colpaner.oscuro,
              ),

              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    "Ranking",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'BubblegumSans',
                      fontWeight: FontWeight.bold,
                      color: colors_colpaner.claro,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (int i = 0; i < 10; i++)
                          Container(
                            height: 30, // Altura de cada celda
                            color:
                                colors[i % 2], // Alternar colores de la lista
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

/*           //flecha atras
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: ShakeWidgetX(
                child: IconButton(
                  icon: Image.asset('assets/flecha_left.png'),
                  iconSize: 3,
                  onPressed: () {
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
                            return const entrenamientoModulos();
                          }),
                    );
                  },
                ),
              ),
            ),
          ), */
        ],
      ),
      drawer: _getDrawer(context),
    );
  }

  //NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    double drawer_height = MediaQuery.of(context).size.height;
    double drawer_width = MediaQuery.of(context).size.width;

    //firebase
    final user = FirebaseAuth.instance.currentUser!;

    String tecnicaElegida;

    return Drawer(
      width: drawer_width * 0.60,
      elevation: 0,
      child: Container(
        color: colors_colpaner.base,
        child: ListView(
          children: <Widget>[
            Container(
              //height: 150.0,
              alignment: Alignment.center,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 5.0),
                  CachedNetworkImage(
                    fadeInDuration: Duration.zero,
                    imageUrl: _imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(loggedInUser.fullName.toString(),
                        style: const TextStyle(
                            color: colors_colpaner.claro,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text('Técnica de ${loggedInUser.tecnica}',
                      style: const TextStyle(
                        color: colors_colpaner.claro,
                      )),
                  Text(loggedInUser.email.toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: colors_colpaner.claro,
                      )),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
            ListTile(
                title: const Text("Entrenamiento",
                    style: TextStyle(
                        color: colors_colpaner.oscuro,
                        fontWeight: FontWeight.bold)),
                leading: const Icon(
                  Icons.psychology,
                  color: colors_colpaner.oscuro,
                ),
                onTap: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const entrenamientoModulos()))
                    }),
            ListTile(
                title: const Text("Mis Puntajes",
                    style: TextStyle(
                      color: colors_colpaner.claro,
                    )),
                leading: const Icon(
                  Icons.sports_score,
                  color: colors_colpaner.claro,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
              title: const Text("Ávatar",
                  style: TextStyle(
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.face,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () {
                //si es primera vez que se ingresa, mstrar al usuario dialogo de genero a leegor

                if (isAvatar == true) {
                  if (gender == 'male') {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const avatarsMale()));
                  }

                  if (gender == 'female') {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const avatarsFemale()));
                  }
                } else {
                  DialogHelper.gender_dialog(context);
                }
              },
            ),
            ListTile(
              title: const Text("Patrones ICFES",
                  style: TextStyle(
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.insights,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () {},
            ),
            ListTile(
              title: const Text("Usabilidad",
                  style: TextStyle(
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.extension,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () {},
            ),
            SizedBox(
              height: drawer_height * 0.15,
            ),
            Expanded(
              child: ListTile(
                title: const Text("",
                    style: TextStyle(
                      color: colors_colpaner.oscuro,
                    )),
                leading: const Icon(
                  Icons.settings,
                  color: colors_colpaner.oscuro,
                ),
                //at press, run the method
                onTap: () {},
              ),
            ),
            const Divider(
              color: colors_colpaner.claro,
            ),
            ListTile(
              title: const Text("Cerrar sesión",
                  style: TextStyle(
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.logout,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () {
                clearSharedPreferences();
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // función para eliminar todos los registros de Shared Preferences
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
