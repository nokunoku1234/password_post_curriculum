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
                ),
                Divider(),
              ],
            );
          },
          itemCount: titleList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleList.add('Google');
          setState(() {

          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


//todo 新しい画面を作成し、リストをタップしたときに遷移
//todo 新しい画面のレイアウトを作成
//todo 新しい画面にリストからデータを引き継ぐ


