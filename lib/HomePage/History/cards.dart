import 'package:flutter/material.dart';
import 'package:animated_card/animated_card.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/TimeCard.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Global.dart';
import 'editTimeDialog.dart';



class cards extends StatelessWidget {


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
  static List<TimeCard> _timeCards;


  Function updateTimesPageState;

  cards(this.updateTimesPageState);


  @override
  Widget build(BuildContext context) {
    _timeCards = null;
    updateTimeList(context);
    if (_timeCards == null) {
//      return Loading();
    return (Text("NO TIME HISTORY IN THIS COURSE",   style: GoogleFonts.meriendaOne(fontSize: 20, fontWeight: FontWeight.bold)));
    }
    _timeCards = _timeCards;
    return Container(

//      color: Colors.yellow[300],
      height: 650.0,
      //padding: EdgeInsets.only(bottom: 50.0),
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
            onRemove: (FirebaseAPI().getUid() == _timeCards[index].getUid())
                ? () => removeTime(_timeCards[index], updateTimesPageState)
                : null,
            curve: Curves.decelerate,
            //Animation curve
            child: cardContent(
                context, _course, index, _timeCards, updateTimesPageState),
          );
        },
      ),
    );
  }

  void removeTime(TimeCard timeCard, Function updateTimesPageState) {
    TimeDataBase.deleteTimeCard(timeCard);
    updateTimesPageState();
  }


  Future<List<TimeCard>> updateTimeList(BuildContext context) async {
    _timeCards = Provider.of<List<TimeCard>>(context);
    return _timeCards;
  }

  // creating a card with the users tip and adding it to the tips list.
  void addCard(String course, String resource, String date, int hours,
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
    updateTimesPageState();
  }

  // creating the tags widget for the cards.
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
    margin:  EdgeInsets.only( bottom: 25.0),
    width: MediaQuery.of(context).size.height/2.5,
    height: MediaQuery.of(context).size.height/10,
    decoration: BoxDecoration(
      color: Global.getBackgroundColor(0),
      borderRadius: BorderRadius.circular(50),
//      boxShadow: [
//        BoxShadow(
//          blurRadius: 0,
//          offset: Offset(-5, -5),
//          color: Colors.white,
//        ),
//        BoxShadow(
//          blurRadius: 0,
//          offset: Offset(10.5, 10.5),
////            color: Color.fromRGBO(214, 223, 230, 1),
//          color: Global.getBackgroundColor(500),
//        )
      //],
    ),
// Digital green background
    child: Center(
        child: LayoutBuilder(
        builder: (context, constraints) => Container(
    height:  MediaQuery.of(context).size.height/10,
    width: MediaQuery.of(context).size.height/2.8,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        Global.backgroundPageColor,
        Global.backgroundPageColor,
      ]),
      borderRadius: BorderRadius.circular(50),
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



// creating the cards tags, date and like for the all the cards, except fot the first one.
Widget showInfo(BuildContext context,Function course, int index , List<TimeCard> times, Function updateTimesPageState){
  return Container(
    margin:  EdgeInsets.only( top:3.0,bottom: 3.0),
    child: Column(
    children: <Widget>[
      course(index),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(times[index].getDate().toString(), style: TextStyle( fontSize: 14)),
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

String timeString(int time){
  if(time<10){
    return "0"+time.toString();
  }return time.toString();

}

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


