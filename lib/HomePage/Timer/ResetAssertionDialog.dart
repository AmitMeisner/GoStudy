import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/Timer/enterTime.dart';
import 'package:flutterapp/signIn/google_sign_in.dart';

import '../../Global.dart';
import 'bottomButtons.dart';
import 'enterTime.dart';
import 'enterTime.dart';

class ResetAssertionDialog extends StatelessWidget {
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
    height: 200,
    decoration: BoxDecoration(
        color:Global.backgroundPageColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: Column(
      children: <Widget>[
        SizedBox(height: 35,),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Text('Delete time?',
            style: TextStyle(fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
        ),

        SizedBox(height: 30,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(onPressed: (){
              NeuResetButton.reset=true;
              Navigator.of(context).pop();
            }, child: Text('Yes'),color: Global.backgroundPageColor, textColor:Colors.blueGrey),
            RaisedButton(onPressed: (){
              NeuResetButton.reset=false;
              Navigator.of(context).pop();
              }, child: Text('No'),color: Global.backgroundPageColor, textColor:Colors.blueGrey),
          ],
        )
      ],
    ),
  );
}