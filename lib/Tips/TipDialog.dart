import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Tips/CoursesMultiChoice.dart';
import 'package:flutterapp/Tips/Cards.dart';
import 'package:flutterapp/Tips/Tips.dart';

class TipDialog extends StatefulWidget {
  final Function callback;
  TipDialog(this.callback);
  @override
  _TipDialogState createState() => _TipDialogState(callback);
}

class _TipDialogState extends State<TipDialog> {
//  for calling call setState in the tips page
  Function callback;
  _TipDialogState(this.callback);

  List<String> usersTags=["general"];

//  for getting the users tip
  final myController = TextEditingController();
  final myDescController = TextEditingController();

  bool isLink=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: mainBodyOfDialog(isLink),
    );
  }


  void updateUserTags(List<String> newUserTags){
    usersTags.clear();
    for(int i=0;i<newUserTags.length;i++){
      usersTags.add(newUserTags[i]);
    }
  }

  Widget mainBodyOfDialog(bool isLink){
    if(!isLink){
      return  Column(
        mainAxisSize: MainAxisSize.min ,
        children: <Widget>[
          tags(),
          textInput(),
          Row(
            children: <Widget>[
              linkButton(),
              Spacer(),
              postButton(context, callback),
            ],
          ),
        ],
      );
    }else{
      return Column(
        mainAxisSize: MainAxisSize.min ,
        children: <Widget>[
          tags(),
          descriptionInput(),
          Row(
            children: <Widget>[
              linkInput(),
              postButton(context, callback),
            ],
          ),
          textButton(),
        ],
      );
    }

  }

  Widget linkInput(){
    double borderRadius = 20.0;
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
      width: 320,
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: new BorderRadius.only(
                  topLeft:  Radius.circular(borderRadius),
                  topRight:  Radius.circular(borderRadius),
                  bottomLeft:  Radius.circular(borderRadius),
                  bottomRight:  Radius.circular(borderRadius),
                )),
            child: TextFormField(
              controller: myController,
              autocorrect: false,
              cursorColor: Colors.black,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Select tags and enter a URL."),
            ),
          ),
        ],
      ),
    );
  }

  Widget descriptionInput(){
    double borderRadius = 20.0;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: new BorderRadius.only(
                  topLeft:  Radius.circular(borderRadius),
                  topRight:  Radius.circular(borderRadius),
                  bottomLeft:  Radius.circular(borderRadius),
                  bottomRight:  Radius.circular(borderRadius),
                )),
            child: TextFormField(
              controller: myDescController,
              autocorrect: false,
              cursorColor: Colors.black,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Enter a description."),
            ),
          ),
        ],
      ),
    );
  }

  Widget tags(){
    return CoursesMultiChoice(updateUserTags,0.0);
  }

  Widget textInput(){
    double borderRadius = 20.0;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 170,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: new BorderRadius.only(
                  topLeft:  Radius.circular(borderRadius),
                  topRight:  Radius.circular(borderRadius),
                  bottomLeft:  Radius.circular(borderRadius),
                  bottomRight:  Radius.circular(borderRadius),
                )),
            child: TextFormField(
              controller: myController,
              autocorrect: false,
              cursorColor: Colors.black,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Select tags and enter a tip."),
            ),
          ),
        ],
      ),
    );
  }

  Widget postButton(BuildContext context, Function callback){
    return Container(
        alignment: Alignment.bottomRight ,
        child: FlatButton(
            onPressed: (){addUserTipAndUpdate(callback, isLink);},
            child: Text("Post"),
          color: Colors.blueAccent,
        )
    );
  }


  void addUserTipAndUpdate(Function callback, bool link){
    if( myController.text!="" && myController.text!=null){
      if(isLink) {
        Cards().addCard(null, usersTags,isLink, myDescController.text,myController.text);
      }else{
        Cards().addCard(myController.text, usersTags,isLink, null,null);
      }
    }
    callback();
    Navigator.pop(context);

  }

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


