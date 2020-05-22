
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:starter_course/model/model.dart';

class DBProvider {

  static Database database;

  DBProvider._internal();

  static final instance = DBProvider._internal();


  static Future<void> setDb() async{
    if(database == null) {
      database = await initDb();
      return database;
    } else {
      return database;
    }
  }

  static Map<int, String> createTableList = {
    2 : FileData.sqlCreateTable,
    3 : FolderData.sqlCreateTable,
  };

  static Future<Database> initDb() async{
    String path = join(await getDatabasesPath(), "password_post.db");

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createTable,
      onUpgrade: (Database db, int oldVersion, int newVersion) async{
        for(int i = oldVersion + 1; i <= newVersion; i++) {
          var query = createTableList[i];
          await db.execute(query);
        }
      },
    );
  }

  static Future<void> _createTable(Database db, int version) async {
    await db.execute(FileData.sqlCreateTable);
    await db.execute(FolderData.sqlCreateTable);
  }

  //insert文
  static Future<void> insertSaveData({String tableName, bool isFile, FileData fileData, FolderData folderData}) async{
    await database.insert(
      tableName, isFile ? fileData.toMap() : folderData.toMap());
  }

  //select文
  static Future<List<FileData>> getFileData() async{
    var maps = await database.query('file');
    return List.generate(maps.length, (i){
      return FileData(
        id: maps[i]['id'],
        title: maps[i]['title'],
        passId: maps[i]['pass_id'],
        passPw: maps[i]['pass_pw'],
        parent: maps[i]['parent'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  static Future<List<FolderData>> getFolderData() async{
    var maps = await database.query('folder');
    return List.generate(maps.length, (i){
      return FolderData(
        id: maps[i]['id'],
        title: maps[i]['title'],
        parent: maps[i]['parent'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  //update文
  static Future<void> updateSaveData({String tableName, bool isFile, FileData fileData, FolderData folderData}) async {
    await database.update(
      tableName,
      isFile ? fileData.toMap() : folderData.toMap(),
      where: "id = ?",
      whereArgs: isFile ? [fileData.id] : [folderData.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  //delete文
  static Future<void> deleteSaveData({String tableName, int id}) async {
    await database.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //DBの削除
  static Future<void> deleteAll() async {
    await database.delete('file');
    await database.delete('folder');

  }

}