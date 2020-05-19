
import 'dart:async';

import 'package:flutter/material.dart';
import 'digitalClock.dart';
import 'progress_pie_bar.dart';
import 'neu_reset_button.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/signIn/google_sign_in.dart';

class HomeMainPage extends StatelessWidget{

  String userName;
  String userEmail;

  Map userDetails= {};

  @override
  Widget build(BuildContext context) {
    /** getting the user name from google_sign_in.dart to this page */
    userDetails=ModalRoute.of(context).settings.arguments;
    userName=userDetails["userName"];
    userEmail=userDetails["userEmail"];
//
//    print("user name is"+userName);
//    print("user email is"+userEmail);

    final timeService = TimerService();
    return ChangeNotifierProvider<TimerService>(
      create: (_) => timeService,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
//              TimerTitle(),
//              SizedBox(height: 5),
              userDet(context, userName),
              neuDigitalClock(),
//              SizedBox(height: 1),
              NeuProgressPieBar(),
//              SizedBox(height: 1),
              NeuResetButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerTitle extends StatelessWidget {
  const TimerTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
//        Text(
//          'HomePage.Timer',
////          style: Theme.of(context).textTheme.headline1,
//        ),
//        Spacer(),
//        NeuHamburgerButton()
      ],
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
            SignInDemoState().signOut(context);
          },
        ),
      ],
    );
}
