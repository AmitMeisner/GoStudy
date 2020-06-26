import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/Timer/enterTime.dart';
import 'package:flutterapp/signIn/google_sign_in.dart';

import 'enterTime.dart';
import 'enterTime.dart';

class MissingDataDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
    height: 450,
    decoration: BoxDecoration(
        color: Colors.redAccent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset('images/error.jpg', height: 130, width: 130,),
          ),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
          ),
        ),
        SizedBox(height: 35,),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Text('Some data is missing. check values: course, resource and time',
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
        ),

        SizedBox(height: 30,),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pop();
              }, child: Text('OK'),color: Colors.white, textColor: Colors.redAccent),
          ],
        )
      ],
    ),
  );
}