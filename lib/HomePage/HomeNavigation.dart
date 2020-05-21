


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Calender/Calender.dart';
import 'Extra/Extra.dart';
import 'Timer/HomeMain.dart';
import 'Top20/Top20.dart';

class HomeNavPage extends StatefulWidget {
  final Widget child;
  HomeNavPage({Key key, this.child}) : super(key: key);
  _HomeNavPageState createState() => _HomeNavPageState();
}

Color primaryColor =  Color(0xff109618);

class _HomeNavPageState extends State<HomeNavPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              // backgroundColor: Color(0xff109618),
              backgroundColor: primaryColor,
//            title: Text("GoStudyHome"),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 6.0,
                onTap: (int index){
                  setState(() {
                    switch (index) {
                      case 0:
                        primaryColor= Color(0xffff5722);
                        break;
                      case 1:
                        primaryColor= Color(0xff3f51b5);
                        break;
                      case 2:
                        primaryColor= Color(0xffe91e63);
                        break;
                      case 3:
                        primaryColor= Color(0xff9c27b0);
                        break;

                    default:
                  }
                });
              },
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Text(
                      'HOME',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'CALENDER',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'TOP20',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'EXTRA',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),

              ],
            ),
              ),
          ),
            body: TabBarView(
            children: <Widget>[
              HomeMainPage(),//ff5722
              CalenderPage(),//3f51b5
              top20Table(),//e91e63
              ExtraPage(), //9c27b0

            ],
          )
          ),
    );
  }

}