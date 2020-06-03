import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Tips/CoursesMultiChoice.dart';
import 'package:flutterapp/Tips/Cards.dart';
import 'package:flutterapp/Tips/Tips.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TipDialog extends StatefulWidget {
  final Function tipsPageSetState;
  TipDialog(this.tipsPageSetState);
  @override
  TipDialogState createState() => TipDialogState(tipsPageSetState);
}

class TipDialogState extends State<TipDialog> {
  //  for calling call setState in the tips page
  Function tipsPageSetState;
  TipDialogState(this.tipsPageSetState);

  //list of the users tags.
  List<String> usersTags=["general"];

  // controllers for getting the users input.
  final tipController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();

  // indicator if the tip is a link or text.
  bool isLink=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: mainBodyOfDialog(isLink),
    );
  }

  // method to update the list of users tags, to be used from other classes.
  void updateUserTags(List<String> newUserTags){
    usersTags.clear();
    for(int i=0;i<newUserTags.length;i++){
      usersTags.add(newUserTags[i]);
    }
  }

  // creating the dialog body content.
  Widget mainBodyOfDialog(bool isLink){
    return  Column(
      mainAxisSize: MainAxisSize.min ,
      children: <Widget>[
        tags(),
        isLink? descriptionInput():textInput(),
        isLink? SizedBox(height:5.0):Container(),
        Row(
          children: <Widget>[
            isLink? linkInput():linkButton(),
            isLink? Container():Spacer(),
            postButton(context),
          ],
        ),
        isLink? textButton():Container(),
      ],
    );
  }

  //creating the link input in the dialog.
  Widget linkInput(){
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
      width: 320,
      child: Column(
        children: <Widget>[
          inputDecoration( "Select tags and enter a URL.",linkController, 32.0,1),
        ],
      ),
    );
  }

  //creating the description input in the dialog.
  Widget descriptionInput(){
    return inputDecoration( "Enter a description.",descriptionController, 32.0,1);
  }

  //creating the courses choices in the dialog.
  Widget tags(){
    return CoursesMultiChoice(updateUserTags,0.0, tipsPageSetState, false);
  }

  //creating the text input in the dialog.
  Widget textInput(){
    return Container(
      child: Column(
        children: <Widget>[
          inputDecoration("Select tags and enter a tip.",tipController, 32.0,10),
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
            onPressed: (){addUserTipAndUpdate(context, isLink);},
            child: Text("Post"),
          color: Colors.blueAccent,
        )
    );
  }

  //handle pressing the post button.
  void addUserTipAndUpdate(BuildContext context, bool link){
    if(usersTags.length==0){showColoredToast("Select at least one tag");return;}
    if(isLink){
      if(descriptionController.text==""){showColoredToast("Enter a description"); return;}
      if(linkController.text==""){showColoredToast("Enter a link");return;}
       Cards(tipsPageSetState).addCard(null, usersTags,isLink, descriptionController.text,linkController.text,  getDate());
    }else{
      if(tipController.text==""){showColoredToast("Enter a tip");return;}
       Cards(tipsPageSetState).addCard(tipController.text, usersTags,isLink, null,null,  getDate());
    }
    tipsPageSetState();
    Navigator.pop(context);

  }

  //return the date in the form day/month/year.
  static String getDate(){
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String day=date.day.toString();
    String month=date.month.toString();
    String year=date.year.toString();
    return (day+"/"+month+"/"+year);
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

  //creating the link button, that changes the dialog to link mode.
  Widget linkButton(){
    return  Container(
        alignment:Alignment.bottomLeft,
        child: FlatButton(
            color: Colors.grey[200],
            onPressed: (){isLink=true ; setState(() {});},
            child: Icon(Icons.link)
        )
    );
  }

  //creating the text button that changes the dialog to a text mode.
  Widget textButton(){
    return  Container(
        alignment:Alignment.bottomLeft,
        child: FlatButton(
            color: Colors.grey[200],
            onPressed: (){isLink=false ; setState(() {});},
            child: Icon(Icons.text_fields)
        )
    );
  }

}


