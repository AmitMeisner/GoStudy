

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class top20Table extends StatefulWidget {
  @override
  top20TableState createState() => top20TableState();
}

class top20TableState extends State<top20Table> {

  @override
  Widget build(BuildContext context) {

   return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image:AssetImage("images/top20new.jpeg"),
            fit:BoxFit.cover
        )
      ),
    ),

   );
  }


}