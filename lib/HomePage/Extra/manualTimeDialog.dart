import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Tips/CoursesMultiChoice.dart';
import 'package:flutterapp/Tips/Cards.dart';
import 'package:flutterapp/Tips/Tips.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cards.dart';
import 'courseChoice.dart';

class TimeDialog extends StatefulWidget {
  final Function timesPageSetState;
  TimeDialog(this.timesPageSetState);
  @override
  TimeDialogState createState() => TimeDialogState(timesPageSetState);
}

class TimeDialogState extends State<TimeDialog> {
  //  for calling call setState in the tips page
  Function timesPageSetState;
  TimeDialogState(this.timesPageSetState);

  //list of the users tags.
  String userCourse="general";

  // controllers for getting the users input.
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: mainBodyOfDialog(),
    );
  }

  // method to update the list of users tags, to be used from other classes.
  void updateUserTags(String newCourse){
    userCourse = newCourse;
  }

  // creating the dialog body content.
  Widget mainBodyOfDialog(){
    return  Column(
      mainAxisSize: MainAxisSize.min ,
      children: <Widget>[
        tags(),
        textInput(),
        Container(),
        Row(
          children: <Widget>[
            Spacer(),
            postButton(context),
          ],
        ),
        Container(),
      ],
    );
  }


  //creating the description input in the dialog.
  Widget descriptionInput(){
    return inputDecoration( "Enter a description.",descriptionController, 32.0,1);
  }

  //creating the courses choices in the dialog.
  Widget tags(){
    return CourseChoice(updateUserTags,0.0, timesPageSetState, false);
  }

  //creating the text input in the dialog.
  Widget textInput(){
    return Container(
      child: Column(
        children: <Widget>[
          inputDecoration("Select tags and enter time.",timeController, 32.0,10),
        ],
      ),
    );
  }

  //creating the decoration for the text, description and link inputs.
  Widget inputDecoration(String hint,TextEditingController controller, double borderRadius, int lines){
    return TextFormField(
      controller: controller,
      autocorrect: false,
      cursorColor: Colors.black,
      keyboardType: TextInputType.multiline,
      maxLines: lines,
      minLines: lines,
      decoration: new InputDecoration(
        border:  InputBorder.none,
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft:  Radius.circular(borderRadius),
              topRight:  Radius.circular(borderRadius),
              bottomLeft:  Radius.circular(borderRadius),
              bottomRight:  Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0)
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft:  Radius.circular(borderRadius),
            topRight:  Radius.circular(borderRadius),
            bottomLeft:  Radius.circular(borderRadius),
            bottomRight:  Radius.circular(borderRadius),
          ),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 15, bottom: 15, top: 11, right: 15),
        hintText: hint,
      ),
    );
  }

  //creating the post button.
  Widget postButton(BuildContext context){
    return Container(
        alignment: Alignment.bottomRight ,
        child: FlatButton(
          onPressed: (){addUserTimeAndUpdate(context);},
          child: Text("Post"),
          color: Colors.blueAccent,
        )
    );
  }

  //handle pressing the post button.
  void addUserTimeAndUpdate(BuildContext context){
    if(userCourse==""){showColoredToast("Select one course");return;}
    if(timeController.text==""){showColoredToast("Enter a time");return;}
    cards(timesPageSetState).addCard(userCourse,null, getDate(),timeController.text,);
    timesPageSetState();
    Navigator.pop(context);

  }

  //return the date in the form day/month/year.
  static DateTime getDate(){
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    return date;
  }

  //display message to the user.
  void showColoredToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.grey,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white);
  }


  //creating the text button that changes the dialog to a text mode.
  Widget textButton(){
    return  Container(
        alignment:Alignment.bottomLeft,
        child: FlatButton(
            color: Colors.grey[200],
            onPressed: (){setState(() {});},
            child: Icon(Icons.text_fields)
        )
    );
  }

}


