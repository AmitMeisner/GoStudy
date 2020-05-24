


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Nadine/AndroidStudioProjects/flutter_app/lib/HomePage/Calender/Calender.dart';
import 'file:///C:/Users/Nadine/AndroidStudioProjects/flutter_app/lib/HomePage/Extra/Extra.dart';
import 'file:///C:/Users/Nadine/AndroidStudioProjects/flutter_app/lib/HomePage/Timer/HomeMain.dart';
import 'file:///C:/Users/Nadine/AndroidStudioProjects/flutter_app/lib/HomePage/Top20/Top20.dart';

class HomeNavPage extends StatefulWidget {
  final Widget child;
  HomeNavPage({Key key, this.child}) : super(key: key);
  _HomeNavPageState createState() => _HomeNavPageState();
}

Color PrimaryColor =  Color(0xffff5722);

class _HomeNavPageState extends State<HomeNavPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Color(0xff109618),
            backgroundColor: PrimaryColor,
            title: Text("GoStudyHome"),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 6.0,
              onTap: (int index){
                setState(() {
                  switch (index) {
                    case 0:
                      PrimaryColor= Color(0xffff5722);
                      break;
                    case 1:
                      PrimaryColor= Color(0xff3f51b5);
                      break;
                    case 2:
                      PrimaryColor= Color(0xffe91e63);
                      break;
                    case 3:
                      PrimaryColor= Color(0xff9c27b0);
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
          body: TabBarView(
            children: <Widget>[
              HomeMainPage(),//ff5722
              CalenderPage(),//3f51b5
              top20Table(),//e91e63
              ExtraPage(), //9c27b0

            ],
          )),
    );
  }

}