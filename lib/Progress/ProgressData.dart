import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Progress/PlanBuild.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:nice_button/nice_button.dart';
import 'package:flutterapp/FirstInfo/InformationPage.dart';
import 'package:provider/provider.dart';
import 'package:simple_progress_bar/progress_bar.dart';

import '../Global.dart';
import 'CourseSelectChoice.dart';

class ProgressData extends StatefulWidget {
  final Function updateProgressPage;
  ProgressData(this.updateProgressPage);
  @override
  State<StatefulWidget> createState() {
    return _ProgressDataState(updateProgressPage);
  }
}

class _ProgressDataState extends State<ProgressData> {
  static List<UserStatForCourse> _users;
  String currentCourse="";
  double hw=0.0;
  double recitation=0.0;
  double lectures=0.0;
  double exams=0.0;
  double extra=0.0;
  double hwDone=0.0;
  double recitationDone=0.0;
  double lecturesDone=0.0;
  double examsDone=0.0;
  double extraDone=0.0;
  double semesterHours=0.0;
  double semesterHoursDone=0.0;
  double weekHours=0.0;
  double weekHoursDone=0.0;
  int rank=1;
  String week="";

  bool createPlan=false;

  void initial(String course)async{
    currentCourse=course;
    User user=await UserDataBase().getUser();
    week=await AllUserDataBase().getWeek();
    setState(() {
      hw=user.getGoal(course,Activities.HomeWork);
      recitation=user.getGoal(course,Activities.Recitation);
      lectures=user.getGoal(course,Activities.Lectures);
      exams=user.getGoal(course,Activities.Exams);
      extra=user.getGoal(course,Activities.Extra);

      hwDone=user.getCourseTime(course,Activities.HomeWork);
      recitationDone=user.getCourseTime(course,Activities.Recitation);
      lecturesDone=user.getCourseTime(course,Activities.Lectures);
      examsDone=user.getCourseTime(course,Activities.Exams);
      extraDone=user.getCourseTime(course,Activities.Extra);

      semesterHours=user.getGoal("SemesterHours",null);
      semesterHoursDone=user.getCourseTime("totalTime",null);

      weekHours=hw+recitation+lectures+exams+extra;
      weekHoursDone=hwDone+recitationDone+lecturesDone+examsDone+extraDone;
    });
    if((semesterHoursDone/semesterHours)>0.3){rank=2;}
    if((semesterHoursDone/semesterHours)>0.6){rank=3;}
    if((semesterHoursDone/semesterHours)>0.9){rank=4;}
    if((semesterHoursDone/semesterHours)>0.95){rank=5;}
    user.setRank(rank);
    UserDataBase().updateUser(user);
    setState(() {});
  }

  Function updateProgressPage;
  _ProgressDataState(this.updateProgressPage);



  @override
  Widget build(BuildContext context) {
    _users=null;
    updateUsersData(context);
    if(_users==null){
      return Loading();
    }
    if(createPlan){
      createPlan=false;
      createAPlan();
    }
    return SingleChildScrollView(
//        height: MediaQuery.of(context).size.height - 150,
        child:  SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CourseSelectChoice(initial),
              Container(
//                height: 50,
//                width: MediaQuery.of(context).size.width * 20,
                child: Column(
                  children: [
                    Center(child: Text("Week "+week,style:TextStyle(fontFamily: 'Piedra',fontSize: 35),)),
//                    Align(
//                      alignment: Alignment.topLeft,
//                      child: Text('   Week '+week,
//                        style:TextStyle(fontFamily: 'Piedra',fontSize: 35),
////                              style:
////                              GoogleFonts.merriweather(
////                                fontSize: 35,
////                                fontStyle: FontStyle.italic,
////                                fontWeight: FontWeight.bold,
////                              )
//                      ),
//                    ),
//                        Expanded(
//                          child: Row(
//                            children: [
//                              Expanded(
//                                  child: starIcon(context)),
//                              starIcon(context),
//                              starIcon(context),
//                            ],
//                          ),
//                        ),
//                    rankStars(rank),
                  ],
                ),
              ),
//                  SizedBox(height: MediaQuery.of(context).size.height / 80),
//                  Row(
//                    children: [
//                      Expanded(
//                        child: Align(
//                          alignment: Alignment.center,
//                          child: Text(
//                            'Your Weekly Progress',
//                            style: TextStyle(fontSize: 21),
//                          ),
//                        ),
//                      ),
//                      Align(
//                          alignment: Alignment.topRight,
//                          child: IconButton(
//                            icon: Icon(Icons.edit),
//                            onPressed: () {
//                              showEditDialog(context);
//                            },
//                          )),
//                    ],
//                  ),
//                  SizedBox(height: MediaQuery.of(context).size.height / 80),
//                  CircularPercentIndicator(
//                      radius: 200,
//                      lineWidth: 13,
//                      animation: true,
//                      animationDuration: 2000,
//                      percent: percentage,
//                      progressColor: Global.getBackgroundColor(0),
//                      backgroundColor: Global.getBackgroundColor(200),
//                      center: Text(
//                            "HW: "+hwDone.toString()+"/"+hw.toString()+
//                            "\nRec: "+recitationDone.toString()+"/"+recitation.toString()+
//                            "\nLec: "+lecturesDone.toString()+"/"+lectures.toString()+
//                            "\nOverall:"+(percentage*100).toStringAsFixed(2)+"%",
//                        textAlign: TextAlign.center,
//                        style: GoogleFonts.inconsolata(fontSize: 20,
//                            fontWeight: FontWeight.bold),
//                      )
//                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  rankStars(rank),
                ],
              ),
              Card(
                elevation: 10.0,
                child: Column(
                  children: <Widget>[
                    customProgressBard(context, "Homework",hwDone,hw),
                    customProgressBard(context, "Lectures",lecturesDone,lectures),
                    customProgressBard(context, "Recitations",recitationDone,recitation),
                    customProgressBard(context, "Exams",examsDone,exams),
                    customProgressBard(context, "Extra",extraDone,extra),
                  ],
                ),
              ),
              SizedBox(height: 6.0,),
              Center(child: Text("Total Progress",style:TextStyle(fontFamily: 'Piedra',fontSize: 35),)),
              SizedBox(height: 6.0,),
              Card(
                elevation: 10.0,
                child: Column(
                  children: <Widget>[
                    customProgressBard(context, "Semesters Progress",semesterHoursDone,semesterHours),
                    customProgressBard(context, "Weekly progress",weekHoursDone,weekHours),
                  ],
                ),
              ),

//                  SizedBox(height: MediaQuery.of(context).size.height / 35),
//                  Text(
//                    'Your Semester Progress',
//                    style: TextStyle(fontSize: 21),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.all(25),
//                    child: LinearPercentIndicator(
//                      width: MediaQuery.of(context).size.width - 50,
//                      animation: true,
//                      lineHeight: 20,
//                      animationDuration: 2000,
//                      percent: semesterPercentage,
//                      center: Text((semesterPercentage*100).toString()+'%'),
//                      linearStrokeCap: LinearStrokeCap.roundAll,
//                      progressColor: Global.getBackgroundColor(0),
//                      backgroundColor: Global.getBackgroundColor(200),
//                    ),
//                  ),
//                  SizedBox(height: MediaQuery.of(context).size.height / 25),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: NiceButton(
                  background: Colors.grey[300],
                  radius: 40,
                  padding: EdgeInsets.all(5),
                  text: "Set New Plan",
                  icon: Icons.account_box,
                  gradientColors: [Global.getBackgroundColor(400),Global.getBackgroundColor(500),Global.getBackgroundColor(400)],
                  onPressed: (){setNewPlanDialog(context);},
                ),
              ),
            ],
          ),
        )
    );


//    return LayoutBuilder(
//        builder: (BuildContext context, BoxConstraints constraints) {
//      return Container(
//          height: MediaQuery.of(context).size.height - 150,
//          child: Scaffold(
////              backgroundColor: Colors.blueAccent,
//              body: Column(
//                children: [
//                  Container(
//                    height: 50,
//                    width: MediaQuery.of(context).size.width * 20,
//                    child: Row(
//                      children: [
//                        Align(
//                          alignment: Alignment.topLeft,
//                          child: Text('   Week 9',
//                              style:
//                              GoogleFonts.merriweather(
//                                fontSize: 35,
//                                fontStyle: FontStyle.italic,
//                                fontWeight: FontWeight.bold,
//                              )
//                          ),
//                        ),
//                        Expanded(
//                          child: Row(
//                            children: [
//                              Expanded(
//                                  child: starIcon(context)),
//                                          starIcon(context),
//                                          starIcon(context),
//                            ],
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                  CourseSelectChoice(updateProgressPage),
//                  SizedBox(height: MediaQuery.of(context).size.height / 80),
//                  Row(
//                    children: [
//                      Expanded(
//                        child: Align(
//                          alignment: Alignment.center,
//                          child: Text(
//                            'Your Weekly Progress',
//                            style: TextStyle(fontSize: 21),
//                          ),
//                        ),
//                      ),
//                      Align(
//                          alignment: Alignment.topRight,
//                          child: IconButton(
//                            icon: Icon(Icons.edit),
//                            onPressed: () {
//                              showEditDialog(context);
//                            },
//                          )),
//                    ],
//                  ),
//                  SizedBox(height: MediaQuery.of(context).size.height / 80),
//                  CircularPercentIndicator(
//                      radius: 200,
//                      lineWidth: 13,
//                      animation: true,
//                      animationDuration: 2000,
//                      percent: 0.7,
//                      progressColor: Global.getBackgroundColor(0),
//                      backgroundColor: Global.getBackgroundColor(200),
//                      center: Text(
//                        "HW: 4/6\nRec: 2/2\nLec: 2/3\nOverall: 70%",
//                        textAlign: TextAlign.center,
//                        style: GoogleFonts.inconsolata(fontSize: 20,
//                        fontWeight: FontWeight.bold),
//                      )),
//                  SizedBox(height: MediaQuery.of(context).size.height / 35),
//                  Text(
//                    'Your Semester Progress',
//                    style: TextStyle(fontSize: 21),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.all(25),
//                    child: LinearPercentIndicator(
//                      width: MediaQuery.of(context).size.width - 50,
//                      animation: true,
//                      lineHeight: 20,
//                      animationDuration: 2000,
//                      percent: 0.83,
//                      center: Text('83%'),
//                      linearStrokeCap: LinearStrokeCap.roundAll,
//                      progressColor: Global.getBackgroundColor(0),
//                      backgroundColor: Global.getBackgroundColor(200),
//                    ),
//                  ),
//                  SizedBox(height: MediaQuery.of(context).size.height / 25),
//                  NiceButton(
//                    background: Colors.grey[300],
//                    radius: 40,
//                    padding: EdgeInsets.all(5),
//                    text: "Set New Plan",
//                    icon: Icons.account_box,
//                    gradientColors: [Global.getBackgroundColor(300),Global.getBackgroundColor(500)],
//                    onPressed: (){setNewPlanDialog(context);},
//                  )
//                ],
//              ))
//      );
//    });
  }


  Future<List<UserStatForCourse>> updateUsersData(BuildContext context) async{
    _users=Provider.of<List<UserStatForCourse>>(context);
    return _users;
  }



  Future<void> setPlan()async{
    await AllUserDataBase().sortUsersDataByGrades(_DedicationInputState._dedication,updateProgressPage);
    setState(() {createPlan=true;});
  }

  void createAPlan()async{
    PlanBuild planBuild;
    List<double> res;
    planBuild=PlanBuild(_users,_DedicationInputState._dedication);
    await planBuild.createPlan();
    initial(currentCourse);
  }



  Widget customProgressBard(BuildContext context, String title, double done, double toDo){
    return ProgressBar(
      padding: 5,
      barColor: Global.getBackgroundColor(800),
      barHeight: 8,
      barWidth: MediaQuery.of(context).size.width*0.9,
      numerator: done,
      denominator: toDo,
      title: title,
      dialogTextStyle: new TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white),
      titleStyle: new TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black),
      boarderColor: Colors.grey,
      showRemainder: (done>toDo)? false:true,
    );

  }


  Widget rankStars(int rank){
    switch(rank){
      case 1:
        return buildStars(context,Colors.black,Colors.black,Colors.black,Colors.black,Global.goldStars);
      case 2:
        return buildStars(context,Colors.black,Colors.black,Colors.black,Global.goldStars,Global.goldStars);
      case 3:
        return buildStars(context,Colors.black,Colors.black,Global.goldStars,Global.goldStars,Global.goldStars);
      case 4:
        return buildStars(context,Colors.black,Global.goldStars,Global.goldStars,Global.goldStars,Global.goldStars);
      case 5:
        return buildStars(context,Global.goldStars,Global.goldStars,Global.goldStars,Global.goldStars,Global.goldStars);
    }
    return buildStars(context,Colors.black,Colors.black,Colors.black,Colors.black,Global.goldStars);
  }



  Widget buildStars(BuildContext context, Color color1, Color color2,Color color3,Color color4,Color color5){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[500]),
          borderRadius: BorderRadius.circular(22.0)
      ),
      child: Row(
        children: <Widget>[
          starIcon(context , color1),
          starIcon(context , color2),
          starIcon(context , color3),
          starIcon(context , color4),
          starIcon(context , color5)
        ],
      ),
    );
  }


  starIcon(BuildContext context, Color color) {
    return Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.star,color: color,),
          onPressed: () {
            showStarDialog(context);
          },
        )
    );
  }

  showStarDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Rank"),
      backgroundColor: Global.getBackgroundColor(0),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: Text(
          "You're 43 hours away of goStudying Logic to get 90 on average.\n\n GoStudy Tip: 53 hours from next Rank."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showEditDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("GoStudy Team"),
      backgroundColor: Global.getBackgroundColor(0),
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: Text(
          "Feature coming soon..."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  setNewPlanDialog(BuildContext context){
    TextEditingController controller = TextEditingController();


    return showDialog(context: context, builder: (context){
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text("Set A New Plan", style:TextStyle(fontFamily: 'Piedra',fontSize: 35),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height/3,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 25),
//                    Text('Enter Excepted Average:'),
//                    TextField(
//                      controller: controller,
//                      keyboardType: TextInputType.number,
//                      decoration: InputDecoration(
//                        hintText: "hint: 100",
//                      ),
//                    ),
      //              SizedBox(height: MediaQuery.of(context).size.height / 25),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("We will build you a study plan according to the time you are planning to dedicate this semester.\n"
                          "Choose your dedication this semester:"),
                    ),
                    DedicationInput(),
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Cancel"),
                  onPressed: (){
                    Navigator.of(context).pop(context);},
                ),
                MaterialButton(
                  child: Text("Submit"),
                  onPressed: ()async{
                    setPlan();
                    Navigator.of(context).pop(context);},
                )
              ],
            ),
          );
//      return SingleChildScrollView(
//        child: AlertDialog(
//          title: Text("Set New Plan"),
//          content: Container(
//            height: MediaQuery.of(context).size.height/3.2,
//            child: Column(
//              children: [
//                SizedBox(height: MediaQuery.of(context).size.height / 25),
//                Text('Enter Excepted Average:'),
//                TextField(
//                  controller: controller,
//                  keyboardType: TextInputType.number,
//                  decoration: InputDecoration(
//                    hintText: "hint: 100",
//                  ),
//                ),
////              SizedBox(height: MediaQuery.of(context).size.height / 25),
//                Padding(
//                  padding: const EdgeInsets.all(18.0),
//                  child: Text("Be Dedicated, set your's:"),
//                ),
//                DedicationInput(),
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            MaterialButton(
//              child: Text("Submit"),
//              onPressed: ()async{
//                await updateUsersData(context);
//                pBuild=PlanBuild(_users);
//                pBuild.setAvg();
//                Navigator.of(context).pop(context);},
//            )
//          ],
//        ),
//      );
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

  void initial()async{
    User user=await UserDataBase().getUser();
    _dedication=user.getDedication();
    setState(() {});
  }

  @override
  void initState() {
    initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,0,0,0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Dedication", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Slider(
              activeColor: Global.getBackgroundColor(0),
              inactiveColor: Global.getBackgroundColor(500),
              value: _dedication.toDouble(),
              min: 1, //low
              max: 3, //high
              divisions: 2,
              onChanged: (val)=>setState(()=>_dedication=val.round()),
              label: labels[_dedication-1],
            ),
          ),
        ],
      ),
    );
  }

}

