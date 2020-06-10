import 'package:flutter/material.dart';
import 'package:flutterapp/Progress/CourseSelectChoice.dart';
import 'package:flutterapp/Progress/ProgressData.dart';

class ProgressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProgressPageState();
  }
}

class _ProgressPageState extends State<ProgressPage> {
  void updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress"),
      ),
        body: ListView(
      children: <Widget>[
        CourseSelectChoice(updateState),
        ProgressData(),
      ],
    ));
  }
}
