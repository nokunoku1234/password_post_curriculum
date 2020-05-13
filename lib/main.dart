import 'package:flutter/material.dart';
import 'package:starter_course/add_password.dart';
import 'package:starter_course/confirm_pass.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> titleList = ['Amazon', '楽天', 'Yahoo!'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('パスワード管理'),
      ),
      body: ListView.builder(
          itemBuilder: (BuildContext context, int i) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(titleList[i]),
                  leading: Icon(Icons.vpn_key),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmPass(titleList, i)));
                  },
                ),
                Divider(height: 0.0,),
              ],
            );
          },
          itemCount: titleList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPassword(titleList)));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

//todo IDとPWのListも作成し情報管理する
//todo クリップボードコピー
//todo スライダブル実装
//todo テーマカラー変更
//todo ダイアログ表示


