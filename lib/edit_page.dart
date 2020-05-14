import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

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
