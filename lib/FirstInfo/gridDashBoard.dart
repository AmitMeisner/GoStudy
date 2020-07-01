
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';
import 'package:google_fonts/google_fonts.dart';

import 'InfoCourse.dart';


class GridDashboard extends StatefulWidget {
  @override
  GridDashboardState createState() => GridDashboardState();
}

class GridDashboardState extends State<GridDashboard> {

  Widget build(BuildContext context) {
    var allCourses = Global().getAllCourses();
    var myGridView = new GridView.builder(
      itemCount: allCourses.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.centerLeft,
              margin: new EdgeInsets.only(top: 10.0, bottom: 10.0,left: 10.0),
              child: new Text(allCourses[index]),
            ),
          ),
          onTap: () async{
            return await DialogHelper.exit(context);
            },
        );
      },
    );

    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Flutter GridView")
      ),
      body: myGridView,
    );
  }


}


class DialogHelper {

  static exit(context) => showDialog(context: context, builder: (context) => InfoCourse());
}
//barrierDismissible: false,
//context: context,
//child: new CupertinoAlertDialog(
//title: new Column(
//children: <Widget>[
//new Text(allCourses[index]),
//new Icon(
//Icons.favorite,
//color: Colors.red,
//),
//],
//),
//content: new Text( allCourses[index]),
//actions: <Widget>[
//new FlatButton(
//onPressed: () {
//Navigator.of(context).pop();
//},
//child: new Text("OK"))
//],
//));