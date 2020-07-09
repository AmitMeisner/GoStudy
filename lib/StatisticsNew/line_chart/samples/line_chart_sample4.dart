import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:table_calendar/table_calendar.dart';






class LineChartSample4 extends StatefulWidget {

  @override
  _LineChartSample4State createState() => _LineChartSample4State();
}

class _LineChartSample4State extends State<LineChartSample4> {
  String algoExamString = "[65,63,67,64,60,59,48,63,62,69,55,47,65,63,63,55,60,62,63,64,59,55,59,58,56,60,57,58,null,null,null,null,null,null,null,null,null,null,null,null,null]";
  String algoFGString = "[68,85,95,83,78,100,86,82,77,84,73,82,81,83,83,74,84,78,77,82,81,83,86,70,71,80,82,86,null,null,null,null,null,null,null,null,null,null,null,null,null]";
  String algoHWString = "[13,13,20,16,16,8,8,20,13,10,9,9,13,22,13,14,10,11,10,13,10,15,11,10,18,16,14,12,null,null,null,null,null,null,null,null,null,null,null,null,null]";
  List exams;
  List finalGrades;
  List<FlSpot> algoExamsStats = [FlSpot(0,65),FlSpot(1,67),FlSpot(2,64),FlSpot(3,60),FlSpot(4,59),FlSpot(5,48),FlSpot(6,63),FlSpot(7,62),FlSpot(8,69),FlSpot(9,55),FlSpot(10,47),FlSpot(11,65),FlSpot(12,63),FlSpot(13,63),FlSpot(14,55),FlSpot(15,63)];
  List<FlSpot> algoFGStats;
  List<FlSpot> algoHWStats;

  void initData(){
    exams = json.decode(algoExamString);
    finalGrades = json.decode(algoFGString);
    List homework = json.decode(algoHWString);
  }


  @override
  Widget build(BuildContext context) {
    initData();
    const cutOffYValue = 5.0;
    const dateTextStyle =
    TextStyle(fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold);

    return AspectRatio(
      aspectRatio: 2.1,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: algoExamsStats,
              isCurved: true,
              barWidth: 5,
              colors: [
                Colors.purpleAccent,
              ],
              belowBarData: BarAreaData(
                show: true,
                colors: [Colors.deepPurple.withOpacity(0.4)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              aboveBarData: BarAreaData(
                show: true,
                colors: [Colors.orange.withOpacity(0.6)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 14,
                textStyle: dateTextStyle,
                getTitles: (value) {
                  return relevantData(value);
                }),
            leftTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                return '${value}';
              },
            ),
          ),
          axisTitleData: FlAxisTitleData(
              leftTitle: AxisTitle(showTitle: true, titleText: 'Exam Hours', margin: 4),
              bottomTitle: AxisTitle(
                  showTitle: true,
                  margin: 0,
                  titleText: '2019',
                  textStyle: dateTextStyle,
                  textAlign: TextAlign.right)),
          gridData: FlGridData(
            show: true,
            checkToShowHorizontalLine: (double value) {
              return value == 1 || value == 6 || value == 4 || value == 5;
            },
          ),
        ),
      ),
    );
  }

  String relevantData(double value) {

    return finalGrades[value.toInt()].toString();

  }
}

