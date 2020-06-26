import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/Timer/coursesResources.dart';


class TimeConfirmationDialog extends StatelessWidget {
  static bool toEnterTime = false;
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
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset('images/time.png', height:130 , width: 130,),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
            ),
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Text('Do you want to enter time?  you can always delete/update the time entered later',
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 30,),
          ShowHideDropdown(),
          SizedBox(height: 40,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(onPressed: (){
                toEnterTime = false;
                Navigator.of(context).pop();
              }, child: Text('No'),textColor: Colors.white,),
              SizedBox(width: 8,),
              RaisedButton(onPressed: (){
                toEnterTime = true;
                return Navigator.of(context).pop(true);
              }, child: Text('Yes'), color: Colors.white, textColor: Colors.redAccent,)
            ],
          )
        ],
      ),
    ),
  );
}