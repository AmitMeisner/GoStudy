import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';
import 'package:flutterapp/HomePage/Timer/coursesResources.dart';
import 'package:flutterapp/HomePage/Timer/progress_pie_bar.dart';


class TimeConfirmationDialog extends StatelessWidget {
  static bool toEnterTime = false;
  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      elevation: 30,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
    height: 250,
    decoration: BoxDecoration(
        color:Global.backgroundPageColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 25,),
          ShowHideDropdown(),
          SizedBox(height: 40,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(onPressed: (){
                toEnterTime = false;
                NeuStartButtonState.isRunning=false;
                Navigator.of(context).pop();
                }, child: Text('Discard'), color: Global.backgroundPageColor,textColor: Colors.blueGrey,),
              RaisedButton(onPressed: (){
                toEnterTime = true;
                NeuStartButtonState.isRunning=false;
                return Navigator.of(context).pop(true);

                }, child: Text('Save',), color: Global.backgroundPageColor, textColor:Colors.blueGrey)

            ],
          ),
        ],
      ),
    ),
  );
}



