import 'package:flutterapp/FirstInfo/InformationPage.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Global.dart';
import '../../Tips/TipDialog.dart';
import 'package:flutter/material.dart';
import '../HomeMain.dart';
import 'package:provider/provider.dart';
import '../Extra/cards.dart';
import 'coursesResources.dart';
import 'dialog_helper.dart';
import 'enterTimeDialog.dart';
import 'fireBase/TimeCard.dart';
import 'fireBase/fireBase_api.dart';
import 'package:intl/intl.dart';

class EnterTimeButton extends StatefulWidget {
  final double bevel;
  final Offset blurOffset;

  EnterTimeButton({
    Key key,
    this.bevel = 10.0,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  EnterTimeState createState() => EnterTimeState();
}

 String getDate() {
  var now = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  String formatted = formatter.format(now);
  return formatted;
}

class EnterTimeState extends State<EnterTimeButton> {
  static String course ;
  static String resource ;
  String date = getDate();
  //String date =  TipDialogState.getDate();
  String uid=  FirebaseAPI().getUid();
  int hours; int minutes; int seconds;
  String docId = "" ;
  bool _isPressed = false;


  String format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  void _onPointerDown() async{
    _isPressed=true;
    await DialogHelperTime.enterTime(context);
    course = ShowHideDropdownState.selectedValue;
    resource = ShowHideDropdownState.resource;
    hours = TimerService.currentDurationTime.inHours;
    minutes = TimerService.currentDurationTime.inMinutes;
    seconds = TimerService.currentDurationTime.inSeconds;

    while (TimeConfirmationDialog.toEnterTime == true) {
      if(course== "Select course" || resource == "Select resource" || !checkValidTime(hours, minutes, seconds)){
        TimeConfirmationDialog.toEnterTime =false;
        await DialogHelperMissingData.showError(context);
        await DialogHelperTime.enterTime(context);
        continue;
      }
      TimeCard newTime = new TimeCard(
          course, resource, uid,docId, date, hours, minutes, seconds);
      TimeDataBase().addTime(newTime);
      User user=await UserDataBase().getUser();
      Activities act;
      if(resource=="HomeWorks"){act=Activities.HomeWork;}
      if(resource=="Lectures"){act=Activities.Lectures;}
      if(resource=="Recitations"){act=Activities.Recitation;}
      if(resource=="Exams"){act=Activities.Exams;}
      if(resource=="Extra"){act=Activities.Extra;}
      user.addCourseTime(course, act, hours+((minutes)/60));
      user.addCourseTime("totalTime", null, hours+((minutes)/60));
      UserDataBase().addUser(user);
      break;
    }
    setState(() {});
  }

  bool checkValidTime(int hours, int minutes, int seconds){
    if(hours==0 && minutes ==0 && seconds==0){
      return false;
    }
    return true;
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        _onPointerDown();
      },
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: MediaQuery.of(context).size.height/20,
//        width: 150,
//        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
//          color: Color.fromRGBO(227, 237, 247, 1),
          color: Global.getBackgroundColor(200),
//          borderRadius: BorderRadius.circular(15),
          shape: BoxShape.circle,
          boxShadow: _isPressed
              ? null
              : [
            BoxShadow(
              blurRadius: 30,
              offset: -widget.blurOffset,
              color: Colors.white,
            ),
            BoxShadow(
              blurRadius: 30,
              offset: Offset(10.5, 10.5),
              color: Color.fromRGBO(214, 223, 230, 1),
            )
          ],
        ),
        child: Container(
          height: 35.0,
          width: 35.0,
          child:
            Icon(Icons.save,),
//          Text(
//            "Enter time",
//            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
//          ),

        ),
      ),
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }


}