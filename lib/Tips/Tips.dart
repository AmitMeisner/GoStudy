
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/HomeMain.dart';
import 'package:flutterapp/Tips/CoursesMultiChoice.dart';
import 'package:flutterapp/Tips/Cards.dart';
import 'package:flutterapp/Tips/TipDialog.dart';



import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:provider/provider.dart';

class TipsPage extends StatefulWidget {
  static List<String> usersTags=["general"];
  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {

  //list of the users courses choice in the tip page.
  List<String> usersTags=TipsPage.usersTags;


  @override
  Widget build(BuildContext context) {
    return  StreamProvider<List<TipCard>>.value(
      value: TipDataBase().tips,
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                CoursesMultiChoice(updateUserTags,20,updateState, true),
                Cards(updateState),
              ],
            ),
          ),
        ),
        floatingActionButton: fabAddTip(context),
      ),
    );
  }


  //creating the floating action button for add tip.
  Widget fabAddTip(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton.extended(
                onPressed: (){addTip(context, updateState);},
                label: Text("Add Tip"),
                backgroundColor: Colors.blueAccent,
                icon: Icon(Icons.add),
//            shape: new CircleBorder(),
              ),
              fabReload(context),
            ],
          ),
        )
      ],
    );
  }


  //creating the floating action button for reloading.
  Widget fabReload(BuildContext context){
    return FloatingActionButton.extended(
      onPressed: (){updateState();},
      label: Icon(Icons.autorenew),
      backgroundColor: Colors.blueAccent,
      shape: new CircleBorder(),
      focusElevation: 30.0,
    );
  }


  //updating the state of the tips page, to be used in other classes.
  void updateState(){
    setState(() {});
  }

  //updating the users courses choice in the tip page.
  void updateUserTags(List<String> newUserTags){
    usersTags.clear();
    for(int i=0;i<newUserTags.length;i++){
      usersTags.add(newUserTags[i]);
    }
  }

}

//adding a tip the tips page.
void addTip(BuildContext context, Function callback){
  showModalBottomSheet(
      context: context,
      builder: (context){return TipDialog(callback);},
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      );
}


