
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';
import 'package:google_fonts/google_fonts.dart';

import 'InfoCourse.dart';


class GridDashboard extends StatefulWidget {
  @override
  GridDashboardState createState() => GridDashboardState();
}

class GridDashboardState extends State<GridDashboard> {

  Widget build(BuildContext context) {
    var allCourses = Global().getAllCourses();
    var myGridView = new GridView.builder(
      itemCount: allCourses.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 8.0,
            shadowColor: Global.getBackgroundColor(0),
            child: new Container(
              alignment: Alignment.center,
              margin: new EdgeInsets.only(top: 10.0, bottom: 10.0,left: 10.0),
              child: new Text(allCourses[index], style:  TextStyle(fontFamily: 'Piedra', fontSize: 16.0),),
            ),
          ),
          onTap: () {
            navigateToInfoPage(context, index);
            },
        );
      },
    );

    return  Scaffold(
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
        backgroundColor: Global.getBackgroundColor(0),
      ),),
      body: myGridView,
    );
  }


}


Future navigateToInfoPage(context,index) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoCourse(index)));
}

