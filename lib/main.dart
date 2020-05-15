import 'package:flutter/material.dart';
import 'package:starter_course/home_page.dart';
import 'package:starter_course/setting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(title: 'Flutter Demo Home Page'),
    );
  }
}

class Main extends StatefulWidget {
  Main({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onItemTapped(int index) {
    _pageController.animateToPage(index, duration: Duration(milliseconds: 1), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (int index) {
          _selectedIndex = index;
          setState(() {

          });
        },
        controller: _pageController,
        children: <Widget>[
          HomePage(),
          Setting()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('ホーム')),
          BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('設定')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

//todo ボトムナビゲーションの追加
//todo ダイアログ表示


