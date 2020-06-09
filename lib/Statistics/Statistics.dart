import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:flutter/src/painting/edge_insets.dart';
import 'package:flutterapp/Tips/CoursesMultiChoice.dart';
import 'package:flutterapp/Tips/Tips.dart';
import 'package:flutterapp/Statistics/StatisticsDataBase.dart';
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


class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> usersTags = TipsPage.usersTags;
  List myList;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 10;
  List<String> courses=Courses().getAllCourses();
  List<String> criterias = new List<String>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var lastSevenDaysData;
  var data1 = [0.0,-2.0,3.5,-2.0,0.5,0.7,0.8,1.0,2.0,3.0,3.2];

  getLastSevenDaysData() async {
    //await Future.delayed(Duration(seconds: 4));
    //Dynamically load last 7 days of user's progress and load them into last seven days variable
    lastSevenDaysData = [0.0, 1.0, 2.0, 1.75, 1.5, 0.0, 1.0, 1.5, 0.0, 0.0, 2.0];
  }
  

  void updateState(){
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    myList = List.generate(10, (i) => "Item : ${i + 1}");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    this.getLastSevenDaysData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget chip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade600,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
    );
  }

  Sparkline lastSevenDaysSparkline(){
    //return last 7 days of progress in a sparkline form.
    return new Sparkline(
      data: lastSevenDaysData,
      lineColor: Color(0xffff6101),
      pointsMode: PointsMode.all,
      pointSize: 8.0,
    );
  }
  Material WeeklyProgressCard(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(5.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(title, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),),
                  ),
                  SizedBox(height:20.0),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Container(
                        height: 60,
                        width: 300,
                        child: lastSevenDaysSparkline()
                    ),
                  ),
                  SizedBox(height:15.0),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Material mychart2Items(String title, String priceVal,String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 0.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(title, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(subtitle, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueGrey,
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: data1,
                      fillMode: FillMode.below,
                      fillGradient: new LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.amber[800], Colors.amber[200]],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getMoreData() {
    for (int i = _currentMax; i < _currentMax + 10; i++) {
      myList.add("Item : ${i + 1}");
    }

    _currentMax = _currentMax + 10;

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: CollapsingList(),
    );
  }
}



class Graphs extends StatefulWidget {
  @override
  _GraphsState createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  List<String> items = new List.generate(100, (index) => 'Hello $index');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Map<String, Object>> _data1 = [{ 'name': 'Please wait', 'value': 0 }];

  getData1() async {

    const dataObj = [{
      'name': 'Jan',
      'value': 8726.2453,
    }, {
      'name': 'Feb',
      'value': 2445.2453,
    }, {
      'name': 'Mar',
      'value': 6636.2400,
    }, {
      'name': 'Apr',
      'value': 4774.2453,
    }, {
      'name': 'May',
      'value': 1066.2453,
    }, {
      'name': 'Jun',
      'value': 4576.9932,
    }, {
      'name': 'Jul',
      'value': 8926.9823,
    }];

    this.setState(() { this._data1 = dataObj;});
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemExtent: 80,
        itemBuilder: (context, i){
          return ListTile(
            title: Container(
              height: 50,
              width: 50,
              child: Text('DEBUG')
            ),
          );
        }
      ),
    );
  }
}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;


  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}





class ChipsFirstBar extends StatefulWidget {

  static Function firstBarUpdateState;
  @override
  _ChipsFirstBar createState() => _ChipsFirstBar();
}

class _ChipsFirstBar extends State<ChipsFirstBar> {
  firstBarUpdateState(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    ChipsFirstBar.firstBarUpdateState = firstBarUpdateState;

    if (ChipsSecondBar.graphsBeingDisplayed){
      return EmptyChipsChoice();
    }
    return CoursesChipsChoice();
  }
}




List<String> ListSubtraction(List<String> allCourses, List<String> userCourses) {

  List<String> returnList = []..addAll(allCourses);
  for(int i=0;i<userCourses.length;i++){
    if (returnList.contains(userCourses[i])){
      returnList.remove(userCourses[i]);
    }
  }
  return returnList;
}



void clearDisplayedGraphs(){
  LoadMoreGraphsButton.graphsList.clear();
  LoadMoreGraphsButton.counter = 0 ;
}


class CriteriasChipsChoice extends StatefulWidget {
  static List<String> criteriasSelected = [];
  @override
  _CriteriasChipsChoiceState createState() => _CriteriasChipsChoiceState();
}


class _CriteriasChipsChoiceState extends State<CriteriasChipsChoice> {

  List<String> criterias = Courses().criterias;

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<String>.multiple(
      value: CriteriasChipsChoice.criteriasSelected,
      options: ChipsChoiceOption.listFrom<String, String>(
        source: criterias,
        value: (i, v) {
          return v;
        },
        label: (i, v) => v,
      ),
      onChanged: (val) {
        print(val);
        clearDisplayedGraphs();
        CLPicking.statsPageUpdateState();
        setState(() {
          return CriteriasChipsChoice.criteriasSelected = val;
        });
      },
      itemConfig: ChipsChoiceItemConfig(
        selectedColor: Colors.green,
        unselectedColor: Colors.black87,
        showCheckmark: true,
      ),
    );
  }
}

class EmptyChipsChoice extends StatefulWidget {
  @override
  _EmptyChipsChoiceState createState() => _EmptyChipsChoiceState();
}

class _EmptyChipsChoiceState extends State<EmptyChipsChoice> {
  List<String> emptyList = [];

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<String>.multiple(
      value: emptyList,
      options: ChipsChoiceOption.listFrom<String, String>(
        source: emptyList,
        value: (i, v) {
          return v;
        },
        label: (i, v) => v,
      ),
      onChanged: (val) {
      },
      itemConfig: ChipsChoiceItemConfig(
        selectedColor: Colors.green,
        unselectedColor: Colors.black87,
        showCheckmark: true,
      ),
    );
  }
}


class CoursesChipsChoice extends StatefulWidget {
  static List<String> coursesSelected = [];
  @override
  _CoursesChipsChoiceState createState() => _CoursesChipsChoiceState();
}

class _CoursesChipsChoiceState extends State<CoursesChipsChoice> {

  List<String> userCourses=Courses().getUserCourses();
  List<String> allCourses = Courses().getAllCourses();
  List<String> otherCourses;

  void _initResources(){
    otherCourses = ListSubtraction(allCourses, userCourses);
  }


  @override
  Widget build(BuildContext context) {
    _initResources();
    return ChipsChoice<String>.multiple(
      value: CoursesChipsChoice.coursesSelected,
      options: ChipsChoiceOption.listFrom<String, String>(
        source: userCourses + otherCourses,
        value: (i, v) {
          return v;
        },
        label: (i, v) => v,
      ),
      onChanged: (val) {
        print(val);
        clearDisplayedGraphs();
        CLPicking.statsPageUpdateState();
        setState(() {
          return CoursesChipsChoice.coursesSelected = val;
        });

      },
      itemConfig: ChipsChoiceItemConfig(
        selectedColor: Colors.green,
        unselectedColor: Colors.black87,
        showCheckmark: true,
      ),
    );
  }
  }





class ChipsSecondBar extends StatefulWidget {
  static  List<ChipsChoice<String>> courseChoices;
  static Function secondBarUpdateState;
  static bool graphsBeingDisplayed = false;
  @override
  _ChipsSecondBar createState() => _ChipsSecondBar();
}
class _ChipsSecondBar extends State<ChipsSecondBar> {

  secondBarUpdateState(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    ChipsSecondBar.secondBarUpdateState = secondBarUpdateState;

    if (ChipsSecondBar.graphsBeingDisplayed){
      return EmptyChipsChoice();
    }
    return CriteriasChipsChoice();
  }
}




class RefreshGraphsButton extends StatefulWidget {
  final Function statsPageUpdateState;
  RefreshGraphsButton(this.statsPageUpdateState);
  @override
  _RefreshGraphsButtonState createState() => _RefreshGraphsButtonState(statsPageUpdateState);
}

class _RefreshGraphsButtonState extends State<RefreshGraphsButton> {
  final Function statsPageUpdateState;
  _RefreshGraphsButtonState(this.statsPageUpdateState);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 28,
      child: FloatingActionButton(
          child: new Icon(Icons.clear),
          backgroundColor: new Color(0xFFE57373),
          onPressed: (){
            clearDisplayedGraphs();
            this.statsPageUpdateState();
          },
      ),
    );
  }
}
class MyGraph extends StatelessWidget {
  StatisticsDataBase dbApi = new StatisticsDataBase(LoadMoreGraphsButton.counter,CoursesChipsChoice.coursesSelected,  CriteriasChipsChoice.criteriasSelected);
  @override
  Widget build(BuildContext context) {
    return dbApi.returnGraphFromApi();
  }
}


class LoadMoreGraphsButton extends StatefulWidget {
  static List<Widget> graphsList = [];
  static int counter = 0;
  final Function statsPageUpdateState;

  LoadMoreGraphsButton(this.statsPageUpdateState);

  @override
  _LoadMoreGraphsButtonState createState() => _LoadMoreGraphsButtonState(statsPageUpdateState);
}

class _LoadMoreGraphsButtonState extends State<LoadMoreGraphsButton> {

  final Function statsPageUpdateState;

  _LoadMoreGraphsButtonState(this.statsPageUpdateState);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(
          child: ButtonTheme(
            minWidth: 10.0,
            height: 5.0,
            child: FloatingActionButton.extended(
              onPressed: () {

                setState((){
                  LoadMoreGraphsButton.counter ++;
                  LoadMoreGraphsButton.graphsList.add(MyGraph());
                });
                this.statsPageUpdateState();


                //updating the bars state after clicking Load (potentionally hiding, not full made decision)
                //ChipsSecondBar.graphsBeingDisplayed = true;
                //ChipsSecondBar.secondBarUpdateState();

                //this.barsSectionUpdateState();
                print(LoadMoreGraphsButton);
                },
              icon: Icon(Icons.replay),
              label:
                  Text("Load graphs"),
            ),
          ),
      ),
      margin: EdgeInsets.all(8.0)
    );
  }
}

class ActionRow extends StatefulWidget {
  final Function statsPageUpdateState;

  ActionRow(this.statsPageUpdateState);
  @override
  _ActionRowState createState() => _ActionRowState(statsPageUpdateState);
}

class _ActionRowState extends State<ActionRow> {

  final Function statsPageUpdateState;
  _ActionRowState(this.statsPageUpdateState);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoadMoreGraphsButton(statsPageUpdateState),
        SizedBox(width: 10),
        RefreshGraphsButton(statsPageUpdateState),
      ]
    );
  }
}

class CLPicking extends StatefulWidget {
  static Function statsPageUpdateState;
  @override
  _CLPickingState createState() => _CLPickingState();
}

class _CLPickingState extends State<CLPicking> {
  var lastSevenDaysData;
  int numberOfItems = 11;
  ScrollController _scrollController = ScrollController();
  SliverPersistentHeader makeChipsOptions(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 120.0,
        maxHeight: 120.0,
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              ChipsFirstBar(),
              ChipsSecondBar(),
            ],
          ),
        ),
      ),
    );
  }
  Sparkline lastSevenDaysSparkline(){
    //return last 7 days of progress in a sparkline form.
    return new Sparkline(
      data: lastSevenDaysData,
      lineColor: Color(0xffff6101),
      pointsMode: PointsMode.all,
      pointSize: 8.0,
    );
  }

  Material WeeklyProgressCard(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(5.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(title, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),),
                  ),
                  SizedBox(height:20.0),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Container(
                        height: 60,
                        width: 300,
                        child: lastSevenDaysSparkline()
                    ),
                  ),
                  SizedBox(height:15.0),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getLastSevenDaysData(

      ) async {
    //await Future.delayed(Duration(seconds: 4));
    //Dynamically load last 7 days of user's progress and load them into last seven days variable
    lastSevenDaysData = [0.0, 1.0, 2.0, 1.75, 1.5, 0.0, 1.0, 1.5, 0.0, 0.0, 2.0];
  }

  void updateState(){
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    CLPicking.statsPageUpdateState = updateState;
    this.getLastSevenDaysData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _getMoreItems();
      }
    });
  }

  void _getMoreItems(){

  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(

      slivers: <Widget>[
        SliverAppBar(
          title: Text('Statistics'),
        ),
        makeChipsOptions('Debug'),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            [
              WeeklyProgressCard('Last Week\'s Progress'),
            ],
          ),
        ),


        SliverFixedExtentList(
            itemExtent: 50.0,
            delegate:
            SliverChildListDelegate(
                LoadMoreGraphsButton.graphsList + [ActionRow(updateState)]

            )
        ),
      ],
    );
  }
}

class CLScrolling extends StatefulWidget {
  @override
  _CLScrollingState createState() => _CLScrollingState();
}

class _CLScrollingState extends State<CLScrolling> {
  var lastSevenDaysData;
  int numberOfItems = 11;
  ScrollController _scrollController = ScrollController();
  SliverPersistentHeader makeChipsOptions(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 120.0,
        maxHeight: 120.0,
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              ChipsFirstBar(),
              ChipsSecondBar(),
            ],
          ),
        ),
      ),
    );
  }
  Sparkline lastSevenDaysSparkline(){
    //return last 7 days of progress in a sparkline form.
    return new Sparkline(
      data: lastSevenDaysData,
      lineColor: Color(0xffff6101),
      pointsMode: PointsMode.all,
      pointSize: 8.0,
    );
  }

  Material WeeklyProgressCard(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(5.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(title, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),),
                  ),
                  SizedBox(height:20.0),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Container(
                        height: 60,
                        width: 300,
                        child: lastSevenDaysSparkline()
                    ),
                  ),
                  SizedBox(height:15.0),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getLastSevenDaysData(

      ) async {
    //await Future.delayed(Duration(seconds: 4));
    //Dynamically load last 7 days of user's progress and load them into last seven days variable
    lastSevenDaysData = [0.0, 1.0, 2.0, 1.75, 1.5, 0.0, 1.0, 1.5, 0.0, 0.0, 2.0];
  }

  void updateState(){
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    this.getLastSevenDaysData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _getMoreItems();
      }
    });
  }

  void _getMoreItems(){

  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(

      slivers: <Widget>[
        SliverAppBar(
          title: Text('Statistics'),
        ),
        makeChipsOptions('Debug'),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            [
              WeeklyProgressCard('Last Week\'s Progress'),
            ],
          ),
        ),

        SliverFixedExtentList(
          itemExtent: 25.0,
          delegate: SliverChildListDelegate(
            [

            ],
          ),
        ),

        SliverFixedExtentList(
            itemExtent: 50.0,
            delegate:
            SliverChildListDelegate(
                LoadMoreGraphsButton.graphsList + [ActionRow(updateState)]

            )
        ),
      ],
    );
  }
}


class CollapsingList extends StatefulWidget {
  static Function updateState;
  @override
  _CollapsingListState createState() => _CollapsingListState();
}
class _CollapsingListState extends State<CollapsingList> {

  clUpdateState(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    CollapsingList.updateState = clUpdateState();
    if  (ChipsSecondBar.graphsBeingDisplayed){
      return CLScrolling();
    }
    return CLPicking();
  }
}
/*back up*/
//delegate:
//SliverChildBuilderDelegate((BuildContext context, int index) {
//return new Container(
//child: new Text('List item $index'),
//);
//},
//childCount: numberOfItems,
//)
//StaggeredGridView.count(
//crossAxisCount: 4,
//crossAxisSpacing: 6.0,
//mainAxisSpacing: 6.0,
//children: <Widget>[
//Padding(
//padding: const EdgeInsets.all(6.0),
//child: mychart1Items("Last Weeks Progress","421.3M","+12.9% of target"),
//),
//Padding(
//padding: const EdgeInsets.all(6.0),
//child: myCircularItems("Quarterly Profits","68.7M"),
//),
//Padding(
//padding: const EdgeInsets.only(right:6.0),
//child: myTextItems("Mktg. Spend","48.6M"),
//),
//Padding(
//padding: const EdgeInsets.only(right:8.0),
//child: myTextItems("Users","25.5M"),
//),
//Padding(
//padding: const EdgeInsets.all(6.0),
//child: mychart2Items("Conversion","0.9M","+19% of target"),
//),
//
//],
//staggeredTiles: [
//StaggeredTile.extent(4, 250.0),
//StaggeredTile.extent(2, 250.0),
//StaggeredTile.extent(2, 120.0),
//StaggeredTile.extent(2, 120.0),
//StaggeredTile.extent(4, 250.0),
//],
//),

//SingleChildScrollView(
//child: Column(
//mainAxisAlignment: MainAxisAlignment.start,
//children: <Widget>[
//Card(
//child: Padding(
//padding: EdgeInsets.all(6.0),
//child: Column(
//children: <Widget>[
//WeeklyProgressCard('Last Week\'s Progress'),
//]
//),
//)
//),
//Divider(),
//ChipsChoice<String>.multiple(
//value: ["general"],
//options: ChipsChoiceOption.listFrom<String, String>(
//source: courses,
//value: (i, v) {
//return v;
//},
//label: (i, v) => v,
//),
//onChanged: (val) {
//print(val);
//setState(() {
//return usersTags = val;
//});
////if(tipsPage){TipDataBase().setUserSelectedTags(usersTags,tipsPageSetState);}
//// update stats database by selected tags
//},
//itemConfig: ChipsChoiceItemConfig(
//selectedColor: Colors.green,
//unselectedColor: Colors.black87,
//showCheckmark: true,
//),
//),
//ChipsChoice<String>.multiple(
//
//value: ["general"],
//options: ChipsChoiceOption.listFrom<String, String>(
//source: courses,
//value: (i, v) {
//return v;
//},
//label: (i, v) => v,
//),
//onChanged: (val) {
//print(val);
//setState(() {
//return usersTags = val;
//});
////if(tipsPage){TipDataBase().setUserSelectedTags(usersTags,tipsPageSetState);}
//// update stats database by selected tags
//},
//itemConfig: ChipsChoiceItemConfig(
//selectedColor: Colors.green,
//unselectedColor: Colors.black87,
//showCheckmark: true,
//),
//),
//Container(
//child: Graphs(),
//),
//
//],
//),
//),