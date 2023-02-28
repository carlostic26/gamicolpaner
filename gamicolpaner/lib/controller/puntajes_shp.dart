//guarda el modulo ingresado en sharedPreferences
import 'package:shared_preferences/shared_preferences.dart';

int niv1MAT = 0,
    niv2MAT = 0,
    niv3MAT = 0,
    niv4MAT = 0,
    niv5MAT = 0,
    niv6MAT = 0,
    niv7MAT = 0,
    niv8MAT = 0,
    niv9MAT = 0,
    niv10MAT = 0;

int niv1ING = 0,
    niv2ING = 0,
    niv3ING = 0,
    niv4ING = 0,
    niv5ING = 0,
    niv6ING = 0,
    niv7ING = 0,
    niv8ING = 0,
    niv9ING = 0,
    niv10ING = 0;

void setPuntaje_MAT1(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_mat_1', puntaje);
}

Future<int> getPuntaje_MAT1() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_1') ?? '';
  niv1MAT = int.parse(score);
  return niv1MAT;
}

void setPuntaje_MAT2(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_mat_2', puntaje);
}

Future<int> getPuntaje_MAT2() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_2') ?? '';
  niv2MAT = int.parse(score);
  return niv2MAT;
}

void setPuntaje_MAT3(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_mat_3', puntaje);
}

Future<int> getPuntaje_MAT3() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_3') ?? '';
  niv3MAT = int.parse(score);
  return niv3MAT;
}

void setPuntaje_MAT4(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_mat_4', puntaje);
}

Future<int> getPuntaje_MAT4() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_4') ?? '';
  niv4MAT = int.parse(score);
  return niv4MAT;
}

void setPuntaje_MAT5(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_mat_5', puntaje);
}

Future<int> getPuntaje_MAT5() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_5') ?? '';
  niv5MAT = int.parse(score);
  return niv5MAT;
}

void setPuntaje_MAT6(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_mat_6', puntaje);
}

Future<int> getPuntaje_MAT6() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_6') ?? '';
  niv6MAT = int.parse(score);
  return niv6MAT;
}

void setPuntaje_MAT7(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_mat_7', puntaje);
}

Future<int> getPuntaje_MAT7() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_7') ?? '';
  niv7MAT = int.parse(score);
  return niv7MAT;
}

void setPuntaje_MAT8(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_mat_8', puntaje);
}

Future<int> getPuntaje_MAT8() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_8') ?? '';
  niv8MAT = int.parse(score);
  return niv8MAT;
}

void setPuntaje_MAT9(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_mat_9', puntaje);
}

Future<int> getPuntaje_MAT9() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_9') ?? '';
  niv9MAT = int.parse(score);
  return niv9MAT;
}

void setPuntaje_MAT10(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_mat_10', puntaje);
}

Future<int> getPuntaje_MAT10() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_10') ?? '';
  niv10MAT = int.parse(score);
  return niv10MAT;
}

//INGLES -----------------------------------------------------

void setPuntaje_ING1(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_ing_1', puntaje);
}

Future<int> getPuntaje_ING1() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_1') ?? '';
  niv1ING = int.parse(score);
  return niv1ING;
}

void setPuntaje_ING2(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_ing_2', puntaje);
}

Future<int> getPuntaje_ING2() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_2') ?? '';
  niv2ING = int.parse(score);
  return niv2ING;
}

void setPuntaje_ING3(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_ing_3', puntaje);
}

Future<int> getPuntaje_ING3() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_3') ?? '';
  niv3ING = int.parse(score);
  return niv3ING;
}

void setPuntaje_ING4(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntje_ing_4', puntaje);
}

Future<int> getPuntaje_ING4() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_4') ?? '';
  niv4ING = int.parse(score);
  return niv4ING;
}

void setPuntaje_ING5(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_ing_5', puntaje);
}

Future<int> getPuntaje_ING5() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_5') ?? '';
  niv5ING = int.parse(score);
  return niv5ING;
}

void setPuntaje_ING6(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_ing_6', puntaje);
}

Future<int> getPuntaje_ING6() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_6') ?? '';
  niv6ING = int.parse(score);
  return niv6ING;
}

void setPuntaje_ING7(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_ing_7', puntaje);
}

Future<int> getPuntaje_ING7() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_7') ?? '';
  niv7ING = int.parse(score);
  return niv7ING;
}

void setPuntaje_ING8(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_ing_8', puntaje);
}

Future<int> getPuntaje_ING8() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_8') ?? '';
  niv8ING = int.parse(score);
  return niv8ING;
}

void setPuntaje_ING9(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_ing_9', puntaje);
}

Future<int> getPuntaje_ING9() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_9') ?? '';
  niv9ING = int.parse(score);
  return niv9ING;
}

void setPuntaje_ING10(puntaje) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('puntaje_ing_10', puntaje);
}

Future<int> getPuntaje_ING10() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_10') ?? '';
  niv10ING = int.parse(score);
  return niv10ING;
}

int scoreTotal_MAT = 0;
int scoreTotal_ING = 0;

Future<int> getPuntajesTotal_MAT() async {
  final prefs = await SharedPreferences.getInstance();

  //logró funcionar ya que antes estaba como puntajae_mat_1
  //si eliminamos esta forma de obtener por shared preferences, dejandolo separado en
  // una funcon future int, no va a mostrar en tiempo real la sumatoria al banner, debe ser aqui
  String score_m1 = prefs.getString('puntaje_mat_1') ?? '';
  niv1MAT = int.parse(score_m1);

  String score_m2 = prefs.getString('puntaje_mat_2') ?? '';
  niv2MAT = int.parse(score_m2);

  /*
  // no usar el siguiente codigo hasta que los demas niveles guarden el puntaje 
  // o al menos tengan el codigo para guardar los puntajes

  String score_m3 = prefs.getString('puntaje_mat_3') ?? '';
  niv3MAT = int.parse(score_m3);

  String score_m4 = prefs.getString('puntaje_mat_4') ?? '';
  niv4MAT = int.parse(score_m4);

  String score_m5 = prefs.getString('puntaje_mat_5') ?? '';
  niv5MAT = int.parse(score_m5);

  String score_m6 = prefs.getString('puntaje_mat_6') ?? '';
  niv6MAT = int.parse(score_m6);

  String score_m7 = prefs.getString('puntaje_mat_7') ?? '';
  niv7MAT = int.parse(score_m7);

  String score_m8 = prefs.getString('puntaje_mat_8') ?? '';
  niv8MAT = int.parse(score_m8);

  String score_m9 = prefs.getString('puntaje_mat_9') ?? '';
  niv9MAT = int.parse(score_m9);

  String score_m10 = prefs.getString('puntaje_mat_10') ?? '';
  niv10MAT = int.parse(score_m10);
    */

  scoreTotal_MAT = niv1MAT +
      niv2MAT +
      niv3MAT +
      niv4MAT +
      niv5MAT +
      niv6ING +
      niv7ING +
      niv8ING +
      niv9MAT +
      niv10ING;
  return scoreTotal_MAT;
}

Future<int> getPuntajesTotal_ING() async {
  final prefs = await SharedPreferences.getInstance();

  String score_ing1 = prefs.getString('puntaje_ing_1') ?? '';
  niv1ING = int.parse(score_ing1);

  String score_ing2 = prefs.getString('puntaje_ing_2') ?? '';
  niv2ING = int.parse(score_ing2);
/*   

  String score_ing3 = prefs.getString('puntaje_ing_3') ?? '';
  niv3ING = int.parse(score_ing3);

  String score_ing4 = prefs.getString('puntaje_ing_4') ?? '';
  niv4ING = int.parse(score_ing4);

  String score_ING5 = prefs.getString('puntaje_ING_5') ?? '';
  niv5ING = int.parse(score_ING5);

  String score_ING6 = prefs.getString('puntaje_ING_6') ?? '';
  niv6ING = int.parse(score_ING6);

  String score_ING7 = prefs.getString('puntaje_ING_7') ?? '';
  niv7ING = int.parse(score_ING7);

  String score_ing8 = prefs.getString('puntaje_ing_8') ?? '';
  niv8ING = int.parse(score_ing8);

  String score_ING9 = prefs.getString('puntaje_ING_9') ?? '';
  niv9ING = int.parse(score_ING9);

  String score_ING10 = prefs.getString('puntaje_ING_10') ?? '';
  niv10ING = int.parse(score_ING10);
 */
  scoreTotal_ING = niv1ING +
      niv2ING +
      niv3ING +
      niv4ING +
      niv5ING +
      niv6ING +
      niv7ING +
      niv8ING +
      niv9ING +
      niv10ING;
  return scoreTotal_ING;
}
