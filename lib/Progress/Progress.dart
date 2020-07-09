import 'package:flutter/material.dart';
import 'package:flutterapp/Progress/ProgressData.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:provider/provider.dart';

class ProgressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProgressPageState();
  }
}

class _ProgressPageState extends State<ProgressPage> {
  void updateState(){
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserStatForCourse>>.value(
      value: AllUserDataBase().usersStats,
      child: Scaffold(
          body:
          ListView(
            children: <Widget>[
            ProgressData(updateState),
        ],
      )),
    );
  }
}
