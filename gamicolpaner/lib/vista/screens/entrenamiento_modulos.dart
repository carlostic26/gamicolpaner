import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/dialogs/gender_dialog.dart';
import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/screens/avatars_female.dart';
import 'package:gamicolpaner/vista/screens/avatars_male.dart';
import 'package:gamicolpaner/vista/screens/gender_chooser.dart';
import 'package:gamicolpaner/vista/screens/mis_puntajes.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:gamicolpaner/controller/modulo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class entrenamientoModulos extends StatefulWidget {
  const entrenamientoModulos({super.key});

  @override
  State<entrenamientoModulos> createState() => _entrenamientoModulosState();
}

class _entrenamientoModulosState extends State<entrenamientoModulos> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //color claro: d1fccf: 209, 252, 207
      //color base: 1f7e87; 31, 126, 135
      //color oscuro: 023b40: 2, 59, 64
      backgroundColor: colors_colpaner.base,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Entrenamiento",
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'BubblegumSans',
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 100, 20, 1),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            //establece en memoria el módulo controlado por el usuario
                            setModulo('Matemáticas');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const world_game()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors_colpaner.oscuro,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colors_colpaner.oscuro,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://blogger.googleusercontent.com/img/a/AVvXsEi65drZlUOAOrTo1nrlpal6HmYjZk-Ju3SFpee8cYOYbWulOYMcuGxU2M-b0o9424zrXnKeqzc-XaiRXhrN9UBJCYBxFhiJxf_c5yHFlj_QVZgkRfCBGKbtkUn-Nsw9xytcwWDgg3KMtFElAINa4Z7UM8qQxNE4kiWutgOS9M2fS5MMAnFPeNjD9j4",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Matemáticas",
                                  style: TextStyle(
                                      fontFamily: 'BubblegumSans',
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setModulo('Inglés');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const world_game()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors_colpaner.oscuro,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colors_colpaner.oscuro,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://blogger.googleusercontent.com/img/a/AVvXsEh7TLYTExTyHj1uyRWLPST62P-r_mQflNxPYVMHI5B-OH8uYkqKnUDHzLz2PwiBKG5gnyd1sBRmCESj5ped63rSK5bjq0umgls4pbAAWmP3EP3082I-Z1BcbVnQJlwGcXpb9wd3oM7eCPLS4jxabo8KQA_gfSFZSFu5pKYDmyE_j5X2kUjNOiK_z-I",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Inglés",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'BubblegumSans',
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
              )
              //2do renglon
/*               //Juegos de Mesa
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const game(requiredModulo: '',)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Image.network(
                                        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh8QXQJjFfYTSuIdJTaqQq3NS8cwNEylUDQboyohb__uAvxToKk9RYZz2x_UN8RZQkLtU5dxvAL2-hagGnUuuqiLefCAVk63tT4dR9RtGzQ3qgTRjG041itG_K3bfoi57S32AKDDvC8alipGlRBAq_H3wxsH3jwBVEt3ivVywiE7l7l7UaO16lUyQ/s320/plan%20juegos%20de%20mesa.png",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Juegos de Mesa",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      //Hobbies
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const game(requiredModulo: '',)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Image.network(
                                        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjacTxTyarlUtroHrY5mBfPUFPQs2ht8OiCAhCCA0CWVwtcBDqIoiVUelq10UVStia2tXfY1oPjv0oPHIaYfdx-tJunso0HLih7Vb2pPb_cRUoniae7kW_hCvTMeJQWE2jZrmqutunBVh5jeizK4SyfAhsPqlKCTTI5I1wOZuOaxFL0F-_B_0UmcQ/s320/plan%20hobbie.png",
                                        //width: 150,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Hobbies",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //3er renglon
              //Juegos Outdoor
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 1, 20, 100),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const game(requiredModulo: '',)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Image.network(
                                        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEic-Q3TOf_VkePRHd1D0Tfw4Y0nfl-FXK74WN8sXT-m7pDZ52OgwV2qHkFDE4wIn8xfQ4ZR_I2RSQ1PTVkDkT0YAczg_oX-Y7XNDTJUJ4J5RQbau4bcE0AUbWG3CPdJ90Lx-BSrLZO57tVzCc6WkK0HJHma59lAo9hEQjnlwM4JlE5AB-69QZVhiQ/s320/juegos%20outdoor.png",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Juegos Outdoor",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      //Postres
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const game(requiredModulo: '',)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Image.network(
                                        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhd8EhMsQYCYg2sic_wnqOrAcJPCYSCpgHfHj9dS98drTXlW7oZqh4q4NKbIGbD2G33dDggiPHbkd0i4rdmc08RyNFrHrS4wgwoMT9Dh50xfLTZp18z2UpL3uwrPD7XqaKQw9x5la_Iem9xFvttF0BIBhVvvjAfSNZCDnz2Jt22GjMR3warGtM8vw/s320/icono%20postres.png",
                                        //width: 150,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Postres",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), */
            ],
          ),
        ],
      ),
      drawer: _getDrawer(context),
    );
  }

  //NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    _getAvatarFromSharedPrefs();

    double drawer_height = MediaQuery.of(context).size.height;
    double drawer_width = MediaQuery.of(context).size.width;

    //firebase
    final user = FirebaseAuth.instance.currentUser;

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
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(loggedInUser.fullName.toString(),
                        style: const TextStyle(
                            fontFamily: 'BubblegumSans',
                            color: colors_colpaner.claro,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text('Técnica de ${loggedInUser.tecnica}',
                      style: const TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: colors_colpaner.claro,
                      )),
                  Text(loggedInUser.email.toString(),
                      style: const TextStyle(
                        fontFamily: 'BubblegumSans',
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
                        fontFamily: 'BubblegumSans',
                        color: colors_colpaner.claro,
                        fontWeight: FontWeight.bold)),
                leading: const Icon(
                  Icons.psychology,
                  color: colors_colpaner.claro,
                ),
                onTap: () => {
                      Navigator.pop(context),
                    }),
            ListTile(
                title: const Text("Mis Puntajes",
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      color: colors_colpaner.oscuro,
                    )),
                leading: const Icon(
                  Icons.sports_score,
                  color: colors_colpaner.oscuro,
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const misPuntajes()));
                }),
            ListTile(
              title: const Text("Ávatar",
                  style: TextStyle(
                    fontFamily: 'BubblegumSans',
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.face,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () async {
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
                    fontFamily: 'BubblegumSans',
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
                    fontFamily: 'BubblegumSans',
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
                    fontFamily: 'BubblegumSans',
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
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
