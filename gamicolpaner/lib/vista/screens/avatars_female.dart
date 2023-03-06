import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/puntajes_shp.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/mis_puntajes.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class avatarsFemale extends StatefulWidget {
  const avatarsFemale({super.key});

  @override
  State<avatarsFemale> createState() => _avatarsFemaleState();
}

class _avatarsFemaleState extends State<avatarsFemale> {
  bool _pressed = false;
  int _selectedIndex = -1;
  List<bool> _pressedList = [false, false, false, false, false, false];

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  String _modulo = '';
  String _imageUrl = '';

  //recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  //recibe el avatar imageUrl guardado anteriormente en sharedPreferences
  void _getAvatarFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageUrl = prefs.getString('imageUrl') ?? '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    _getAvatarFromSharedPrefs();
    _getModuloFromSharedPrefs();
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
    _getAvatarFromSharedPrefs();
    final double totalWidth = MediaQuery.of(context).size.width;
    final double cellWidth = (totalWidth - 16) / 3;
    final double cellHeight = 40 / 3 * cellWidth;

    const borderColorPressed = colors_colpaner.claro;
    const borderColorNormal = colors_colpaner.oscuro;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Elige tu ávatar Femenino",
          style: TextStyle(
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: colors_colpaner.base,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              ShakeWidgetY(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      width: MediaQuery.of(context).size.width,
                      height: 125,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/banner_user.png"),
                        ),
                      ),
                    ),
                    //image avatar
                    Positioned(
                      top: 45,
                      left: MediaQuery.of(context).size.width * 0.40,
                      child: Container(
                          padding: const EdgeInsets.all(1.0),
                          width: 70,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: cellWidth,
                              height: cellHeight,
                              child: FadeInImage(
                                placeholder: const NetworkImage(
                                    'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw'),
                                image: NetworkImage(_imageUrl),
                                fit: BoxFit.cover,
                                imageErrorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                          )),
                    ),
                    Positioned(
                      left: 65,
                      top: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
/*                           Text(
                            _modulo,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'BubblegumSans',
                              fontSize: 13,
                            ),
                          ), */
                        ],
                      ),
                    ),
                    Positioned(
                      right: 50,
                      top: 45,
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 500,
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                      children: [
                        _buildAvatarButton(
                          index: 0,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiOjqtlJ0B6Wr2FircsiqSEoW_zktifuRI1qSbdInXMrBKnNfEc8A-3lkLYyS7Wk6hE6-l2u8vKG2arhhgU-tnnCHWpSQ2BQLRjvFvakSSx8NO7tss0ZP-4_rXzwZssbcN8PJIZuyw71pJnLcTlmQFCPX40gMFEP1ahKsQadpOVLpAN0UXLWzjLC1w/w200-h194/a1.PNG',
                        ),
                        _buildAvatarButton(
                          index: 1,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgDq9UyZb1p4kriNXrN-QfrZP_Lj80fPV7EP1Lf6RW7EZhwu1n0y6sCz7Wkzg_SoP41NvuX2GH2xapMlZNbRZ7cDDkVk_sSsLLeyQ1tweAleO_zbZPU0fPAsffIVx7jUQqqQVcbrYuf_KhO_9stdh77W0g4hYxn9eXzyOrv6-MWnaEdEjX7YSjeN20/w200-h197/a2.PNG',
                        ),
                        _buildAvatarButton(
                          index: 2,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgyIcDtwypK8LqEi1Ad-BSS1uxz4gbcp7M3FlsCPbwlyCLtMQgs4FaMQE2qWDofnZ1HrtxHNobKQQ-0c4854vHAY3X64Q9FtD1Lf468rLB3kvJQdBPcTEkhW6ZWiUrnrSWrIv0rQd5zQCj0KzDqsy-9GxQkANeZwEuIpWyMMlgkV-64aHBKo0Wu7J0/w200-h173/a3.PNG',
                        ),
                        _buildAvatarButton(
                          index: 3,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiUDqeQ8AiJoaU77yHFHof-0L8cu37nKs7DkVrNPzI5Xc2qVlo9eYCwGZXCzZ1WMDKtSQFPAaLpRWiVLBOQINYwPCo3fP_PeNtJRs95NHjz87vTZnOT-uro400RPcEXmcQc5-xCJ40_38IOJ6aYoLgYebCGBlPF37K9ju3HVkiXjpXuCO5c0uRs9lo/w200-h184/a4.PNG',
                        ),
                        _buildAvatarButton(
                          index: 4,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiU3b9bRIHvWyoleUQExaJnFxZGFR_nfek8rv-_idzIdGgfZzBF2ZcqyM1cxCL07rU817M830dmmYZNXTA2p72_JbVJmgKyVcIl5BZm-H4MBZoLLzYLqSXbLG6i-XoyJLbnRSKdd20ygnYS6A8N5WWaSvcdBeIpeaBKR5DFvzCOQn8CCezj75Io9zY/w200-h188/a5.PNG',
                        ),
                        _buildAvatarButton(
                          index: 5,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgsaXNdoH1wK8jCEKE73LtHhrr9rqR1NoJV2KnIDl7aIkFaCaU-VAlbRqasIO36pRKFuTYSHwE86auXd6ebJY0m_Jfowh3jZauu5tCLOr5MSo6x33vmr82VI1HswiVszMlEzyp8qA4X_xBPfiBwVoVNAK-b61XatB91TsRNGPJ2lfVNUMXnE7wHlSw/w200-h183/a6.PNG',
                        ),
                        _buildAvatarButton(
                          index: 6,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEinRweYojRSLAMDhJ7dv0i_1cSPYldFVOnhPnf4lBqqL-sn3irpKcbawMpXB-fDtqDDBBGqds6BX9dCp3v1yo0WNRfdx3arTUdVt-10l-RzFuPYzTV0ge8T_pbXXjnscqH9qvYYtgVeAZjpJwPLen7kqjeqRVn9Aj4WGq6QPC797gNElWGOjpF7mog/w200-h175/a7.PNG',
                        ),
                        _buildAvatarButton(
                          index: 7,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiuP2sCiPlv5QCRCWn5n0EMtdpTN-pzuxPsmqhBm33uco__26Y33E5Yc3hAlpW7KFTgLQBIpLY72rss7DP1SyuvNw69se_Sw5UuB6FES7EfEmAh1fWnp0XTHOFrccOf0S367aEi_dJiYd0TGXFXGR-9SYnxiNGGJLb8W4j4x9vMMNHCrg1LxpYiTXA/w193-h200/a8.PNG',
                        ),
                        _buildAvatarButton(
                          index: 8,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjpJ3pxZ-MBVQF_OqSfGTTL3nOKG3HvrEsnbLHNJk_aWW53FseQ3gMhxfb5xd_0AfB4ZXJUTxfbBr1eXuqWbVU6aBag64-pXBSoZtv0nCycsCyLv6BqOcphSX2xfQpRSnaCOHDgUffR4EuIAGDqnVwDp6knydmsSJclUG7Q-p8oBT1mt2iZnVZPlOo/w200-h176/a9.PNG',
                        ),
                        _buildAvatarButton(
                          index: 9,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhKOZmTI7fVhyfhZRsZt4IGCY-f3hNo70tYoeEiLh8pEkrLpY4HTk5zv4d9L54VBw3XWyPBjWU5NhD4sESi2auZLorgGshr-DsOxf6kUVSla6RLihdqCEf_ki2Pj3p19wHUU0Z6XIdcKRBaQoTyydgeOantNfeYQIO-fI4l7jFlpvIFvXzwtDmdTFw/w200-h189/a10.PNG',
                        ),
                        _buildAvatarButton(
                          index: 10,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEivae6Qa9ZQ9FuL-fPJeCIPsSyzQ2Tkxbpa4cfClHYGQVHfSGGqsUHf5Bl7Fq6s2xZpYU5Lp7DX_yAg9quOAcK7Op0X2GPaiP8MMb-HxWfhmtSBsARCda5OUl2qZsjjqeYHj1Q3mezdhpNlJOMdCGF0aGrsJRogT2jJc-HSxMsXRbURyHXESGGn0RQ/w200-h180/a11.PNG',
                        ),
                        _buildAvatarButton(
                          index: 11,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEibgyNVef3pMWSbrV1t9XzN8irYLlX1jQ4AUsxvFupQezI-InwgvKas0GmgxG-fDoJmBBmkdc_La2FTwhFaRbYHKSHxJZKEliiZu8tTpL8HhyGds8AtpaUIdHvDEO4M_mt8cyrywJp7MGiH8qIOBcEgUaGlBvxscXd2A0Qwh1OZCKBQ6eSdbin1PwI/w200-h184/a12.PNG',
                        ),
                        _buildAvatarButton(
                          index: 12,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjstDuUAGlFImGwO7ry2o9KuLyNn9RleLtoSZzI5oZj9by5zupufwfaaTT2JpymTddnvNO_pTipptpKXY6PUSoYRWq2PAWmrelc-DjgtkHPixuO4RbNANo8GNzZ8b8pjZdGVrYdMMTJEzY0BWSTUQ2XWqShCaKy4sNHwaTjXurQpvPycPl8lphJls/w200-h194/a13.PNG',
                        ),
                        _buildAvatarButton(
                          index: 13,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgJoEf5FVZmF93CAJK6s3IF7gOjpKo8O8ByTjmDW08Eq1aBNOAR3_tAO7EW4HSSOHqmNlIGsAZP6pfH_xTRbtlb1_mnxUYBfCZnCfVuyVpsIM0Qm4zudHoavXovWx57pjDgQx8Ifwm5wFEGs7AYlnCJLEXE0BrVNKd1ZjhVdoIaWYPi55PFvqzrSmc/w196-h200/a14.PNG',
                        ),
                        _buildAvatarButton(
                          index: 14,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFcEGdckscnEueJkXni-pdqYJ0Jg_tT2BwmpSkWTy4y6BOsE6ctJIpRiPWaPsV9bZgAsOCbzZQQwRjtwcDobAEev3xRM2ttUtHTpXny5lIa4A7-LTSphqiZkRBTFrMfI6y4XV6WGpIdqR9C9MUwpTf9bZF-c4qx-gyCX3PaxYUIx93oWqybyNOzIc/w200-h191/a15.PNG',
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
      drawer: _getDrawer(context),
    );
  }

  Widget _buildAvatarButton({
    required int index,
    required Color borderColorPressed,
    required Color borderColorNormal,
    required double cellWidth,
    required double cellHeight,
    required String imageUrl,
  }) {
    return InkResponse(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('imageUrl', imageUrl);
        print('Avatar $index pressed');
        setState(() {
          // Si se toca el mismo botón, desmarcarlo
          if (index == _selectedIndex) {
            _selectedIndex = -1;
          } else {
            _selectedIndex = index;
          }
        });
      },
      highlightShape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.green.withOpacity(0.5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedIndex == index
                ? borderColorPressed
                : borderColorNormal,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: SizedBox(
            width: cellWidth,
            height: cellHeight,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
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
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/psd-gratis/3d-ilustracion-persona-gafas-sol_23-2149436200.jpg?w=360'),
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
                    color: colors_colpaner.claro,
                  )),
              leading: const Icon(
                Icons.face,
                color: colors_colpaner.claro,
              ),
              //at press, run the method
              onTap: () {
                //si es primera vez que se ingresa, mstrar al usuario dialogo de genero a leegor
/*                 Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const genderDialog()));
              */
                Navigator.pop(context);
                //DialogHelper.gender_dialog(context);
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
