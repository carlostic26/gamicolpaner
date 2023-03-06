import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
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

  Future<bool?> getIsAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isAvatar = prefs.getBool('isAvatar')!;
    });
  }

  String gender = '';

  Future<String?> getGender() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      gender = prefs.getString('gender')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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

    super.initState();
  }

  final colors = [Colors.blue[800], Colors.blue[200]]; // Lista de colores

  final int puntos_test = 5;
  final int puntosMaximos_test = 100;

  @override
  Widget build(BuildContext context) {
    final double porcentaje_test =
        puntos_test / puntosMaximos_test; // Calcular el porcentaje de progreso

    return Scaffold(
      backgroundColor: colors_colpaner.base,
      appBar: AppBar(
        title: const Text(
          "Mis Puntajes",
          style: TextStyle(
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        centerTitle: true,
        backgroundColor:
            Colors.transparent, // establece el color de fondo transparente
        elevation: 0, // elimina la sombra
        iconTheme: const IconThemeData(
            color: Colors
                .white), // cambia el color del icono del botón de menú lateral a negro
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 80),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Mis puntajes",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'BubblegumSans',
                      fontWeight: FontWeight.bold,
                      color: colors_colpaner.claro,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: 1,
                color: colors_colpaner.oscuro,
              ),
              const SizedBox(height: 10),
              //--- MIS PUNTAJES
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: const [
                          Text(
                            'Matemáticas',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          Text(
                            '5/100',
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
              const SizedBox(height: 100),

              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Text(
                    "Progreso",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'BubblegumSans',
                      fontWeight: FontWeight.bold,
                      color: colors_colpaner.claro,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: 1,
                color: colors_colpaner.oscuro,
              ),
              const SizedBox(height: 10),
              //--- PROGRESO
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
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Text(
                    "Ranking",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'BubblegumSans',
                      fontWeight: FontWeight.bold,
                      color: colors_colpaner.claro,
                    ),
                  ),
                ),
              ),

              const Divider(
                thickness: 1,
                color: colors_colpaner.oscuro,
              ),

              const SizedBox(height: 10),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(_imageUrl),
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
