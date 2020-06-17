import 'package:flutter/material.dart';
import 'package:animated_card/animated_card.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/TimeCard.dart';
import 'package:flutterapp/HomePage/Timer/fireBase/fireBase_api.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';



class cards extends StatelessWidget {
  // content of the first card in the tips page.
  static final String _helpOthers="Add time manually if you forgot to start the timer";
  static List<String> emptyList=[];
  static final int maxLikeCount=100000000;
  // list of all tip cards.
  static final _firstTip=[TimeCard( null, null,null,null,null,null)];
  static List<TimeCard> _timeCards;


  Function updateTimesPageState;
  cards(this.updateTimesPageState);


  @override
  Widget build(BuildContext context){
    _timeCards=null;
    updateTimeList(context);
    if(_timeCards==null){
      return Loading();
    }
    _timeCards=_timeCards;
    return Container(
      color: Colors.grey[300],
      height: 535.0,
      padding: EdgeInsets.only(bottom: 50.0),
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
            onRemove: (FirebaseAPI().getUid()==_timeCards[index].getUid()) ? ()=>removeTime(_timeCards[index],updateTimesPageState):null,
            curve: Curves.decelerate,
            //Animation curve
            child: cardContent(context, _tags, index, _timeCards, updateTimesPageState),
          );
        },
      ),
    );
  }


  void removeTime(TimeCard timeCard,Function updateTimesPageState ){
    TimeDataBase.deleteTimeCard(timeCard);
    updateTimesPageState();
  }



  Future<List<TimeCard>> updateTimeList(BuildContext context) async{
    _timeCards=Provider.of<List<TimeCard>>(context);
    return _timeCards;
  }

  // creating a card with the users tip and adding it to the tips list.
  void addCard(String course, String resource, String date, String time){
    TimeCard newTime;
    String uid=FirebaseAPI().getUid();
    newTime = new TimeCard(course, resource,uid,null,date,time);
    TimeDataBase().addTime(newTime);
    _timeCards.add(newTime);
    updateTimesPageState();
  }

  // creating the tags widget for the cards.
  Widget _tags(int index){
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(" course ", style: TextStyle(backgroundColor: Colors.white))),
              ],
            ),
            Row(
              children: _createChildren(_timeCards[index].getCourse()),
            ),
          ],
        ),
      ),
    );
  }

  // creating list of the users tags.
  List<Widget> _createChildren(String lst) {
    return new List<Widget>.generate(1, (int index) {
      return _courseTag(lst);
    });
  }

  // creating the design for the tags.
  Widget _courseTag(String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.label_important, size: 14,),
          Text(text, style: TextStyle( fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

}
// creating the cards content.
Widget cardContent(BuildContext context,Function tags, int index , List<TimeCard> times, Function updateTimesPageState){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Card(
      color:  Colors.white,
      elevation: 5,
      child: ListTile(
        title: Wrap(
          children: <Widget>[
            showTagsAndLike( context,tags, index ,times, updateTimesPageState),
          ],
        ),
      ),
    ),
  );
}



// creating the cards tags, date and like for the all the cards, except fot the first one.
Widget showTagsAndLike(BuildContext context,Function tags, int index , List<TimeCard> times, Function updateTipsPageState){
  return Wrap(
    children: <Widget>[
      tags(index),
      Row(
        children: <Widget>[
          Text(times[index].getDate().toString().substring(0,10)),
          Text(" "+times[index].getTime().toString()),
          Spacer(),
          Text(times[index].getResource()),

        ],
      ),
    ],
  );

}



// display error to the user.
void showColoredToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.grey,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white);
}