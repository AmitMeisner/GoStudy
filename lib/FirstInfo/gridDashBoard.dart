
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'InfoCourse.dart';
import 'InfoCourse.dart';
import 'InformationPage.dart';


class GridDashboard extends StatefulWidget {
  @override
  GridDashboardState createState() => GridDashboardState();
}

class GridDashboardState extends State<GridDashboard> {

  static bool updated=false;
  static List<String> oldCourses=  oldCourses = Global().allCourses ;

//  Future<void>  updateCourses() async {
//    oldCourses= await InformationPageState.getOldCourses();
//    updated=true;
//    setState(() {});
//  }



  Widget build(BuildContext context) {
//    if(!updated){
//      oldCourses=Global.getAllCourses();
//      updateCourses();
//      return Loading();
//    }
  //  updated=false;
    setState(() {});
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
//      appBar: new PreferredSize(
//        preferredSize: Size.fromHeight(48.0),
//        child: AppBar(
//          backgroundColor: Global.getBackgroundColor(0),
//        ),),
      body: myGridView,
    );
  }


}


Future navigateToInfoPage(context,index) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoCourse(index)));
//  InfoCourseState.grade = "choose value";
//  InfoCourseState.homeworkHours = "choose value";
//  InfoCourseState.recitationHours = "choose value";
//  InfoCourseState.lecturesHours = "choose value";
//  InfoCourseState.examHours = "choose value";
//  InfoCourseState.extraHours = "choose value";
}



