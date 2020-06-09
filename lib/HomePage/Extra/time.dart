
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/HomeMain.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/TimeCard.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
import 'package:flutterapp/Tips/CoursesMultiChoice.dart';
import 'package:flutterapp/Tips/Cards.dart';
import 'package:flutterapp/Tips/TipDialog.dart';



import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:provider/provider.dart';

import 'cards.dart';
import 'courseChoice.dart';
import 'manualTimeDialog.dart';

class TimesPage extends StatefulWidget {
  static List<String> userCourse=["Calculus 2"];
  @override
  TimesPageState createState() => TimesPageState();
}

class TimesPageState extends State<TimesPage> {

  //list of the users courses choice in the tip page.
  List<String> userCourse = TimesPage.userCourse;


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TimeCard>>.value(
      value: TimeDataBase().times,
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                CourseChoice(updateUserCourse, 20, updateState, true),
                cards(updateState),
              ],
            ),
          ),
        ),
        floatingActionButton: fabAddTip(context),
      ),
    );
  }


  //creating the floating action button for add tip.
  Widget fabAddTip(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton.extended(
          onPressed: () {
            addTip(context, updateState);
          },
          label: Text("Add Time Manually"),
          backgroundColor: Colors.blueAccent,
          icon: Icon(Icons.add),
//            shape: new CircleBorder(),
        ),
        fabReload(context),
      ],
    );
  }


  //creating the floating action button for reloading.
  Widget fabReload(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        updateState();
      },
      label: Icon(Icons.autorenew),
      backgroundColor: Colors.blueAccent,
      shape: new CircleBorder(),
      focusElevation: 30.0,
    );
  }


  //updating the state of the tips page, to be used in other classes.
  void updateState() {
    setState(() {});
  }

  //updating the users courses choice in the tip page.
  void updateUserCourse(List<String> newUserCourse) {
    userCourse.clear();
    for(int i=0;i<newUserCourse.length;i++){
      userCourse.add(newUserCourse[i]);
    }

  }

//adding a tip the tips page.
  void addTip(BuildContext context, Function callback) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TimeDialog(callback);
      },
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    );
  }
}

