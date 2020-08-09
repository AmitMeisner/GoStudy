import 'dart:async';
import 'dart:convert';

import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Statistics/StatisticsDataBase.dart';
import 'package:flutter/src/painting/edge_insets.dart';
import 'package:provider/provider.dart';
import '../Global.dart';
import 'package:number_display/number_display.dart';
import 'package:charts_flutter/flutter.dart' as chart;


final display = createDisplay(decimal: 2);


class StatisticsPage extends StatelessWidget {
  DataService data=DataService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(create: (_)=>data.getData(),catchError: (_,error){
          print(error);
        },)
      ],
      child: MaterialApp(
        title: 'Statistics',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}




getLength(){
//  var t=min(_HomeScreenState.exams.length, _HomeScreenState.grades.length);
//  return min(t,_HomeScreenState.homework.length);
  if(_HomeScreenState.xAxisValues!=null && _HomeScreenState.yAxisValues!=null)
    {return min(_HomeScreenState.xAxisValues.length,_HomeScreenState.yAxisValues.length);}
  return 0;
}


class _HomeScreenState extends State<HomeScreen> {
  static String course;
//  static String subject="";
  static String xAxis="examTime";
  static String Yaxis="grade";
//  static String currentChart="Bar";
//  static List<int> exams=[]; //should be removed
//  static List<int> grades=[]; //should be removed
//  static List<int> homework=[]; //should be removed
  static List<int> xAxisValues; //should include the data that is display in the X Axis, replacing the above exams,grades, homework
  static List<int> yAxisValues; //kanal
//  static List<DataModel> data;
//  static String test = "testString";
  bool reload=true;


  List<List<int>> sortDataForGraph(List<int> XAxis, List<int> YAxis){
//    List<int> currentX = XAxis=="Exam"?exams:XAxis=="Grade"?grades:homework;
//    List<int> currentY = YAxis=="Exam"?exams:YAxis=="Grade"?grades:homework;
    var newList=List.generate(getLength(), (i) =>[xAxisValues[i],yAxisValues[i]]);
    newList.sort((a,b){
      if(a[0]==null && b[0]==null){return 0;}
      if(a[0]==null && b[0]!=null){return -5;}
      if(a[0]!=null && b[0]==null){return 5;}
      return a[0].compareTo(b[0]);
      }
    );
    List<int> newCurrentX = [];
    List<int> newCurrentY = [];
    for (var i=0; i<newList.length; i++){
      reload=false;
      setState(() {
        newCurrentX.add(newList[i][0]);
        newCurrentY.add(newList[i][1]);
      });
    }
    return [newCurrentX, newCurrentY]; //could hold more than only two parameters. thats why its a List.

  }
//
//  getExamValue(DataModel data){
//    List<int>value=[];
//    var exam=data!=null?data.exam.split(","):[];
//    exam.forEach((element) {
//      var e=element.replaceAll("[","").replaceAll("]","");
//      if(e!="null"){
//        value.add(int.parse(e));
//      }
//    });
//
//    return value;
//  }
//  getGradeValue(DataModel data){
//    List<int>value=[];
//    var exam=data!=null?data.grade.split(","):[];
//    exam.forEach((element) {
//      var e=element.replaceAll("[","").replaceAll("]","");
//      if(e!="null"){
//        value.add(int.parse(e));
//      }
//    });
//
//    return value;
//  }
//  getHomeWorkValue(String data){
//    List<int>value=[];
//    var exam=data!=null?data.split(","):[];
//    exam.forEach((element) {
//      var e=element.replaceAll("[","").replaceAll("]","");
//      if(e!="null"){
//        value.add(int.parse(e));
//      }
//    });
//
//    return value;
//  }

  Future<void> loadData(BuildContext context) async {
    //exams, grades, homework are List<int> that include the current-chosen-course, its returned and parsed from string representation using the above 3 functions.
//    data=Provider.of<List<DataModel>>(context);

    if(course==null){
      course= Global().getAllCourses()[0];
    }

    //this functions returns string representation of array that holds values, which then can be parsed by the parsing functions above to convert to List<int>, which then displayed in the graph
    xAxisValues= await StatisticsDataBase.queryValues(course, xAxis) ;
    yAxisValues= await StatisticsDataBase.queryValues(course, Yaxis);


    reload=false;
    setState(() {});


    return;
  }



  @override
  Widget build(BuildContext context) {
    if (reload){
      xAxisValues=null;
      yAxisValues=null;
      loadData(context);
      return Loading();
    }
    reload=true;


    List<Chart>charts=[];

    //via the pick of currentX and currentY, sortDataForGraph sorts them by the X-Axis for display.
    List<List<int>> displayed = sortDataForGraph(xAxisValues, yAxisValues);



    //filling up the chart with the data, displayed[0] is XAxis, displayed[1] is YAxis
    for (var i = 0; i < getLength(); i++) {
      if(displayed[0][i]==null || displayed[1][i]==null){continue;}
      charts.add(Chart(xValue: displayed[0][i],yValue: displayed[1][i],barColor:chart.MaterialPalette.blue.shadeDefault));
    }


    List<chart.Series<Chart, String>> series = [
      chart.Series(
          id: "Statistics",
          data: charts,
          domainFn: (Chart series, _) =>series.xValue.toString(),
          measureFn: (Chart series, _) =>int.tryParse(series.yValue.toString()),
          colorFn: (Chart series, _) => series.barColor
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title:Container(
          padding: EdgeInsets.only(left: 10),
          child: Center(
            child:
            DropdownButton<String>(
                value: course,
                icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                dropdownColor: Colors.blue,
                underline: Container(),
                items:
                Global().getAllCourses().map((e) => DropdownMenuItem<String>(
                  child: Text(e),
                  value: e,
                )
                ).toList(),
                onChanged:(value){
                    setState(() {
                        reload=true;
                        course=value;
//                        subject=value=="Overall Average"?"Logic":value;
                    });
                }
            ),
          ),
        ),

      ),

      body:xAxisValues==null||yAxisValues==null||xAxisValues.isEmpty || yAxisValues.isEmpty ?Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
        child: Column(
          children: [
//            ListTile(
//              leading: Text("X-Axis"),
//              trailing: DropdownButton(
//                  value: xAxis,
//                  underline: Container(),
//                  items: [
//                    DropdownMenuItem(child: Text("Exam Time"),value: "examTime",),
//                    DropdownMenuItem(child: Text("Final Grade"),value: "grade",),
//                    DropdownMenuItem(child: Text("Homework Time"),value: "hwTime",),
//                  ], onChanged:(value){
//                setState(() {
//                  reload=true;
//                  xAxis=value;
//                });
//              }),
//            ),
//            ListTile(
//              leading: Text("Y-Axis"),
//              trailing: DropdownButton(
//                  value: Yaxis,
//                  underline: Container(),
//                  items: [
//                    DropdownMenuItem(child: Text("Exam Time"),value: "examTime",),
//                    DropdownMenuItem(child: Text("Average"),value: "avg",),
//                    DropdownMenuItem(child: Text("Final Grade"),value: "grade",),
//                    DropdownMenuItem(child: Text("Homework Time"),value: "hwTime",),
//                  ], onChanged:(value){
//                setState(() {
//                  reload=true;
//                  Yaxis=value;
//                });
//              }),
//            ),
            Divider(height: 1,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DropdownButton(
                      value: Yaxis,
                      underline: Container(),
                      items: [
                        DropdownMenuItem(child: Text("Exam Time"),value: "examTime",),
                        DropdownMenuItem(child: Text("Average"),value: "avg",),
                        DropdownMenuItem(child: Text("Final Grade"),value: "grade",),
                        DropdownMenuItem(child: Text("Homework Time"),value: "hwTime",),
                      ], onChanged:(value){
                    setState(() {
                      reload=true;
                      Yaxis=value;
                    });
                  })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,top: 25),
              height: MediaQuery.of(context).size.height*0.6,
              child: chart.BarChart(
                series,
                animate: true,behaviors: [
                  chart.SlidingViewport(),
                  chart.PanAndZoomBehavior(),
                  ],
              ),
            ),
            Center(
              child: DropdownButton(
                  value: xAxis,
                  underline: Container(),
                  items: [
                    DropdownMenuItem(child: Text("Exam Time"),value: "examTime",),
                    DropdownMenuItem(child: Text("Final Grade"),value: "grade",),
                    DropdownMenuItem(child: Text("Homework Time"),value: "hwTime",),
                  ], onChanged:(value){
                setState(() {
                  reload=true;
                  xAxis=value;
                });
              }),
            ),
           

          ],
        ),
      )
      ,


    );
  }

}

class Chart{
  int xValue;
  int yValue;
  chart.Color barColor;
  Chart({this.xValue, this.yValue,this.barColor});
}