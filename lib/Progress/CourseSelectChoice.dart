import 'package:flutter/material.dart';

class CourseSelectChoice extends StatefulWidget {
  final Function progressPageSetState;

  CourseSelectChoice(this.progressPageSetState);

  @override
  State<StatefulWidget> createState() {
    return _CoursesSelectChoiceState(progressPageSetState);
  }
}

class _CoursesSelectChoiceState extends State<CourseSelectChoice> {
  final Function progressPageState;

  _CoursesSelectChoiceState(this.progressPageState);

//  List<String> courses=["general"]+Courses.getUserCourses();
  List<String> courses = ["General", "Calculus 2", "Algorithms","Logic","Software 1","Complexity","Computational Models"];
  int _currChip = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Scaffold(
//        backgroundColor: Colors.blueAccent,
        body: Container(
            height: 70.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: List<Widget>.generate(
                courses.length,
                (int i) {
                  return ChoiceChip(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    label: Text(courses[i]),
                    selected: _currChip == i,
                    onSelected: (bool selected) {
                      setState(() {
                        _currChip = i;
                      });
                    },
                  );
                },
              ).toList(),
            )),
      ),
    );
  }
}
