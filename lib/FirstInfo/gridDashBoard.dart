
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'InfoCourse.dart';
import 'InformationPage.dart';


class GridDashboard extends StatefulWidget {
  @override
  GridDashboardState createState() => GridDashboardState();
}

class GridDashboardState extends State<GridDashboard> {

  bool updated=false;
  List<String> oldCourses=[] ;

  Future<void>  updateCourses() async {
    oldCourses= await InformationPageState.getOldCourses();
    updated=true;
    setState(() {});
  }

  Widget build(BuildContext context) {
    if(!updated){
      oldCourses=null;
      updateCourses();
      return Loading();
    }
    updated=false;
    var myGridView = new GridView.builder(
      itemCount: oldCourses.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 8.0,
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



