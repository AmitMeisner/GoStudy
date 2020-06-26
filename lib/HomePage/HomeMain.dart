import 'dart:async';
import 'dart:math';

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
//            userDet(context, userName),
//                SizedBox(height: MediaQuery.of(context).viewPadding.top + 23),
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
//            ShowHideDropdown(),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                neuDigitalClock(),
//            SizedBox(height: MediaQuery.of(context).size.height / 80),
//            NeuProgressPieBar(),
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

//Widget userDet(BuildContext context, String userName) {
//  return Container(
//    child: Row(
//    children: <Widget>[
//      personalInfo(context, userName),
//      Spacer(),
//      RaisedButton(
//        child: const Text('SIGN OUT'),
//        textColor: Colors.blue,
//        onPressed: () async {
//          return await DialogHelperExit.exit(context);
//         // SignInState().signOut(context);
//        },
//      ),
//    ],),
//  );
//}


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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle,color: Global.backgroundPageColor),
      child: IconButton(
        onPressed: (){Navigator.pushNamed(context, '/friends');},
        icon: Icon(Icons.group,color: Colors.black,),
      ),
    );
  }
}



//Widget personalInfo(BuildContext context, String userName) {
//  return RaisedButton(
//    child: Text("Hello " + userName,
//        style: TextStyle(color: Colors.black, fontSize: 15.0)),
//    onPressed: () {
//      Navigator.pushReplacementNamed(context, '/getInfo');
//    },
//  );
//}
