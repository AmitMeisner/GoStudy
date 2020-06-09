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
    return GroupedBarChart(GroupedBarChart._createSampleData());

  }
}