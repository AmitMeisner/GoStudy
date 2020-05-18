


import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Progress.dart';
import 'package:flutterapp/Tips.dart';
import 'package:flutterapp/Statistics.dart';
import 'HomePage/HomeNavigation.dart';

class NavigationButtomPage extends StatefulWidget {
  @override
  _NavigationButtomState createState() => _NavigationButtomState();
}

class _NavigationButtomState extends State<NavigationButtomPage> {
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
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.accessibility, size: 30),
            Icon(Icons.compare_arrows, size: 30),
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