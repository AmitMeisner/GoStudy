import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';

class calculation extends StatefulWidget {

  @override
  calculationState createState() => calculationState();
}

class calculationState extends State<calculation> {
  int hoursTotal =0;
  int minutesTotal = 0;
  int secondsTotal = 0;
  Duration durationCourse = Duration.zero;
  Duration durationCourseResource = Duration.zero;
  Duration timesUser = Duration.zero;
  Duration timesUserWeek = Duration.zero;
  String uid=  FirebaseAPI().getUid();


// sum of times for specific course
  void queryTimeSumForCourse(selectedCourse) {
    Firestore.instance
        .collection('Times')
        .where('uid', isEqualTo:uid )
        .where('course', isEqualTo:selectedCourse)
        .snapshots()
        .listen((snapshot) {
      int hours = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['hours']);
      int minutes = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['minutes']);
      int seconds = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['seconds']);
      setState(() {
        durationCourse = new Duration(hours:hours, minutes: minutes,seconds: seconds);
      });
    });
  }

// get sum of times for user &specific course& specific resource
  void querySumCourseResource(selectedCourse, selectedResource) {
    Firestore.instance
        .collection('Times')
        .where('uid', isEqualTo:uid )
        .where('course', isEqualTo:selectedCourse)
        .where('resource',isEqualTo:selectedResource )
        .snapshots()
        .listen((snapshot) {
      int hours = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['hours']);
      int minutes = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['minutes']);
      int seconds = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['seconds']);
      setState(() {
        durationCourseResource = new Duration(hours:hours, minutes: minutes,seconds: seconds);
      });
    });
  }

// get sum of times for user
  void querySumUser() {
    Firestore.instance
        .collection('Times')
        .where('uid', isEqualTo:uid )
        .snapshots()
        .listen((snapshot) {
      int hours = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['hours']);
      int minutes = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['minutes']);
      int seconds = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['seconds']);
      setState(() {
        timesUser = new Duration(hours:hours, minutes: minutes,seconds: seconds);
      });
    });
  }

  // get sum of times for user from last week
  void querySumUserWeek() {
    DateTime lastWeek = DateTime.now().add(Duration(days: -7));
    String lastWeekString = convertDateToString(lastWeek);
    print("last week"+lastWeek.toString());
    Firestore.instance
        .collection('Times')
        .where('uid', isEqualTo:uid )
        .where('date', isGreaterThanOrEqualTo: lastWeekString)
        .snapshots()
        .listen((snapshot) {
      int hours = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['hours']);
      int minutes = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['minutes']);
      int seconds = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['seconds']);
      setState(() {
        timesUserWeek = new Duration(hours:hours, minutes: minutes,seconds: seconds);
      });
    });
  }


  //return the date in the form day/month/year.
  static String convertDateToString(DateTime dateTime){
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new RaisedButton(
            padding: const EdgeInsets.all(8.0),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: ()=>queryTimeSumForCourse("Calculus 2"),
            child: new Text(" total time for Calculus 2 only is: $durationCourse"),
          ),
          new RaisedButton(
            padding: const EdgeInsets.all(5.0),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: ()=>querySumCourseResource("Calculus 2", "Recitations"),
            child: new Text(" total time for Calculus 2 and Recitations is: $durationCourseResource"),
          ),
          new RaisedButton(
            padding: const EdgeInsets.all(5.0),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: ()=>querySumUser(),
            child: new Text(" total time for user  $timesUser"),
          ),
          new RaisedButton(
            padding: const EdgeInsets.all(5.0),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: ()=>querySumUserWeek(),
            child: new Text(" total time for user for last week is: $timesUserWeek"),
          ),

          ]
    //body: Text(queryTimeSumForCourse("Calculus 2").toString())
    );
  }
}