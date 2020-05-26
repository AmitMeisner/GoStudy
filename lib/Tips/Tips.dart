
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
                CoursesMultiChoice(updateUserTags,20,updateState),
                Cards(updateState),
              ],
            ),
          ),
        ),
        floatingActionButton: fab(context),
      ),
    );
  }


  //creating the floating action button.
  Widget fab(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Center(
          child: FloatingActionButton.extended(
            onPressed: (){addTip(context, updateState);},
            label: Text("Add Tip"),
            backgroundColor: Colors.blueAccent,
            icon: Icon(Icons.add),
//            shape: new CircleBorder(),
          ),
        )
      ],
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


