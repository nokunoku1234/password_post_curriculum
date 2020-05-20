import 'package:intl/intl.dart';

class FileData {

  static final tableName = 'file';

  int id;
  String title;
  String passId;
  String passPw;
  int parent;
  DateTime date;

  FileData({this.id, this.title, this.passId, this.passPw, this.parent, this.date});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['title'] = title;
    map['pass_id'] = passId;
    map['pass_pw'] = passPw;
    map['parent'] = parent;
    map['date'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);

    return map;
  }

  static final sqlCreateTable = '''
  CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, pass_id TEXT, pass_pw TEXT, parent INTEGER, date TEXT)
  ''';

}

class FolderData {

  static final tableName = 'folder';
  int id;
  String title;
  int parent;
  DateTime date;

  FolderData({this.id, this.title, this.parent, this.date});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['title'] = title;
    map['parent'] = parent;
    map['date'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);

    return map;
  }

  static final sqlCreateTable = '''
  CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, parent INTEGER, date TEXT)
  ''';
}
