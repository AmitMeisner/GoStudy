



import 'package:cloud_firestore/cloud_firestore.dart';

import 'TimeCard.dart';




class TimeDataBase{

  //collection reference.
  static  CollectionReference TimeCollection= Firestore.instance.collection("Times");
  //Stream<QuerySnapshot> tipsCollectionQuery = TimeCollection.orderBy('date', descending: true)
    //  .snapshots();




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

}

