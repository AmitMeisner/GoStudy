//import 'package:date_picker_timeline/date_picker_widget.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutterapp/Tips/CoursesMultiChoice.dart';
//import 'package:flutterapp/Tips/Cards.dart';
//import 'package:flutterapp/Tips/Tips.dart';
//import 'package:intl/intl.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//
//import 'cards.dart';
//import 'courseChoice.dart';
//
//class TimeDialog extends StatefulWidget {
//  final Function timesPageSetState;
//  TimeDialog(this.timesPageSetState);
//  @override
//  TimeDialogState createState() => TimeDialogState(timesPageSetState);
//}
//
//class TimeDialogState extends State<TimeDialog> {
//  //  for calling call setState in the tips page
//  Function timesPageSetState;
//  DateTime _selectedate;
//  TimeDialogState(this.timesPageSetState);
//
//  //list of the users tags.
//  List<String> userCourse=[""];
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//      child: mainBodyOfDialog(),
//    );
//  }
//
//  // method to update the list of users tags, to be used from other classes.
//  void updateUserTags(List<String> newUserTags){
//    userCourse.clear();
//    for(int i=0;i<newUserTags.length;i++){
//      userCourse.add(newUserTags[i]);
//    }
//  }
//
//  // creating the dialog body content.
//  Widget mainBodyOfDialog(){
//    return  Column(
//      mainAxisSize: MainAxisSize.min ,
//      children: <Widget>[
//        tags(),
//        resources(),
//        Container(
//          width:double.infinity,
//          height: 100,
//          child: DatePicker(
//            DateTime.now().add(Duration(days: -7)),
//            initialSelectedDate: DateTime.now(),
//            daysCount: 8,
//            selectionColor: Colors.black,
//            selectedTextColor: Colors.white,
//            onDateChange: (date) {
//              // New date selected
//              setState(() {
//                _selectedate = date;
//              });
//            },
//          ),
//        ),
//        Row(
//          children: <Widget>[
//            Spacer(),
//            postButton(context),
//          ],
//        ),
//        Container(),
//      ],
//    );
//  }
//
//  //creating the courses choices in the dialog.
//  Widget tags(){
//    return CourseChoice(updateUserTags,0.0, timesPageSetState, false,false);
//  }
//  Widget resources(){
//    return CourseChoice(updateUserTags,0.0, timesPageSetState, false,true);
//  }
//
//
//  //creating the decoration for the text, description and link inputs.
//  Widget inputDecoration(String hint,TextEditingController controller, double borderRadius, int lines){
//    return TextFormField(
//      controller: controller,
//      autocorrect: false,
//      cursorColor: Colors.black,
//      keyboardType: TextInputType.multiline,
//      maxLines: lines,
//      minLines: lines,
//      decoration: new InputDecoration(
//        border:  InputBorder.none,
//        focusedBorder:  OutlineInputBorder(
//            borderRadius: BorderRadius.only(
//              topLeft:  Radius.circular(borderRadius),
//              topRight:  Radius.circular(borderRadius),
//              bottomLeft:  Radius.circular(borderRadius),
//              bottomRight:  Radius.circular(borderRadius),
//            ),
//            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0)
//        ),
//        enabledBorder:  OutlineInputBorder(
//          borderRadius: BorderRadius.only(
//            topLeft:  Radius.circular(borderRadius),
//            topRight:  Radius.circular(borderRadius),
//            bottomLeft:  Radius.circular(borderRadius),
//            bottomRight:  Radius.circular(borderRadius),
//          ),
//          borderSide: BorderSide(color: Colors.black, width: 2.0),
//        ),
//        errorBorder: InputBorder.none,
//        disabledBorder: InputBorder.none,
//        contentPadding: EdgeInsets.only(left: 15, bottom: 15, top: 11, right: 15),
//        hintText: hint,
//      ),
//    );
//  }
//
//  //creating the post button.
//  Widget postButton(BuildContext context){
//    return Container(
//        alignment: Alignment.bottomRight ,
//        child: FlatButton(
//          onPressed: (){addUserTimeAndUpdate(context);},
//          child: Text("Post"),
//          color: Colors.blueAccent,
//        )
//    );
//  }
//
//  //handle pressing the post button.
//  void addUserTimeAndUpdate(BuildContext context){
//    if(userCourse==""){showColoredToast("Select one course");return;}
//    //cards(timesPageSetState).addCard(userCourse[0],null, getDate(),timeController.text,);
//    timesPageSetState();
//    Navigator.pop(context);
//
//  }
//
////  //return the date in the form day/month/year.
////  static String convertDateToString(DateTime dateTime){
////    var formatter = new DateFormat('yyyy-MM-dd');
////    String formatted = formatter.format(dateTime);
////    return formatted;
////  }
//
//  //display message to the user.
//  void showColoredToast(String msg) {
//    Fluttertoast.showToast(
//        msg: msg,
//        toastLength: Toast.LENGTH_SHORT,
//        backgroundColor: Colors.grey,
//        gravity: ToastGravity.CENTER,
//        textColor: Colors.white);
//  }
//
//
//}
