import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:csv/csv.dart';
import 'dart:convert';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Global.dart';
import 'Timer/dialog_helper.dart';
import 'Timer/enterTime.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'Timer/digitalClock.dart';
import 'Timer/progress_pie_bar.dart';
import 'Timer/buttomButtons.dart';
import 'package:provider/provider.dart';


class HomeMainPage extends StatefulWidget {
  @override
  HomeMainPageState createState() => HomeMainPageState();
}

class HomeMainPageState extends State<HomeMainPage> {

  @override
  Widget build(BuildContext context) {
    final timeService = TimerService();
    return ChangeNotifierProvider<TimerService>(
      create: (_) => timeService,
      child: Scaffold(
        backgroundColor: Global.getBackgroundColor(0),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(width: 6.0,),
                        Notification(),
                        SizedBox(width: 6.0,),
                        FriendsButton(),
                      ],
                    ),
                    Settings(),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                neuDigitalClock(),
                SizedBox(height: MediaQuery.of(context).size.height / 25),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      NeuResetButton(),
                      NeuProgressPieBar(),
                      EnterTimeButton(),
                    ]),
                SizedBox(height: MediaQuery.of(context).size.height / 25),
                MotivationSentence(),
              ],
              // ),
            ),
          ),
        ),
      ),
    );
  }
}

class MotivationSentence extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MotivationSentenceState();
}

class MotivationSentenceState extends State<MotivationSentence> {
  static String jsonStats;
  Random random = new Random();
  String sentence = "";
  int len = 0;
  CollectionReference colRef =
      Firestore.instance.collection("motivationSentences");

  Future getLen() async{
    await colRef.getDocuments().then((value) {
        len = value.documents.length;
        pickSentence();
    });
  }

  Future pickSentence() async {
    int randomIndex = random.nextInt(len);
    await colRef.document(randomIndex.toString()).get().then((doc) {
      setState(() {
        sentence = doc.data["data"];
      });
    });
    sentence = sentence.replaceAll("-userName-", FirebaseAPI().getUserFirstName());
  }

  @override
  void initState(){
    super.initState();
    CollectionReference statsCollection= Firestore.instance.collection("Statistics");
    String stringjson = '''{"Calculus 1-Exams":"[76,74,58,54,48,59,37,77,70,68,67,65,80,64,63,60,58,59,55,53,52,72,73,50,54,72,44,72,76,70,50,45,45]","Calculus 1-Homeworks":"[20,13,16,8,16,4,8,22,20,18,18,18,17,16,15,14,15,13,12,10,8,4,5,10,10,10,4,13,7,8,8,5,5]","Calculus 1-Final Grade":"[63,72,68,83,66,61,77,82,73,67,68,69,91,85,84,83,82,81,80,70,79,73,93,77,73,77,72,92,63,63,74,74,74]","Calculus 2-Exams":"[77,76,40,59,68,33,74,100,80,70,75,76,77,78,79,68,67,66,65,64,80,70,34,76,72,45]","Calculus 2-Homeworks":"[16,15,6,16,5,6,21,16,13,12,11,12,18,14,12,11,18,16,14,14,13,8,4,7,13,4,7,8,5,5,5]","Calculus 2-Final Grade":"[61,88,73,74,77,78,64,87,86,88,84,85,83,84,82,82,80,79,78,76,77,98,60,63,73,73]","Linear Algebra 1-Exams":"[80,68,63,44,38,50,39,72,60,66,66,68,67,65,64,63,62,61,55,52,49,78,76,35,70,48,46,76,80,71,40,45,45]","Linear Algebra 1-Homeworks":"[24,11,14,5,17,5,5,20,19,15,19,18,17,16,15,14,13,12,11,10,9,7,20,4,4,7,4,4,8,6,5,5,5,5]","Linear Algebra 1-Final Grade":"[62,92,82,78,88,98,91,63,79,83,95,83,81,80,75,80,79,85,81,80,95,97,88,64,98,82,78,77,86,73,73,84,79,78]","Linear Algebra 2-Exams":"[70,57,43,46,45,35,70,60,50,57,58,59,45,56,52,53,51,55,52,50,81,76,39,59,40,70,69,40,40]","Linear Algebra 2-Homeworks":"[10,14,8,21,5,7,23,15,10,14,13,14,15,16,13,14,15,16,11,10,8,14,7,7,4,5,3,5,5]","Linear Algebra 2-Final Grade":"[92,86,77,62,81,71,63,85,80,87,86,85,82,83,81,80,79,80,90,86,88,97,74,73]","CS 101-Exams":"[50,57,33,71,68,53,49,58,49,57,52,49,45,76,49,69,60,68,67,66,65,64,63,62,61,60,59,58,55,76,48,58,39,49,58,73,74,35,50,50]","CS 101-Homeworks":"[42,28,4,18,33,8,14,28,4,9,10,10,14,40,20,32,25,33,32,31,30,15,20,25,20,24,23,20,14,29,14,19,9,20,40,15,14,10,20,20]","CS 101-Final Grade":"[78,79,85,75,82,97,87,72,86,73,84,79,74,88,82,86,89,82,62,70,75,80,78,77,84,86,81,83,88,92,93,82,82,62,62,84]","Discrete Mathematics-Exams":"[80,79,59,72,76,61,49,74,73,72,62,54,54,72,53,71,72,76,78,85,75,74,73,72,71,70,65,60,76,76,33,55,55,63,70,73,45,52,53]","Discrete Mathematics-Homeworks":"[30,30,24,32,25,40,4,31,8,14,8,8,22,30,24,24,32,25,31,30,26,24,23,25,29,24,21,20,19,30,10,15,14,19,19,20,12,13,14]","Discrete Mathematics-Final Grade":"[63,62,73,73,86,99,69,61,65,65,64,63,62,61,76,84,73,86,86,82,83,81,80,78,76,68,71,90,83,88,62,97,63,82,63,64,61,62,63]","Probability-Exams":"[65,55,40,70,55,73,50,66,55,54,53,51,50,40,45,35,39,65,40,58,76,33,93,39,62,65,39,38]","Probability-Homeworks":"[10,16,4,16,8,22,14,12,20,19,18,17,16,15,14,13,12,11,10,5,11,7,7,7,8,8,8,8]","Probability-Final Grade":"[98,87,72,73,63,71,81,91,87,85,86,80,76,80,81,91,91,91,87,87,92,78,78]","Software 1-Exams":"[39,66,54,62,68,48,43,63,55,34,53,53,35,72,60,50,54,50,69,68,67,66,65,64,63,62,61,40,64,76,34,76,70]","Software 1-Homeworks":"[15,17,24,13,22,8,8,19,4,13,6,5,10,20,13,12,24,22,29,28,27,26,25,24,23,22,21,20,11,16,10,4,16,17]","Software 1-Final Grade":"[68,93,78,92,92,96,91,82,77,82,79,79,69,93,97,75,78,84,83,81,86,89,88,75,81,92,98,92,88,98,68,69]","Data Structures-Exams":"[93,54,54,64,68,70,50,63,55,62,45,50,55,66,65,40,93,60,51,55,59,57,56,51,53,60,75,70]","Data Structures-Homeworks":"[10,10,22,15,15,8,8,17,11,8,8,11,10,23,14,10,10,21,20,19,18,17,16,15,14,13,12,11]","Data Structures-Final Grade":"[89,82,71,78,83,98,81,64,82,83,84,77,83,88,92,76,89,86,83,82,81,80,79,89,82,80,90,90]","Statistics-Exams":"[48,33,59,44,63,4,4,49,63,55,45,59,58,57,56,55,52,51,50,48,59,59]","Statistics-Homeworks":"[9,12,13,6,20,6,11,20,12,11,13,13,16,20,15,14,10,13,13,13,16]","Statistics-Final Grade":"[73,99,87,86,77,75,74,66,85,74,87,84,85,80,87,90,79,78,77,81,87]","Computer Structure-Exams":"[65,58,59,67,38,62,63,60,50,40,65,64,55,67,64,63,61,60,69,65,58,51,55,67]","Computer Structure-Homeworks":"[16,11,18,13,9,11,10,4,7,5,16,12,10,20,19,18,17,16,15,14,13,12,11,10]","Computer Structure-Final Grade":"[72,93,74,91,83,82,82,78,72,77,65,84,72,90,91,92,85,86,80,79,77,89,88]","Algorithms-Exams":"[65,63,67,64,60,59,48,63,62,69,55,47,65,63,63,55,60,62,63,64,59,55,59,58,56,60,57,58]","Algorithms-Homeworks":"[13,13,20,16,16,8,8,20,13,10,9,9,13,22,13,14,10,11,10,13,10,15,11,10,18,16,14,12]","Algorithms-Final Grade":"[68,85,95,78,100,86,82,77,84,73,82,81,83,83,74,84,78,77,82,81,83,86,70,71,80,82,86]","Computational Models-Exams":"[63,59,51,66,59,55,50,65,50,60,54,44,47,68,57,70,55,62,58,50,65,55,58,49,49,64,48,57]","Computational Models-Homeworks":"[13,16,20,14,23,9,10,16,4,4,7,10,11,26,14,25,16,20,21,18,16,17,13,15,19,18,17,20]","Computational Models-Final Grade":"[79,88,100,98,100,97,82,83,61,67,72,73,92,86,97,99,88,92,84,86,80,79,78,74,80,68,86,92]","Operating Systems-Exams":"[63,58,59,59,37,58,48,53,58,39,64,65,60,58,36,57,47,52,57,38,62,68,62,60]","Operating Systems-Homeworks":"[10,23,21,13,7,21,17,13,10,4,21,23,20,18,19,20,21,20,19,18,17,16,19,18]","Operating Systems-Final Grade":"[68,91,78,96,88,81,87,92,83,73,68,71,73,70,85,67,80,82,83,85,71,79,85,88]","Software Project-Exams":"[10,18,14,17,26,34,7,40,18,13,25,15,7,40,26,35,30,34,31,35,30,28,18,19,20,15,13]","Software Project-Project":"[80,81,86,78,79,90,95,90,75,49,62,48,32,70,78,78,75,76,72,71,70,72,73,71,69,64,72]","Software Project-Homeworks":"[24,9,18,24,34,7,8,33,14,10,10,5,10,39,36,33,30,29,34,31,27,26,24,30,31,29,21]","Software Project-Final Grade":"[78,82,99,73,82,97,93,71,82,89,93,94,89,100,83,81,81,84,83,80,84,76,79,80,83,86,87]","Logic-Exams":"[55,63,50,38,65,63,50,70,65,65,64,67,62,60,59,57,60,62,63,61,69]","Logic-Homeworks":"[14,18,8,7,22,14,8,29,18,17,18,17,19,15,18,19,21,23,24,19,21]","Logic-Final Grade":"[83,97,96,82,64,83,83,63,97,94,91,87,89,85,84,80,89,83,79,83,87]","Complexity-Exams":"[65,93,75,80]","Complexity-Homeworks":"[15,10,9]","Complexity-Final Grade":"[88,69]","Compilation-Exams":"[35,35,46,19,36,34,31,32,30,27,26,33,30,26,39,29,35]","Compilation-Homeworks":"[30,50,50,20,51,49,56,49,48,35,38,40,47,40,29,35,36]","Compilation-Project":"[69,69,67,25,64,62,69,75,61,58,56,57,53,52,58,55,50]","Compilation-Final Grade":"[87,83,62,74,81,83,85,86,80,81,79,83,74,81,80,83,86]","Overall Average":"[70,82,82,82.83,85,98,76,75,80,78,81,76,79,82,85,84,80,85,82,81,85,83,82,81,80,83,84,89,86,90,72,80,80,91,70,86,79,79,73,70,70]"}''';
    Map<String, dynamic> stats = jsonDecode(stringjson);
    print(stats['Calculus 1-Exams']);
    List<String> resources = ["Exams", "Homeworks", "Final Grade"];
    List<String> allCourses=["Calculus 1", "Linear Algebra 1", "CS 101" , "Discrete Mathematics",
      "Probability", "Calculus 2", "Linear Algebra 2", "Software 1", "Data Structures",
      "Statistics", "Computer Structure", "Algorithms", "Software Project", "Computational Models",
      "Operating Systems", "Logic","Complexity","Compilation"];
    statsCollection.document("Overall Average").setData({
      "Overall Average":stats["Overall Average"]
    });


//    for (var i=0; i<allCourses.length; i++){
//      var course = allCourses[i];
//      statsCollection.document(course).setData({
//        resources[0]:stats[course+"-Exams"],
//        resources[1]:stats[course+ "-Homeworks"],
//        resources[2]:stats[course + "-Final Grade"]
//      });
//    }
    //final file = new File("C:\Users\Raghd\Desktop\Workshop Surveys\ey.csv").openRead();
    //Future<List<dynamic>> x = file.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
    //print(x[0]);
    print('Testing testing');
    getLen();
  }

  @override
  Widget build(BuildContext context) {
    return Text(sentence,
    textAlign: TextAlign.center,
//    style: GoogleFonts.bebasNeue(
//      fontSize: 30)
    style: TextStyle(fontFamily: 'Piedra', fontSize: 30.0),
    );
  }
}

class TimerService extends ChangeNotifier {
  static Stopwatch watch;
  Timer _timer;

  Duration get currentDuration => currentDurationTime;
  static Duration currentDurationTime = Duration.zero;
  static Duration SendTime = Duration.zero;
  bool get isRunning => _timer != null;

  TimerService() {
    watch = Stopwatch();
  }

  void _onTick(Timer timer) {
    currentDurationTime = watch.elapsed;

    // notify all listening widgets
    notifyListeners();
  }

  void start() {
    if (_timer != null) return;

    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    watch.start();

    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    watch.stop();
    currentDurationTime = watch.elapsed;
    SendTime = currentDurationTime;
    notifyListeners();
  }

  void reset() {
    stop();
    watch.reset();
    currentDurationTime = Duration.zero;

    notifyListeners();
  }
}


class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle,color: Global.backgroundPageColor),
      child: PopupMenuButton<String>(
        onSelected: (index){},
        icon: Icon(Icons.notifications,color: Colors.black,),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[],
      ),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle,color: Global.backgroundPageColor),
      child: PopupMenuButton<String>(

        onSelected: (index)async{
          switch (int.parse(index)){
            case 0:
              Navigator.pushNamed(context, '/getInfo');
              return;
            case 1:
              Navigator.pushNamed(context, '/history');
              return;
            case 2:
              return await DialogHelperExit.exit(context);
          }
        },
        icon: Icon(Icons.settings,color: Colors.black,),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem(value:'0',child: menuEntry("Personal Information", Icon(Icons.assignment_ind,color: Colors.black,))),
          PopupMenuItem(value:'1',child: menuEntry("Activity History", Icon(Icons.history,color: Colors.black))),
          PopupMenuItem(value:'2',child: menuEntry("Log Out", Icon(Icons.exit_to_app,color: Colors.black))),
        ],
      ),
    );
  }


  Widget menuEntry(String title,Icon icn){
    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        icn,
        SizedBox(width: 6.0,),
        Text(title, style: TextStyle(color: Colors.black, fontSize: 15.0)),
      ],
    );
  }

}


class FriendsButton extends StatefulWidget {
  @override
  _FriendsButtonState createState() => _FriendsButtonState();
}

class _FriendsButtonState extends State<FriendsButton> {

  bool newFriendReq=false;
  static bool first=true;

  void initial(bool set)async{
    UserDataBase.user=await UserDataBase().getUser();
    List<String> friendReqUid=await UserDataBase().getUserFriendReqReceive(FirebaseAPI().getUid());
    newFriendReq = friendReqUid.isEmpty? false: true;
    if(set){setState(() {});}
  }

  @override
  Widget build(BuildContext context) {
    initial(first);
    first=!first;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle,color: Global.backgroundPageColor),
      child: Stack(
        children: <Widget>[
          newFriendReq? Positioned(
              left: 30.0,
              top: 10,
              child: Icon(Icons.brightness_1,
                color: Colors.red,
                size: 9.0,)
          ):Container(),
          IconButton(
            onPressed: (){Navigator.pushNamed(context, '/friends');},
            icon: Icon(Icons.group,color: Colors.black,),
          ),
        ],
      ),
    );
  }
}