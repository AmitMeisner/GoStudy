import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutterapp/Courses.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
import 'package:flutterapp/Tips/Tips.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';



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
  Function updateUserTags;

  final Function tipsPageSetState;

  // distance of the title from the top.
  double ceiling;
  bool addResource;
  bool timesPage;

  //constructor.
  _CourseChoiceState(this.updateUserTags, this.ceiling, this.tipsPageSetState, this.timesPage, this.addResource);



  // list of all courses.
  List<String> courses=Courses().getUserCourses();
  List<String> resources=Courses().getAllResources();
  List<String> userCourse=[""];


  @override
  Widget build(BuildContext context) {
    updateUserTags(userCourse);
    if(addResource){
    return scrollableListSingleleChoice(ceiling,resources);}
    else{
      return scrollableListSingleleChoice(ceiling,courses);}

  }

  // creating the multi choice list.
  Widget scrollableListSingleleChoice(double ceiling, listSource){
    return ChipsChoice<String>.single(
          value:userCourse[0] ,
          options: ChipsChoiceOption.listFrom<String, String>(
            source: listSource,
            value: (i, v) => v,
            label: (i, v) => v,
          ),
          onChanged: (val) {
            setState(() => userCourse[0] = val);
            if(timesPage){TimeDataBase().setUserSelectedCourse(userCourse[0],tipsPageSetState);}
          },
          itemConfig: ChipsChoiceItemConfig(
            selectedColor: Colors.green,
            unselectedColor: Colors.black87,
            showCheckmark: true,
          )

    );
  }



}

// class for the custom chip widget.
class CustomChip extends StatelessWidget {

  final String label;
  final bool selected;
  final Function(bool selected) onSelect;

  CustomChip(
      this.label,
      this.selected,
      this.onSelect,
      { Key key }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 100,
      width: 70,
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: selected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: selected ? Colors.green : Colors.grey,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Visibility(
                visible: selected,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 32,
                )
            ),
            Positioned(
              left: 9,
              right: 9,
              bottom: 7,
              child: Container(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class that creates the content of the multi choice.
class Content extends StatelessWidget {

  final String title;
  final Widget child;
  final double ceiling;

  Content({
    Key key,
    @required this.title,
    @required this.child,
    @required this.ceiling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      elevation: 2,
      margin: EdgeInsets.fromLTRB(0,ceiling,0,0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(5, 15, 0, 15),
            color: Colors.blueAccent,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
