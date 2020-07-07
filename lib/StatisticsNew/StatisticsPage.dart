import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/StatisticsNew/pie_chart/samples/pie_chart_sample1.dart';
import 'package:flutterapp/StatisticsNew/pie_chart/samples/pie_chart_sample2.dart';
import 'package:flutterapp/StatisticsNew/scatter_chart/samples/scatter_chart_sample2.dart';
import 'package:flutterapp/StatisticsNew/scatter_chart/samples/scatter_chart_sample1.dart';
import 'package:flutterapp/StatisticsNew/CourseXY.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:provider/provider.dart';

import '../Global.dart';
import 'CourseXY.dart';
import 'bar_chart/samples/bar_chart_sample1.dart';
import 'bar_chart/samples/bar_chart_sample2.dart';
import 'bar_chart/samples/bar_chart_sample4.dart';
import 'line_chart/samples/line_chart_sample1.dart';
import 'line_chart/samples/line_chart_sample2.dart';
import 'line_chart/samples/line_chart_sample3.dart';
import 'line_chart/samples/line_chart_sample4.dart';
import 'line_chart/samples/line_chart_sample5.dart';
import 'line_chart/samples/line_chart_sample6.dart';
import 'line_chart/samples/line_chart_sample7.dart';
import 'line_chart/samples/line_chart_sample8.dart';



class NewStatistics extends StatefulWidget {
  const NewStatistics({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NewStatistics createState() => _NewStatistics();
}

class _NewStatistics extends State<NewStatistics> {
//  @override
//  void initState() {
//    var rng=Random();
//    for(String course in Global().getAllCourses()) {
//      UserStatForCourse user=UserStatForCourse(course,60+rng.nextDouble()*40,4+rng.nextDouble()*2,
//          4+rng.nextDouble()*2,2+rng.nextDouble()*1,5+rng.nextDouble()*2,1+rng.nextDouble()*1,60+rng.nextDouble()*40);
//      AllUserDataBase().addUserData(user);
//    }
//    super.initState();
//  }

  List<UserStatForCourse> _usersData=[];
  static int chosenChart=1;
  static bool paramChoose=false;



  @override
  void initState(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
//    _usersData=null;
//    updateUsersData(context);
//    if(_usersData==null){
//      return Loading();
//    }
    return StreamProvider<List<UserStatForCourse>>.value(
      value: AllUserDataBase().usersStats,
      child: Scaffold(
        backgroundColor: Global.getBackgroundColor(0),
        body: SafeArea(
          child: bodyBuild(),
        ),
      ),
    );
  }




  Widget bodyBuild(){
    return Container(
      color: Global.backgroundPageColor,
      child: ListView(
        children: <Widget>[
          ShowHideDropdown(setStatisticsPageState),
          arrowButtons(),
        ],
      ),
    );
  }


  Future<List<UserStatForCourse>> updateUsersData(BuildContext context) async{
    _usersData=Provider.of<List<UserStatForCourse>>(context);
    return _usersData;
  }



  Widget arrowButtons(){
    return Container(
      height: MediaQuery.of(context).size.height/1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          paramChoose? IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: chosenChart==1? Colors.grey:Colors.black,
            onPressed: (){
              if(chosenChart==1){return;}
              chosenChart--;
              setState(() {});
            },
          ):Container(),
          shownChart(),
          paramChoose? IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            color: chosenChart==7? Colors.grey:Colors.black,
            onPressed: (){
              if(chosenChart==7){return;}
              chosenChart++;
              setState(() {});
            },
          ):Container(),
        ],
      ),
    );
  }

  Widget shownChart(){
    if(!paramChoose){return BarChartSample1();}
    switch(chosenChart){
      case 1:
        return  ScatterChartSample1();
      case 2:
        return  LineChartSample2();
      case 3:
        return  ScatterChartSample2();
      case 4:
        return  LineChartSample4(ShowHideDropdownState.selectedCourse, ShowHideDropdownState.xAxisValue, ShowHideDropdownState.yAxisValue1);
      case 5:
        return  PieChartSample1();
      case 6:
        return  PieChartSample2();
      case 7:
        return  LineChartSample7();
    }
    return Text('hi');
  }

  void setStatisticsPageState(String xAxis1, String yAxis1, String yAxis2, String yAxis3){
    if (yAxis2=="yAxis2" && yAxis3=="yAxis3"){
      setTwoParamsGraphs(xAxis1, yAxis1);
    }else if(yAxis2!="yAxis2" && yAxis3=="yAxis3"){
      setThreeParamsGraphs(xAxis1, yAxis1, yAxis2);
    }else if(yAxis2!="yAxis2" && yAxis3!="yAxis3"){
      setFourParamsGraphs(xAxis1, yAxis1, yAxis2, yAxis3);
    }

    print(xAxis1);
    print(yAxis1);
    print(yAxis2);
    print(yAxis3);
    setState(() {paramChoose=true;});
  }

  void setTwoParamsGraphs(String xAxis1, String yAxis1) {

  }

  void setThreeParamsGraphs(String xAxis1, String yAxis1, String yAxis2) {}

  void setFourParamsGraphs(String xAxis1, String yAxis1, String yAxis2, String yAxis3) {}
}


//                LineChartSample1(),
//                LineChartSample2(),
//                BarChartSample1(),
//                BarChartSample2(_usersData),
//                PieChartSample1(),
//                PieChartSample2(),
//                LineChartSample3(),
//                LineChartSample4(),
//                LineChartSample7(),
//                LineChartSample5(),
//                LineChartSample8(),
//                LineChartSample6(),
//                BarChartSample4(_usersData),
//                BarChartSample5(),
//                ScatterChartSample1(),
//                ScatterChartSample2(),