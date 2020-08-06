import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/StatisticsNew/pie_chart/samples/pie_chart_sample1.dart';
import 'package:flutterapp/StatisticsNew/pie_chart/samples/pie_chart_sample2.dart';
import 'package:flutterapp/StatisticsNew/Choice.dart';
import 'package:flutterapp/StatisticsNew/scatter_chart/samples/scatter_chart_sample1.dart';
import 'package:flutterapp/StatisticsNew/CourseXY.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
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
  static Choice choice;
  bool yStatsStringLoaded = false;

  static bool xyOption=false;
  static bool xyyOption=false;
  static bool xyyyOption=false;
  String yStatsString;
  List<FlSpot> yStats;
  String algoExamString = "[65,63,67,64,60,59,48,63,62,69,55,47,65,63,63,55,60,62,63,64,59,55,59,58,56,60,57,58,null,null,null,null,null,null,null,null,null,null,null,null,null]";
  String algoFGString = "[68,85,95,null,78,100,86,82,77,84,73,82,81,83,83,74,84,78,77,82,81,83,86,70,71,80,82,86,null,null,null,null,null,null,null,null,null,null,null,null,null]";
  String algoHWString = "[13,13,20,16,16,8,8,20,13,10,9,9,13,22,13,14,10,11,10,13,10,15,11,10,18,16,14,12,null,null,null,null,null,null,null,null,null,null,null,null,null]";


  void initState(){
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
              chosenChart = chosenChart % 3;
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
              chosenChart = chosenChart % 3;
              setState(() {});
            },
          ):Container(),
        ],
      ),
    );
  }

  void parseStrings(){
    print(yStatsString);
    var x = json.decode(yStatsString);
    print(x[0]);
    print(x[2]);
  }

  Future<String> getData(String document, String field) async {
    //Returns the data from the relevant (Statistics).document.field
    CollectionReference statsCollection = Firestore.instance.collection(
        "Statistics");
    String data;
    var x = statsCollection.document(document).get().then((value) {
      setState(() {
        data = value.data[field];
        print(data);
        yStatsStringLoaded = true;
        yStatsString = data;
        print("inside");
        print(yStatsString);
        var x = json.decode(algoExamString);
      });
    });
    return data;
  }
  Future<void> loadYAxis() async{
    print("flagz");
    print(_NewStatistics.choice.selectedCourse);
    print(_NewStatistics.choice.yAxis1);
    getData(_NewStatistics.choice.selectedCourse, _NewStatistics.choice.yAxis1);

    //print("flagz: " + yStatsString);
  }

  Widget shownChart(){
    if(!paramChoose){return BarChartSample1();}
    switch(chosenChart){
      case 0:
        return  LineChartSample4();
      case 1:
        return  LineChartSample7();
      case 2:
        return  LineChartSample4();
    }
    return Text('irrelevant');
  }

  void setStatisticsPageState(Choice choice){
    _NewStatistics.choice = choice;
    if (choice.yAxis2=="yAxis2" && choice.yAxis3=="yAxis3"){
      setTwoParamsGraphs(choice.xAxis, choice.yAxis1);
    }else if(choice.yAxis2!="yAxis2" && choice.yAxis3=="yAxis3"){
      setThreeParamsGraphs(choice.xAxis, choice.yAxis1, choice.yAxis2);
    }else if(choice.yAxis2!="yAxis2" && choice.yAxis3!="yAxis3"){
      setFourParamsGraphs(choice.xAxis, choice.yAxis1, choice.yAxis2, choice.yAxis3);
    }
    //loadYAxis();

    setState(() {
      //print("Loaded");
      //print(yStatsString);
      paramChoose=true;});
  }

  void setTwoParamsGraphs(String xAxis1, String yAxis1) {
    xyOption=true;
  }

  void setThreeParamsGraphs(String xAxis1, String yAxis1, String yAxis2) {
    xyyOption=true;
  }

  void setFourParamsGraphs(String xAxis1, String yAxis1, String yAxis2, String yAxis3) {
    xyyyOption=true;
  }
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