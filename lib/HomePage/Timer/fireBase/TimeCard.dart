


import 'package:flutterapp/Tips/Cards.dart';

class TimeCard {
  String course;
  String resource;
  String uid;
  String date;
  String time;


  TimeCard(this.course, this.resource, this.uid, this.date,this.time);

 String getCourse(){return this.course;}
  String getResource(){return this.resource;}
  String getUid(){return this.uid;}
  String getDate(){return this.date;}
  String getTime(){return this.time;}


}

