import 'package:gamicolpaner/model/question_list_model.dart';
import 'package:gamicolpaner/model/score.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Este archivo dart contiene todas LA BASE DE DATOS  QUE COMPLEMENTA el modelo MVC
//Contiene codigo SQL que se ejecutara una unica vez almacenando los datos en la cache del dispositivo
//se recomienda iterar el numero del nombre de la base de datos de la linea 13

class SimulacroHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'simulacro_exam_11.db'),
      onCreate: (database, version) async {
        const String sql = '''
        CREATE TABLE preguntasICFES (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          modulo TEXT,
          pregunta TEXT,
          resp_1 TEXT,
          resp_2 TEXT,
          resp_3 TEXT,
          resp_4 TEXT,
          op_1 INTEGER,
          op_2 INTEGER,
          op_3 INTEGER,
          op_4 INTEGER,
          imagen TEXT
        );
      ''';

        await database.execute(sql);

        const String addQuestion = ''
            'INSERT INTO preguntasICFES(modulo, pregunta, resp_1, resp_2, resp_3, resp_4, op_1, op_2, op_3, op_4, imagen ) VALUES '
            // MATEMATICAS: X PREGUNTAS
            '("MAT", "¿Cuanto es 1+1?", "es 100", "es 2", "es 13", "es 20", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 2+1?", "es 100", "es 12", "es 13", "es 3", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 3+1?", "es 100", "es 4", "es 13", "es 2", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 4+1?", "es 5", "es 12", "es 13", "es 2", 1,0,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 5+1?", "es 100", "es 12", "es 13", "es 6", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'

            // INGLES: X PREGUNAS
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuanto es 1+1?", "s 100", "es 12", "es 13", "es 2", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg")';

        await database.execute(addQuestion);

        /*Se recomienda eliminar la version anterior  de la base de datos mientras se testea el software
        deleteDatabase("gamilibre12.db");*/
      },
      version: 1,
    );
  }

  Future<List<question_model>> queryMAT() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db
        .query('preguntasICFES', where: 'modulo like ?', whereArgs: ['%MAT%']);

    //imprime bien en formato lista visible el queryResult
    print(
        '----------------------\n\n\nIMPRIMIENDO QUERYRESULT MAT dbexam.dart:\n $queryResult');

    //al ser un map, no imprime de forma visible sino:  [Instance of 'question_model', Instance of 'question_model', Instance of 'question_model', Instance of 'question_model', Instance of 'question_model']
    //print(List<question_model>  list = queryResult.map((e) => question_model.fromMap(e)).toList();
    return queryResult.map((e) => question_model.fromMap(e)).toList();
  }

  //La siguiente funcion hace la consulta de todos las preguntas que sean del modulo ingles
  Future<List<question_model>> queryING() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM preguntasICFES WHERE modulo like ?', ['%ING%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }
    print(
        '----------------------\n\n\nIMPRIMIENDO QUERYRESULT ING:\n $queryResult');

    return queryResult.map((e) => question_model.fromMap(e)).toList();
  }
}
