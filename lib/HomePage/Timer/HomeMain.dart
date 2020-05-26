

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/Timer/resources_buttons.dart';

import 'course_spinner.dart';
import 'digitalClock.dart';
import 'newTry.dart';
import 'progress_pie_bar.dart';
import 'neu_reset_button.dart';

import 'package:provider/provider.dart';
class HomeMainPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    final timeService = TimerService();
    return ChangeNotifierProvider<TimerService>(
      create: (_) => timeService,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          //child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
              //courseSpinner(),
              ShowHideDropdown(),
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
    ShowHideDropdownState.timernNotRunning = false;
    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    _watch.start();
    //ShowHideDropdownState.notRunning = false ;
    notifyListeners();

  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _watch.stop();
    _currentDuration = _watch.elapsed;
    ShowHideDropdownState.timernNotRunning = false;
    notifyListeners();
  }

  void reset() {
    stop();
    _watch.reset();
    _currentDuration = Duration.zero;
    ShowHideDropdownState.timernNotRunning = true;
    notifyListeners();
  }


  }


