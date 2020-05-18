import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {

  final int i;
  final List<String> titleList;
  final List<String> idList;
  final List<String> pwList;

  EditPage(this.i, this.titleList, this.idList, this.pwList);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  void editPassword() {
    widget.titleList[widget.i] = titleController.text;
    widget.idList[widget.i] = idController.text;
    widget.pwList[widget.i] = pwController.text;
    Navigator.pop(context);

    print('id: ${widget.idList}');
    print('pw: ${widget.pwList}');
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
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'パスワード'
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
                onPressed: () {
                  editPassword();
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
