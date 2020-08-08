import 'dart:async';
import 'dart:convert';

import 'dart:math';

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
  var t=min(_HomeScreenState.exams.length, _HomeScreenState.grades.length);
  return min(t,_HomeScreenState.homework.length);
}
class _HomeScreenState extends State<HomeScreen> {
  static String currentSubject="Logic";
  static String subject;
  static String currentX="Exam";
  static String currentY="Grade";
  static String currentChart="Bar";
  static List<int> exams;
  static List<int> grades;
  static List<int> homework;
  static List<DataModel> data;


  List<List<int>> sortDataForGraph(String XAxis, String YAxis){
    List<int> currentX = XAxis=="Exam"?_HomeScreenState.exams:XAxis=="Grade"?_HomeScreenState.grades:_HomeScreenState.homework;
    List<int> currentY = YAxis=="Exam"?_HomeScreenState.exams:YAxis=="Grade"?_HomeScreenState.grades:_HomeScreenState.homework;
    var newlist=List.generate(getLength(), (i) =>[currentX[i],currentY[i]]);
    newlist.sort((a,b)=>a[0].compareTo(b[0]));
    List<int> newCurrentX = [];
    List<int> newCurrentY = [];
    for (var i=0; i<newlist.length; i++){
      setState(() {
        newCurrentX.add(newlist[i][0]);
        newCurrentY.add(newlist[i][1]);
      });
    }
    return [newCurrentX, newCurrentY]; //could hold more than only two parameters. thats why its a List.

  }

  getExamValue(DataModel data){
    List<int>value=[];
    var exam=data!=null?data.exam.split(","):[];
    exam.forEach((element) {
      var e=element.replaceAll("[","").replaceAll("]","");
      if(e!="null"){
        value.add(int.parse(e));
      }
    });

    return value;
  }
  getGradeValue(DataModel data){
    List<int>value=[];
    var exam=data!=null?data.grade.split(","):[];
    exam.forEach((element) {
      var e=element.replaceAll("[","").replaceAll("]","");
      if(e!="null"){
        value.add(int.parse(e));
      }
    });

    return value;
  }
  getHomeWorkValue(DataModel data){
    List<int>value=[];
    var exam=data!=null?data.homework.split(","):[];
    exam.forEach((element) {
      var e=element.replaceAll("[","").replaceAll("]","");
      if(e!="null"){
        value.add(int.parse(e));
      }
    });

    return value;
  }

  Future<List<DataModel>> loadData(BuildContext context) async {
    _HomeScreenState.data=Provider.of<List<DataModel>>(context);
    _HomeScreenState.exams=_HomeScreenState.data.where((element) =>element.docId==(_HomeScreenState.subject==null?_HomeScreenState.currentSubject:_HomeScreenState.subject)).toList().length==0?[]:getExamValue(_HomeScreenState.data.where((element) =>element.docId==(_HomeScreenState.subject==null?_HomeScreenState.currentSubject:_HomeScreenState.subject)).toList()[0]);
    _HomeScreenState.grades=_HomeScreenState.data.where((element) =>element.docId==(_HomeScreenState.subject==null?_HomeScreenState.currentSubject:_HomeScreenState.subject)).toList().length==0?[] :getGradeValue(_HomeScreenState.data.where((element) =>element.docId==(_HomeScreenState.subject==null?_HomeScreenState.currentSubject:_HomeScreenState.subject)).toList()[0])??[];
    _HomeScreenState.homework=_HomeScreenState.data.where((element) =>element.docId==(_HomeScreenState.subject==null?_HomeScreenState.currentSubject:_HomeScreenState.subject)).toList().length==0?[]:getHomeWorkValue(_HomeScreenState.data.where((element) =>element.docId==(_HomeScreenState.subject==null?_HomeScreenState.currentSubject:_HomeScreenState.subject)).toList()[0]);
    _HomeScreenState.currentSubject=_HomeScreenState.subject==null?_HomeScreenState.data[0].docId:_HomeScreenState.subject;
    return data;
  }
  @override
  Widget build(BuildContext context) {
    data = null;
    loadData(context);
    if (data ==null){
      return Loading();
    }
    print("hi");
    print(data);
    List<Chart>charts=[];
    List<List<int>> displayed = sortDataForGraph(currentX, currentY);
    for (var i = 0; i < getLength(); i++) {
      charts.add(Chart(xValue: displayed[0][i],yValue: displayed[1][i],barColor:chart.MaterialPalette.blue.shadeDefault));
    }


    List<chart.Series<Chart, String>> series = [
      chart.Series(
          id: "Statistics",
          data: charts,
          domainFn: (Chart series, _) =>series.xValue.toString(),
          measureFn: (Chart series, _) =>int.tryParse(series.yValue.toString()),
          colorFn: (Chart series, _) => series.barColor)
    ];
    return Scaffold(
      appBar: AppBar(
        title:Container(
          padding: EdgeInsets.only(left: 10),
          child: Center(
            child: DropdownButton<String>(
                value: currentSubject,
                icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                dropdownColor: Colors.blue,
                underline: Container(),
                items: data.map((e) => DropdownMenuItem<String>(
                  child: Text(e.docId),
                  value: e.docId,
                )
                ).toList(), onChanged:(value){
              setState(() {
                currentSubject=value=="Overall Average"?"Logic":value;
                subject=value=="Overall Average"?"Logic":value;
              });
            }),
          ),
        ),

      ),

      body:exams.isEmpty||grades.isEmpty||homework.isEmpty?Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Text("X-Axis"),
              trailing: DropdownButton(
                  value: currentX,
                  underline: Container(),
                  items: [
                    DropdownMenuItem(child: Text("Exam Time"),value: "Exam",),
                    DropdownMenuItem(child: Text("Final Grade"),value: "Grade",),
                    DropdownMenuItem(child: Text("Homework Time"),value: "HomeWork",),
                  ], onChanged:(value){
                setState(() {
                  currentX=value;
                });
              }),
            ),
            ListTile(
              leading: Text("Y-Axis"),
              trailing: DropdownButton(
                  value: currentY,
                  underline: Container(),
                  items: [
                    DropdownMenuItem(child: Text("Exam Time"),value: "Exam",),
                    DropdownMenuItem(child: Text("Final Grade"),value: "Grade",),
                    DropdownMenuItem(child: Text("Homework Time"),value: "HomeWork",),
                  ], onChanged:(value){
                setState(() {
                  currentY=value;
                });
              }),
            ),
            Divider(height: 1,),
            Container(
              margin: EdgeInsets.only(left: 10,top: 25),
              height: MediaQuery.of(context).size.height*0.6,
              child: chart.BarChart(series,animate: true,behaviors: [
                chart.SlidingViewport(),
                chart.PanAndZoomBehavior(),
              ],

              ),
            ),
            //  Container(
            //    margin: EdgeInsets.only(left: 10),
            //    height: MediaQuery.of(context).size.height*0.5,
            //    child: chart.PieChart(series,animate: true,behaviors: [
            //      //chart.SlidingViewport(),
            //        //chart.PanAndZoomBehavior(),
            //    ],),
            //  ),
            //  Container(
            //     margin: EdgeInsets.only(left: 10),
            //    height: MediaQuery.of(context).size.height*0.5,
            //    child: chart.LineChart(series,animate: true,))

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