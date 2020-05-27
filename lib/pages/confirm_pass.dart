import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_course/model/model.dart';
import 'package:starter_course/pages/edit_page.dart';
import 'package:starter_course/utils/db_provider.dart';
import 'package:starter_course/utils/method.dart';

class ConfirmPass extends StatefulWidget {

  final FileData fileData;
  ConfirmPass(this.fileData);

  @override
  _ConfirmPassState createState() => _ConfirmPassState();
}

class _ConfirmPassState extends State<ConfirmPass> {

  Future<void> deleteList() async{
    await DBProvider.deleteSaveData(tableName: 'file', id :widget.fileData.id);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void iDClipboardCopy() async{
    var idData = ClipboardData(text: widget.fileData.passId);
    await Clipboard.setData(idData);
  }

  void pwClipboardCopy() async{
    var pwData = ClipboardData(text: widget.fileData.passPw);
    await Clipboard.setData(pwData);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileData.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async{
              await Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(fileData: widget.fileData)));
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
                        Method.buildShowModalPopup(context, fileData: widget.fileData);
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
