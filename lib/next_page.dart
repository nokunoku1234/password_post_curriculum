import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  child: Text('ID'),
                ),
                Container(
                  width: 20,
                  child: Text(':'),
                ),
                Text('毎回同じテキストを表示ID'),
              ],
            ),
            Padding(padding: EdgeInsets.all(5.0),),
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  child: Text('PW'),
                ),
                Container(
                  width: 20,
                  child: Text(':'),
                ),
                Text('毎回同じパスワードを表示PW'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
