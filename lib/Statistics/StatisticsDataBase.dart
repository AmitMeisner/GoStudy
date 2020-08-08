import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:number_display/number_display.dart';
import 'dark_theme_script.dart' show darkThemeScript;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

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


class StatisticsDataBase {
  final int itemsCount;
  final List<String> coursesSelected;
  final List<String> criteriasSelected;
  double total = 0.0;
  StatisticsDataBase(this.itemsCount, this.coursesSelected,
      this.criteriasSelected);



   static String removeFirstCharacter(String str) {
    String result = null;
    if ((str != null) && (str.length > 0)) {
      result = str.substring(1, str.length );
    }

    return result;
  }
  static Future<String> queryValues(String course, String resource) async{
    String total = "";
    String tempString;
    String tempTotal2;
    Firestore.instance
        .collection('AllUsers')
        .where('course', isEqualTo: course)
        .snapshots()
        .listen((snapshot) {
      String tempTotal = snapshot.documents.fold("", (tot, doc) => tot +"," +doc.data[resource].toString());
      tempTotal2 = removeFirstCharacter(tempTotal);
      tempTotal = "["+tempTotal2+"]";
      tempString=tempTotal;
      print(tempTotal);
      return tempTotal;

    });
    print(tempString);
    return tempString;
  }


}


class DataModel{
  String exam;
  String homework;
  String grade;
  String docId;
  DataModel({this.exam,this.grade,this.homework,this.docId});
  DataModel.fromJson(Map<String,dynamic>data,String id)
      :exam=data['Exams'],
        docId=id,
        grade=data['Final Grade'],
        homework=data['Homeworks'];
}

class DataService {
  Firestore firestore = Firestore.instance;

  Stream<List<DataModel>> getData() {
    return firestore.collection("Statistics").snapshots().map((sanpshot) =>
        sanpshot.documents.map((e) => DataModel.fromJson(e.data,e.documentID)).toList());
  }
}

