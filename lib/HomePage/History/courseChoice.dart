import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
import '../../Global.dart';



// class of the courses multi choice.
class CourseChoice extends StatefulWidget {
  // updating the users course list.
  final Function updateUserCourse;

  // for refreshing the page.
  final Function timesPageSetState;

  //indicates that this is the multi choice from the times page
  //and not the edit dialog.
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
  bool timesPage;

  //constructor.
  _CourseChoiceState(this.updateUserCourse, this.timesPageSetState, this.timesPage);



  // list of all courses.
  List<String> courses=Global().getUserCourses();
  // chosen user course
  List<String> userCourse=[""];


  @override
  Widget build(BuildContext context) {
    //if user chose no course update the course to be the first course from his current courses
    if(userCourse[0] == ""){
      userCourse = [Global().getUserCourses()[0]];}
    updateUserCourse(userCourse);
      return scrollableListChoice(courses,userCourse);

  }

  // creating the single choice list.
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
