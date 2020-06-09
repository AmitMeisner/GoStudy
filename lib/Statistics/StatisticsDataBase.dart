import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:flutter/src/painting/edge_insets.dart';
import 'package:flutterapp/Tips/CoursesMultiChoice.dart';
import 'package:flutterapp/Tips/Tips.dart';
import 'package:flutterapp/Courses.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:number_display/number_display.dart';
//import 'package:nu';

import 'liquid_script.dart' show liquidScript;
import 'gl_script.dart' show glScript;
import 'dark_theme_script.dart' show darkThemeScript;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

final display = createDisplay(decimal: 2);

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {this.animate});

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
  static List<charts.Series<OrdinalSales, String>> _myCreateSampleData() {
    final desktopSalesData = [
      new OrdinalSales('Calculus 1', 80),
      new OrdinalSales('Calculus 2', 85),
      new OrdinalSales('Discrete', 90),
      new OrdinalSales('CS 101', 100),
    ];

    final tableSalesData = [
      new OrdinalSales('Calculus 1', 92),
      new OrdinalSales('Calculus 2', 81),
      new OrdinalSales('Discrete', 79),
      new OrdinalSales('CS 101', 90),
    ];

    final mobileSalesData = [
      new OrdinalSales('Calculus 1', 83),
      new OrdinalSales('Calculus 2', 82),
      new OrdinalSales('Discrete', 86),
      new OrdinalSales('CS 101', 95),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}


/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}


class StatisticsDataBase{
  final int itemsCount;
  final List<String> coursesSelected;
  final List<String> criteriasSelected;
  StatisticsDataBase(this.itemsCount, this.coursesSelected, this.criteriasSelected);

  Widget returnGraphFromApi(){
    if (this.itemsCount % 3 == 0){
      return Container(
        child: Echarts(
          extensions: [darkThemeScript],
          theme: 'dark',
          option: '''
                    {
                      legend: {
                        data: ['Homework', 'Recitations', 'Exams', 'Else', 'Lectures']
                      },
                      grid: {
                        left: '3%',
                        right: '8%',
                        bottom: '3%',
                        containLabel: true
                      },
                      xAxis: {
                        type: 'value'
                      },
                      yAxis: {
                        type: 'category',
                        data: ['Calculus 1', 'Calculus 2', 'CS 101', 'Discrete Math', 'Workshop', 'Compilation', 'Complexity']
                      },
                      series: [
                        {//
                          name: 'Homework',
                          type: 'bar',
                          stack: 'total',
                          data: [8, 7, 4, 10, 7, 8, 11]
                        },
                        {
                          name: 'Recitations',
                          type: 'bar',
                          stack: 'total',
                          data: [4, 4, 4, 8, 6, 5, 8]
                        },
                        {
                          name: 'Exams',
                          type: 'bar',
                          stack: 'total',
                          data: [7, 5, 6, 8, 7, 3, 9]
                        },
                        {
                          name: 'Else',
                          type: 'bar',
                          stack: 'total',
                          data: [8, 9, 4, 8, 5, 4, 4]
                        },
                        {
                          name: 'Lectures',
                          type: 'bar',
                          stack: 'total',
                          data: [6, 6, 6, 6, 3, 7, 8]
                        }
                      ]
                    }
                  ''',
        ),
        width: 300,
        height: 250,
      );
    }
    if (this.itemsCount % 3 == 1){
      return GroupedBarChart(GroupedBarChart._myCreateSampleData());
    }
    return GroupedBarChart(GroupedBarChart._createSampleData());

  }
}