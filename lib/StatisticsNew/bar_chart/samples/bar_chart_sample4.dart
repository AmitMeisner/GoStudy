//import 'package:fl_chart/fl_chart.dart';
//import 'package:flutter/material.dart';
//import 'package:flutterapp/firebase/FirebaseAPI.dart';
//
//class BarChartSample4 extends StatefulWidget {
//  final   List<UserStatForCourse> _usersData;
//  BarChartSample4(this._usersData);
//  @override
//  State<StatefulWidget> createState() => BarChartSample4State(_usersData);
//}
//
//class BarChartSample4State extends State<BarChartSample4> {
//  final Color dark = const Color(0xff3b8c75);
//  final Color normal = const Color(0xff64caad);
//  final Color light = const Color(0xff73e8c9);
//  final   List<UserStatForCourse> _usersData;
//
//  BarChartSample4State(this._usersData);
//
//  @override
//  Widget build(BuildContext context) {
//    return AspectRatio(
//      aspectRatio: 2.1,
//      child: Card(
//        elevation: 4,
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//        color: Colors.white,
//        child: Padding(
//          padding: const EdgeInsets.only(top: 16.0),
//          child: BarChart(
//            BarChartData(
//              alignment: BarChartAlignment.center,
//              barTouchData: BarTouchData(
//                enabled: true,
//              ),
//              titlesData: FlTitlesData(
//                show: true,
//                bottomTitles: SideTitles(
//                  showTitles: true,
//                  textStyle: const TextStyle(color: Color(0xff939393), fontSize: 10),
//                  margin: 10,
//                  getTitles: (double value) {
//                    switch (value.toInt()) {
//                      case 0:
//                        return '60';
//                      case 1:
//                        return '65';
//                      case 2:
//                        return '70';
//                      case 3:
//                        return '75';
//                      case 4:
//                        return '80';
//                      case 5:
//                        return '85';
//                      case 6:
//                        return '90';
//                      case 7:
//                        return '95';
//                      case 8:
//                        return '100';
//                      default:
//                        return '';
//                    }
//                  },
//                ),
//                leftTitles: SideTitles(
//                  showTitles: true,
//                  textStyle: const TextStyle(
//                      color: Color(
//                        0xff939393,
//                      ),
//                      fontSize: 10),
//                  margin: 0,
//                ),
//              ),
//              gridData: FlGridData(
//                show: true,
//                checkToShowHorizontalLine: (value) => value % 10 == 0,
//                getDrawingHorizontalLine: (value) => FlLine(
//                  color: const Color(0xffe7e8ec),
//                  strokeWidth: 1,
//                ),
//              ),
//              borderData: FlBorderData(
//                show: false,
//              ),
//              groupsSpace: 4,
//              barGroups: getData(),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  List<BarChartGroupData> getData() {
//    return [
//      BarChartGroupData(
//        x: 0,
//        barsSpace: 4,
//        barRods: [
//          BarChartRodData(
//              y: 17000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 2000000000, dark),
//                BarChartRodStackItem(2000000000, 12000000000, normal),
//                BarChartRodStackItem(12000000000, 17000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 24000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 13000000000, dark),
//                BarChartRodStackItem(13000000000, 14000000000, normal),
//                BarChartRodStackItem(14000000000, 24000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 23000000000.5,
//              rodStackItem: [
//                BarChartRodStackItem(0, 6000000000.5, dark),
//                BarChartRodStackItem(6000000000.5, 18000000000, normal),
//                BarChartRodStackItem(18000000000, 23000000000.5, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 29000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 9000000000, dark),
//                BarChartRodStackItem(9000000000, 15000000000, normal),
//                BarChartRodStackItem(15000000000, 29000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 32000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 2000000000.5, dark),
//                BarChartRodStackItem(2000000000.5, 17000000000.5, normal),
//                BarChartRodStackItem(17000000000.5, 32000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//        ],
//      ),
//      BarChartGroupData(
//        x: 1,
//        barsSpace: 4,
//        barRods: [
//          BarChartRodData(
//              y: 31000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 11000000000, dark),
//                BarChartRodStackItem(11000000000, 18000000000, normal),
//                BarChartRodStackItem(18000000000, 31000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 35000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 14000000000, dark),
//                BarChartRodStackItem(14000000000, 27000000000, normal),
//                BarChartRodStackItem(27000000000, 35000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 31000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 8000000000, dark),
//                BarChartRodStackItem(8000000000, 24000000000, normal),
//                BarChartRodStackItem(24000000000, 31000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 15000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 6000000000.5, dark),
//                BarChartRodStackItem(6000000000.5, 12000000000.5, normal),
//                BarChartRodStackItem(12000000000.5, 15000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 17000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 9000000000, dark),
//                BarChartRodStackItem(9000000000, 15000000000, normal),
//                BarChartRodStackItem(15000000000, 17000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//        ],
//      ),
//      BarChartGroupData(
//        x: 2,
//        barsSpace: 4,
//        barRods: [
//          BarChartRodData(
//              y: 34000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 6000000000, dark),
//                BarChartRodStackItem(6000000000, 23000000000, normal),
//                BarChartRodStackItem(23000000000, 34000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 32000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 7000000000, dark),
//                BarChartRodStackItem(7000000000, 24000000000, normal),
//                BarChartRodStackItem(24000000000, 32000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 14000000000.5,
//              rodStackItem: [
//                BarChartRodStackItem(0, 1000000000.5, dark),
//                BarChartRodStackItem(1000000000.5, 12000000000, normal),
//                BarChartRodStackItem(12000000000, 14000000000.5, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 20000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 4000000000, dark),
//                BarChartRodStackItem(4000000000, 15000000000, normal),
//                BarChartRodStackItem(15000000000, 20000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 24000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 4000000000, dark),
//                BarChartRodStackItem(4000000000, 15000000000, normal),
//                BarChartRodStackItem(15000000000, 24000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//        ],
//      ),
//      BarChartGroupData(
//        x: 3,
//        barsSpace: 4,
//        barRods: [
//          BarChartRodData(
//              y: 14000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 1000000000.5, dark),
//                BarChartRodStackItem(1000000000.5, 12000000000, normal),
//                BarChartRodStackItem(12000000000, 14000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 27000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 7000000000, dark),
//                BarChartRodStackItem(7000000000, 25000000000, normal),
//                BarChartRodStackItem(25000000000, 27000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 29000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 6000000000, dark),
//                BarChartRodStackItem(6000000000, 23000000000, normal),
//                BarChartRodStackItem(23000000000, 29000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 16000000000.5,
//              rodStackItem: [
//                BarChartRodStackItem(0, 9000000000, dark),
//                BarChartRodStackItem(9000000000, 15000000000, normal),
//                BarChartRodStackItem(15000000000, 16000000000.5, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//          BarChartRodData(
//              y: 15000000000,
//              rodStackItem: [
//                BarChartRodStackItem(0, 7000000000, dark),
//                BarChartRodStackItem(7000000000, 12000000000.5, normal),
//                BarChartRodStackItem(12000000000.5, 15000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
//        ],
//      ),
//    ];
//  }
//
//
//  List<BarChartGroupData> getData1() {
//    List<BarChartGroupData> res=[];
//    int i=0;
//    for(UserStatForCourse userData in _usersData){
//      if(i>8){return res;}
//      res.add(BarChartGroupData(
//        x: i,
//        barsSpace: 0,
//        barRods: [
//          BarChartRodData(
//              y:  30,
//              rodStackItem: [
//                BarChartRodStackItem(0, _usersData[i].getHWTime(), dark),
//                BarChartRodStackItem(_usersData[i].getHWTime(), 100, Colors.white),
////                BarChartRodStackItem(12000000000, 17000000000, light),
//              ],
//              borderRadius: const BorderRadius.all(Radius.zero)),
////          BarChartRodData(
////              y: 24000000000,
////              rodStackItem: [
////                BarChartRodStackItem(0, 13000000000, dark),
////                BarChartRodStackItem(13000000000, 14000000000, normal),
////                BarChartRodStackItem(14000000000, 24000000000, light),
////              ],
////              borderRadius: const BorderRadius.all(Radius.zero)),
////          BarChartRodData(
////              y: 23000000000.5,
////              rodStackItem: [
////                BarChartRodStackItem(0, 6000000000.5, dark),
////                BarChartRodStackItem(6000000000.5, 18000000000, normal),
////                BarChartRodStackItem(18000000000, 23000000000.5, light),
////              ],
////              borderRadius: const BorderRadius.all(Radius.zero)),
////          BarChartRodData(
////              y: 29000000000,
////              rodStackItem: [
////                BarChartRodStackItem(0, 9000000000, dark),
////                BarChartRodStackItem(9000000000, 15000000000, normal),
////                BarChartRodStackItem(15000000000, 29000000000, light),
////              ],
////              borderRadius: const BorderRadius.all(Radius.zero)),
////          BarChartRodData(
////              y: 32000000000,
////              rodStackItem: [
////                BarChartRodStackItem(0, 2000000000.5, dark),
////                BarChartRodStackItem(2000000000.5, 17000000000.5, normal),
////                BarChartRodStackItem(17000000000.5, 32000000000, light),
////              ],
////              borderRadius: const BorderRadius.all(Radius.zero)),
//        ],
//      ));
//      i++;
//    }
//    return res;
//  }
//}
