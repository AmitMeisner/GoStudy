

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/Timer/resources_buttons.dart';
import 'course_spinner.dart';
import 'digitalClock.dart';
import 'buttonTop.dart';
import 'progress_pie_bar.dart';
import 'neu_reset_button.dart';
import 'package:provider/provider.dart';

import 'package:flutterapp/signIn/google_sign_in.dart';

class HomeMainPage extends StatefulWidget{

  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {

  String userName="";

  String userEmail="";

  Map userDetails= {};
  
  @override
  Widget build(BuildContext context) {
    /** getting the user name from google_sign_in.dart to this page */
    userDetails=ModalRoute.of(context).settings.arguments;
    userName=userDetails["userName"];
    userEmail=userDetails["userEmail"];
    final timeService = TimerService();
    return ChangeNotifierProvider<TimerService>(
      create: (_) => timeService,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          //child: Column(
            children: <Widget>[
              userDet(context, userName),
              SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
              courseSpinner(),
              SizedBox(height: MediaQuery.of(context).size.height/20),
              resourcesButtons(),
              SizedBox(height: 60),
              neuDigitalClock(),
              SizedBox(height: MediaQuery.of(context).size.height/20),
              NeuProgressPieBar(),
              SizedBox(height: 25),
              NeuResetButton(),
              SizedBox(height: 60),
            ],
         // ),
        ),
      ),
    );
  }
}



class TimerService extends ChangeNotifier {
  Stopwatch _watch;
  Timer _timer;

  Duration get currentDuration => _currentDuration;
  Duration _currentDuration = Duration.zero;

  bool get isRunning => _timer != null;

  TimerService() {
    _watch = Stopwatch();
  }

  void _onTick(Timer timer) {
    _currentDuration = _watch.elapsed;

    // notify all listening widgets
    notifyListeners();
  }

  void start() {
    if (_timer != null) return;

    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    _watch.start();

    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _watch.stop();
    _currentDuration = _watch.elapsed;

    notifyListeners();
  }

  void reset() {
    stop();
    _watch.reset();
    _currentDuration = Duration.zero;

    notifyListeners();
  }


  }


Widget userDet(BuildContext context, String userName){
  return Row(
    children: <Widget>[
      Text("Hello "+userName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
      Spacer(),
      RaisedButton(
        child: const Text('SIGN OUT'),
        onPressed: (){
          SignInState().signOut(context);
        },
      ),
    ],
  );
}