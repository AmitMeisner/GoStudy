
//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterapp/HomePage/History/cards.dart';
import 'package:flutterapp/Tips/Cards.dart';
import 'package:flutterapp/Tips/Tips.dart';
import 'package:flutterapp/FirstInfo/InformationPage.dart';
import 'dart:math';


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

class statisticsDataBase{
  static  CollectionReference statsCollection= Firestore.instance.collection("Statistics");
  Future<String> getData(String document, String field) async {
    //Returns the data from the relevant (Statistics).document.field
    String data;
    var x = statsCollection.document(document).get().then((value){
      data = value.data[field];
    });
    return data;
  }


}

class TipDataBase{

  //collection reference.
  static  CollectionReference tipsCollection= Firestore.instance.collection("Tips");
  static Stream<QuerySnapshot> tipsCollectionQuery = tipsCollection.orderBy(sort, descending: true)
  .where('tags',arrayContainsAny: selectedTags).snapshots();

//  Stream<QuerySnapshot> tipsCollectionQuery = tipsCollection.orderBy('date', descending: true)
//      .where('tags',arrayContainsAny: selectedTags).snapshots();

   static List<String> selectedTags=["general"];
   static bool firstCall=true;
   static String sort="likeCount";



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
      "search": tipCard.getSearch(),
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
        DateTime.parse(doc.data["date"].toDate().toString()),
        doc.data["docId"],
        doc.data["uid"],
        List.from(doc.data["search"])
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

  void sortBy(int index,Function setTipsPageState, bool isSearch){
    switch(index){
      case 0:
        sort="likeCount";

        tipsCollectionQuery = isSearch? tipsCollectionQuery:tipsCollection.orderBy('likeCount', descending: true)
            .where('tags',arrayContainsAny: selectedTags).snapshots();

            break;
      case 1:
        sort="date";

        tipsCollectionQuery = isSearch? tipsCollectionQuery:tipsCollection.orderBy('date', descending: true)
            .where('tags',arrayContainsAny: selectedTags).snapshots();

            break;
      default:
        tipsCollectionQuery = tipsCollection.orderBy(sort, descending: true)
            .where('tags',arrayContainsAny: selectedTags).snapshots();

    }
    setTipsPageState();

  }

  void search(String searchInput, Function setTipsPageState){
    tipsCollectionQuery = tipsCollection.orderBy(sort, descending: true).where("search",arrayContainsAny: [searchInput.toUpperCase()]).snapshots();
    setTipsPageState();
  }

}

class UserDataBase {

  //collection reference.
  static  CollectionReference usersCollection= Firestore.instance.collection("Users");
  static User user;


  //add user card.
  Future<void> addUser(User user) async{
    Map<String, dynamic> userMap = {
      "uid":FirebaseAPI().getUid(),
      "nickname":user.getNickname(),
      "avg":user.getAverage(),
      "friends":user.getFriends(),
      "courses":user.getCourses(),
      "year":user.getYear(),
      "semester":user.getSemester(),
      "friendRequestSent":user.getFriendRequestSent(),
      "friendRequestReceive": user.getFriendRequestReceive(),
      "searchNickname":user.getSearchNickname(),
      "Gender": user.getGender(),
    };
    return await usersCollection.document(FirebaseAPI().getUid()).setData(userMap);
  }

  //get user
  Future<User> getUser()async{
    DocumentReference userDoc=  usersCollection.document(FirebaseAPI().getUid());
    await userDoc.get().then((doc) {
      user = User(
        doc.data["uid"],
        doc.data["nickname"],
        doc.data["avg"],
        List.from(doc.data["friends"]),
        List.from(doc.data["courses"]),
        doc.data["year"],
        doc.data["semester"],
        List<String>.from(doc.data["friendRequestSent"]),
        List<String>.from(doc.data["friendRequestReceive"]),
        List<String>.from(doc.data["searchNickname"]),
        doc.data["Gender"],

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

  Future<bool> validNickname(String nickname)async {
    Stream<QuerySnapshot> userDoc=usersCollection.where("nickname",isEqualTo: nickname).snapshots();
    QuerySnapshot l=await userDoc.first;
    if(l.documents.length==0 || (l.documents.length==1 && l.documents[0].data['uid']==FirebaseAPI().getUid())){return true;}
    return false;
  }


  Future<String> getUserNickname(String uid)async{
    DocumentReference userDoc=  usersCollection.document(uid);
    String res;
    await userDoc.get().then((value){
      res=value.data["nickname"];
    });
    return res;
  }

  Future<List<String>> getUserFriendsList(String uid)async{
    DocumentReference userDoc=  usersCollection.document(uid);
    List<String> res=[];
    await userDoc.get().then((value){
      res=List<String>.from(value.data["friends"]);
    });
    return res;
  }


  Future<List<String>> getUserFriendReqReceive(String uid)async{
    DocumentReference userDoc=  usersCollection.document(uid);
    List<String> res=[];
    await userDoc.get().then((value){
      res=List<String>.from(value.data["friendRequestReceive"]);
    });
    return res;
  }


  Future<List<String>> getUserFriendReqSent(String uid)async{
    DocumentReference userDoc=  usersCollection.document(uid);
    List<String> res=[];
    await userDoc.get().then((value){
      res=List<String>.from(value.data["friendRequestSent"]);
    });
    return res;
  }

}

class FriendsDataBase{
  //collection reference.
  static  CollectionReference usersCollection= Firestore.instance.collection("Users");
  static Stream<QuerySnapshot> usersCollectionQuery = usersCollection.orderBy('nickname').snapshots();

  //get sorted users cards.
  Stream<List<User>> get users{
    return usersCollectionQuery.map(_usersCardsFromSnapshot);
  }

  List<User> _usersCardsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return User(
          doc.data["uid"],
          doc.data["nickname"],
          doc.data["avg"],
          List.from(doc.data["friends"]),
          List.from(doc.data["courses"]),
          doc.data["year"],
          doc.data["semester"],
          List<String>.from(doc.data["friendRequestSent"]),
          List<String>.from(doc.data["friendRequestReceive"]),
          List<String>.from(doc.data["searchNickname"]),
         doc.data["Gender"],

      );
    }).toList();
  }

  void searchUsers(String searchInput, Function setFriendPageState){
    usersCollectionQuery= searchInput.isEmpty?
    usersCollection.orderBy('nickname').snapshots():usersCollection.where('searchNickname',arrayContainsAny: [searchInput.toUpperCase()]).snapshots();
    setFriendPageState();
  }

  void sendFriendRequest(User friendUser, Function setFriendsPageStat)async{
     DocumentReference friend=usersCollection.document(friendUser.getUid());
     List<String> freindReqRecieve = friendUser.getFriendRequestReceive();
     DocumentReference user = usersCollection.document(FirebaseAPI().getUid());
     List<String> userReqSent = friendUser.getFriendRequestSent();
     if(!freindReqRecieve.contains(FirebaseAPI().getUid())) {
       freindReqRecieve.add(FirebaseAPI().getUid());
       await friend.updateData({"friendRequestReceive": freindReqRecieve});
       userReqSent.add(friendUser.getUid());
       await user.updateData({"friendRequestSent": userReqSent});
     }else{
       freindReqRecieve.remove(FirebaseAPI().getUid());
       await friend.updateData({"friendRequestReceive": freindReqRecieve});
       userReqSent.remove(friendUser.getUid());
       await user.updateData({"friendRequestSent": userReqSent});
     }
     await setFriendsPageStat();
  }

  List<String> nicknameSearch(String nickname){
    List<String> res=[];
    int len=nickname.length;
    for(int firstIndex=0; firstIndex<len;firstIndex++){
      for(int lastIndex=firstIndex+1;lastIndex<=len;lastIndex++){
        res.add(nickname.substring(firstIndex,lastIndex).toUpperCase());
      }
    }
    return res;
  }

  void friendRequestAnswer(bool accept, String friendUid, Function initialFriendPage)async{
    DocumentReference friend=usersCollection.document(friendUid);
    DocumentReference user=usersCollection.document(FirebaseAPI().getUid());
    List<String> friendReqSent;
    List<String> userFriendReqReceive;
    await friend.get().then((value) => friendReqSent=List<String>.from(value.data["friendRequestSent"]));
    await user.get().then((value) => userFriendReqReceive=List<String>.from(value.data["friendRequestReceive"]));
    friendReqSent.remove(FirebaseAPI().getUid());
    userFriendReqReceive.remove(friendUid);
    friend.updateData({"friendRequestSent":friendReqSent});
    user.updateData({"friendRequestReceive":userFriendReqReceive});

    if(accept){
      List<String> friendFriends;
      List<String> userFriends;
      await friend.get().then((value) => friendFriends=List<String>.from(value.data["friends"]));
      await user.get().then((value) => userFriends=List<String>.from(value.data["friends"]));
      friendFriends.add(FirebaseAPI().getUid());
      userFriends.add(friendUid);
      friend.updateData({"friends":friendFriends});
      user.updateData({"friends":userFriends});
    }
    await initialFriendPage();

    return;
  }

  void removeFriend( String friendUid, Function initialFriendPage)async{
    DocumentReference friend=usersCollection.document(friendUid);
    DocumentReference user=usersCollection.document(FirebaseAPI().getUid());
    List<String> friendFriendsList;
    List<String> userFriendList;
    await friend.get().then((value) => friendFriendsList=List<String>.from(value.data["friends"]));
    await user.get().then((value) => userFriendList=List<String>.from(value.data["friends"]));
    friendFriendsList.remove(FirebaseAPI().getUid());
    userFriendList.remove(friendUid);
    friend.updateData({"friends":friendFriendsList});
    user.updateData({"friends":userFriendList});

    await initialFriendPage();

    return;
  }


//  Future<double> getFriendProgress(String uid)async{
//    DocumentReference doc=usersCollection.document(uid);
//    List<String> times=[];
//    List<String> goals=[];
//    List<String> tmp=[];
//    double res=0.0;
//    await doc.get().then((value){
//      times=List.from(value.data["Times"]);
//      goals=List.from(value.data["Goals"]);
//    });
//
//
//    for(String elem in times){
//      tmp=elem.split("_");
//      if(tmp[0]=="totalTime"){
//        res=double.parse(tmp[1]);
//        break;
//      }
//    }
//
//
//    for(String elem in goals){
//      tmp=elem.split("_");
//      if(tmp[0]=="SemesterHours"){
//        res=double.parse((res/double.parse(tmp[1])).toStringAsFixed(2));
//        break;
//      }
//    }
//    return res*100;
//
//
//  }
//
//  Future<int> getFriendRank(String uid)async{
//    DocumentReference doc=usersCollection.document(uid);
//    int res=1;
//    await doc.get().then((value){
//      res=value.data["Rank"];
//    });
//
//    return res;
//  }

}


class AllUserDataBase {

  //collection reference.
  static  CollectionReference usersDataCollection= Firestore.instance.collection("AllUsers");
  static Stream<QuerySnapshot> usersDataCollectionQuery = usersDataCollection.where('avg',isGreaterThan: 0).snapshots();


  //add user card.
  Future<void> addUserData(UserStatForCourse user) async{
    Map<String, dynamic> userMap = {
      "avg":user.getAvg(),
      "course":user.getCourse(),
      "examTime":user.getExamTime(),
      "extraTime":user.getExtraTime(),
      "grade":user.getGrade(),
      "hwTime":user.getHWTime(),
      "lectureTime":user.getLectureTime(),
      "recTime":user.getRecTime(),
      "userId":user.getUserId(),
    };
    return await usersDataCollection.document().setData(userMap);
  }


  Stream<List<UserStatForCourse>> get usersStats{
    return usersDataCollectionQuery.map(_usersDataCardsFromSnapshot);
  }

  List<UserStatForCourse> _usersDataCardsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return UserStatForCourse(
        doc.data['course'],
        doc.data['avg']==null? 1.0:doc.data['avg'].toDouble(),
        doc.data['hwTime']==null? 1.0:doc.data['hwTime'].toDouble(),
        doc.data['lectureTime']==null? 1.0:doc.data['lectureTime'].toDouble(),
        doc.data['recTime']==null? 1.0:doc.data['recTime'].toDouble(),
        doc.data['examTime']==null? 1.0:doc.data['examTime'].toDouble(),
        doc.data['extraTime']==null? 1.0:doc.data['extraTime'].toDouble(),
        doc.data['grade']==null? 1.0:doc.data['grade'].toDouble(),
        doc.data['userId'],
      );
    }).toList();
  }

  Future<void> sortUsersDataByGrades(int dedication, Function updateProgressPage)async{
    usersDataCollectionQuery=null;
    switch(dedication){
      case 0:
        usersDataCollectionQuery = usersDataCollection.where('grade',isGreaterThan: 0).snapshots();
        break;
      case 1:
        usersDataCollectionQuery = usersDataCollection.where('grade',isGreaterThan: 70).where('grade',isLessThan: 80).snapshots();
        break;
      case 2:
        usersDataCollectionQuery = usersDataCollection.where('grade',isGreaterThan: 80).where('grade',isLessThan: 90).snapshots();
        break;
      case 3:
        usersDataCollectionQuery = usersDataCollection.where('grade',isGreaterThan: 90).where('grade',isLessThan: 100).snapshots();
        break;
    }
    updateProgressPage();
    await usersDataCollectionQuery.first;
  }

  Future<String> getWeek()async{
    DocumentReference week=Firestore.instance.collection("AllUsers").document("week");
    String res="";
    await week.get().then((value) => res=value.data["weekNumber"].toString());
    return res;
  }

}


class UserProgressDataBase{

  static CollectionReference usersCollection= Firestore.instance.collection("Progress");

  Future<void> addUser(UserProgress userProgress) async{
    Map<String, dynamic> userMap = {
      "avg":userProgress.getAvg(),
      "goals":userProgress.getGoals(),
      "times":userProgress.getTimes(),
      "rank":userProgress.getRank(),
      "dedication":userProgress.getDedication(),
    };
    return await usersCollection.document(FirebaseAPI().getUid()).setData(userMap);
  }


  Future<UserProgress> getUser(String uid)async{
    DocumentReference doc=usersCollection.document(uid);
    UserProgress user=UserProgress(0, 1, [], [],3);
    await doc.get().then((value){
      user.setAvg(value.data["avg"]);
      user.setRank(value.data["rank"]);
      user.setTimes(List<String>.from(value.data["times"]));
      user.setGoals(List<String>.from(value.data["goals"]));
      user.setDedication(value.data["dedication"]);
    });

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

  Future<void> updateUser(UserProgress user){
    return addUser(user);
  }

  Future<int> getFriendRank(String uid)async{
    DocumentReference doc=usersCollection.document(uid);
    int res=1;
    await doc.get().then((value){
      res=value.data["rank"];
    });

    return res;
  }


  Future<double> getFriendProgress(String uid)async{
    DocumentReference doc=usersCollection.document(uid);
    List<String> times=[];
    List<String> goals=[];
    List<String> tmp=[];
    double res=0.0;
    await doc.get().then((value){
      times=List.from(value.data["times"]);
      goals=List.from(value.data["goals"]);
    });


    for(String elem in times){
      tmp=elem.split("_");
      if(tmp[0]=="totalTime"){
        res=double.parse(tmp[1]);
        break;
      }
    }


    for(String elem in goals){
      tmp=elem.split("_");
      if(tmp[0]=="SemesterHours"){
        res=double.parse((res/double.parse(tmp[1])).toStringAsFixed(2));
        break;
      }
    }
    return res*100;


  }


}


class UserProgress{
  double _avg;
  List<String> _goals=[];
  List<String> _times=[];
  int _rank;
  int _dedication;
  UserProgress(this._avg, this._rank ,this._times , this._goals, this._dedication);

  void setAvg(double avg){
    this._avg=avg;
  }

  double getAvg(){
    return this._avg;
  }

  void addGoal(String course , Activities activity, double time){
    if(course==null && activity==null){
      _goals.add("SemesterHours"+"_"+time.toString());
      return;
    }
    String act="";
    switch(activity){
      case Activities.HomeWork:
        act="HomeWork";
        break;
      case Activities.Lectures:
        act="Lectures";
        break;
      case Activities.Recitation:
        act="Recitation";
        break;
      case Activities.Exams:
        act="Exams";
        break;
      case Activities.Extra:
        act="Extra";
        break;
    }
    _goals.add(course+"_"+act+"_"+time.toString());
  }

  double getGoal(String course , Activities activity){
    String act="";
    switch(activity){
      case Activities.HomeWork:
        act="HomeWork";
        break;
      case Activities.Lectures:
        act="Lectures";
        break;
      case Activities.Recitation:
        act="Recitation";
        break;
      case Activities.Exams:
        act="Exams";
        break;
      case Activities.Extra:
        act="Extra";
        break;
      default:
        act="";
        break;
    }
    List<String> res=_goals;

    for(String elem in res){
      List<String> parsing=elem.split("_");
      if(parsing[0]==course && parsing[1]==act){
        return double.parse(parsing[2]);
      }
      if(course=="SemesterHours" && parsing[0]=="SemesterHours") {
        return double.parse(parsing[1]);
      }
    }
    return 10.0;
  }

  // updating course goal by resource

  void setGoalForCourse(String course , String activity, String time, String current) async{
    List<String> goals;
    CollectionReference usersCollection= Firestore.instance.collection("Progress");
    await usersCollection.document(FirebaseAPI().getUid()).get().then((value){
     goals = List.from(value.data["goals"]);
     print(goals);
    }).then((_) {
      activity == "Homework" ? activity = "HomeWork" : null;
      String name = course+"_"+activity+"_"+current;
      String newName = course+"_"+activity+"_"+time;
      int index;
      for (int i=0;i<goals.length;i++){
        if (goals.elementAt(i) == name) index = i;;
      }
      goals.replaceRange(index, index+1, [newName]);
      updateGoals(goals, name);
    });
  }

  void updateGoals(List<String> goals,String oldName) async{
    CollectionReference usersCollection= Firestore.instance.collection("Progress");
    await usersCollection.document(FirebaseAPI().getUid()).updateData({
      "goals": FieldValue.arrayRemove([oldName]),
    });
    await usersCollection.document(FirebaseAPI().getUid()).updateData({
      "goals": FieldValue.arrayUnion(goals)
    });
  }

  List<String> getGoals(){
    return _goals;
  }

  void setGoals(List<String> lst){
    this._goals=lst;
  }

  void resetGoals(){
    _goals.clear();
  }

  void setTimes(List<String> times){
    this._times=times;
  }

  void setRank(int rank){
    this._rank=rank;
  }

  int getRank(){
    return this._rank;
  }

  void addCourseTime(String course , Activities activity, double time){
    double prevTime=getCourseTime( course ,  activity);
    double newTime=prevTime+time;
    if(course=="totalTime"){
      _times.remove(course+"_"+prevTime.toString());
      _times.add(course+"_"+newTime.toStringAsFixed(2));
      return;
    }
    String act="";
    switch(activity){
      case Activities.HomeWork:
        act="HomeWork";
        break;
      case Activities.Lectures:
        act="Lectures";
        break;
      case Activities.Recitation:
        act="Recitation";
        break;
      case Activities.Exams:
        act="Exams";
        break;
      case Activities.Extra:
        act="Extra";
        break;
    }
    _times.remove(course+"_"+act+"_"+prevTime.toString());
    _times.add(course+"_"+act+"_"+newTime.toStringAsFixed(2));

  }

  double getCourseTime(String course , Activities activity){
    String act="";
    switch(activity){
      case Activities.HomeWork:
        act="HomeWork";
        break;
      case Activities.Lectures:
        act="Lectures";
        break;
      case Activities.Recitation:
        act="Recitation";
        break;
      case Activities.Exams:
        act="Exams";
        break;
      case Activities.Extra:
        act="Extra";
        break;
    }
    List<String> res=_times;
    for(String elem in res){
      List<String> parsing=elem.split("_");
      if(course=="totalTime" && parsing[0]==course){
        return double.parse(parsing[1]);
      }
      if(parsing[0]==course && parsing[1]==act){
        return double.parse(parsing[2]);
      }
    }
    return 0.0;
  }

  List<String> getTimes(){
    return this._times;
  }


  void setDedication(int ded){
    this._dedication=ded;
  }

  int getDedication(){
    return _dedication;
  }

}




class UserStatForCourse{
  String _course;
  double _avg;
  double _hwTime;
  double _lectureTime;
  double _recTime;
  double _examTime;
  double _extraTime;
  double _grade;
  String _userId;

  UserStatForCourse(this._course,this._avg,this._hwTime,this._lectureTime,this._recTime,this._examTime,this._extraTime,this._grade, this._userId);

  void setCourse(String course){
    this._course=course;
  }

  String getCourse(){
    return this._course;
  }

  void setAvg(double avg){
    this._avg=avg;
  }

  double getAvg(){
    return this._avg;
  }

  void setHWTime(double hwTime){
    this._hwTime=hwTime;
  }

  double getHWTime(){
    return this._hwTime;
  }

  void setLectureTime(double lectureTime){
    this._lectureTime=lectureTime;
  }

  double getLectureTime(){
    return this._lectureTime;
  }

  void setRecTime(double recTime){
    this._recTime=recTime;
  }

  double getRecTime(){
    return this._recTime;
  }

  String getUserId(){
    return this._userId;
  }

  void setExamTime(double examTime){
    this._examTime=examTime;
  }

  double getExamTime(){
    return this._examTime;
  }

  void setExtraTime(double extraTime){
    this._extraTime=extraTime;
  }

  double getExtraTime(){
    return this._extraTime;
  }

  void setGrade(double grade){
    this._grade=grade;
  }

  double getGrade(){
    return this._grade;
  }

}