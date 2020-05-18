import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';



import 'NavigationButtom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GoStudy',
      home: NavigationButtomPage(),
    );
  }
}



