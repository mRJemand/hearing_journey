import 'package:flutter/material.dart';
import 'package:hearing_journey/screens/home_screen.dart';
import './diary_screen.dart';
import './help_screen.dart';
import './profile_screen.dart';
import './settings_screen.dart';
import 'tips_category_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': HomeScreen(),
      'title': 'Hearing Journey',
    },
    {
      'page': TippsCategoryScreen(),
      'title': 'Tipps',
    },
    {
      'page': DiaryScreen(),
      'title': 'Tagebuch',
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _selectPage,
      //   backgroundColor: Theme.of(context).primaryColor,
      //   unselectedItemColor: Colors.white,
      //   selectedItemColor: Theme.of(context).accentColor,
      //   currentIndex: _selectedPageIndex,
      //   // type: BottomNavigationBarType.shifting,
      //   items: [
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).primaryColor,
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).primaryColor,
      //       icon: Icon(Icons.edit),
      //       label: 'Edit',
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).primaryColor,
      //       icon: Icon(Icons.book),
      //       label: 'Diary',
      //     ),
      //   ],
      // ),
    );
  }
}
