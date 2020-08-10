
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/History/resourceChoice.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/TimeCard.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
import '../../Global.dart';
import 'courseChoice.dart';

class EditTimeDialog extends StatefulWidget {
  final Function timesPageSetState;
  TimeCard card;
  EditTimeDialog(this.timesPageSetState, this.card);
  @override
  EditTimeDialogState createState() => EditTimeDialogState(timesPageSetState,card);
}

class EditTimeDialogState extends State<EditTimeDialog> {
  //  for calling call setState in the tips page
  Function timesPageSetState;
  TimeCard card;
  EditTimeDialogState(this.timesPageSetState,this.card);

  //list of the users courses and resources
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


  //creating the resources choices in the dialog.
  Widget resources(){
    return ResourceChoice(updateUserResource,0.0, timesPageSetState);
  }
// update user courses for the multi choice
  void updateUserCourse(List<String> newUserTags){
    userCourse.clear();
    for(int i=0;i<newUserTags.length;i++){
      userCourse.add(newUserTags[i]);
    }
  }
  // update user resources for the multi choice
  void updateUserResource(List<String> newUserTags){
    userResource.clear();
    for(int i=0;i<newUserTags.length;i++){
      userResource.add(newUserTags[i]);
    }
  }



  //creating the update button.
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
  //creating the exit button.
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
