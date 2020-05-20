import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:starter_course/utils/db_provider.dart';
import 'package:starter_course/model/model.dart';
import 'add_password.dart';
import 'confirm_pass.dart';
import '../utils/method.dart';

List<int> stageList = [0];

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<FileData> fileList = [];
  List<FolderData> folderList = [];
  Widget _widget;

  Future<void> setDb() async{
    final dbProvider = DBProvider.instance;
    await dbProvider.initializeDatabase();


    await DBProvider.setDb();
    fileList = await DBProvider.getFileData();
    folderList = await DBProvider.getFolderData();

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
        leading: (stageList[stageList.length - 1] == 0) ? Container() : IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            stageList.removeLast();
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.folder),
            onPressed: () async{
              await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPassword('フォルダー追加', false)));
              setDb();
            }
          ),
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int i) {

                if(i < folderList.length) {
//                        print(folderList[i].parent);
//                        print(fileList[i].parent);
                  if (stageList[stageList.length - 1] == folderList[i].parent) {
                    _widget = Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.folder),
                          title: Text(folderList[i].title),
                          onTap: () {
                            stageList.add(folderList[i].id);
                            print(stageList);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },
                        ),
                        Divider(height: 0.0,),
                      ],
                    );
                  } else {
                    _widget = Container();
                  }
                } else {
                  if(stageList[stageList.length - 1] == fileList[i - folderList.length].parent) {
                    _widget = Column(
                      children: <Widget>[
                        Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actions: <Widget>[
                            IconSlideAction(
                              icon: Icons.content_copy,
                              color: Colors.blue,
                              caption: 'ID',
                              onTap: () {
                                Copy.idCopy(fileList[i - folderList.length].passId);
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
                                Copy.pwCopy(fileList[i - folderList.length].passPw);
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('パスワードをコピーしました'), duration: Duration(seconds: 1),)
                                );
                              },
                            ),
                          ],
                          child: ListTile(
                            title: Text(fileList[i - folderList.length].title),
                            leading: Icon(Icons.vpn_key),
                            onTap: () {
                              pushConfirmPage(i);
                            },
                          ),
                        ),
                        Divider(height: 0.0,),
                      ],
                    );
                  } else {
                    _widget = Container();
                  }
                }
                return _widget;
              },
              itemCount: fileList.length + folderList.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPassword('パスワード追加', true)));
          setDb();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> pushConfirmPage(int i) async{
    FileData _saveData = FileData(
      id: fileList[i].id,
      title: fileList[i].title,
      passId: fileList[i].passId,
      passPw: fileList[i].passPw,
    );
    await Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmPass(_saveData)));
    setDb();
  }
}
