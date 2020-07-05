import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/Extra/resourceChoice.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/TimeCard.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Global.dart';
import 'courseChoice.dart';

class editTimeDialog extends StatefulWidget {
  final Function timesPageSetState;
  TimeCard card;
  editTimeDialog(this.timesPageSetState, this.card);
  @override
  editTimeDialogState createState() => editTimeDialogState(timesPageSetState,card);
}

class editTimeDialogState extends State<editTimeDialog> {
  //  for calling call setState in the tips page
  Function timesPageSetState;
  TimeCard card;
  editTimeDialogState(this.timesPageSetState,this.card);

  //list of the users courses.
  List<String> userCourse=[""];
  List<String> userResource=[""];


  @override
  Widget build(BuildContext context) {
    userCourse = [card.getCourse()];
    userResource = [card.getResource()];
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: mainBodyOfDialog(),
    );
  }


  // creating the dialog body content.
  Widget mainBodyOfDialog(){
    return  Column(
      mainAxisSize: MainAxisSize.min ,
      children: <Widget>[
        courses(),
        new Container(
          height: 20.0,
        ),
        resources(),
        new Container(
          height: 28.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            exitButton(context),
            editButton(context),

          ],
        ),
      ],
    );
  }

  //creating the courses choices in the dialog.
  Widget courses(){
    return CourseChoice(updateUserCourse, timesPageSetState,false);
  }



  Widget resources(){
    return ResourceChoice(updateUserResource,0.0, timesPageSetState);
  }

  void updateUserCourse(List<String> newUserTags){
    userCourse.clear();
    for(int i=0;i<newUserTags.length;i++){
      userCourse.add(newUserTags[i]);
    }
  }
  void updateUserResource(List<String> newUserTags){
    userResource.clear();
    for(int i=0;i<newUserTags.length;i++){
      userResource.add(newUserTags[i]);
    }
  }



  //creating the post button.
  Widget editButton(BuildContext context){
    return Container(
        alignment: Alignment.bottomRight ,
        child: FlatButton(
          onPressed: (){TimeDataBase.editTimeCard(context,card,userCourse[0],userResource[0]);},
          child: Text("UPDATE"),
          color: Global.getBackgroundColor(0),
        )
    );
  }

  Widget exitButton(BuildContext context){
    return Container(
        alignment: Alignment.bottomRight ,
        child: FlatButton(
          onPressed: (){Navigator.pop(context);},
          child: Text("EXIT"),
          color:Global.getBackgroundColor(0),
        )
    );
  }



}
