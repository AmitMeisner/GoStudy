import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';
import 'package:flutterapp/HomePage/History/editTimeDialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'TimeCard.dart';


class TimeDataBase{

  //collection reference.
  static  CollectionReference timeCollection= Firestore.instance.collection("Times");
//  Stream<QuerySnapshot> timesCollectionQuery = timeCollection.orderBy('date', descending: true)
//      .where('course', isEqualTo:selectedCourse).snapshots();

  Stream<QuerySnapshot> timesCollectionQuery = timeCollection
      .where('course', isEqualTo:selectedCourse).orderBy('date', descending: true).snapshots();

  static String selectedCourse=Global().getUserCourses()[0];


  //add tip card.
  Future addTime(TimeCard timeCard) async{
    DocumentReference doc=await timeCollection.add({});
    Map<String, dynamic> timeMap = {
      "course":timeCard.getCourse(),
      "resource": timeCard.getResource(),
      "hours": timeCard.getHours(),
      "minutes": timeCard.getMinutes(),
      "seconds": timeCard.getSeconds(),
      "date": timeCard.getDate(),
      "docId": doc.documentID,
      "uid": timeCard.getUid(),
    };
    return await doc.updateData(timeMap);
  }



  //get sorted tip cards.
  Stream<List<TimeCard>> get times{
    return timesCollectionQuery.map(_timesCardsFromSnapshot);
  }


  List<TimeCard> _timesCardsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return TimeCard(
        doc.data["course"],
        doc.data["resource"],
        doc.data["uid"],
        doc.data["docId"],
        doc.data["date"],
        doc.data["hours"],
        doc.data["minutes"],
        doc.data["seconds"],
      );
    }).toList();
  }


  void setUserSelectedCourse(String userSelectedCourse, Function updateTimePageState){
    selectedCourse=userSelectedCourse;
    if(userSelectedCourse.isEmpty){selectedCourse=Global().getUserCourses()[0];}
    timesCollectionQuery=timeCollection.orderBy('date', descending: true).where('course',isEqualTo: selectedCourse).snapshots();
    updateTimePageState();
  }


  //delete tip card.
  static void deleteTimeCard(TimeCard card){
    DocumentReference doc = timeCollection.document(card.getDocId());
    doc.delete();
  }


  static void editTimeCard(BuildContext context, TimeCard card, String userCourse,String userResource) async{
    DocumentReference doc = timeCollection.document(card.getDocId());
    if(userCourse == "" || userResource == ""){
      return showColoredToast("choose course and resource");
    }
    doc.updateData({'course' : userCourse});
    doc.updateData({'resource': userResource});
    Navigator.pop(context);
    showColoredToast("Course is updated to $userCourse and Resource to $userResource");

  }

// display error to the user.
  static void showColoredToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        fontSize: 18,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.grey,
        gravity: ToastGravity.CENTER,
        textColor: Colors.black);
  }

}

