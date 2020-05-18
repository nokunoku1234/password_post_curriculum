import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:starter_course/utils/db.dart';
import 'package:starter_course/model/model.dart';
import 'add_password.dart';
import 'confirm_pass.dart';
import '../utils/method.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> titleList = ['Amazon', '楽天', 'Yahoo!'];
  List<String> idList = ['Amazon', '楽天', 'Yahoo!'];
  List<String> pwList = ['Amazon', '楽天', 'Yahoo!'];

  List<SaveData> list = [];

  Future<void> setDb() async{
    await DBProvider.setDb();
    list = await DBProvider.getSaveData();

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
                            Copy.idCopy(list[i].passId);
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
                            Copy.pwCopy(list[i].passPW);
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('パスワードをコピーしました'), duration: Duration(seconds: 1),)
                            );
                          },
                        ),
                      ],
                      child: ListTile(
                        title: Text(list[i].title),
                        leading: Icon(Icons.vpn_key),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmPass(i, titleList, idList, pwList)));
                        },
                      ),
                    ),
                    Divider(height: 0.0,),
                  ],
                );
              },
              itemCount: list.length,
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPassword(titleList, idList, pwList)));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
