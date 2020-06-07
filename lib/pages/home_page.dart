import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:starter_course/pages/edit_page.dart';
import 'package:starter_course/utils/db_provider.dart';
import 'package:starter_course/model/model.dart';
import 'add_password.dart';
import 'confirm_pass.dart';
import '../utils/method.dart';

List<int> stageList = [0];

class HomePage extends StatefulWidget {

  final String title;
  HomePage(this.title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<FileData> fileList = [];
  List<FolderData> folderList = [];
  Widget _widget;

  Future<void> setDb() async{
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
        centerTitle: true,
        leading: (stageList[stageList.length - 1] == 0) ? Container() : IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            stageList.removeLast();
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          (stageList.length < 5) ?
          IconButton(
            icon: Icon(Icons.folder),
            onPressed: () async{
              await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPassword('フォルダー追加', false)));
              setDb();
            }
          ) : Container(),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async{
              await DBProvider.deleteAll();
              setDb();
            },
          )
        ],
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int i) {

                //フォルダ表示に関する記述 → フォルダがあればifの内容を実施。
                if(i < folderList.length) {
                  //任意の階層に表示できるよう記述 → stageListが今いる階層。そこにfolderListのparentが一致するやつだけを表示。
                  if (stageList[stageList.length - 1] == folderList[i].parent) {
                    _widget = Column(
                      children: <Widget>[
                        ListTile(
                          trailing: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: (){
                              buildShowModalBottomSheet(folderData: folderList[i]);
                            },
                          ),
                          leading: Icon(Icons.folder),
                          title: Text(folderList[i].title),
                          onTap: () {
                            //一つ下の階層に移動。
                            stageList.add(folderList[i].id);
                            print(stageList);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(folderList[i].title)));
                          },
                        ),
                        Divider(height: 0.0,),
                      ],
                    );
                  } else {
                    //parentが一致しないときには何も表示しない → 新しい階層に行った際のクリーンなページを表示。
                    _widget = Container();
                  }
                  //ファイル表示に関する記述 → フォルダを表示し切ったらファイルを表示。
                } else {
                  //任意の階層に表示できるよう記述 → ファイル表示はフォルダー表示を終えた後に行う。従って[i - folderList.length]によってfileを適切に取り出す。
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
                                Method.idCopy(fileList[i - folderList.length].passId);
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
                                Method.pwCopy(fileList[i - folderList.length].passPw);
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('パスワードをコピーしました'), duration: Duration(seconds: 1),)
                                );
                              },
                            ),
                          ],
                          child: ListTile(
                            title: Text(fileList[i - folderList.length].title),
                            leading: Icon(Icons.vpn_key),
                            trailing: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () async{
                                await buildShowModalBottomSheet(fileData: fileList[i - folderList.length]);
                                setDb();
                              },
                            ),
                            onTap: () async{
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmPass(fileList[i - folderList.length])));
                              setDb();
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

  Future<void> buildShowModalBottomSheet({FileData fileData, FolderData folderData}) {
    return showModalBottomSheet(
      context: context, builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('編集'),
            onTap: () async{
              Navigator.pop(context);
              await Navigator.push(context, MaterialPageRoute(builder: (context) => (folderData == null) ? EditPage(fileData: fileData) : EditPage(folderData: folderData)));
              setDb();
            },
          ),
          Divider(height: 0.0,),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('削除'),
            onTap: () async{
              await Method.buildShowModalPopup(context, fileData: fileData, folderData: folderData);
              setDb();
            },
          ),
        ],
      );
    });
  }

}
