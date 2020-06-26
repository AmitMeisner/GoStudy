


import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Progress/Progress.dart';
import 'Global.dart';
import 'HomePage/HomeMain.dart';
import 'Statistics/Statistics.dart';
import 'package:flutterapp/Tips/Tips.dart';
import 'Progress/ProgressPageNav.dart';
import 'StatisticsNew/StatisticsPage.dart';

class NavigationBottomPage extends StatefulWidget {
  @override
  _NavigationBottomState createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottomPage> {
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final ProgressPageNav _progress=ProgressPageNav();
  final TipsPage _tips = TipsPage();
  final HomeMainPage _home = HomeMainPage();
//  final StatisticsPage _statistics = StatisticsPage();
  final NewStatistics _statistics=NewStatistics();

  Widget _showPage = new HomeMainPage();
  Widget _pageChooser (int page){
    switch(page){
      case 0:
        return _home;
        break;
      case 1:
        return _progress;
        break;
      case 2:
        return _statistics;
        break;
      case 3:
        return _tips;
        break;
      default:
        return _home;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Global.getBackgroundColor(0),
          height: 50.0,
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.trending_up, size: 30),
            Icon(Icons.insert_chart, size: 30),
            Icon(Icons.lightbulb_outline, size: 30),
          ],
          onTap: (int index) {
            setState(() {
              _showPage = _pageChooser(index);
            });
          },
        ),
        body: Container(
          color: Global.getBackgroundColor(0),
          child: Center(
            child: _showPage,
          ),
        ));
  }
}