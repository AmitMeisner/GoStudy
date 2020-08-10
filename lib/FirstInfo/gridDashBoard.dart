import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';
import 'InfoCourse.dart';


class GridDashboard extends StatefulWidget {
  @override
  GridDashboardState createState() => GridDashboardState();
}

class GridDashboardState extends State<GridDashboard> {

  static bool updated=false;
  static List<String> oldCourses=  oldCourses = Global().allCourses ;


  Widget build(BuildContext context) {
    var myGridView = new GridView.builder(
      itemCount: oldCourses.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 8.0,
            color:  (index % 2 == 0) ? Global.getBackgroundColor(200): Global.getBackgroundColor(50),
            shadowColor: Global.getBackgroundColor(0),
            child: new Container(
              alignment: Alignment.center,
              margin: new EdgeInsets.only(top: 10.0, bottom: 10.0,left: 10.0),
              child: new Text(oldCourses[index], style:  TextStyle(fontFamily: 'Piedra', fontSize: 16.0),),
            ),
          ),
          onTap: () {
            navigateToInfoPage(context, index);
          },
        );
      },
    );

    return  Scaffold(
      backgroundColor: Global.getBackgroundColor(0),
      body: SafeArea(
          child: Container(
              color: Colors.white,
              child: myGridView)
      ),
    );
  }


}

// navigate to the chosen page.
Future navigateToInfoPage(context,index) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoCourse(index)));
}



