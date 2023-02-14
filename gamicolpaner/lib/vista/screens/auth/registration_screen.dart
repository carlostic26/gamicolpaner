import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamicolpaner/controller/services/NavigatorServices.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamicolpaner/vista/screens/pin_screen.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

final navigatorkey = GlobalKey<NavigatorState>();

class _RegistrationScreenState extends State<RegistrationScreen> {
  late BuildContext _context;
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final fullNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  String? selectedTecnica;
  String? nombre;
  List<String> items_tecnicas = [
    'Sistemas',
    'Contabilidad',
  ];
  List<bool> isSelected = [false, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _context = context;
  }

  @override
  Widget build(BuildContext context) {
    final fullNameField = TextFormField(
        autofocus: false,
        controller: fullNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("El nombre no puede estar vació");
          }
          if (!regex.hasMatch(value)) {
            return ("Tu nommbre debe ser de al menos 3 caracteres");
          }
          return null;
        },
        onSaved: (value) {
          fullNameEditingController.text = value!;

          setState(() {
            nombre = value as String;
          });
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nombre Completo",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Ingresa tu correo");
          }
          // reg expression for email validation
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return ("Ingresa un correo válido");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Correo",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Se necesita una contraseña");
          }
          if (!regex.hasMatch(value)) {
            return ("Ingresa una contraseña de al menos 6 caracteres");
          }
          return null;
        },
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contraseña",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Opps! Las contraseñas no son iguales";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirmar contraseña",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colors_colpaner.oscuro,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          "Registrarse",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: colors_colpaner.claro,
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    final dropdownTecnicas = DropdownButtonHideUnderline(
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft, child: Text('Técnica')),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < items_tecnicas.length; i++)
                Row(
                  children: [
                    Checkbox(
                      value: isSelected[i],
                      onChanged: (value) {
                        setState(() {
                          for (int j = 0; j < items_tecnicas.length; j++) {
                            if (j == i) {
                              isSelected[j] = value!;
                              if (value) {
                                selectedTecnica = items_tecnicas[j];
                              }
                            } else {
                              isSelected[j] = false;
                            }
                          }
                        });
                      },

                      //color claro: d1fccf: 209, 252, 207
                      //color base: 1f7e87; 31, 126, 135
                      //color oscuro: 023b40: 2, 59, 64
                      checkColor: colors_colpaner.claro,
                      activeColor: colors_colpaner.base,
                      tristate: false,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    Text(items_tecnicas[i]),
                  ],
                ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      //color claro: d1fccf: 209, 252, 207
      //color base: 1f7e87; 31, 126, 135
      //color oscuro: 023b40: 2, 59, 64
      backgroundColor: colors_colpaner.base,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colors_colpaner.claro),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 1, 35, 1),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 150,
                        child: Image.network(
                          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEim9Hj2p9LsGTL47iHayHV-ouvuSJKTa0pAIbhBro6xnmb4dZXLNCJyahomAVWDv0Py1sLKY2i-2GLch21OnyG_oSYylW1BjHK05nGKmWps6BIt-FpA90jjaejXufQ6AwhR0cDtrpQ5b4_v6oLUiGwIxhWbZE89Kk11r2feQjQwObLu3OJNhm80A5I/s320/logo.png",
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(height: 45),
                    fullNameField,
                    const SizedBox(height: 20),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 15),
                    dropdownTecnicas,
                    const SizedBox(height: 15),
                    signUpButton,
                    const SizedBox(height: 15),
                  ],
                )),
          ),
        )),
      ),
    );
  }

  bool firstLog = false;

  void signUp(
    String eemail,
    String ppassword,
  ) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: eemail, password: ppassword)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });

      firstLog = true;

      //Se carga a sharedpreferences el buleano que validará el primer ingreso
      LocalStorage.prefs.setBool("firstLog", firstLog);
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    LocalStorage.prefs.setBool("firstLog", firstLog);

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = fullNameEditingController.text;
    userModel.tecnica = selectedTecnica;
    userModel.sumScoreRC = '0';
    userModel.sumScoreDS = '0';

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Cuenta GamiColpaner creada con éxito");

    //NavigatorService().navigateTo('/pinScreen');

    gotopinscreen();
  }

  gotopinscreen() {
    Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(builder: (context) => const pinScreen()),
        (route) => false);
  }
}
