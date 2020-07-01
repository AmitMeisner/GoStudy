


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/Timer/coursesResources.dart';

import 'InformationPage.dart';





  class InfoCourse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Dialog(
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(16)
  ),
  elevation: 0,
  backgroundColor: Colors.transparent,
  child: _buildChild(context),
  );
  }

  _buildChild(BuildContext context) => Container(
  height: 650,
  decoration: BoxDecoration(
      color: Colors.blue,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.all(Radius.circular(12))
  ),
  child: Column(
  children: <Widget>[
  SizedBox(height: 24,),
  Text('how long in total(hours) did you study for the exam?', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
  SizedBox(height: 8,),
    examHours(),

  RaisedButton(onPressed: (){
  return Navigator.of(context).pop(true);
  }, child: Text('Yes'), color: Colors.white, textColor: Colors.redAccent,)
  ],
  )

  );
  }



class examHours extends StatefulWidget {
  @override
  examHoursState createState() => examHoursState();
}

class examHoursState extends State<examHours> {
  static int year;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("30-35"),
              Radio(
                value: 2,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("36-40"),
              Radio(
                value: 3,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("41-45"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Radio(
                value: 4,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("46-50"),
              Radio(
                value: 5,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("51-55"),
              Radio(
                value: 6,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("56-60"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Radio(
                value: 7,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("61-65"),
              Radio(
                value: 8,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("66-70"),
              Radio(
                value: 9,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("70+"),
            ],
          ),
        ],

    );
  }

}