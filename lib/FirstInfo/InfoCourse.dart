
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'InformationPage.dart';
import 'gridDashBoard.dart';


class InfoCourse extends StatefulWidget {
  int courseIndex;
  InfoCourse(this.courseIndex);
  @override
  InfoCourseState createState() => InfoCourseState(courseIndex);
}

class InfoCourseState extends State<InfoCourse> {
  int courseIndex;
   String examHours = "Select Value";
   String extraHours = "Select Value";
   String homeworkHours ="Select Value";
   String recitationHours = "Select Value";
   String lecturesHours = "Select Value";
   String grade = "Select Value" ;
  InfoCourseState(this.courseIndex);
  String userId = FirebaseAPI().getUid();

//  Future<String> getValues (DocumentReference doc, String resource) async{
//    DocumentSnapshot docField = await doc.get();
//    if(doc != null){
//      switch (resource){
//        case "grade":
//          return docField['grade'];
//        case "examHours":
//          return docField['examTime'];
//        case "extraHours":
//          return docField['extraTime'];
//        case "homeworkHours":
//          return docField['hwTime'];
//        case "recitationHours":
//          return docField['recTime'];
//        case "lecturesHours":
//          return docField['lectureTime'];
//      }
//    }else{
//     examHours = "select value";
//      extraHours = "select value";
//      homeworkHours = "select value";
//      recitationHours = "select value";
//      lecturesHours = "select value";
//      grade = "select value";
//    }
//  }

//    double average = double.parse(await InformationPageState.getAverage());
  final List<String> _dropdownGrades = [
    "30-35",
    "35-40",
    "40-45",
    "45-50",
    "50-55",
    "55-60",
    "60-65",
    "65-70",
    "70+"
  ];
  final List<String> _dropdownGradeFin = [
    "0-60",
    "60-65",
    "65-70",
    "70-75",
    "75-80",
    "85-90",
    "90-95",
    "95-100"
  ];


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          backgroundColor: Global.getBackgroundColor(0),
        ),),
      body: buildChild(context, 1),
    );
  }


  Widget buildChild(BuildContext context, int courseIndex) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
//        decoration: BoxDecoration(
//            shape: BoxShape.rectangle,
//            borderRadius: BorderRadius.all(Radius.circular(12))
//        ),
      children: <Widget>[
        Text('how long in total(hours) did you study for....',
          style: TextStyle(fontSize: 30,
            color: Colors.black,
            fontFamily: 'Piedra',
          ),
          textAlign: TextAlign.center
          ,),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('the exam',
              style: TextStyle(fontSize: 20,
                color: Colors.black,
                fontFamily: 'Piedra',
              ),),
            totalHoursExam(),
          ],
        ),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('the homeworks',
              style: TextStyle(fontSize: 20,
                color: Colors.black,
                fontFamily: 'Piedra',
              ),),
            totalHoursHomework(),
          ],
        ),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('the recitations',
              style: TextStyle(fontSize: 20,
                color: Colors.black,
                fontFamily: 'Piedra',
              ),),
            totalHoursRecitations(),
          ],
        ),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('the lectures',
              style: TextStyle(fontSize: 20,
                color: Colors.black,
                fontFamily: 'Piedra',
              ),),
            totalHoursLectures(),
          ],
        ),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('using extra materials',
              style: TextStyle(fontSize: 20,
                color: Colors.black,
                fontFamily: 'Piedra',
              ),),
            totalHoursExtra(),
          ],
        ),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('your final grade is',
              style: TextStyle(fontSize: 20,
                color: Colors.black,
                fontFamily: 'Piedra',
              ),),
            total(),
          ],
        ),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                return Navigator.of(context).pop(true);
              },
              child: Text('BACK', style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 12)),
              color: Colors.white,
              textColor: Colors.black,),
            RaisedButton(
                splashColor: Global.getBackgroundColor(0),
                onPressed: () {
                  onClick(context);
                  GridDashboardState();
                },
                child: Text('ENTER INFO', style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12)),
                color: Colors.white,
                textColor: Colors.black)
          ],
        ),
      ],
    );
  }


  Future<String> doesExists(String id, int index)async{
    final QuerySnapshot result = await Firestore.instance
        .collection("AllUsers")
        .where('userId', isEqualTo: userId).where('course', isEqualTo:Global().getAllCourses()[index] ).limit(1).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if(documents.length == 1){
      return documents[0].documentID;
    }
    return null;}

  Future <DocumentReference> getDocument (BuildContext context) async{
    String doc;
    doc =  await doesExists(userId, courseIndex) ;
    if(doc == null) {
      return null;
    }else{
      DocumentReference docDelete = AllUserDataBase.usersDataCollection.document(doc);
      return docDelete;
    }
  }


    Future <void> onClick(BuildContext context) async {
      DocumentReference doc = await getDocument(context);
    if(doc == null) {
      enterData(context);
    }else{
      doc.delete();
      enterData(context);
    }}


  void enterData(BuildContext context) async{
    UserStatForCourse userInfo = new UserStatForCourse(
      Global().getAllCourses()[courseIndex],
      double.parse(await InformationPageState.getAverage()),
      Global().getHour(homeworkHours),
      Global().getHour(lecturesHours),
      Global().getHour(recitationHours),
      Global().getHour(examHours),
      Global().getHour(extraHours),
      Global().getAllGrades(grade),
      userId,

    );
    AllUserDataBase().addUserData(userInfo);
    return Navigator.of(context).pop(true);
  }


  Widget totalHoursHomework() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DropdownButton<String>(
              items: _dropdownGrades
                  .map((data) =>
                  DropdownMenuItem<String>(
                    child: Text(data),
                    value: data,
                  ))
                  .toList(),
              onChanged: (String value) {
                setState(() => homeworkHours = value);
              },
              hint: Text(homeworkHours),
              // value: _selectedValue,
            ),
          ],
        ),
      ],

    );
  }


  Widget totalHoursRecitations() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DropdownButton<String>(
              items: _dropdownGrades
                  .map((data) =>
                  DropdownMenuItem<String>(
                    child: Text(data),
                    value: data,
                  ))
                  .toList(),
              onChanged: (String value) {
                setState(() => recitationHours = value);
              },
              hint: Text(recitationHours),
              // value: _selectedValue,
            ),
          ],
        ),
      ],

    );
  }


  Widget totalHoursLectures() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DropdownButton<String>(
              items: _dropdownGrades
                  .map((data) =>
                  DropdownMenuItem<String>(
                    child: Text(data),
                    value: data,
                  ))
                  .toList(),
              onChanged: (String value) {
                setState(() => lecturesHours = value);
              },
              hint: Text(lecturesHours),
              // value: _selectedValue,
            ),
          ],
        ),
      ],

    );
  }

  Widget totalHoursExam() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DropdownButton<String>(
              items: _dropdownGrades
                  .map((data) =>
                  DropdownMenuItem<String>(
                    child: Text(data),
                    value: data,
                  ))
                  .toList(),
              onChanged: (String value) {
                setState(() => examHours = value);
              },
              hint: Text(examHours),
              // value: _selectedValue,
            ),
          ],
        ),
      ],

    );
  }

  Widget totalHoursExtra() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DropdownButton<String>(
              items: _dropdownGrades
                  .map((data) =>
                  DropdownMenuItem<String>(
                    child: Text(data),
                    value: data,
                  ))
                  .toList(),
              onChanged: (String value) {
                setState(() => extraHours = value);
              },
              hint: Text(extraHours),
              // value: _selectedValue,
            ),
          ],
        ),
      ],

    );
  }




  Widget total() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DropdownButton<String>(
              items: _dropdownGradeFin
                  .map((data) =>
                  DropdownMenuItem<String>(
                    child: Text(data),
                    value: data,
                  ))
                  .toList(),
              onChanged: (String value) {
                setState(() => grade = value);
              },
              hint: Text(grade),
              // value: _selectedValue,
            ),
          ],
        ),
      ],

    );
  }


  void showColoredToast(String msg) {
    Fluttertoast.showToast(
        fontSize: 18,
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Global.getBackgroundColor(0),
        gravity: ToastGravity.CENTER,
        textColor: Colors.white);
  }

}


Future navigateToDashboardPage(context,index) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => GridDashboard()));
//  InfoCourseState.grade = "choose value";
//  InfoCourseState.homeworkHours = "choose value";
//  InfoCourseState.recitationHours = "choose value";
//  InfoCourseState.lecturesHours = "choose value";
//  InfoCourseState.examHours = "choose value";
//  InfoCourseState.extraHours = "choose value";
}
