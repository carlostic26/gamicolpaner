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
      join(path, 'gamiColpaner1.db'),
      onCreate: (database, version) async {
        const String sql = ''
            'CREATE TABLE scoreTable ('
            ' id TEXT PRIMARY KEY,'
            ' modulo TEXT,'
            ' nivel TEXT,'
            ' score TEXT'
            ');';

        await database.execute(sql);
        const String addScoreGame = ''
            'INSERT INTO scoreTable(id, modulo, nivel, score) VALUES '
            //son 4 valores correspondiente al puntaje segun el modulo
            '("MAT1", "MAT", "1", "0"),'
            '("MAT2", "MAT", "2", "0"),'
            '("MAT3", "MAT", "3", "0"),'
            '("MAT4", "MAT", "4", "0"),'
            '("MAT5", "MAT", "5", "0"),'
            '("MAT6", "MAT", "6", "0"),'
            '("MAT7", "MAT", "7", "0"),'
            '("MAT8", "MAT", "8", "0"),'
            '("MAT9", "MAT", "9", "0"),'
            '("MAT10", "MAT", "10", "0"),'
            '("MAT11", "MAT", "11", "0"),'

            //son 4 valores correspondiente al puntaje segun el modulo
            '("ING1", "ING", "1", "0"),'
            '("ING2", "ING", "2", "0"),'
            '("ING3", "ING", "3", "0"),'
            '("ING4", "ING", "4", "0"),'
            '("ING5", "ING", "5", "0"),'
            '("ING6", "ING", "6", "0"),'
            '("ING7", "ING", "7", "0"),'
            '("ING8", "ING", "8", "0"),'
            '("009", "ING", "9", "0"),'
            '("ING10", "ING", "10", "0"),'
            '("ING11", "ING", "11", "0")';

        await database.execute(addScoreGame);

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
