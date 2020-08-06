import 'dart:async';
import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Statistics/StatisticsDataBase.dart';
import 'package:flutter/src/painting/edge_insets.dart';
import 'package:provider/provider.dart';
import 'package:number_display/number_display.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        title: 'Chart App',
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

class _HomeScreenState extends State<HomeScreen> {
  String currentSubject="Logic";
  String subject;
  String currentX="Exam";
  String currentY="Grade";
  String currentChart="Bar";
  @override
  Widget build(BuildContext context) {
    var data=Provider.of<List<DataModel>>(context);
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




    List<int>exams=data.where((element) =>element.docId==(subject==null?currentSubject:subject)).toList().length==0?[]:getExamValue(data.where((element) =>element.docId==(subject==null?currentSubject:subject)).toList()[0]);
    //print(exams);
    List<int>grades=data.where((element) =>element.docId==(subject==null?currentSubject:subject)).toList().length==0?[] :getGradeValue(data.where((element) =>element.docId==(subject==null?currentSubject:subject)).toList()[0])??[];
    List<int>homework=data.where((element) =>element.docId==(subject==null?currentSubject:subject)).toList().length==0?[]:getHomeWorkValue(data.where((element) =>element.docId==(subject==null?currentSubject:subject)).toList()[0]);
    List<Chart>charts=[];
    //print(exams);
    //print(grades);
    getLenght(){
      var t=min(exams.length, grades.length);
      return min(t,homework.length);
    }
    var newlist=List.generate(getLenght(), (i) =>[exams[i],grades[i]]);
    var newgradehome=List.generate(getLenght(), (i) => [grades[i],homework[i]]);
    newlist.sort((a,b)=>a[0].compareTo(b[0]));
    newgradehome.sort((a,b)=>a[0].compareTo(b[0]));
    print(newlist);
    print(newgradehome);
    var nexams=[];
    var ngrade=[];
    var nhome=[];
    for (var i = 0; i < newlist.length; i++) {
      setState(() {
        nexams.add(newlist[i][0]);
        ngrade.add(newlist[i][1]);
        nhome.add(newgradehome[i][1]);
      });
    }
    print(nexams);
    print(ngrade);
    print(nhome);
    for (var i = 0; i < getLenght(); i++) {
      charts.add(Chart(exam: exams[i],grader: grades[i],homework: homework[i],barColor:chart.MaterialPalette.blue.shadeDefault));
    }

    currentSubject=subject==null?data[0].docId:subject;
    List<chart.Series<Chart, String>> series = [
      chart.Series(
          id: "Subscribers",
          data: charts,
          domainFn: (Chart series, _) =>currentX=="Exam"?series.exam.toString():currentX=="Grade"?series.grader.toString():series.homework.toString(),
          measureFn: (Chart series, _) =>currentY=="Grade"?int.tryParse(series.grader.toString()):currentY=="Exam"?int.parse(series.exam.toString()):int.parse(series.homework.toString()),
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
                    DropdownMenuItem(child: Text("Exam"),value: "Exam",),
                    DropdownMenuItem(child: Text("Grade"),value: "Grade",),
                    DropdownMenuItem(child: Text("HomeWorks"),value: "HomeWork",),
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
                    DropdownMenuItem(child: Text("Exam"),value: "Exam",),
                    DropdownMenuItem(child: Text("Grade"),value: "Grade",),
                    DropdownMenuItem(child: Text("HomeWorks"),value: "HomeWork",),
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
  int exam;
  int homework;
  int grader;
  chart.Color barColor;
  Chart({this.exam,this.homework,this.grader,this.barColor});
}