import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gamicolpaner/model/user_model.dart';

class world_game extends StatefulWidget {
  final String requiredModulo;

  const world_game({required this.requiredModulo, Key? key}) : super(key: key);

  @override
  State<world_game> createState() => _world_gameState();
}

class _world_gameState extends State<world_game> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late Image button1;

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
    button1 = buttonUnpressed;

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
                  imageUrl:
                      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiR8gtf1dpYgecZ6Cd2cMiXRlm23xgNzyDbGDKdLewrwP0_oULflqGyGvEVioEgaGcsDNUpsu1kzY5lXEv3yE3tGNqQS-fCf_fgxuvihazYcXUX7wb1iry_irjwPFFP30sVtChna5KDISVUUSb3d0RhV66th9zpHQSzVAs6tPUUC6DIDkzk5y3b9gE/s16000/fondo%20ruta%202.png',
                  //height: 1000,

                  //dimension de llenado ancho y alto de pantalla candy crush
                  height: MediaQuery.of(context).size.height * 1.0,
                  width: MediaQuery.of(context).size.width * 1.0,

                  fit: BoxFit.fill,
                ),

                //btn inicial 1
                Positioned(
                  bottom: -15,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 1.1,
                  //right: 90,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 150,
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
}
