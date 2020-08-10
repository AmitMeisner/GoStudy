import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Rank/Rank.dart';
import '../Global.dart';
import 'Progress.dart';


class ProgressPageNav extends StatefulWidget {
  final Widget child;
  ProgressPageNav({Key key, this.child}) : super(key: key);
  _ProgressPageNavState createState() => _ProgressPageNavState();
}




class _ProgressPageNavState extends State<ProgressPageNav> {



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: AppBar(
              backgroundColor: Global.getBackgroundColor(0),
              bottom: TabBar(
//                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 2.0,
              tabs: <Widget>[
                Tab(
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Progress"),
                        SizedBox(width: 4.0,),
                        Icon(
                          Icons.trending_up,
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Rank"),
                        SizedBox(width: 4.0,),
                        Icon(
                          Icons.table_chart,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
              ),
          ),
            body:TabBarView(
              children: <Widget>[
                ProgressPage(),
                Rank(),
              ],
          )
            ),
      ),
    );
  }

}