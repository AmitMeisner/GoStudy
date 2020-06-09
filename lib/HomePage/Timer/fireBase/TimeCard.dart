


import 'package:flutterapp/Tips/Cards.dart';

class TimeCard {
  String course;
  String resource;
  String uid;
  DateTime date;
  String time;
  String docId;


  TimeCard(this.course, this.resource, this.uid,this.docId, this.date,this.time);

 String getCourse(){return this.course;}
  String getResource(){return this.resource;}
  String getUid(){return this.uid;}
  DateTime getDate(){return this.date;}
  String getTime(){return this.time;}

  String getDocId(){
    return docId ?? "";
  }

}

