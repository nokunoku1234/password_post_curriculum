import 'package:flutter/material.dart';
import 'package:starter_course/model/model.dart';
import 'package:starter_course/utils/db_provider.dart';

import 'home_page.dart';

class AddPassword extends StatefulWidget {

  final String title;
  final bool _fileAdd;

  AddPassword(this.title, this._fileAdd);

  @override
  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {

  TextEditingController titleController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  bool _showPassword = false;

  void addFile() async{
    FileData _fileData = FileData(
        title: titleController.text,
        passId: idController.text,
        passPw: pwController.text,
        parent: stageList[stageList.length - 1],
        date: DateTime.now()
    );
    await DBProvider.insertSaveData(tableName: 'file', isFile: true, fileData: _fileData);
    Navigator.pop(context);
  }

  void addFolder() async{
    FolderData _folderData = FolderData(
        title: titleController.text,
        parent: stageList[stageList.length - 1],
        date: DateTime.now()
    );
    await DBProvider.insertSaveData(tableName: 'folder', isFile: false, folderData: _folderData);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 100,
                  child: Text('タイトル'),
                ),
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'タイトル'
                    ),
                  ),
                ),
              ],
            ),
            widget._fileAdd ?
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text('ID'),
                  ),
                  Expanded(
                    child: TextField(
                      controller: idController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'ID'
                      ),
                    ),
                  ),
                ],
              ),
            ) : Container(),
            widget._fileAdd ?
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text('パスワード'),
                  ),
                  Expanded(
                    child: TextField(
                      controller: pwController,
                      obscureText: _showPassword ? false : true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'パスワード',
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: _showPassword ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            _showPassword = !_showPassword;
                            setState(() {

                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) : Container(),
            Padding(padding: EdgeInsets.all(20.0),),
            Container(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                color: Colors.blue,
                onPressed: () {
                  widget._fileAdd ? addFile() : addFolder();
                },
                child: Text('追加', style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
