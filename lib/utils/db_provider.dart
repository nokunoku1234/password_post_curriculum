import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:starter_course/model/model.dart';

class DBProvider {

  static Database database;

  static Future<void> setDb() async{
    if(database == null) {
      database = await initDb();
      return database;
    } else {
      return database;
    }
  }

  static Future<Database> initDb() async{
    String path = join(await getDatabasesPath(), "password_post.db");

    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  static Future<void> _createTable(Database db, int version) async {
    return await db.execute(
      "CREATE TABLE password_post(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, pass_id TEXT, pass_pw TEXT, date TEXT)",
    );
  }

  //insert文
  static Future<void> insertSaveData(SaveData saveData) async{
    await database.insert(
      'password_post',
      {
        'title': saveData.title,
        'pass_id': saveData.passId,
        'pass_pw': saveData.passPw,
        'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(saveData.date)
      }
    );
  }

  //select文
  static Future<List<SaveData>> getSaveData() async{
    final List<Map<String, dynamic>> maps = await database.query('password_post');
    return List.generate(maps.length, (i){
      return SaveData(
        id: maps[i]['id'],
        title: maps[i]['title'],
        passId: maps[i]['pass_id'],
        passPw: maps[i]['pass_pw'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  //update文
  static Future<void> updateSaveData(SaveData saveData, int id) async {
    await database.update(
      'password_post',
      {
        'title' : saveData.title,
        'pass_id' : saveData.passId,
        'pass_pw': saveData.passPw,
        'date' : DateFormat('yyyy-MM-dd HH:mm:ss').format(saveData.date)
      },
      where: "id = ?",
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  //delete文
  static Future<void> deleteSaveData(int id) async {
    await database.delete(
      'password_post',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //DBの削除
  static Future<void> deleteAll() async {
    await database.delete('password_post');
  }

}