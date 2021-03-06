import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'InformationPage.dart';
import 'gridDashBoard.dart';


class InfoCourse extends StatefulWidget {
  int courseIndex;
  InfoCourse(this.courseIndex);
  @override
  InfoCourseState createState() => InfoCourseState(courseIndex);
}

/// update course times page.
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
      backgroundColor: Global.getBackgroundColor(0),
      body: buildChild(context, 1),
    );
  }


  Widget buildChild(BuildContext context, int courseIndex) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: ListView(

          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
          children: <Widget>[
            Container(
              child: Text('HOW LONG IN TOTAL(HOURS) DID YOU STUDY FOR THE...',
                style: GoogleFonts.cabin(fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center
                ,),
            )

            ,SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('EXAM',
                  style: GoogleFonts.cabin(fontSize: 20,fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,),),
                totalHoursExam(),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('HOMEWORKS',
                  style: GoogleFonts.cabin(fontSize: 20,fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,),),
                totalHoursHomework(),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('RECITATIONS',
                  style: GoogleFonts.cabin(fontSize: 20,fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,),),
                totalHoursRecitations(),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('LECTURES ',
                  style: GoogleFonts.cabin(fontSize: 20,fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,),),
                totalHoursLectures(),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('EXTRA MATERIALS',
                  style: GoogleFonts.cabin(fontSize: 20,fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,),),
                totalHoursExtra(),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('FINAL GRADE   ',
                  style: GoogleFonts.cabin(fontSize: 20,fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,),),
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
                  color: Global.backgroundPageColor,
                  textColor: Colors.blueGrey,),
                RaisedButton(
                    splashColor: Global.getBackgroundColor(0),
                    onPressed: () {
                      onClick(context);
                      GridDashboardState();
                    },
                    child: Text('ENTER INFO', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
                    color: Global.backgroundPageColor,
                    textColor: Colors.blueGrey)
              ],
            ),
          ],
        ),
      ),
    );
  }


  //check if document of the specific course for the user already exists.
  // if it does- return the doc id.
  Future<String> doesExists(String id, int index)async{
    final QuerySnapshot result = await Firestore.instance
        .collection("AllUsers")
        .where('userId', isEqualTo: userId).where('course', isEqualTo:Global().getAllCourses()[index] ).limit(1).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if(documents.length == 1){
      return documents[0].documentID;
    }
    return null;}


    // check if the doc of the user& course exists. if it does- return it as a document reference.
  Future <DocumentReference> getDocument (BuildContext context) async{
    String doc;
    doc =  await doesExists(userId, courseIndex) ;
    if(doc == null) {
      return null;
    }else{
      DocumentReference docNew = AllUserDataBase.usersDataCollection.document(doc);
      return docNew;
    }
  }

// this function is called when the user presses the course.
  // if the user has not entered previous data of the course enter a new doc
  // else update the current doc ( as each course&userId can hace only one doc).
    Future <void> onClick(BuildContext context) async {
      DocumentReference doc = await getDocument(context);
    if(doc == null) {
      enterData(context);
    }else{
      doc.delete();
      enterData(context);
    }}

// enter the doc to the firebase.
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
}
