//import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/FirstInfo/InformationPage.dart';
import 'package:flutterapp/Global.dart';
import 'package:flutterapp/Tips/Cards.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../NavigationButtom.dart';
import 'FriendsCards.dart';


class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  TextEditingController searchController=TextEditingController();
  bool isSearch=false;
  List<String> friendReqNames=[];
  List<String> friends=[];
  List<String> friendsUid=[];


  void initial()async{
    friends.clear();
    friendReqNames.clear();
    friendsUid.clear();
    friendsUid=await UserDataBase().getUserFriendsList(FirebaseAPI().getUid());
    List<String> friendReqUid=await UserDataBase().getUserFriendReqReceive(FirebaseAPI().getUid());
    for(String user in friendsUid) {
      friends.add(await UserDataBase().getUserNickname(user));
    }
    for(String user in friendReqUid) {
      friendReqNames.add(await UserDataBase().getUserNickname(user));
    }
    setState(() {});

  }

  @override
  void initState() {
    initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: StreamProvider<List<User>>.value(
        value: FriendsDataBase().users,
        child: Scaffold(
          backgroundColor: Global.backgroundPageColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  inputDecoration("Search",searchController, 50.0,TextInputType.text ),
                  isSearch? FriendsCards(initial):friendsList(),
                ],
              ),
            ),
          ),
//        floatingActionButton: fabAddTip(context),
        ),
      ),
      onWillPop: ()async{
        pushPage(context, NavigationBottomPage());
        return false;
        },
    );
  }

  Future<T> pushPage<T>(BuildContext context, Widget page) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  Widget friendsList(){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Friend Requests", style: GoogleFonts.habibi(fontSize: 35, fontWeight: FontWeight.bold),
//          TextStyle(fontFamily: 'Piedra',fontSize: 35)
          ),
          friendRequest(),
          Text("Friends List", style: GoogleFonts.habibi(fontSize: 35, fontWeight: FontWeight.bold),
//          TextStyle(fontFamily: 'Piedra',fontSize: 35)
          ),
          friendsListCards(),
        ],
    );
  }

  Widget inputDecoration(String hint,TextEditingController controller, double borderRadius, TextInputType type){
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      color: Global.backgroundPageColor,
      child: TextFormField(
        controller: controller,
        autocorrect: false,
        cursorColor: Colors.black,
        keyboardType: type,
        maxLines: 1,
        minLines: 1,
        onChanged: (search){
          FriendsDataBase().searchUsers(search,setFriendPageState);
          setState(() {
            isSearch= (search==""? false:true);
          });
        },
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
            icon: Icon(Icons.clear , color: Colors.grey[600],),
            onPressed: (){
              isSearch=false;
              FocusScope.of(context).unfocus();
              searchController.clear();
              initial();
            },
          ),
        ),
      ),
    );
  }

  Widget friendRequest(){
    return Card(
      child: friendReqNames.isEmpty? emptyCardMessage("There are no friend requests"):Column(
        children:_createChildren(friendReqNames,true),
      ),
    );
  }


  Widget friendsListCards(){
    return Card(
      child: friends.isEmpty? emptyCardMessage("Search friends and add them to your friends list"):Column(
        children: _createChildren(friends,false),
      ),
    );
  }


  Widget emptyCardMessage(String msg){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(child: Text(msg, style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),)),
    );
  }

  // creating list of the users tags.
  List<Widget> _createChildren(List<String> lst, bool friendReq) {
    return new List<Widget>.generate(lst.length, (int index) {
      return Container(
        child: Card(
            elevation: 5.0,
            child: Padding(
              padding: friendReq? const EdgeInsets.all(12.0):const EdgeInsets.all(12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.person),
                            SizedBox(width: 4.0),
                            Text(lst[index].toString()),
                          ],
                        ),
                      ],
                    ),
                    friendReq? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height/23,
                          width: MediaQuery.of(context).size.width/5,
                          child: RaisedButton(
                            color: Colors.blue,
                            child: Text("Accept"),
                            onPressed: ()async{
                                UserDataBase.user=await UserDataBase().getUser();
                                FriendsDataBase().friendRequestAnswer(true,
                                UserDataBase.user.getFriendRequestReceive()[index],
                                initial);
                            },
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Container(
                          height: MediaQuery.of(context).size.height/23,
                          width: MediaQuery.of(context).size.width/5,
                          child: RaisedButton(
                            color: Colors.grey,
                            child: Text("Delete"),
                            onPressed: ()async{
                              UserDataBase.user=await UserDataBase().getUser();
                              FriendsDataBase().friendRequestAnswer(false,
                                UserDataBase.user.getFriendRequestReceive()[index],
                                initial);
                            },
                          ),
                        ),
                      ],
                    ):PopupMenuButton<String>(
                      onSelected: (ind)async{
                        switch (int.parse(ind)){
                          case 0:
                            FriendsDataBase().removeFriend(friendsUid[index],initial);
                            return;
                        }
                      },
                      icon: Icon(Icons.more_vert,color: Colors.black,),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        PopupMenuItem(value:'0',child: Text("Unfriend "+lst[index].toString())),
                      ],
                    ),

                  ],
              ),
            ),
        ),
      );
    });
  }




  void setFriendPageState(){
    setState(() {
    });
    return;
  }

}
