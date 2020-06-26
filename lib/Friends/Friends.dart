//import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/FirstInfo/InformationPage.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';

import 'package:provider/provider.dart';

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


  void initial()async{
    friends.clear();
    friendReqNames.clear();
    List<String> friendsuid=await UserDataBase().getUserFriendsList(FirebaseAPI().getUid());
    List<String> freindReqUid=await UserDataBase().getUserFriendReqReceive(FirebaseAPI().getUid());
    for(String user in friendsuid) {
      friends.add(await UserDataBase().getUserNickname(user));
    }
    for(String user in freindReqUid) {
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
    return StreamProvider<List<User>>.value(
      value: FriendsDataBase().users,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
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
    );
  }

  Widget friendsList(){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Text("Friend Requests"
                ,style: TextStyle(fontWeight: FontWeight.bold  ,decoration: TextDecoration.underline)),
          ),
          friendRequest(),
          Center(
            child: Text("Friend List"
                ,style: TextStyle(fontWeight: FontWeight.bold ,decoration: TextDecoration.underline)),
          ),
          friendsListCards(),
        ],
    );
  }

  Widget inputDecoration(String hint,TextEditingController controller, double borderRadius, TextInputType type){
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      color: Colors.grey[300],
      child: Expanded(
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
              icon: Icon(Icons.clear),
              onPressed: (){
                isSearch=false;
                searchController.clear();
                initial();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget friendRequest(){
    return Column(
      children: _createChildren(friendReqNames,true),
    );
  }


  Widget friendsListCards(){
    return Column(
      children: _createChildren(friends,false),
    );
  }


  // creating list of the users tags.
  List<Widget> _createChildren(List<String> lst, bool friendReq) {
    return new List<Widget>.generate(lst.length, (int index) {
      return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.person),
                      SizedBox(width: 4.0),
                      Text(lst[index].toString()),
                    ],
                  ),
                  friendReq? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.green,
                        child: Text("Accept"),
                        onPressed: (){FriendsDataBase().friendRequestAnswer(true,
                            UserDataBase.user.getFriendRequestReceive()[index],
                            initial);
                        },
                      ),
                      RaisedButton(
                        color: Colors.red,
                        child: Text("Delete"),
                        onPressed: (){FriendsDataBase().friendRequestAnswer(false,
                            UserDataBase.user.getFriendRequestReceive()[index],
                            initial);
                        },
                      ),
                    ],
                  ):Container(),
                ],
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
