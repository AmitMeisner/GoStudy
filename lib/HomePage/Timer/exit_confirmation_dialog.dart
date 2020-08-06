import 'package:flutter/material.dart';
import 'package:flutterapp/signIn/google_sign_in.dart';

import '../../Global.dart';

class ExitConfirmationDialog extends StatelessWidget {
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
        SizedBox(height: 40,),
        Text('Exit?', style: TextStyle(fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
        SizedBox(height: 24,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(onPressed: (){
              //return Navigator.of(context).pop(true);
             return SignInState().signOut(context);
            }, child: Text('Yes'),color: Global.backgroundPageColor, textColor:Colors.blueGrey,)

            ,RaisedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('No'),color: Global.backgroundPageColor, textColor:Colors.blueGrey),
          ],
        )
      ],
    ),
  );
}