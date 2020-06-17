import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Extra/cards.dart';
import 'TimeCard.dart';


class TimeDataBase{

  //collection reference.
  static  CollectionReference timeCollection= Firestore.instance.collection("Times");
//  Stream<QuerySnapshot> timesCollectionQuery = timeCollection.orderBy('date', descending: true)
//      .where('course', isEqualTo:selectedCourse).snapshots();

  Stream<QuerySnapshot> timesCollectionQuery = timeCollection
      .where('course', isEqualTo:selectedCourse).snapshots();

  static String selectedCourse="Calculus 2";


  //add tip card.
  Future addTime(TimeCard timeCard) async{
    DocumentReference doc=await timeCollection.add({});
    Map<String, dynamic> timeMap = {
      "course":timeCard.getCourse(),
      "resource": timeCard.getResource(),
      "time": timeCard.getTime(),
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
        doc.data["time"],
      );
    }).toList();
  }


  void setUserSelectedCourse(String userSelectedCourse, Function updateTimePageState){
    selectedCourse=userSelectedCourse;
    if(userSelectedCourse.isEmpty){selectedCourse="Calculus 2";}
    timesCollectionQuery=timeCollection.orderBy('date', descending: true).where('course',isEqualTo: selectedCourse).snapshots();
    updateTimePageState();
  }


  //delete tip card.
  static void deleteTimeCard(TimeCard card){
    DocumentReference doc = timeCollection.document(card.getDocId());
    doc.delete();
  }



}

