
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/FirstInfo/InformationPage.dart';
import 'package:flutterapp/HomePage/HomeMain.dart';
import 'package:flutterapp/Tips/CoursesMultiChoice.dart';
import 'package:flutterapp/Tips/Cards.dart';
import 'package:flutterapp/Tips/TipDialog.dart';



import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:provider/provider.dart';

import '../Global.dart';

class TipsPage extends StatefulWidget {
  static List<String> usersTags=["general"];
  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {

  //list of the users courses choice in the tip page.
  List<String> usersTags=TipsPage.usersTags;
  TextEditingController searchController=TextEditingController();
  List<bool> _selections=[true,false];
  bool isSearch=false;





  @override
  Widget build(BuildContext context) {
    return  StreamProvider<List<TipCard>>.value(
      value: TipDataBase().tips,
      child: Scaffold(
        backgroundColor:  Global.getBackgroundColor(0),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                CoursesMultiChoice(updateUserTags,updateState, true),
                inputDecoration("Search",searchController, 12.0,TextInputType.text ),
                Cards(updateState),
              ],
            ),
          ),
        ),
        floatingActionButton: fabAddTip(context),
      ),
    );
  }


  Widget inputDecoration(String hint,TextEditingController controller, double borderRadius, TextInputType type){
    return Container(
      height: MediaQuery.of(context).size.height/15,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: controller,
              autocorrect: false,
              cursorColor: Colors.black,
              keyboardType: type,
              maxLines: 1,
              minLines: 1,
              onChanged: (search){
                if(search==""){isSearch=false;TipDataBase().sortBy(2,updateState,isSearch);return;}
                isSearch=true;
                TipDataBase().search(search, updateState);},
              decoration: new InputDecoration(
                border:  InputBorder.none,
                focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft:  Radius.circular(borderRadius),
                      topRight:  Radius.circular(borderRadius),
                      bottomLeft:  Radius.circular(borderRadius),
                      bottomRight:  Radius.circular(borderRadius),
                    ),
                    borderSide: BorderSide(color: InformationPage.focusColor, width: 2.0)
                ),
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft:  Radius.circular(borderRadius),
                    topRight:  Radius.circular(borderRadius),
                    bottomLeft:  Radius.circular(borderRadius),
                    bottomRight:  Radius.circular(borderRadius),
                  ),
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15, bottom: 15, top: 11, right: 15),
                hintText: hint,
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search, color: Colors.grey,),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: (){
                    searchController.clear();
                    isSearch=false;
                    TipDataBase().sortBy(2,updateState,isSearch);
                  },
                ),
              ),
            ),
          ),
          ToggleButtons(
            children: <Widget>[
              Icon(Icons.thumb_up),
              Icon(Icons.date_range),
            ],
            renderBorder: true,
            borderRadius: BorderRadius.circular(10),
            borderColor: Colors.grey,
            color: Colors.grey,
            selectedColor: Colors.black,
            isSelected: _selections,
            onPressed: (int index){
              setState(() {
                _selections[index]=true;
                _selections[1-index]=false;
                TipDataBase().sortBy(index,updateState,isSearch);
              });
            },
          )
        ],
      ),
    );
  }


  //creating the floating action button for add tip.
  Widget fabAddTip(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton.extended(
          onPressed: (){    SystemChannels.textInput.invokeMethod('TextInput.show');
          addTip(context, updateState);},
          label: Text("Add Tip"),
          backgroundColor:  Global.getBackgroundColor(0),
          icon: Icon(Icons.add),
//            shape: new CircleBorder(),
        ),
//        fabReload(context),
      ],
    );
  }


  //creating the floating action button for reloading.
  Widget fabReload(BuildContext context){
    return FloatingActionButton.extended(
      onPressed: (){updateState();},
      label: Icon(Icons.autorenew),
      backgroundColor:  Global.getBackgroundColor(0),
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


