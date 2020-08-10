import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:flutterapp/Global.dart';

/// resource object.
enum Activities{
  HomeWork, Recitation , Lectures , Exams, Extra
}

/// user object.
class User{
  String _nickname;
  String _avg;
  List<String> _friends;
  List _courses;
  int _year;
  int _semester;
  List<String> _friendRequestSent = [];
  List<String> _friendRequestReceive = [];
  String _uid;
  List<String> _searchNickname=[];
  int _gender;


  User(this._uid,this._nickname, this._avg, this._friends,this._courses,
      this._year, this._semester,this._friendRequestSent, this._friendRequestReceive,
      this._searchNickname, this._gender);


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

/// users personal information page.
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
  bool check=true;  // run initial() or not.
  int gender;
  static User user;

  //  get data from firebase.
  Future<void> initial() async{
    bool hasData=await UserDataBase().hasData();
    if(hasData){
      user=await UserDataBase().getUser();
      setState(() {
        nicknameController.text=user.getNickname();
        averageController.text=user.getAverage();
        _YearInputState.year=user.getYear();
        _SemesterInputState.semester=user.getSemester();
        _CoursesInputState().updateCourses(user.getCourses());
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
                      onPressed: (){updateInfo();},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Average explanation.
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

  // Nickname explanation.
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

  // Insert user's information (if exist) from firebase to the page.
  void updateInfo()async{
    nickName=nicknameController.text;
    avg=averageController.text;
    year=_YearInputState.year;
    semester=_SemesterInputState.semester;
    gender=_GenderInputState.gender;
    courses.clear();

    for(var course in _CoursesInputState._courses){
      courses.add(course.toString());
    }
    _CoursesInputState._courses.clear();
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
        year,
        semester,
        hasData? (await UserDataBase().getUser()).getFriendRequestSent():[],
        hasData? (await UserDataBase().getUser()).getFriendRequestReceive():[],
        hasData? FriendsDataBase().nicknameSearch((await UserDataBase().getUser()).getNickname()):FriendsDataBase().nicknameSearch(nickName),
        gender,
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
    Global().setUserCourses(courses);
  }

  // Get the user's average.
  static Future<String> getAverage() async {
    String id = FirebaseAPI().getUid();
    String avg ="90.0";
    DocumentReference documentReference =
    Firestore.instance.collection("Users").document(id);
    await documentReference.get().then((DocumentSnapshot ds) {
      if (ds.exists) {
        avg = ds.data['avg'];
      }
    }
    );
    return avg;

  }

  // Insert/Update course time to the firebase.
  void updateTimes(List<String> goal, List<String> courses){
    for(String course in courses){
      goal.add(course+"_"+"HomeWork"+"_"+"0.0");
      goal.add(course+"_"+"Recitation"+"_"+"0.0");
      goal.add(course+"_"+"Lectures"+"_"+"0.0");
      goal.add(course+"_"+"Exams"+"_"+"0.0");
      goal.add(course+"_"+"Extra"+"_"+"0.0");
    }
  }

  // Insert/Update course goal to the firebase.
  void updateGoal(List<String> goal, List<String> courses){
    for(String course in courses){
      goal.add(course+"_"+"HomeWork"+"_"+"14.0");
      goal.add(course+"_"+"Recitation"+"_"+"14.0");
      goal.add(course+"_"+"Lectures"+"_"+"14.0");
      goal.add(course+"_"+"Exams"+"_"+"14.0");
      goal.add(course+"_"+"Extra"+"_"+"14.0");
    }
  }

  // check if the user's personal information is valid.
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

  // return the current user.
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


// Page description widget.
class DescriptionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text("GoStudy Profile",
                style: GoogleFonts.cabin(fontWeight: FontWeight.bold, fontSize: 28)
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text("*Your profile is private.\n"
            "*Data will be used for statistical analysis.\n",
          style: GoogleFonts.cabin(fontSize: 15),
        ),
      ],
    );
  }
}

// Year input widget.
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

// Semester input widget.
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

// Gender input widget.
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

// Current courses input widget.
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
