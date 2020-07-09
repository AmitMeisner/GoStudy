import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class LineChartSample7 extends StatelessWidget {
  String algoExamString = "[65,63,67,64,60,59,48,63,62,69,55,47,65,63,63,55,60,62,63,64,59,55,59,58,56,60,57,58,null,null,null,null,null,null,null,null,null,null,null,null,null]";
  String algoFGString = "[68,85,95,83,78,100,86,82,77,84,73,82,81,83,83,74,84,78,77,82,81,83,86,70,71,80,82,86,null,null,null,null,null,null,null,null,null,null,null,null,null]";
  String algoHWString = "[13,13,20,16,16,8,8,20,13,10,9,9,13,22,13,14,10,11,10,13,10,15,11,10,18,16,14,12,null,null,null,null,null,null,null,null,null,null,null,null,null]";
  String overall = "[70,82,82,82.83,85,98,76,75,80,78,81,76,79,82,85,84,80,85,82,81,85,83,82,81,80,83,84,89,86,90,72,80,80,91,70,86,79,79,73,70,70]";
  List<FlSpot> algoExamsStats = [FlSpot(0,65),FlSpot(1,63),FlSpot(2,67),FlSpot(3,64),FlSpot(4,60),FlSpot(5,59),FlSpot(6,48),FlSpot(7,63),FlSpot(8,62),FlSpot(9,69),FlSpot(10,55),FlSpot(11,47),FlSpot(12,65),FlSpot(13,63),FlSpot(14,63),FlSpot(15,55),FlSpot(16,60),FlSpot(17,62),FlSpot(18,63),FlSpot(19,64),FlSpot(20,59),FlSpot(21,55),FlSpot(22,59),FlSpot(23,58),FlSpot(24,56),FlSpot(25,60),FlSpot(26,57),FlSpot(27,58)];
  List<FlSpot> algoFGStats = [FlSpot(0,68),FlSpot(1,85),FlSpot(2,95),FlSpot(3,83),FlSpot(4,78),FlSpot(5,100),FlSpot(6,86),FlSpot(7,82),FlSpot(8,77),FlSpot(9,84),FlSpot(10,73),FlSpot(11,82),FlSpot(12,81),FlSpot(13,83),FlSpot(14,83),FlSpot(15,74),FlSpot(16,84),FlSpot(17,78),FlSpot(18,77),FlSpot(19,82),FlSpot(20,81),FlSpot(21,83),FlSpot(22,86),FlSpot(23,70),FlSpot(24,71),FlSpot(25,80),FlSpot(26,82),FlSpot(27,86)];
  List<FlSpot> algoHWStats = [FlSpot(0,13),FlSpot(1,13),FlSpot(2,20),FlSpot(3,16),FlSpot(4,16),FlSpot(5,8),FlSpot(6,8),FlSpot(7,20),FlSpot(8,13),FlSpot(9,10),FlSpot(10,9),FlSpot(11,9),FlSpot(12,13),FlSpot(13,22),FlSpot(14,13),FlSpot(15,14),FlSpot(16,10),FlSpot(17,11),FlSpot(18,10),FlSpot(19,13),FlSpot(20,10),FlSpot(21,15),FlSpot(22,11),FlSpot(23,10),FlSpot(24,18),FlSpot(25,16),FlSpot(26,14),FlSpot(27,12)];
  List<FlSpot> overallStats = [FlSpot(0,70),FlSpot(1,82),FlSpot(2,82),FlSpot(3,82.83),FlSpot(4,85),FlSpot(5,98),FlSpot(6,76),FlSpot(7,75),FlSpot(8,80),FlSpot(9,78),FlSpot(10,81),FlSpot(11,76),FlSpot(12,79),FlSpot(13,82),FlSpot(14,85),FlSpot(15,84),FlSpot(16,80),FlSpot(17,85),FlSpot(18,82),FlSpot(19,81),FlSpot(20,85),FlSpot(21,83),FlSpot(22,82),FlSpot(23,81),FlSpot(24,80),FlSpot(25,83),FlSpot(26,84),FlSpot(27,89)];
  List overallAverage;
  void initData(){
    overallAverage = json.decode(overall);
  }
  @override
  Widget build(BuildContext context) {
    initData();
    return AspectRatio(
      aspectRatio: 2.1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: true),
            lineBarsData: [
              LineChartBarData(
                spots: algoExamsStats,
                isCurved: true,
                barWidth: 2,
                colors: [
                  Colors.green,
                ],
                dotData: FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: algoFGStats,
                isCurved: true,
                barWidth: 2,
                colors: [
                  Colors.black,
                ],
                dotData: FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: algoHWStats,
                isCurved: false,
                barWidth: 2,
                colors: [
                  Colors.red,
                ],
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
            betweenBarsData: [
              BetweenBarsData(
                fromIndex: 0,
                toIndex: 2,
                colors: [Colors.red.withOpacity(0.3)],
              )
            ],
            minY: 0,
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                  showTitles: true,
                  textStyle:
                      TextStyle(fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold),
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
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (double value) {
                return value == 1 || value == 6 || value == 4 || value == 5;
              },
            ),
          ),
        ),
      ),
    );
  }

  String relevantData(double value) {

    return overallAverage[value.toInt()].toString();

  }
}
