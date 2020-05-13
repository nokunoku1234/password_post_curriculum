import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmPass extends StatefulWidget {

  final int i;
  final List<String> titleList;
  final List<String> idList;
  final List<String> pwList;
  ConfirmPass(this.i, this.titleList, this.idList, this.pwList);

  @override
  _ConfirmPassState createState() => _ConfirmPassState();
}

class _ConfirmPassState extends State<ConfirmPass> {

  void deleteList() {
    widget.titleList.removeAt(widget.i);
    widget.idList.removeAt(widget.i);
    widget.pwList.removeAt(widget.i);
    Navigator.pop(context);

    print('id: ${widget.idList}');
    print('pw: ${widget.pwList}');
  }

  void iDClipboardCopy() async{
    var idData = ClipboardData(text: widget.idList[widget.i]);
    await Clipboard.setData(idData);
    print('IDコピー');
  }

  void pwClipboardCopy() async{
    var pwData = ClipboardData(text: widget.pwList[widget.i]);
    await Clipboard.setData(pwData);
    print('PWコピー');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('パスワード確認'),),
      body: Builder(
        builder: (BuildContext context) {
          return Padding(
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
                        iDClipboardCopy();
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('IDをコピー'), duration: Duration(seconds: 1),)
                        );
                      },
                      child: Text('IDをコピー'),

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
                        pwClipboardCopy();
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('PWをコピー'), duration: Duration(seconds: 1),)
                        );
                      },
                      child: Text('パスワードをコピー')
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
          );
        }
      ),
    );
  }
}
