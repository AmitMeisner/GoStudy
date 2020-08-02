import 'package:flutter/material.dart';
import 'FirstInfo/gridDashBoard.dart';
import 'Friends/Friends.dart';
import 'HomePage/History/time.dart';
import 'Rank/Rank.dart';
import 'signIn/google_sign_in.dart';
import 'NavigationButtom.dart';
import 'package:flutterapp/FirstInfo/InformationPage.dart';


void main() {runApp(MaterialApp(
  initialRoute: '/signIn',
  routes: {
    '/signIn': (context)=> SignIn(),
    '/home': (context)=> NavigationBottomPage(),
    '/getInfo': (context)=> InformationPage(),
    '/history' :(context)=> TimesPage(),
    '/old courses':(context)=> GridDashboard(),
    '/friends' :(context)=> Friends(),
    '/rank' :(context)=> Rank(),


  },
    ),
  );
}





