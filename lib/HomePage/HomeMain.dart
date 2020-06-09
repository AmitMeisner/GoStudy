import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Timer/dialog_helper.dart';
import 'Timer/enterTime.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'Timer/coursesResources.dart';
import 'Timer/digitalClock.dart';
import 'Timer/progress_pie_bar.dart';
import 'Timer/buttomButtons.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutterapp/signIn/google_sign_in.dart';

class HomeMainPage extends StatefulWidget {
  @override
  HomeMainPageState createState() => HomeMainPageState();
}

class HomeMainPageState extends State<HomeMainPage> {
  //  String userName="";
//  String userEmail="";

//  Map userDetails= {};

  @override
  Widget build(BuildContext context) {
//    /** getting the user name from google_sign_in.dart to this page */
//    userDetails=ModalRoute.of(context).settings.arguments;
    String userName = FirebaseAPI().getUserName();
    String userEmail = FirebaseAPI().getUserEmail();

    final timeService = TimerService();
    return ChangeNotifierProvider<TimerService>(
      create: (_) => timeService,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          //child: Column(
          children: <Widget>[
            userDet(context, userName),
            SizedBox(height: MediaQuery.of(context).viewPadding.top + 50),
            ShowHideDropdown(),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            //resourcesButtons(),
            //ActionChipDisplay(),
            //SizedBox(height: 60),
            neuDigitalClock(),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            motivationSentence(),
            SizedBox(height: MediaQuery.of(context).size.height / 80),
            NeuProgressPieBar(),
            SizedBox(height: 55),
            //NeuResetButton(),
            // SizedBox(height: 60),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  NeuResetButton(),
                  enterTimeButton(),
                ])
          ],
          // ),
        ),
      ),
    );
  }
}

class motivationSentence extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => motivationSentenceState();
}

class motivationSentenceState extends State<motivationSentence> {
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
    style: GoogleFonts.bebasNeue(
      fontSize: 30
    ));
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

Widget userDet(BuildContext context, String userName) {
  return Container(
    child: Row(
    children: <Widget>[
      personalInfo(context, userName),
      Spacer(),
      RaisedButton(
        child: const Text('SIGN OUT'),
        textColor: Colors.blue,
        onPressed: () async {
          return await DialogHelperExit.exit(context);
         // SignInState().signOut(context);
        },
      ),
    ],),
  );
}

Widget personalInfo(BuildContext context, String userName) {
  return RaisedButton(
    child: Text("Hello " + userName,
        style: TextStyle(color: Colors.blueGrey, fontSize: 15.0)),
    onPressed: () {
      Navigator.pushReplacementNamed(context, '/getInfo');
    },
  );
}
