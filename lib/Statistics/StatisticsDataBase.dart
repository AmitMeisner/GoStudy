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

//https://pub.dev/packages/flutter_echarts

final display = createDisplay(decimal: 2);

class StatisticsDataBase{
  final int itemsCount;
  final List<String> coursesSelected;
  final List<String> criteriasSelected;
  StatisticsDataBase(this.itemsCount, this.coursesSelected, this.criteriasSelected);

  Widget returnGraphFromApi(){

  }
}