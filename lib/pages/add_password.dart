import 'package:flutter/material.dart';
import 'package:starter_course/model/model.dart';
import 'package:starter_course/utils/db_provider.dart';

class AddPassword extends StatefulWidget {

  final List<String> titleList;
  final List<String> idList;
  final List<String> pwList;
  AddPassword(this.titleList, this.idList, this.pwList);

  @override
  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {

  TextEditingController titleController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  bool _showPassword = false;

  void addPassword() {
    widget.titleList.add(titleController.text);
    widget.idList.add(idController.text);
    widget.pwList.add(pwController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('パスワード追加'),
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
            Padding(padding: EdgeInsets.all(10.0),),
            Row(
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
            Padding(padding: EdgeInsets.all(10.0),),
            Row(
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
            Padding(padding: EdgeInsets.all(20.0),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                color: Colors.blue,
                onPressed: () async{
                  SaveData _saveData = SaveData(
                    title: titleController.text,
                    passId: idController.text,
                    passPW: pwController.text,
                    date: DateTime.now()
                  );
                  await DBProvider.insertSaveData(_saveData);
                  Navigator.pop(context);
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
