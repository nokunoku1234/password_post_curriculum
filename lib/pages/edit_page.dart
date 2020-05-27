import 'package:flutter/material.dart';
import 'package:starter_course/model/model.dart';
import 'package:starter_course/pages/home_page.dart';
import 'package:starter_course/utils/db_provider.dart';

class EditPage extends StatefulWidget {

  final FileData fileData;
  final FolderData folderData;
  EditPage({this.fileData, this.folderData});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  void editFile({FileData fileData, FolderData folderData}) async{
    (fileData != null) ?
      fileData = FileData(
        id: widget.fileData.id,
        title: titleController.text,
        passId: idController.text,
        passPw: pwController.text,
        parent: stageList[stageList.length - 1],
        date: DateTime.now(),
      )
    : folderData = FolderData(
      id: widget.folderData.id,
      title: titleController.text,
      parent: stageList[stageList.length - 1],
      date: DateTime.now(),
    );
    await DBProvider.updateSaveData(tableName: (fileData != null) ? 'file' : 'folder', fileData: fileData, folderData: folderData);
    while(Navigator.canPop(context)) {
      stageList = [0];
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('パスワード編集'),),
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
            (widget.fileData != null) ?
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
            (widget.fileData != null) ?
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
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'パスワード'
                      ),
                    ),
                  ),
                ],
              ),
            ) : Container(),
            Padding(padding: EdgeInsets.all(20.0),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                color: Colors.blue,
                onPressed: () {
                  editFile(fileData: widget.fileData, folderData: widget.folderData);
                },
                child: Text('修正', style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
