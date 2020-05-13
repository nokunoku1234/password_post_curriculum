import 'package:flutter/material.dart';

class AddPassword extends StatefulWidget {

  final List<String> titleList;
  AddPassword(this.titleList);

  @override
  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {

  TextEditingController titleController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  void addPassword() {
    widget.titleList.add(titleController.text);
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
                  addPassword();
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
