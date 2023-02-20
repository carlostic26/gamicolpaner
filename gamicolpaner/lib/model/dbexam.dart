import 'package:gamicolpaner/model/score.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Este archivo dart contiene todas LA BASE DE DATOS  QUE COMPLEMENTA el modelo MVC
//Contiene codigo SQL que se ejecutara una unica vez almacenando los datos en la cache del dispositivo
//se recomienda iterar el numero del nombre de la base de datos de la linea 13

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'simulacro_exam_1.db'),
      onCreate: (database, version) async {
        const String sql = ''
            'CREATE TABLE preguntasICFES ('
            ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
            ' modulo TEXT,'
            ' pregunta TEXT,'
            ' resp_1 TEXT,'
            ' resp_2 TEXT,'
            ' resp_3 TEXT,'
            ' resp_4 TEXT,'
            ' op_1 INTEGER,'
            ' op_2 INTEGER,'
            ' op_3 INTEGER,'
            ' op_4 INTEGER,'
            ' imagen TEXT'
            ');';

        await database.execute(sql);

        const String addQuestion = ''
            'INSERT INTO preguntasICFES(id, modulo, pregunta, resp_1, resp_2, resp_3, resp_4, op_1, op_2, op_3, op_4, imagen ) VALUES '
            // MATEMATICAS: X PREGUNTAS
            '("MAT", "¿Cuanto es 1+1?", "100", "12", "13", "2", "0","0","0","1", "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 2+1?", "100", "12", "13", "2", "0","0","0","1", "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 3+1?", "100", "12", "13", "2", "0","0","0","1", "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 4+1?", "100", "12", "13", "2", "0","0","0","1", "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 5+1?", "100", "12", "13", "2", "0","0","0","1", "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'

            // INGLES: X PREGUNAS
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", "0","0","1","0", "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", "0","0","1","0", "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", "0","0","1","0", "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", "0","0","1","0", "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuanto es 1+1?", "100", "12", "13", "2", "0","0","0","1", "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg")';

        await database.execute(addQuestion);

        /*Se recomienda eliminar la version anterior  de la base de datos mientras se testea el software
        deleteDatabase("gamilibre12.db");*/
      },
      version: 1,
    );
  }

  //La siguiente funcion realiza la insercion de las instancias a la tabla puntaje

  //la idea es que esta funcion va a insertar el puntaje completo por nivel dentro de cada modulo
  //se debe invocar cuando se finalice el juego gameover. Se manda desde alla hacia aca mediante un objeto tipogamilibre donde se ponen todos los datos
  Future<void> insertScoreLevel_1(scoreColpaner ScoreColpaner) async {
    final db = await initializeDB();

    //inserta en la tabla scoresTable la informaion que se recibe
    // ya lo que se recibe es el objeto que contiene la informacion completa
    await db.insert(
      'scoresTable',
      ScoreColpaner.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // La siguiente funcion se selecciona un solo elemento
  Future<List<scoreColpaner>> Colpaner() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult =
        await db.rawQuery('SELECT * FROM score WHERE nivel like ?', ['%1%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }
    return queryResult.map((e) => scoreColpaner.fromMap(e)).toList();
  }

  //La siguiente funcion se selecciona el puntaje y el modulo de la palabra clave que recibe como argumento
  // se requiere: modulo, nivel

  Future<List<scoreColpaner>> SelectScoreForLevelModule(
      String modulo, String nivel) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT score FROM scoreTable WHERE modulo like ? AND nivel like ?',
        ['%' + modulo + '%' + nivel + '%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }
    return queryResult.map((e) => scoreColpaner.fromMap(e)).toList();
  }

  //La siguiente funcion actualiza los puntajes segun se requiera
  //ACTUALIZA TODA LA INFO ROW SEL SCORE SEGUN EL ID QUE LE PASEN. LOS ID'S YA HAN SIDO CREADOR ANTERIORMENTE
  Future<Future<int>> updateScore(scoreColpaner ScoreGamiLibre) async {
    final db = await initializeDB();

    return db.update("scoreTable", ScoreGamiLibre.toMap(),
        where: "id = ?", whereArgs: [ScoreGamiLibre.id]);
  }

//La siguiente funcion inserta todo un objeto dentro del campo de la tabla de puntajes
  Future<void> insertScoreLevel_2(scoreColpaner ScoreGamiLibre) async {
    final db = await initializeDB();

    var resultado = await db.rawInsert(
        "INSERT INTO scoreTable (modulo, nivel, score) "
        "VALUES (${ScoreGamiLibre.modulo}, ${ScoreGamiLibre.nivel}, ${ScoreGamiLibre.score})");
  }

//La siguiente funcion elimina ej puntaje segun el ID
  Future<void> deleteScore(int id) async {
    final db = await initializeDB();
    await db.delete(
      'scoreTable',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

//La siguiente funcion hace la consulta de todos los puntajes segun el modulo seleccionado
  Future<List<scoreColpaner>> QueryAllScoresRC() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db
        .rawQuery('SELECT * FROM scoreTable WHERE modulo like ?', ['%MAT%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }
    return queryResult.map((e) => scoreColpaner.fromMap(e)).toList();
  }

//La siguiente funcion hace la consulta de todos los puntajes segun el modulo seleccionado
  Future<List<scoreColpaner>> QueryAllScoresDS() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db
        .rawQuery('SELECT * FROM scoreTable WHERE modulo like ?', ['%ING%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }
    return queryResult.map((e) => scoreColpaner.fromMap(e)).toList();
  }
}
