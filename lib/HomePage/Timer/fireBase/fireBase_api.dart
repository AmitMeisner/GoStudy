



import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Extra/cards.dart';
import 'TimeCard.dart';





class TimeDataBase{

  //collection reference.
  static  CollectionReference TimeCollection= Firestore.instance.collection("Times");
  Stream<QuerySnapshot> timesCollectionQuery = TimeCollection.orderBy('date', descending: true)
      .where('course', isEqualTo:selectedCourse).snapshots();

  static List<String> selectedCourse=["Calculus 2"];


  //add tip card.
  Future addTime(TimeCard timeCard) async{
    DocumentReference doc=await TimeCollection.add({});
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
        doc.data["date"],
        doc.data["time"],
        doc.data["docId"],
        doc.data["uid"],
      );
    }).toList();
  }


  void setUserSelectedCourse(List<String> userSelectedCourse, Function updateTimePageState){
    selectedCourse=userSelectedCourse;
    if(userSelectedCourse.isEmpty){selectedCourse=["Calculus 2"];}
    timesCollectionQuery=TimeCollection.orderBy('date', descending: true).where('course',isEqualTo: selectedCourse).snapshots();
    updateTimePageState();
  }


  //delete tip card.
  static void deleteTimeCard(TimeCard card){
    DocumentReference doc = TimeCollection.document(card.getDocId());
    doc.delete();
  }



}

