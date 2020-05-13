import 'package:flutter/material.dart';

class ConfirmPass extends StatefulWidget {

  final List<String> titleList;
  final int i;
  ConfirmPass(this.titleList, this.i);

  @override
  _ConfirmPassState createState() => _ConfirmPassState();
}

class _ConfirmPassState extends State<ConfirmPass> {

  void deleteList() {
    widget.titleList.removeAt(widget.i);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('パスワード確認'),),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: 300,
                height: 50,
                child: OutlineButton(
                  borderSide: BorderSide(color: Colors.black),
                  shape: StadiumBorder(),
                  onPressed: () {

                  },
                  child: Text('IDを表示'),

                ),
              ),
              Padding(padding: EdgeInsets.all(20.0),),
              Container(
                width: 300,
                height: 50,
                child: OutlineButton(
                  borderSide: BorderSide(color: Colors.black),
                  shape: StadiumBorder(),
                  onPressed: () {

                  },
                  child: Text('パスワードを表示')
                ),
              ),
              Padding(padding: EdgeInsets.all(30.0),),
              Container(
                width: 300,
                height: 50,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Colors.red,
                  child: Text('削除', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    deleteList();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
