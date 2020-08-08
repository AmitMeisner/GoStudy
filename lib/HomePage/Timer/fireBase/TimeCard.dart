


import 'package:flutterapp/Tips/Cards.dart';

class TimeCard {
  String course;
  String resource;
  String uid;
  DateTime date;
  int hours;
  int minutes;
  int seconds;
  String docId;


  TimeCard(this.course, this.resource, this.uid,this.docId, this.date,this.hours,this.minutes,this.seconds);

 String getCourse(){return this.course;}
  String getResource(){return this.resource;}
  String getUid(){return this.uid;}
  DateTime getDate(){
   return this.date;
 }
  int getHours(){return this.hours;}
  int getMinutes(){return this.minutes;}
  int getSeconds(){return this.seconds;}

  String getDocId(){
    return docId ?? "";
  }

}

