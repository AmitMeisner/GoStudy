


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'InformationPage.dart';


class InfoCourse extends StatefulWidget {
  int index;
  InfoCourse(this.index);
  @override
  InfoCourseState createState() => InfoCourseState(index);
}

  class InfoCourseState extends State<InfoCourse> {
  int index;
  InfoCourseState(this.index);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Flutter GridView")
        ),
        body: buildChild(context, 1),
    );}

  }

  Widget buildChild(BuildContext context, int index) {
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 4),
//        decoration: BoxDecoration(
//            shape: BoxShape.rectangle,
//            borderRadius: BorderRadius.all(Radius.circular(12))
//        ),
          children: <Widget>[
            SizedBox(height: 24,),
            Text('how long in total(hours) did you study for the exam?', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            examHours(),
            SizedBox(height: 40,),
            Text('how long in total(hours) did you study for each homework in average?', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            homeworkHours(),
            SizedBox(height: 40,),
            Text('what is your final grade?', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            totalGrade(),
            SizedBox(height: 8,),
            RaisedButton(onPressed: (){
              return Navigator.of(context).pop(true);
            }, child: Text('ENTER INTO'), color: Colors.white, textColor: Colors.redAccent,)
          ],
        );

  }




  Widget examHours()  {
    return Column(
      children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                value: 1,
                activeColor: InformationPage.focusColor,
              ),
              Text("30-35"),
              Radio(
                value: 2,
              ),
              Text("36-40"),
              Radio(
                value: 3,
              ),
              Text("41-45"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                value: 4,
              ),
              Text("46-50"),
              Radio(
                value: 5,
              ),
              Text("51-55"),
              Radio(
                value: 6,
              ),
              Text("56-60"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                value: 7,
              ),
              Text("61-65"),
              Radio(
                value: 8,
              ),
              Text("66-70"),
              Radio(
                value: 9,
              ),
              Text("70+"),
            ],
          ),
        ],

    );
  }


Widget homeworkHours()  {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Radio(
            value: 1,
            activeColor: InformationPage.focusColor,
          ),
          Text("3-5"),
          Radio(
            value: 2,
          ),
          Text("6-8"),
          Radio(
            value: 3,
          ),
          Text("9-11"),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Radio(
            value: 4,
          ),
          Text("12-14"),
          Radio(
            value: 5,
          ),
          Text("15-17"),
          Radio(
            value: 6,
          ),
          Text("17+"),
        ],
      ),
    ],

  );
}

Widget totalGrade()  {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Radio(
            value: 1,
            activeColor: InformationPage.focusColor,
          ),
          Text("60-64"),
          Radio(
            value: 2,
          ),
          Text("65-69"),
          Radio(
            value: 3,
          ),
          Text("70-74"),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Radio(
            value: 4,
          ),
          Text("75-79"),
          Radio(
            value: 5,
          ),
          Text("80-84"),
          Radio(
            value: 6,
          ),
          Text("85-89"),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Radio(
            value: 7,
          ),
          Text("90-95"),
          Radio(
            value: 8,
          ),
          Text("96-100"),
        ],
      ),
    ],

  );
}
