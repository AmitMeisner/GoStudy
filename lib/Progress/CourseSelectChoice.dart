import 'package:flutter/material.dart';

import '../Global.dart';

class CourseSelectChoice extends StatefulWidget {
  final Function initialProgressPage;

  CourseSelectChoice(this.initialProgressPage);

  @override
  State<StatefulWidget> createState() {
    return _CoursesSelectChoiceState(initialProgressPage);
  }
}

class _CoursesSelectChoiceState extends State<CourseSelectChoice> {
  final Function initialProgressPage;

  _CoursesSelectChoiceState(this.initialProgressPage);

//  List<String> courses=["general"]+Courses.getUserCourses();
  List<String> courses = Global().getUserCourses();
  int _currChip = 0;
  @override
  void initState() {
    initialProgressPage(courses[_currChip]);
    super.initState();
  }

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
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ChoiceChip(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      label: Text(courses[i],
                          style: TextStyle(
                          color: Colors.black),),
                      selected: _currChip == i,
                      selectedColor: Global.getBackgroundColor(0),
                      onSelected: (bool selected) {
                        setState(() {
                          _currChip = i;
                          initialProgressPage(courses[i]);
                        });
                      },
                    ),
                  );
                },
              ).toList(),
            )),
      ),
    );
  }
}
