import 'package:flutter/material.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:provider/provider.dart';
import '../../Global.dart';
import 'samples/bar_chart_sample2.dart';

class BarChartPage2 extends StatelessWidget {
  List<UserStatForCourse> _usersData=[];

  @override
  Widget build(BuildContext context) {
    _usersData=null;
    updateUsersData(context);
    if(_usersData==null){
      return Loading();
    }
    print(_usersData.toString());
    return Container(
      color: const Color(0xff132240),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: BarChartSample2(_usersData),
        ),
      ),
    );
  }


  Future<List<UserStatForCourse>> updateUsersData(BuildContext context) async{
    _usersData=Provider.of<List<UserStatForCourse>>(context);
    return _usersData;
  }
}
