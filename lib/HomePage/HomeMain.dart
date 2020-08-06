import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/pushNotifications.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Global.dart';
import 'Timer/dialog_helper.dart';
import 'Timer/enterTime.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'Timer/digitalClock.dart';
import 'Timer/progress_pie_bar.dart';
import 'Timer/buttomButtons.dart';
import 'package:provider/provider.dart';


class HomeMainPage extends StatefulWidget {
  final firstInit;

  const HomeMainPage({Key key, this.firstInit}) : super(key: key);

  @override
  HomeMainPageState createState() => HomeMainPageState();
}

class HomeMainPageState extends State<HomeMainPage> {
  bool firstInit=true;

  @override
  void initState() {
    PushNotificationsManager pushNotificationsManager = new PushNotificationsManager();
    pushNotificationsManager.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timeService = TimerService();
    if (firstInit && widget.firstInit != null && widget.firstInit){
      return Scaffold(
        backgroundColor: Global.getBackgroundColor(0),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
//                        SizedBox(width: 6.0,),
//                        Notification(),
                        SizedBox(width: 6.0,),
                        FriendsButton(),
                      ],
                    ),
                    Settings(),
                  ],
                ),
                Container(height: 200, width: 200,child: Image(image: AssetImage('images/go_study_logo.jpg'))),
                SizedBox(height: MediaQuery.of(context).size.height / 55),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white24,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: 5,
//                                  offset: Offset(10.5,10.5),
                                  color: Global.getBackgroundColor(50),
                                ),
                                BoxShadow(
                                  blurRadius: 15,
                                  offset: Offset(10.5, 10.5),
                                  color: Colors.blueAccent,
                                )
                              ],
                            ),
                            height: 150,
                            width: 150,
                            child: Center(child: Text("LETS GO",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.meriendaOne(fontSize: 30, fontWeight: FontWeight.bold),
//                            GoogleFonts.pacifico(fontSize: 30),
//                            TextStyle(
//                                fontSize: 30, fontWeight: FontWeight.bold),
                            )
                            ),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            firstInit = false;
                          });
                        },
                      )
                    ]),
                SizedBox(height: MediaQuery.of(context).size.height / 25),
                MotivationSentence(),
              ],
              // ),
            ),
          ),
        ),
      );
    }
    return ChangeNotifierProvider<TimerService>(
      create: (_) => timeService,
      child: Scaffold(
        backgroundColor: Global.getBackgroundColor(0),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
//                        SizedBox(width: 6.0,),
//                        Notification(),
                        SizedBox(width: 6.0,),
                        FriendsButton(),
                      ],
                    ),
                    Settings(),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                Text("Time", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),),
                neuDigitalClock(),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Text("Daily Goal", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey,fontWeight: FontWeight.bold),),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                Text("07 : 30 : 00", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, color: Colors.black),),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                NeuProgressPieBar(),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                NeuResetButton(),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                EnterTimeButton(),
                  ],),
                SizedBox(height: MediaQuery.of(context).size.height / 25),
                //MsgError(),
//                MotivationSentence(),
              ],
              // ),
            ),
          ),
        ),
      ),
    );
  }

  void newRankDialog(){
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text('Congratulations', textAlign: TextAlign.center,),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('New Rank!', textAlign: TextAlign.center,),
                  Image(image: AssetImage('images/Success.jpg'),),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
}

class MotivationSentence extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MotivationSentenceState();
}

class MotivationSentenceState extends State<MotivationSentence> {
  Random random = new Random();
  String sentence = "";
  int len = 0;
  CollectionReference colRef =
  Firestore.instance.collection("motivationSentences");

  Future getLen() async{
    await colRef.getDocuments().then((value) {
      len = value.documents.length;
      pickSentence();
    });
  }

  Future pickSentence() async {
    int randomIndex = random.nextInt(len);
    await colRef.document(randomIndex.toString()).get().then((doc) {
      setState(() {
        sentence = doc.data["data"];
      });
    });
    sentence = sentence.replaceAll("-userName-", FirebaseAPI().getUserFirstName());
  }

  Future<String> getRaghd() async{
    CollectionReference statsCollection= Firestore.instance.collection("Statistics");
    var x =  statsCollection.document("Overall Average").get().then((value) {
      print(value.data['Overall Average']);
      //List x = value.data['Overall Average'];
      //print(x[0]);
      //print('sup mah man');
    });
    return x;

  }
  @override
  void initState(){
    super.initState();
    getLen();
  }

  @override
  Widget build(BuildContext context) {
    return Text(sentence,
      textAlign: TextAlign.center,
      style:
//    GoogleFonts.cabin(fontSize: 35, fontWeight: FontWeight.bold),
      TextStyle(fontFamily: 'Piedra', fontSize: 30.0),
    );
  }
}

class TimerService extends ChangeNotifier {
  static Stopwatch watch;
  Timer _timer;

  Duration get currentDuration => currentDurationTime;
  static Duration currentDurationTime = Duration.zero;
  static Duration SendTime = Duration.zero;
  bool get isRunning => _timer != null;

  TimerService() {
    watch = Stopwatch();
  }

  void _onTick(Timer timer) {
    currentDurationTime = watch.elapsed;

    // notify all listening widgets
    notifyListeners();
  }

  void start() {
    if (_timer != null) return;

    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    watch.start();

    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    watch.stop();
    currentDurationTime = watch.elapsed;
    SendTime = currentDurationTime;
    notifyListeners();
  }

  void reset() {
    stop();
    watch.reset();
    currentDurationTime = Duration.zero;

    notifyListeners();
  }
}


class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle,color: Global.backgroundPageColor),
      child: PopupMenuButton<String>(
        onSelected: (index){},
        icon: Icon(Icons.notifications,color: Colors.black,),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[],
      ),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle,color: Global.backgroundPageColor),
      child: PopupMenuButton<String>(

        onSelected: (index)async{
          switch (int.parse(index)){
            case 0:
              Navigator.pushNamed(context, '/getInfo');
              return;
            case 1:
              Navigator.pushNamed(context, '/history');
              return;
            case 2:
              Navigator.pushNamed(context, '/old courses');
              return;
            case 3:
              return await DialogHelperExit.exit(context);
          }
        },
        icon: Icon(Icons.settings,color: Colors.black,),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem(value:'0',child: menuEntry("Personal Information", Icon(Icons.assignment_ind,color: Colors.black,))),
          PopupMenuItem(value:'1',child: menuEntry("Activity History", Icon(Icons.alarm,color: Colors.black))),
          PopupMenuItem(value:'2',child: menuEntry("Old Courses Info", Icon(Icons.history,color: Colors.black))),
          PopupMenuItem(value:'3',child: menuEntry("Log Out", Icon(Icons.exit_to_app,color: Colors.black))),
        ],
      ),
    );
  }


  Widget menuEntry(String title,Icon icn){
    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        icn,
        SizedBox(width: 6.0,),
        Text(title, style: TextStyle(color: Colors.black, fontSize: 15.0)),
      ],
    );
  }

}


class FriendsButton extends StatefulWidget {
  @override
  _FriendsButtonState createState() => _FriendsButtonState();
}

class _FriendsButtonState extends State<FriendsButton> {

  bool newFriendReq=false;
  static bool first=true;

  void initial(bool set)async{
    UserDataBase.user=await UserDataBase().getUser();
    List<String> friendReqUid=await UserDataBase().getUserFriendReqReceive(FirebaseAPI().getUid());
    newFriendReq = friendReqUid.isEmpty? false: true;
    if(set){setState(() {});}
  }

  @override
  Widget build(BuildContext context) {
    initial(first);
    first=!first;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle,color: Global.backgroundPageColor),
      child: Stack(
        children: <Widget>[
          newFriendReq? Positioned(
              left: 30.0,
              top: 10,
              child: Icon(Icons.brightness_1,
                color: Colors.red,
                size: 9.0,)
          ):Container(),
          IconButton(
            onPressed: (){Navigator.pushReplacementNamed(context, '/friends');},
            icon: Icon(Icons.group,color: Colors.black,),
          ),
        ],
      ),
    );
  }


}

