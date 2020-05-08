import 'package:flutter/material.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('パスワード管理'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Amazon'),
            leading: Icon(Icons.vpn_key),
          ),
          Divider(),
          ListTile(
            title: Text('楽天'),
            leading: Icon(Icons.vpn_key),
          ),
          Divider(),
          ListTile(
            title: Text('Yahoo!'),
            leading: Icon(Icons.vpn_key),
          ),
          Divider(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

//todo ホーム画面のタイトル変更
//todo リスト表示
//todo フロートアクションボタンをタップしたときに、リストにひとつ追加
//todo 新しい画面を作成し、リストをタップしたときに遷移
//todo 新しい画面のレイアウトを作成
//todo 新しい画面にリストからデータを引き継ぐ


