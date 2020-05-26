


import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Progress.dart';
import 'file:///D:/anroid%20studio%20apps/go_Study/lib/Statistics/Statistics.dart';
import 'package:flutterapp/Tips/Tips.dart';
import 'HomePage/HomeNavigation.dart';

class NavigationBottomPage extends StatefulWidget {
  @override
  _NavigationBottomState createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottomPage> {
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final ProgressPage _progress = ProgressPage();
  final TipsPage _tips = TipsPage();
  final HomeNavPage _home = HomeNavPage();
  final StatisticsPage _statistics = StatisticsPage();

  Widget _showPage = new HomeNavPage();
  Widget _pageChooser (int page){
    switch(page){
      case 0:
        return _home;
        break;
      case 1:
        return _statistics;
        break;
      case 2:
        return _tips;
        break;
      case 3:
        return _progress;
        break;
      default:
        return _home;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 50.0,
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.insert_chart, size: 30),
            Icon(Icons.highlight, size: 30),
            Icon(Icons.show_chart, size: 30),
          ],
          onTap: (int index) {
            setState(() {
              _showPage = _pageChooser(index);
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _showPage,
          ),
        ));
  }
}