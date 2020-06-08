import 'package:flutter/material.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'package:flutterapp/Courses.dart';


class User{
  String _nickname;
  String _avg;
  List<String> _friends;
  List _courses;
  int _avgGoal;
  int _dailyGoal;
  int _year;
  int _semester;
  int _dedication;

  User(this._nickname, this._avg, this._friends,this._courses, this._avgGoal, this._dailyGoal,
      this._year, this._semester, this._dedication);

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

  List<String> getCourses(){
    return this._courses;
  }

  void setAvgGoal(int goal){
    this._avgGoal=goal;
  }

  int getAvgGoal(){
    return _avgGoal;
  }


  void setDailyGoal(int goal){
    this._dailyGoal=goal;
  }

  int getDailyGoal(){
    return _dailyGoal;
  }


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
  void setDedication(int ded){
    this._dedication=ded;
  }

  int getDedication(){
    return _dedication;
  }

}


class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final nicknameController = TextEditingController();
  final averageController = TextEditingController();



  String nickName;
  String avg;
  int year;
  int semester;
  List<String> courses=[];
  int dedication;
  static User user;


  Future<void> initial() async{
    if(await UserDataBase().hasData()){
     user=UserDataBase().getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    initial();
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Information"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.0),
            inputDecoration("Choose a nickname",nicknameController, 3.0, TextInputType.text),
            SizedBox(height: 20.0),
            inputDecoration("Average",averageController, 3.0, TextInputType.number),
            SizedBox(height: 20.0),
            YearInput(),
            SizedBox(height: 20.0),
            SemesterInput(),
            SizedBox(height: 20.0),
//            inputDecoration("Dedication",dedicationController, 3.0, TextInputType.number),
            DedicationInput(),
            SizedBox(height: 20.0),
//            inputDecoration("Courses",coursesController, 3.0, TextInputType.text ),
            CoursesInput(),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              RaisedButton(
                child: Text("Save",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                color: Colors.blueAccent,
                padding: EdgeInsets.all(0.0),
//                textColor: Colors.black,
                onPressed: (){updateInfo();},
                ),
            ],
            )
          ],
        ),
      ),
    );
  }

  void updateInfo(){
     nickName=nicknameController.text;
     avg=averageController.text;
     year=_YearInputState.year;
     semester=_SemesterInputState.semester;
     courses.clear();
     for(var course in _CoursesInputState._courses){
       courses.add(course.toString());
     }
     _CoursesInputState._courses.clear();
     dedication=_DedicationInputState._dedication;
     if(validate(nickName, avg, courses, year, semester)) {
       User user = User(
           nickName,
           avg,
           [],
           courses,
           0,
           0,
           year,
           semester,
           dedication);
       UserDataBase().addUser(user);
       Courses().setUserCourses(courses);
       Navigator.pushReplacementNamed(context, '/home');
     }
  }

  bool validate(String nickName, String avg, List<String> courses,int year,int semester){
    if(nickName==""){
      showColoredToast("Please choose a nickname");
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
  return TextFormField(
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
          borderSide: BorderSide(color: Colors.black, width: 2.0)
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
  );
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
        children: <Widget>[
          Text("Year :", style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(width: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: year,
                activeColor: Colors.black,
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
                activeColor: Colors.black,
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
                activeColor: Colors.black,
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
                activeColor: Colors.black,
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
                activeColor: Colors.black,
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
         children: <Widget>[
           Text("Semester :", style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width: 190),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: <Widget>[
               Radio(
                 value: 1,
                 groupValue: semester,
                 activeColor: Colors.black,
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
                 activeColor: Colors.black,
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
}


void  allCourses(List<Map> res){
  List<String> courses=Courses().getAllCourses();
  for(String elem in courses) {
    res.add({
      "display": elem,
      "value": elem,
    });
  }
}


class DedicationInput extends StatefulWidget {
  @override
  _DedicationInputState createState() => _DedicationInputState();
}

class _DedicationInputState extends State<DedicationInput> {
  static int _dedication=1;
  List<String> labels=["low", "medium","high"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,0,0,0),
      child: Row(
        children: <Widget>[
          Text("Dedication", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 130),
          Slider(
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
            value: _dedication.toDouble(),
            min: 1, //low
            max: 3, //high
            divisions: 2,
            onChanged: (val)=>setState(()=>_dedication=val.round()),
            label: labels[_dedication-1],
          ),
        ],
      ),
    );
  }
}
