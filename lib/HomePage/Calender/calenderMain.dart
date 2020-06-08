

import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'event_firestore_service.dart';
import 'add_event.dart';
import 'view_event.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event.dart';



class CalenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: calenderPage22(),
      routes: {
        "add_event": (_) => AddEventPage(),
      },
    );
  }
}

class calenderPage22 extends StatefulWidget {
  @override
  CalenderPageState createState() => CalenderPageState();
}

class CalenderPageState extends State<calenderPage22> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }
  Map <DateTime,List<EventModel>> groupEvents (List<EventModel> events){
    Map <DateTime,List<EventModel>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(event.eventDate.year,event.eventDate.month,event.eventDate.day,12);
      if(data[date] ==null)data[date] = [];
      data[date].add(event);
    });
    return data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<EventModel>>(
        stream: eventDBS.streamList(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<EventModel> allEvents = snapshot.data;
            if(allEvents.isNotEmpty){
              _events = groupEvents(allEvents);
            }
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TableCalendar(
                  events: _events,
                  initialCalendarFormat: CalendarFormat.week,
                  calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      todayColor: Colors.orange,
                      selectedColor: Theme.of(context).primaryColor,
                      todayStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white)),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    formatButtonTextStyle: TextStyle(color: Colors.white),
                    formatButtonShowsNext: false,
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (date, events) {
                    setState(() {
                      _selectedEvents = events;
                    });
                  },
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                    todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  calendarController: _controller,
                ),
                ..._selectedEvents.map((event) => ListTile(
                  leading: Icon(
                    Icons.event,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  //selected: true,
                  title: Text(event.title,),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EventDetailsPage(
                              event: event,
                            )));
                  },
                )),
              ],
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'add_event'),
      ),
    );
  }
}