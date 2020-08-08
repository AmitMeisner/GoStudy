import 'package:flutter/material.dart';
import 'package:animated_card/animated_card.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/TimeCard.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
import 'package:flutterapp/Statistics/StatisticsDataBase.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Global.dart';
import 'editTimeDialog.dart';



class Cards extends StatefulWidget {


  // list of all tip cards.
  static final _firstTip = [
    TimeCard(
        null,
        null,
        null,
        null,
        null,
        0,
        0,
        0)
  ];


  Function updateTimesPageState;
  Cards(this.updateTimesPageState);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {

  static List<TimeCard> _timeCards;

  @override
  Widget build(BuildContext context) {
    _timeCards=null;
    updateTimeList(context);
    //if no activity history show a text
    if (_timeCards==null || _timeCards.isEmpty) {
      return (Text("NO TIME HISTORY IN THIS COURSE",   style: GoogleFonts.meriendaOne(fontSize: 20, fontWeight: FontWeight.bold)));
    }


    return Container(
      height: 650.0,
      child: ListView.builder(
        itemCount: _timeCards.length,
        itemBuilder: (context, index) {
          return AnimatedCard(
            direction: AnimatedCardDirection.top,
            //Initial animation direction
            initDelay: Duration(milliseconds: 0),
            //Delay to initial animation
            duration: Duration(milliseconds: 400),
            //Initial animation duration
            onRemove:  () {
              removeTime(_timeCards[index], widget.updateTimesPageState);
            },
            curve: Curves.decelerate,
            //Animation curve
            child: cardContent(
                context, _course, index, _timeCards, widget.updateTimesPageState),
          );
        },
      ),
    );
  }

  // remove the card and update the page
  Future<void> removeTime(TimeCard timeCard, Function updateTimesPageState)async{
     await TimeDataBase().deleteTimeCard(timeCard);
     updateTimesPageState();
  }
//update the list according to the firebase
  Future<List<TimeCard>> updateTimeList(BuildContext context) async {
    _timeCards = Provider.of<List<TimeCard>>(context);
    return _timeCards;
  }
// add a time history to the firebase
  void addCard(String course, String resource, DateTime date, int hours,
      int minutes, int seconds) {
    TimeCard newTime;
    String uid = FirebaseAPI().getUid();
    newTime = new TimeCard(
        course,
        resource,
        uid,
        null,
        date,
        hours,
        minutes,
        seconds);
    TimeDataBase().addTime(newTime);
    _timeCards.add(newTime);
    widget.updateTimesPageState();
  }

  //create the tags of the course and the resource to be displayed in the card
  Widget _course(int index) {
    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              Text(_timeCards[index].getCourse(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Icon(Icons.forward, size: 14,),
              Text(_timeCards[index].getResource(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          )
      ),
    );
  }
}


// creating the cards content.
Widget cardContent(BuildContext context,Function course, int index , List<TimeCard> times, Function updateTimesPageState){

  return Container(
    margin:  EdgeInsets.only( bottom: 10.0, left: 10.0, right: 10.0),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Global.getBackgroundColor(0),
      borderRadius: BorderRadius.circular(30),
    ),
// Digital green background
    child: Center(
        child: LayoutBuilder(
        builder: (context, constraints) => Container(
    height:  MediaQuery.of(context).size.height/10,
    width: MediaQuery.of(context).size.height*2/3,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        Global.backgroundPageColor,
        Global.backgroundPageColor,
      ]),
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        color: Color.fromRGBO(168, 168, 168, 1),
        width: 2,
      ),
    ),
      child: ListTile(
        title: Wrap(
          children: <Widget>[
            showInfo( context,course, index ,times, updateTimesPageState),
          ],
        ),
    ),
  ),),),);
}



// creating the cards course and resource tags, date and time for the all the cards.
Widget showInfo(BuildContext context,Function course, int index , List<TimeCard> times, Function updateTimesPageState){
  String date=dateTimeToString(times[index].getDate());
  return Container(
    margin:  EdgeInsets.only( top:3.0,bottom: 3.0),
    child: Column(
      children: <Widget>[
      course(index),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(date, style: TextStyle( fontSize: 14)),
          Text(timeString(times[index].getHours())+":"+
              timeString(times[index].getMinutes())+":"+
              timeString(times[index].getSeconds()),style: TextStyle( fontSize: 14)),
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            iconSize: 30,
            color: Global.getBackgroundColor(0),
            splashColor: Colors.grey,
            onPressed: () {
              return editTime(context,updateTimesPageState,times[index]);
            },
          ),
        ],
      ),
    ],
    ),
  );

}
// return the date as a string
String dateTimeToString(DateTime date) {
  String day=date.day.toString();
  String month=date.month.toString();
  String year=date.year.toString();
  return(day+"/"+month+"/"+year);
}
// return the time in the right form
String timeString(int time){
  if(time<10){
    return "0"+time.toString();
  }return time.toString();

}
// create the edit icon
void editTime(BuildContext context, Function updateTimesPageState, TimeCard times) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return editTimeDialog(updateTimesPageState,times);
    },
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
  );
}


