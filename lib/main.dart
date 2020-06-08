import 'package:flutter/material.dart';
import 'signIn/google_sign_in.dart';
import 'NavigationButtom.dart';
import 'package:flutterapp/FirstInfo/InformationPage.dart';


void main() {runApp(MaterialApp(
  initialRoute: '/signIn',
  routes: {
    '/signIn': (context)=> SignIn(),
    '/home': (context)=> NavigationBottomPage(),
    '/getInfo': (context)=> InformationPage(),
    },
    ),
  );
}





