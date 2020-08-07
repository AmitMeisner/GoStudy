import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
import 'package:flutterapp/Tips/Tips.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';

import '../../Global.dart';



// class of the courses multi choice.
class CourseChoice extends StatefulWidget {
  // updating the users tag list.
  final Function updateUserCourse;

  // for refreshing the tips page.
  final Function timesPageSetState;

  //indicates that this is the multi choice from the tips page
  //and not the tipDialog.
  final bool timesPage;

  //constructor/
  CourseChoice(this.updateUserCourse, this.timesPageSetState, this.timesPage);


  @override
  _CourseChoiceState createState() => _CourseChoiceState(updateUserCourse,timesPageSetState, timesPage);
}

class _CourseChoiceState extends State<CourseChoice> {
  // updating the users tag list.
  Function updateUserCourse;

  final Function timesPageSetState;

  // distance of the title from the top.
  bool timesPage;

  //constructor.
  _CourseChoiceState(this.updateUserCourse, this.timesPageSetState, this.timesPage);



  // list of all courses.
  List<String> courses=Global().getUserCourses();
  List<String> userCourse=[""];


  @override
  Widget build(BuildContext context) {
    if(userCourse[0] == ""){
      userCourse = [Global().getUserCourses()[0]];}
    updateUserCourse(userCourse);
      return scrollableListChoice(courses,userCourse);

  }

  // creating the multi choice list.
  Widget scrollableListChoice( List<String> listSource,List<String> chosenList){
    return ChipsChoice<String>.single(
          value:chosenList[0] ,
          options: ChipsChoiceOption.listFrom<String, String>(
            source: listSource,
            value: (i, v) => v,
            label: (i, v) => v,
          ),
          onChanged: (val) {
            setState(() => chosenList[0] = val);
            if(timesPage){TimeDataBase().setUserSelectedCourse(chosenList[0],timesPageSetState);}
          },
          itemConfig: ChipsChoiceItemConfig(

            selectedColor: Global.getBackgroundColor(0),
            unselectedColor: Colors.black87,
            showCheckmark: true,
          )

    );
  }
}
