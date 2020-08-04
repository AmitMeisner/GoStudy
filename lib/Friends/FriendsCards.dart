import 'package:flutter/material.dart';
import 'package:animated_card/animated_card.dart';
import 'package:flutterapp/FirstInfo/InformationPage.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'dart:async';
import 'package:provider/provider.dart';

import '../Global.dart';



class FriendsCards extends StatefulWidget {
  static List<User> _users=[];
  final Function initialFriendPage;
  FriendsCards(this.initialFriendPage);
  @override
  _FriendsCardsState createState() => _FriendsCardsState(initialFriendPage);
}

class _FriendsCardsState extends State<FriendsCards> {
  static List<String> friends=[];

  void initial()async{
    List<String> friendsuid=await UserDataBase().getUserFriendsList(FirebaseAPI().getUid());
    friends.clear();
    for(String user in friendsuid) {
      friends.add(user);
    }
    setState(() {});
  }

  @override
  void initState() {
    initial();
    super.initState();
  }

  final Function initialFriendPage;
  _FriendsCardsState(this.initialFriendPage);

  @override
  Widget build(BuildContext context){
    FriendsCards._users=null;
    updateUsersList(context);
    if(FriendsCards._users==null){
      return Loading();
    }
    return Container(
//      color: Colors.grey[300],
      height: MediaQuery.of(context).size.height*2/3,
      padding: EdgeInsets.only(bottom: 50.0),
      child: ListView.builder(
        itemCount: FriendsCards._users.length,
        itemBuilder: (context, index) {
          return AnimatedCard(
            direction: AnimatedCardDirection.top,
            //Initial animation direction
            initDelay: Duration(milliseconds: 0),
            //Delay to initial animation
            duration: Duration(milliseconds: 400),
            //Initial animation duration
            onRemove: null,
            curve: Curves.decelerate,
            //Animation curve
            child: cardContent(context, index, FriendsCards._users,initialFriendPage),

          );
        },
      ),
    );
  }

  Future<List<User>> updateUsersList(BuildContext context) async{
    FriendsCards._users=Provider.of<List<User>>(context);
    return FriendsCards._users;
  }
}


// creating the cards content.
Widget cardContent(BuildContext context, int index , List<User> users,Function initialFriendPage){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Card(
      elevation: 5,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(users[index].getNickname()),
            addFriend(users,index,initialFriendPage),
          ],
        ),
      ),
    ),
  );
}

IconButton addFriend(List<User> users, int index,Function initialFriendPage){
  bool contain=(_FriendsCardsState.friends.contains(users[index].getUid()) || users[index].getUid()==FirebaseAPI().getUid());
  if (contain){
    return IconButton(
      icon: Icon(
        Icons.check,
        color: Colors.black,
      ),
      onPressed: (){},
    );
  }
  return IconButton(
    icon: Icon(
      Icons.person_add,
      color: (users[index].getFriendRequestReceive().contains(FirebaseAPI().getUid())? Colors.blueAccent: Colors.black),
    ),
    onPressed: (){
      FriendsDataBase().sendFriendRequest(users[index],initialFriendPage);
    },
  );
}

