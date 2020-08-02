import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'package:flutterapp/Global.dart';

import 'gridDashBoard.dart';


class User{
  String _nickname;
  String _avg;
  List<String> _friends;
  List _courses;
//  int _avgGoal;
//  int _dailyGoal;
  int _year;
  int _semester;
//  int _dedication;
//  List<String> _goal=[];
  List<String> _friendRequestSent = [];
  List<String> _friendRequestReceive = [];
  String _uid;
  List<String> _searchNickname=[];
//  List<String> _times=[];
//  int _rank;
  int _gender;
  List<String> _oldCourses = [];


  User(this._uid,this._nickname, this._avg, this._friends,this._courses,
      this._year, this._semester,this._friendRequestSent, this._friendRequestReceive,
      this._searchNickname, this._gender, this._oldCourses);

//  void setRank(int rank){
//    this._rank=rank;
//  }
//
//  int getRank(){
//    return this._rank;
//  }

  void setGender(int gen){
    this._gender=gen;
  }

  int getGender(){
    return this._gender;
  }

  void setUid(String uid){
    this._uid=uid;
  }

  String getUid(){
    return this._uid;
  }

  void setOldCourses(List<String> newCourses){
    this._oldCourses=newCourses;
  }

  List<String> getOldCourses(){
    return this._oldCourses;
  }

  void setNickname(String name){
    this._nickname=name;
  }

  String getNickname(){
    return _nickname;
  }

  void setAverage(String avg){
    this._avg=avg;
  }

  String getAverage(){
    return _avg;
  }

  void setFriends(List<String> friends){
    this._friends=[];
    for(String friend in friends){
      this._friends.add(friend);
    }
  }

  List<String> getFriends(){
    return _friends;
  }

  void setCourses(List<String> courses){
    this._courses=courses;
  }

  List<dynamic> getCourses(){
    return this._courses;
  }

//  void setAvgGoal(int goal){
//    this._avgGoal=goal;
//  }
//
//  int getAvgGoal(){
//    return _avgGoal;
//  }


//  void setDailyGoal(int goal){
//    this._dailyGoal=goal;
//  }
//
//  int getDailyGoal(){
//    return _dailyGoal;
//  }

  void setYear(int year){
    this._year =year;
  }

  int getYear(){
    return _year;
  }

  void setSemester(int sem){
    this._semester=sem;
  }

  int getSemester(){
    return _semester;
  }

//  void setDedication(int ded){
//    this._dedication=ded;
//  }
//
//  int getDedication(){
//    return _dedication;
//  }

//  void addGoal(String course , Activities activity, double time){
//    if(course==null && activity==null){
//      _goal.add("SemesterHours"+"_"+time.toString());
//      return;
//    }
//    String act="";
//    switch(activity){
//      case Activities.HomeWork:
//        act="HomeWork";
//        break;
//      case Activities.Lectures:
//        act="Lectures";
//        break;
//      case Activities.Recitation:
//        act="Recitation";
//        break;
//      case Activities.Exams:
//        act="Exams";
//        break;
//      case Activities.Extra:
//        act="Extra";
//        break;
//    }
//    _goal.add(course+"_"+act+"_"+time.toString());
//  }
//
//  double getGoal(String course , Activities activity){
//    String act="";
//    switch(activity){
//      case Activities.HomeWork:
//        act="HomeWork";
//        break;
//      case Activities.Lectures:
//        act="Lectures";
//        break;
//      case Activities.Recitation:
//        act="Recitation";
//        break;
//      case Activities.Exams:
//        act="Exams";
//        break;
//      case Activities.Extra:
//        act="Extra";
//        break;
//      default:
//        act="";
//        break;
//    }
//    List<String> res=_goal;
//
//    for(String elem in res){
//      List<String> parsing=elem.split("_");
//      if(parsing[0]==course && parsing[1]==act){
//          return double.parse(parsing[2]);
//        }
//      if(course=="SemesterHours" && parsing[0]=="SemesterHours") {
//        return double.parse(parsing[1]);
//      }
//    }
//  return 10.0;
//  }
//
//  List<String> getGoals(){
//    return _goal;
//  }
//
//  void resetGoals(){
//    _goal.clear();
//  }

//  void addCourseTime(String course , Activities activity, double time){
//    double prevTime=getCourseTime( course ,  activity);
//    double newTime=prevTime+time;
//    if(course=="totalTime"){
//      _times.remove(course+"_"+prevTime.toString());
//      _times.add(course+"_"+newTime.toStringAsFixed(2));
//      return;
//    }
//    String act="";
//    switch(activity){
//      case Activities.HomeWork:
//        act="HomeWork";
//        break;
//      case Activities.Lectures:
//        act="Lectures";
//        break;
//      case Activities.Recitation:
//        act="Recitation";
//        break;
//      case Activities.Exams:
//        act="Exams";
//        break;
//      case Activities.Extra:
//        act="Extra";
//        break;
//    }
//    _times.remove(course+"_"+act+"_"+prevTime.toString());
//    _times.add(course+"_"+act+"_"+newTime.toStringAsFixed(2));
//  }
//
//  double getCourseTime(String course , Activities activity){
//    String act="";
//    switch(activity){
//      case Activities.HomeWork:
//        act="HomeWork";
//        break;
//      case Activities.Lectures:
//        act="Lectures";
//        break;
//      case Activities.Recitation:
//        act="Recitation";
//        break;
//      case Activities.Exams:
//        act="Exams";
//        break;
//      case Activities.Extra:
//        act="Extra";
//        break;
//    }
//    List<String> res=_times;
//    for(String elem in res){
//      List<String> parsing=elem.split("_");
//      if(course=="totalTime" && parsing[0]==course){
//        return double.parse(parsing[1]);
//      }
//      if(parsing[0]==course && parsing[1]==act){
//        return double.parse(parsing[2]);
//      }
//    }
//    return 0.0;
//  }
//
//  List<String> getTimes(){
//    return this._times;
//  }

  void setFriendRequestSent(List<String> lst){
    this._friendRequestSent=lst;
  }

  List<String> getFriendRequestSent(){
    return this._friendRequestSent;
  }

  void setFriendRequestReceive(List<String> lst){
    this._friendRequestReceive=lst;
  }

  List<String> getFriendRequestReceive(){
    return this._friendRequestReceive;
  }

  bool newFriendReq(){
    return (this._friendRequestReceive.isNotEmpty);
  }

  List<String> getSearchNickname(){
    return this._searchNickname;
  }

  void setSearchNickname(List<String> searchNickname){
    this._searchNickname=searchNickname;
  }

}

enum Activities{
  HomeWork, Recitation , Lectures , Exams, Extra
}

class InformationPage extends StatefulWidget {
  static final Color focusColor =Global.getBackgroundColor(0);
  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage> {
  final nicknameController = TextEditingController();
  final averageController = TextEditingController();



  String nickName;
  String avg;
  int year;
  int semester;
  List<String> courses=[];
  int dedication;
  bool check=true;
  int gender;
  static List<String> oldCourses=[];
  static User user;


  Future<void> initial() async{
    bool hasData=await UserDataBase().hasData();
    if(hasData){
     user=await UserDataBase().getUser();
     setState(() {
       if(oldCourses == null) {
         oldCourses = Global().allCourses;
       }else {
         oldCourses = user.getOldCourses();
       }
       nicknameController.text=user.getNickname();
       averageController.text=user.getAverage();
       _YearInputState.year=user.getYear();
       _SemesterInputState.semester=user.getSemester();
       _CoursesInputState().updateCourses(user.getCourses());
//       _DedicationInputState._dedication=user.getDedication();
       _GenderInputState.gender=user.getGender();
     });
    }
    check=false;
  }


  @override
  Widget build(BuildContext context) {
    if(check){initial();}
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Global.getBackgroundColor(0),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DescriptionText(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      inputDecoration("Choose a nickname",nicknameController, 3.0, TextInputType.text),
                      IconButton(icon: Icon(Icons.info_outline),
                      onPressed: (){
                        showNicknameDialog();
                      },)
                    ],
                  ),
                ),
//                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      inputDecoration("Average",averageController, 3.0, TextInputType.number),
                      IconButton(icon: Icon(Icons.info_outline),
                        onPressed: (){
                        showAverageDialog();
                        },)
                    ],
                  ),
                ),
                GenderInput(),
                YearInput(),
                SemesterInput(),
//                DedicationInput(),
                CoursesInput(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                    child: Text("Save",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    color: InformationPage.focusColor,
                    padding: EdgeInsets.all(0.0),
//                textColor: Colors.black,
                    onPressed: (){updateInfo();},
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                      textColor: Colors.black,
                      color:  InformationPage.focusColor,
                      child: Text('Update Old Courses',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                      onPressed: () {
                        navigateToCoursesPage(context);
                      },),
                ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAverageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          content: new Text("Your average,year and semester will be used for statistical analysis"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showNicknameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          content: new Text("Your nickname is how your friends can find you."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updateInfo()async{
     nickName=nicknameController.text;
     avg=averageController.text;
     year=_YearInputState.year;
     semester=_SemesterInputState.semester;
     gender=_GenderInputState.gender;
     courses.clear();
     oldCourses = Global().getAllCourses();
     for(var course in _CoursesInputState._courses){
       courses.add(course.toString());
     }
     _CoursesInputState._courses.clear();
//     dedication=_DedicationInputState._dedication;
     bool hasData= await UserDataBase().hasData();
     List<String> goal=[];
     List<String> times=[];
     if(await validate(nickName, avg, courses, year, semester)) {
       updateGoal(goal,courses);
       updateTimes(times,courses);
       User user = User(
           hasData? (await UserDataBase().getUser()).getUid():"",
           nickName,
           avg,
           hasData? (await UserDataBase().getUser()).getFriends():[],
           courses,
//           hasData? (await UserDataBase().getUser()).getAvgGoal():0,
//           hasData? (await UserDataBase().getUser()).getDailyGoal():0,
           year,
           semester,
//           dedication,
//           hasData? (await UserDataBase().getUser()).getGoals():goal,
//           hasData? (await UserDataBase().getUser()).getTimes():times,
           hasData? (await UserDataBase().getUser()).getFriendRequestSent():[],
           hasData? (await UserDataBase().getUser()).getFriendRequestReceive():[],
           hasData? FriendsDataBase().nicknameSearch((await UserDataBase().getUser()).getNickname()):FriendsDataBase().nicknameSearch(nickName),
//           hasData? (await UserDataBase().getUser()).getRank():1,
           gender,
         oldCourses,
       );
       UserDataBase().addUser(user);
       Navigator.pushReplacementNamed(context, '/home');


       hasData= await UserProgressDataBase().hasData();
       String uid=FirebaseAPI().getUid();
       UserProgress user2=UserProgress(
         double.parse(avg),
         hasData? (await UserProgressDataBase().getUser(uid)).getRank():1,
         hasData? (await UserProgressDataBase().getUser(uid)).getTimes():times,
         hasData? (await UserProgressDataBase().getUser(uid)).getGoals():goal,
         hasData? (await UserProgressDataBase().getUser(uid)).getDedication():3,
       );

       UserProgressDataBase().addUser(user2);

     }
  }

  Future navigateToCoursesPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GridDashboard()));
  }


  static void deleteCoursesList(){
    String id = FirebaseAPI().getUid();
    DocumentReference doc = UserDataBase.usersCollection.document(id);
    doc.delete();
  }

   static Future <List<String>> getOldCourses() async {
    print("hello two");
    String id = FirebaseAPI().getUid();
    List<String> oldCourses2;
    DocumentReference documentReference =
    Firestore.instance.collection("Users").document(id);
    await documentReference.get().then((DocumentSnapshot ds) {
      if (ds.exists) {
        oldCourses2 = ds.data['oldCourses'];
        print('12234'+oldCourses2.length.toString());
      }
  return oldCourses2;
    } );}




  void updateTimes(List<String> goal, List<String> courses){
    for(String course in courses){
      goal.add(course+"_"+"HomeWork"+"_"+"0.0");
      goal.add(course+"_"+"Recitation"+"_"+"0.0");
      goal.add(course+"_"+"Lectures"+"_"+"0.0");
      goal.add(course+"_"+"Exams"+"_"+"0.0");
      goal.add(course+"_"+"Extra"+"_"+"0.0");
    }
  }

  void updateGoal(List<String> goal, List<String> courses){
    var rng=Random();
    for(String course in courses){
      goal.add(course+"_"+"HomeWork"+"_"+"14.0");
      goal.add(course+"_"+"Recitation"+"_"+"14.0");
      goal.add(course+"_"+"Lectures"+"_"+"14.0");
      goal.add(course+"_"+"Exams"+"_"+"14.0");
      goal.add(course+"_"+"Extra"+"_"+"14.0");
    }
  }

  Future<bool> validate(String nickName, String avg, List<String> courses,int year,int semester)async{
    if(nickName==""){
      showColoredToast("Please choose a nickname");
      return false;
    }
    if(!await UserDataBase().validNickname(nickName)){
      showColoredToast("This nickname is already exist, try another");
      return false;
    }
    if(avg==""){
      showColoredToast("Please enter your average");
      return false;
    }
    if(year==null){
      showColoredToast("Please select your current year");
      return false;
    }
    if(semester==null){
      showColoredToast("Please select your current semester");
      return false;
    }
    if(courses.isEmpty){
      showColoredToast("Please select your current courses");
      return false;
    }
    return true;
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

  User getUser(){
    return user;

  }


}


//creating the decoration for the text, description and link inputs.
Widget inputDecoration(String hint,TextEditingController controller, double borderRadius, TextInputType type){
  return Flexible(
        child: TextFormField(
          controller: controller,
          autocorrect: false,
          cursorColor: Colors.black,
          keyboardType: type,
          maxLines: 1,
          minLines: 1,
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
          ),
        ),
      );
}


class DescriptionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Create your GoStudy profile",
          textAlign: TextAlign.center,
          style: GoogleFonts.cabin(fontWeight: FontWeight.bold, fontSize: 28)
//          TextStyle(
//              fontWeight: FontWeight.bold,
//              fontSize: 18.0
//            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text("*Your profile is private.\n"
            "*Data will be used for statistical analysis.\n",
//            "Your nickname is how your friends can find you.\n"
//            "Your average,year and semester will be used for statistical analysis,\n"
//            "Your dedication will influence your study plan.\n"
//            "\n"
//            "You can edit your profile at any time by clicking your name at the Home page.\n",
        style: GoogleFonts.cabin(fontSize: 15),
        ),
      ],
    );
  }
}


class YearInput extends StatefulWidget {
  @override
  _YearInputState createState() => _YearInputState();
}

class _YearInputState extends State<YearInput> {
  static int year;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Year :", style: TextStyle(fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("1"),
              Radio(
                value: 2,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("2"),
              Radio(
                value: 3,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("3"),
              Radio(
                value: 4,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("4"),
              Radio(
                value: 5,
                groupValue: year,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    year=T;
                  });
                },
              ),
              Text("5"),
          ],
        ),
      ],
      ),
    );
  }

}

class SemesterInput extends StatefulWidget {
  @override
  _SemesterInputState createState() => _SemesterInputState();
}

class _SemesterInputState extends State<SemesterInput> {
  static int semester;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Semester :", style: TextStyle(fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: semester,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    semester=T;
                  });
                },
              ),
              Text("A"),
              Radio(
                value: 2,
                groupValue: semester,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    semester=T;
                  });
                },
              ),
              Text("B"),
            ],
          ),
        ],
      ),
    );
  }
}

class GenderInput extends StatefulWidget {
   @override
   _GenderInputState createState() => _GenderInputState();
 }

 class _GenderInputState extends State<GenderInput> {
  static int gender;
   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           Text("Gender :", style: TextStyle(fontWeight: FontWeight.bold),),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: <Widget>[
               Radio(
                 value: 1,
                 groupValue: gender,
                 activeColor: InformationPage.focusColor,
                 onChanged: (T){
                   setState(() {
                     gender=T;
                   });
                 },
               ),
               Text("Male"),
               Radio(
                 value: 2,
                 groupValue: gender,
                 activeColor: InformationPage.focusColor,
                 onChanged: (T){
                   setState(() {
                     gender=T;
                   });
                 },
               ),
               Text("Female"),
             ],
           ),
         ],
       ),
     );
   }
 }



class CoursesInput extends StatefulWidget {
  @override
  _CoursesInputState createState() => _CoursesInputState();
}

class _CoursesInputState extends State<CoursesInput> {
  static List _courses;
  String _coursesResult;
  List<Map> _allCourses=[];
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _courses = [];
    _coursesResult = '';
    allCourses(_allCourses);
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _coursesResult = _courses.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: MultiSelectFormField(
                  autovalidate: false,
                  titleText: 'Current Courses',
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                    return null;
                  },
                  dataSource: _allCourses,
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  required: true,
                  hintText: 'Please select your current courses',
                  initialValue: _courses,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _courses = value;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_coursesResult),
              )
            ],
          ),
        ),
      );
  }


  void updateCourses(List<dynamic> userCourses){
    for(String course in userCourses) {
      _courses.add(course);
    }
  }
}


void  allCourses(List<Map> res){
  List<String> courses=Global().getAllCourses();
  for(String elem in courses) {
    res.add({
      "display": elem,
      "value": elem,
    });
  }
}


//class DedicationInput extends StatefulWidget {
//  @override
//  _DedicationInputState createState() => _DedicationInputState();
//}
//
//class _DedicationInputState extends State<DedicationInput> {
//  static int _dedication=1;
//  List<String> labels=["low", "medium","high"];
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.fromLTRB(15,0,0,0),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Text("Dedication :", style: TextStyle(fontWeight: FontWeight.bold)),
//          Slider(
//            activeColor: InformationPage.focusColor,
//            inactiveColor: Colors.grey,
//            value: _dedication.toDouble(),
//            min: 1, //low
//            max: 3, //high
//            divisions: 2,
//            onChanged: (val)=>setState(()=>_dedication=val.round()),
//            label: labels[_dedication-1],
//          ),
//        ],
//      ),
//    );
//  }
//}
