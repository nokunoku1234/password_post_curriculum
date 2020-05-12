import 'package:flutter/material.dart';

class AddPassword extends StatefulWidget {

  @override
  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {

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
                Text('テストタイトル'),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0),),
            Row(
              children: <Widget>[
                Container(
                  width: 100,
                  child: Text('ID'),
                ),
                Text('テストID'),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0),),
            Row(
              children: <Widget>[
                Container(
                  width: 100,
                  child: Text('パスワード'),
                ),
                Text('テストパスワード'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
