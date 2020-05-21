


import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class courseSpinner extends StatefulWidget {
  @override
  courseSpinnerState createState() => courseSpinnerState();
}



class courseSpinnerState extends State<courseSpinner> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String course_id;
  List<String> course = [
    "Hedva",
    "Linear algebra",
    "Introduction into computer science",
    "Statistics",
    "Hedva2",
    "Linear2",
    "Discrete math",

  ];

  @override
  Widget build(BuildContext context) {
    return Listener(

      child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropDownField(
                onValueChanged: (dynamic value) {
                  course_id = value;
                },
                value: course_id,
                required: false,
                hintText: 'Choose a course',
                items: course,
              ),
            ]),

    );
  }
}