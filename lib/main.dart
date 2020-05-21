import 'package:flutter/material.dart';
import 'signIn/google_sign_in.dart';


import 'NavigationButtom.dart';

//void main() {
//  runApp(MyApp());
//}

void main() {runApp(MaterialApp(
  initialRoute: '/signIn',
  routes: {
    '/signIn': (context)=> SignInDemo(),
  '/home': (context)=> NavigationButtomPage()
  },
//      title: 'Google Sign In',
//      home: SignInDemo(),
    ),
  );
}



//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter GoStudy',
//      home: NavigationButtomPage(),
//    );
//  }
//}



