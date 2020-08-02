//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
//
//class infoBlock extends StatefulWidget {
//
//  infoBlockState createState() => infoBlockState();
//}
//
//
//class infoBlockState extends State<infoBlock> {
//
//
//  Widget build(BuildContext context) {
//    return Column(
//        children: <Widget>[
//          Title(),
//          body()
//        ],
//      );
//  }
//
//  Widget body(){
//    return Container(
//      child: Row(
//      children: <Widget>[
//       leftSide(),
//        Spacer(),
//        Container(
//          decoration: BoxDecoration(
//              image: DecorationImage(
//                  image:AssetImage("images/CLOCK-copy.jpg"),
//                  fit:BoxFit.fill
//              )
//          ),
//          height: MediaQuery.of(context).size.height/3,
//          width: MediaQuery.of(context).size.width/3,
//        ),
//      ],
//      ),
//    );
//  }
//
//  Widget leftSide(){
//    return Container(
//        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
//      child: Column(
//        children: <Widget>[
//          infoData1(),
//          infoData2(),
//        ],
//      )
//    );
//  }
//
//
//  Widget Title(){
//    return Container(
//        margin: const EdgeInsets.only(left: 0, right: 0,top: 10),
//      height: 50,
//      width: 250,
//      child: Text("YOU ARE THE MASTER OF YOUR DATA !", textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey)),
//    );
//  }
//
//  Widget infoData1(){
//    return Container(
//      decoration: myBoxDecoration(),
//      margin: const EdgeInsets.only(left: 0, right: 0,top: 10),
//      height: 50,
//      width: 200,
//      child: Text("THIS WEEK YOU STUDIED: ", textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.red)),
//    );
//  }
//
//
//  Widget infoData2(){
//    return Container(
//      decoration: myBoxDecoration(),
//      margin: const EdgeInsets.only(left: 0, right: 0,top: 10),
//      height: 50,
//      width: 200,
//      child: Text("THIS MONTH YOU STUDIED: ", textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.red)),
//    );
//  }
//
//  BoxDecoration myBoxDecoration() {
//    return BoxDecoration(
//      borderRadius:BorderRadius.circular(25),
//      border: Border.all(
//        width: 3,
//        color: Colors.blueGrey ,
//        //                   <--- border width here
//      ),
//    );
//  }
//}