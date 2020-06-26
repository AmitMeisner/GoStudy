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

  // distance of the title from the top.
  final double ceiling;

  //indicates that this is the multi choice from the tips page
  //and not the tipDialog.
  final bool tipsPage;
  final bool addResource;

  //constructor/
  CourseChoice(this.updateUserCourse, this.ceiling, this.timesPageSetState, this.tipsPage, this.addResource);


  @override
  _CourseChoiceState createState() => _CourseChoiceState(updateUserCourse, ceiling,timesPageSetState, tipsPage,addResource);
}

class _CourseChoiceState extends State<CourseChoice> {
  // updating the users tag list.
  Function updateUserCourse;

  final Function tipsPageSetState;

  // distance of the title from the top.
  double ceiling;
  bool addResource;
  bool timesPage;

  //constructor.
  _CourseChoiceState(this.updateUserCourse, this.ceiling, this.tipsPageSetState, this.timesPage, this.addResource);



  // list of all courses.
  List<String> courses=Global().getUserCourses();
  List<String> resources=Global().getAllResources();
  List<String> userCourse=[""];
  List<String> userResource=[""];


  @override
  Widget build(BuildContext context) {
    updateUserCourse(userCourse);
    updateUserCourse(userResource);
    if(addResource){
    return scrollableListChoice(ceiling,resources,userResource);}
    else{
      return scrollableListChoice(ceiling,courses,userCourse);}

  }

  // creating the multi choice list.
  Widget scrollableListChoice(double ceiling, List<String> listSource,List<String> chosenList){
    return ChipsChoice<String>.single(
          value:chosenList[0] ,
          options: ChipsChoiceOption.listFrom<String, String>(
            source: listSource,
            value: (i, v) => v,
            label: (i, v) => v,
          ),
          onChanged: (val) {
            setState(() => chosenList[0] = val);
            if(timesPage){TimeDataBase().setUserSelectedCourse(chosenList[0],tipsPageSetState);}
          },
          itemConfig: ChipsChoiceItemConfig(

            selectedColor: Colors.red,
            unselectedColor: Colors.black87,
            showCheckmark: true,
          )

    );
  }




}


// class for the custom chip widget.
//class CustomChip extends StatelessWidget {
//
//  final String label;
//  final bool selected;
//  final Function(bool selected) onSelect;

//  CustomChip(
//      this.label,
//      this.selected,
//      this.onSelect,
//      { Key key }
//      ) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return AnimatedContainer(
//      color: Colors.yellow,
//      height: 100,
//      width: 70,
//      margin: EdgeInsets.symmetric(
//        vertical: 15,
//        horizontal: 5,
//      ),
//      duration: Duration(milliseconds: 300),
//      decoration: BoxDecoration(
//        color: selected ? Colors.black : Colors.transparent,
//        borderRadius: BorderRadius.circular(15),
//        border: Border.all(
//          color: selected ? Colors.black: Colors.grey,
//          width: 1,
//        ),
//      ),
//      child: InkWell(
//        onTap: () => onSelect(!selected),
//        child: Stack(
//          alignment: Alignment.center,
//          children: <Widget>[
//            Visibility(
//                visible: selected,
////                child: Icon(
////                  Icons.check_circle_outline,
////                  color: Colors.yellow,
////                  size: 32,
////                )
//            ),
//            Positioned(
//              left: 9,
//              right: 9,
//              bottom: 7,
//              child: Container(
//                child: Text(
//                  label,
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
//                  style: TextStyle(
//                    color: selected ? Colors.white : Colors.black45,
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

