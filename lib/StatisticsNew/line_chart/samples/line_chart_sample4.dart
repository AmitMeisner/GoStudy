import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';





class LineChartSample4 extends StatefulWidget {
  final String course;
  final String xAxis;
  final String yAxis;
  LineChartSample4(this.course,this.xAxis, this.yAxis);
  @override
  _LineChartSample4State createState() => _LineChartSample4State(course, xAxis, yAxis);
}

class _LineChartSample4State extends State<LineChartSample4> {
  final String course;
  final String xAxis;
  final String yAxis;
  _LineChartSample4State(this.course, this.xAxis, this.yAxis);

  List<FlSpot> loadYAxis(){
    List<FlSpot> ret;
    print("Inside line chart sample 4 with " + yAxis + xAxis + course);
    return [
      FlSpot(0, 10),
      FlSpot(1, 3.5),
      FlSpot(2, 4.5),
      FlSpot(3, 1),
      FlSpot(4, 4),
      FlSpot(5, 6),
      FlSpot(6, 6.5),
      FlSpot(7, 6),
      FlSpot(8, 4),
      FlSpot(9, 6),
      FlSpot(10, 6),
      FlSpot(11, 7),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
              spots: loadYAxis(),
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
                  switch (value.toInt()) {
                    case 0:
                      return 'Jan';
                    case 1:
                      return 'Feb';
                    case 2:
                      return 'Mar';
                    case 3:
                      return 'Apr';
                    case 4:
                      return 'May';
                    case 5:
                      return 'Jun';
                    case 6:
                      return 'Jul';
                    case 7:
                      return 'Aug';
                    case 8:
                      return 'Sep';
                    case 9:
                      return 'Oct';
                    case 10:
                      return 'Nov';
                    case 11:
                      return 'Dec';
                    default:
                      return '';
                  }
                }),
            leftTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                return '\$ ${value}';
              },
            ),
          ),
          axisTitleData: FlAxisTitleData(
              leftTitle: AxisTitle(showTitle: true, titleText: 'Value', margin: 4),
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
}

