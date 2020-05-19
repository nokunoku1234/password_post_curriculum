import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:starter_course/utils/db_provider.dart';
import 'package:starter_course/model/model.dart';
import 'add_password.dart';
import 'confirm_pass.dart';
import '../utils/method.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<SaveData> pwList = [];

  Future<void> setDb() async{
    await DBProvider.setDb();
    pwList = await DBProvider.getSaveData();

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async{
              await DBProvider.deleteAll();
              setDb();
            },
          )
        ],
        title: Text('パスワード管理'),
      ),
      body: Builder(
          builder: (BuildContext context) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int i) {
                return Column(
                  children: <Widget>[
                    Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actions: <Widget>[
                        IconSlideAction(
                          icon: Icons.content_copy,
                          color: Colors.blue,
                          caption: 'ID',
                          onTap: () {
                            Copy.idCopy(pwList[i].passId);
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('IDをコピーしました'), duration: Duration(seconds: 1),)
                            );
                          },
                        ),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          icon: Icons.content_copy,
                          color: Colors.blue,
                          caption: 'PW',
                          onTap: () {
                            Copy.pwCopy(pwList[i].passPw);
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('パスワードをコピーしました'), duration: Duration(seconds: 1),)
                            );
                          },
                        ),
                      ],
                      child: ListTile(
                        title: Text(pwList[i].title),
                        leading: Icon(Icons.vpn_key),
                        onTap: () {
                          pushConfirmPage(i);
                        },
                      ),
                    ),
                    Divider(height: 0.0,),
                  ],
                );
              },
              itemCount: pwList.length,
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPassword()));
          setDb();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> pushConfirmPage(int i) async{
    SaveData _saveData = SaveData(
      id: pwList[i].id,
      title: pwList[i].title,
      passId: pwList[i].passId,
      passPw: pwList[i].passPw,
    );
    await Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmPass(_saveData)));
    setDb();
  }
}
