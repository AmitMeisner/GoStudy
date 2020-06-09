
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterapp/HomePage/Extra/cards.dart';
import 'package:flutterapp/Tips/Cards.dart';
import 'package:flutterapp/Tips/Tips.dart';
import 'package:flutterapp/FirstInfo/InformationPage.dart';

class FirebaseAPI{

  static FirebaseUser user ;

  //set user.
  void setUser(FirebaseUser firebaseUser){
    user=firebaseUser;
  }

  //getUser.
  FirebaseUser getUser(){
    return user;
  }

  //get users name.
  String getUserName(){
    return user.displayName;
  }

  //get user first name.
  String getUserFirstName(){
    return user.displayName.split(" ")[0];
  }

  //get User Email.
  String getUserEmail(){
    return user.email;
  }

  //get user uid.
  String getUid(){
    return user.uid;
  }

}


class TipDataBase{

  //collection reference.
  static  CollectionReference tipsCollection= Firestore.instance.collection("Tips");
   Stream<QuerySnapshot> tipsCollectionQuery = tipsCollection.orderBy('likeCount', descending: true)
  .where('tags',arrayContainsAny: selectedTags).snapshots();

   static List<String> selectedTags=["general"];
   static bool firstCall=true;


  //add tip card.
  Future addTip(TipCard tipCard) async{
    DocumentReference doc=await tipsCollection.add({});
    Map<String, dynamic> tipMap = {
      "tip":tipCard.getTip(),
      "description": tipCard.getDescription(),
      "tags":tipCard.getTags(),
      "likeCount": tipCard.getLikesCount(),
      "isLink": tipCard.getIsLink(),
      "link": tipCard.getLink(),
      "date": tipCard.getDate(),
      "likes": tipCard.getLikes(),
      "docId": doc.documentID,
      "uid": tipCard.getUid(),
      };
    return await doc.updateData(tipMap);
  }

  //get sorted tip cards.
  Stream<List<TipCard>> get tips{
      return tipsCollectionQuery.map(_tipCardsFromSnapshot);
  }


  List<TipCard> _tipCardsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return TipCard(
        doc.data["tip"],
        doc.data["description"],
        List.from(doc['tags']),
        doc.data["likeCount"],
        List.from(doc['likes']),
        doc.data["isLink"],
        doc.data["link"],
        doc.data["date"],
        doc.data["docId"],
        doc.data["uid"],
      );
    }).toList();
  }

  //like tip card
  void addLike(TipCard card)async{
    DocumentReference doc = tipsCollection.document(card.getDocId());
    List<String> likes=card.getLikes();
    likes.add(FirebaseAPI().getUid());
    await doc.updateData({"likeCount": card.getLikesCount()+1, "likes": likes});
    return;
  }

  void removeLike(TipCard card)async{
    DocumentReference doc = tipsCollection.document(card.getDocId());
    List<String> likes=card.getLikes();
    likes.remove(FirebaseAPI().getUid());
    await doc.updateData({"likeCount": card.getLikesCount()-1, "likes":likes});

    return;
  }


  bool isLiked(TipCard card){
    if(card.getLikes()!=null && card.getLikes().contains(FirebaseAPI().getUid())){
      return true;
    }
    return false;
  }

  void setUserSelectedTags(List<String> userSelectedTags, Function updateTipsPageState){
    selectedTags=userSelectedTags;
    if(userSelectedTags.isEmpty){selectedTags=["general"];}
    tipsCollectionQuery=tipsCollection.orderBy('likeCount', descending: true).where('tags',arrayContainsAny: selectedTags).snapshots();
    updateTipsPageState();
  }

  //delete tip card.
  void deleteTipCard(TipCard card){
    DocumentReference doc = tipsCollection.document(card.getDocId());
    doc.delete();
  }



}

class UserDataBase {

  //collection reference.
  static  CollectionReference usersCollection= Firestore.instance.collection("Users");
  static User user;


  //add user card.
  Future addUser(User user) async{
    Map<String, dynamic> userMap = {
      "nickname":user.getNickname(),
      "avg":user.getAverage(),
      "friends":user.getFriends(),
      "courses":user.getCourses(),
      "avgGoal":user.getAvgGoal(),
      "dailyGoal":user.getDailyGoal(),
      "year":user.getYear(),
      "semester":user.getSemester(),
      "dedication":user.getDedication(),
      "Goals":user.getGoals()
    };
    return await usersCollection.document(FirebaseAPI().getUid()).setData(userMap);
  }





  //get user
  Future<User> getUser()async{
    DocumentReference userDoc=  usersCollection.document(FirebaseAPI().getUid());
    await userDoc.get().then((doc) {
      user = User(
        doc.data["nickname"],
        doc.data["avg"],
        List.from(doc.data["friends"]),
        List.from(doc.data["courses"]),
        doc.data["avgGoal"],
        doc.data["dailyGoal"],
        doc.data["year"],
        doc.data["semester"],
        doc.data["dedication"],
        List<Set<dynamic>>.from(doc.data["Goals"])
      );
    }
    );
    return user;
  }



  Future<bool> hasData()async{
    DocumentReference userDoc=  usersCollection.document(FirebaseAPI().getUid());
    bool exist=false;
    await userDoc.get().then((doc) {
      if (doc.exists){ exist=true;}
    });
    return exist;
  }


  Future<void> updateUser(User user) async{
    DocumentReference userDoc=  usersCollection.document(FirebaseAPI().getUid());
    await addUser(user);
    return;
  }

}


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(150.0),
        child: SpinKitSpinningCircle(
            color: Colors.blueAccent,
            size: 50.0,
          ),
      ),

    );
  }
}

