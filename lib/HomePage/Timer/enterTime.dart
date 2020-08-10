import 'package:flutterapp/FirstInfo/InformationPage.dart';
import 'package:flutterapp/HomePage/Timer/progress_pie_bar.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Global.dart';
import 'package:flutter/material.dart';
import '../HomeMain.dart';
import 'package:provider/provider.dart';
import 'coursesResources.dart';
import 'dialog_helper.dart';
import 'enterTimeDialog.dart';
import 'fireBase/TimeCard.dart';
import 'fireBase/fireBase_api.dart';
import 'package:intl/intl.dart';

class EnterTimeButton extends StatefulWidget {
  final double bevel;
  final Offset blurOffset;

  Function reload;

  EnterTimeButton(void Function() reload, {Key key, this.bevel = 10.0})  : this.blurOffset = Offset(bevel / 2, bevel / 2),this.reload=reload, super(key: key);

  @override
  EnterTimeState createState() => EnterTimeState(reload);
}

 String getDate() {
  var now = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  String formatted = formatter.format(now);
  return formatted;
}

void showColoredToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Global.backgroundPageColor,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.red);
}

class EnterTimeState extends State<EnterTimeButton> {
  static String course ;
  static String resource ;
  DateTime date= DateTime.now();
  String uid=  FirebaseAPI().getUid();
  int hours; int minutes; int seconds;
  String docId = "" ;
  bool _isPressed = false;
  Function reload;

  EnterTimeState(this.reload);


  String format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  void _onPointerDown() async{
    _isPressed=true;

    NeuStartButtonState.isRunning=false;
    Provider.of<TimerService>(context, listen: false).stop();
    reload();

    if(TimerService.currentDurationTime != Duration.zero && !NeuStartButtonState.isRunning ){
    await DialogHelperTime.enterTime(context);
    course = ShowHideDropdownState.selectedValue;
    resource = ShowHideDropdownState.resource;
    hours = TimerService.currentDurationTime.inHours;
    minutes = TimerService.currentDurationTime.inMinutes;
    seconds = TimerService.currentDurationTime.inSeconds;

    while (TimeConfirmationDialog.toEnterTime == true) {
      if(course== "Select course" || resource == "Select resource" || !checkValidTime(hours, minutes, seconds)){
        TimeConfirmationDialog.toEnterTime =false;
        await DialogHelperTime.enterTime(context);
        continue;
      }
      TimeCard newTime = new TimeCard(
          course, resource, uid,docId, date, hours, minutes, seconds);
      TimeDataBase().addTime(newTime);
      UserProgress user=await UserProgressDataBase().getUser(FirebaseAPI().getUid());
      Activities act;
      if(resource=="HomeWorks"){act=Activities.HomeWork;}
      if(resource=="Lectures"){act=Activities.Lectures;}
      if(resource=="Recitations"){act=Activities.Recitation;}
      if(resource=="Exams"){act=Activities.Exams;}
      if(resource=="Extra"){act=Activities.Extra;}
      user.addCourseTime(course, act, hours+((minutes)/60));
      user.addCourseTime("totalTime", null, hours+((minutes)/60));
      UserProgressDataBase().addUser(user);
      Provider.of<TimerService>(context, listen: false).reset();
      break;
    }}
    else{
      showColoredToast("Stop the timer and validate that time is greater than zero");
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
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white24,
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              spreadRadius: 5,
              color: Global.getBackgroundColor(50),
            ),
            BoxShadow(
              blurRadius: 15,
              offset: Offset(10.5, 10.5),
              color: Colors.blueAccent,
            )
          ],
        ),
        child: Container(
          height: 50.0,
          width: 50.0,
          child:
            Icon(Icons.stop, size: 50,),
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