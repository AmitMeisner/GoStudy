import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Global.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/TimeCard.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
import 'package:provider/provider.dart';
import 'cards.dart';
import 'courseChoice.dart';

class TimesPage extends StatefulWidget {
  static List<String> userCourse=[" "];
  @override
  TimesPageState createState() => TimesPageState();
}

class TimesPageState extends State<TimesPage> {

  //list of the users courses choice in the time page.
  List<String> userCourse = TimesPage.userCourse;
  List<String> userResource = ['Lectures'];


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TimeCard>>.value(
      value: TimeDataBase().times,
      child: Scaffold(
        backgroundColor: Global.getBackgroundColor(0),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
              //  infoBlock(),
                    Container(
                      height: 15
                    ),
                    CourseChoice(updateUserCourse, updateState, true),
                    Container(
                        height: 20
                    ),
                    Cards(updateState),
                  ],
            ),
          ),
        ),
        //floatingActionButton: fabAddTip(context),
      ),),),
    );
  }



  //updating the state of the tips page, to be used in other classes.
  void updateState(){
    setState(() {});
  }

  //updating the users courses choice in the tip page.
  void updateUserCourse(List<String> newUserCourse) {
    userCourse.clear();
    for(int i=0;i<newUserCourse.length;i++){
      userCourse.add(newUserCourse[i]);
    }

  }


}