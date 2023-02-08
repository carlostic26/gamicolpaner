import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class entrenamientoModulos extends StatefulWidget {
  const entrenamientoModulos({super.key});

  @override
  State<entrenamientoModulos> createState() => _entrenamientoModulosState();
}

class _entrenamientoModulosState extends State<entrenamientoModulos> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    // TODO: implement initState

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
      backgroundColor: const Color.fromARGB(255, 31, 126, 135),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Entrenamiento",
          style: TextStyle(
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
/*           Align(
            alignment: Alignment.centerRight,
            child: Opacity(
              opacity: 0.5,
              //img background
              child: Image.network(
                "https://blogger.googleusercontent.com/img/a/AVvXsEjZrZ4SvLJ-Jj3ZcWHDGbD0fH3DE2dDVGigDobzbj1F7ZrbHBFs9q1i4L1fPDXxt-olYwWxu4Gjp8wLIZGUKAqu-jRAKjUYqZk15RfNFCIUb1noT36rJwtqZs2QVLkoppMY32Nkc5BoetJGTJxJzjqqSbWQVtlbA9oK7PrJANF2vSXOernqiQ-fPA",
                height: 1000,
                fit: BoxFit.fill,
              ),
            ),
          ), */
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const world_game(
                                        requiredModulo: 'Matemáticas',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 2, 59, 64),
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
                                        "https://cdn.icon-icons.com/icons2/3311/PNG/512/math_book_school_study_icon_209309.png",
                                        //height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Matemáticas",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const world_game(
                                        requiredModulo: 'Inglés',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              //color claro: d1fccf: 209, 252, 207
                              //color base: 1f7e87; 31, 126, 135
                              //color oscuro: 023b40: 2, 59, 64
                              color: Color.fromARGB(255, 2, 59, 64),
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
                                        "https://cdn.icon-icons.com/icons2/230/PNG/256/EnglishLanguage_Flag2_26089.png",
                                        //width: 150,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Inglés",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
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
    double drawer_height = MediaQuery.of(context).size.height;
    double drawer_width = MediaQuery.of(context).size.width;

    //firebase
    final user = FirebaseAuth.instance.currentUser!;

    String tecnicaElegida;

    return Drawer(
      width: drawer_width * 0.60,
      elevation: 0,
      child: Container(
        //color claro: d1fccf: 209, 252, 207
        //color base: 1f7e87; 31, 126, 135
        //color oscuro: 023b40: 2, 59, 64
        color: const Color.fromARGB(255, 209, 252, 207),
        child: ListView(
          children: <Widget>[
            Container(
              //height: 150.0,
              alignment: Alignment.center,
              //imagen de fondo decorativo, es el cuadro detras del avatar
              //
/*               decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 185, 238, 198),
                  image: DecorationImage(
                      image: NetworkImage(
                        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEguAew123nq51EReZ1giaM9ny73tC9h7o1RBXE2TVfIpQabivXCy9eyHhVXkO1E1aJCiad-wmwUflNL6rgF5x964401Nre6WBt0Av_VHEb55CCp483_o27TlGlXmCP_dul-3mdtC3fJSDhqCylnV0bQY9Ih04gf6bbam4Bcc_nHS-NoGXXcH-Gs9P8/s16000/1675262458900.jpg",
                      ),
                      fit: BoxFit.cover)), */
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 5.0),
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/psd-gratis/3d-ilustracion-persona-gafas-sol_23-2149436200.jpg?w=360'),
                  ),
                  const SizedBox(height: 10.0),
                  Text(loggedInUser.fullName.toString(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 42, 42, 42),
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  Text('Técnica de ${loggedInUser.tecnica}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 91, 91, 91))),
                  Text(loggedInUser.email.toString(),
                      style: const TextStyle(
                          fontSize: 10,
                          color: Color.fromARGB(255, 91, 91, 91))),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
            ListTile(
                title: const Text("Entrenamiento",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold)),
                leading: const Icon(
                  Icons.psychology,
                  color: Colors.grey,
                ),
                onTap: () => {
                      Navigator.pop(context),
                    }),
            ListTile(
                title: const Text("Mis Puntajes",
                    style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
                leading: const Icon(
                  Icons.sports_score,
                  color: Colors.grey,
                ),
                onTap: () {}),
            ListTile(
              title: const Text("Mi Usuario",
                  style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
              leading: const Icon(
                Icons.face,
                color: Colors.grey,
              ),
              //at press, run the method
              onTap: () {},
            ),
            ListTile(
              title: const Text("Patrones ICFES",
                  style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
              leading: const Icon(
                Icons.insights,
                color: Colors.grey,
              ),
              //at press, run the method
              onTap: () {},
            ),
            ListTile(
              title: const Text("Usabilidad",
                  style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
              leading: const Icon(
                Icons.extension,
                color: Colors.grey,
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
                    style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
                leading: const Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                //at press, run the method
                onTap: () {},
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: const Text("Cerrar sesión",
                  style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
              leading: const Icon(
                Icons.logout,
                color: Colors.grey,
              ),
              //at press, run the method
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
