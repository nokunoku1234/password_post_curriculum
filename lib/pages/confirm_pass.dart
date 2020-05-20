import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_course/model/model.dart';
import 'package:starter_course/pages/edit_page.dart';
import 'package:starter_course/utils/db_provider.dart';

class ConfirmPass extends StatefulWidget {

  final FileData saveData;
  ConfirmPass(this.saveData);

  @override
  _ConfirmPassState createState() => _ConfirmPassState();
}

class _ConfirmPassState extends State<ConfirmPass> {

  Future<void> deleteList() async{
//    await DBProvider.deleteSaveData(widget.saveData.id);
    Navigator.pop(context);
  }



  void iDClipboardCopy() async{
    var idData = ClipboardData(text: widget.saveData.passId);
    await Clipboard.setData(idData);
  }

  void pwClipboardCopy() async{
    var pwData = ClipboardData(text: widget.saveData.passPw);
    await Clipboard.setData(pwData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.saveData.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async{
              await Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(widget.saveData)));
            }
          )
        ],
      ),
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
