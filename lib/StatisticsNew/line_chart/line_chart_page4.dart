import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Global.dart';
import '../bar_chart/samples/bar_chart_sample3.dart';
import '../bar_chart/samples/bar_chart_sample4.dart';
import '../bar_chart/samples/bar_chart_sample5.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';

class LineChartPage4 extends StatefulWidget {
  @override
  _LineChartPage4State createState() => _LineChartPage4State();
}

class _LineChartPage4State extends State<LineChartPage4> {
  List<UserStatForCourse> _usersData=[];

  @override
  Widget build(BuildContext context) {
    _usersData=null;
    updateUsersData(context);
    if(_usersData==null){
      return Loading();
    }
    print(_usersData[3].getCourse());
    return Scaffold(
      backgroundColor: Colors.white,
//      body: Center(child: BarChartSample4(_usersData)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[
          BarChartSample3(),
          const SizedBox(
            height: 18,
          ),
          BarChartSample4(_usersData),
          const SizedBox(
            height: 18,
          ),
          BarChartSample5(),
        ],
      ),
    );
  }

  Future<List<UserStatForCourse>> updateUsersData(BuildContext context) async{
    _usersData=Provider.of<List<UserStatForCourse>>(context);
    return _usersData;
  }
}
