import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_button/nice_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProgressDataState();
  }
}

class _ProgressDataState extends State<ProgressData> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          height: MediaQuery.of(context).size.height - 150,
          child: Scaffold(
//              backgroundColor: Colors.blueAccent,
              body: Column(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 20,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('   Week 9',
                              style:
                              GoogleFonts.merriweather(
                                fontSize: 35,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(child: starIcon(BuildContext)),
                              starIcon(BuildContext),
                              starIcon(BuildContext),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Your Weekly Progress',
                            style: TextStyle(fontSize: 21),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showEditDialog(context);
                            },
                          )),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  CircularPercentIndicator(
                      radius: 200,
                      lineWidth: 13,
                      animation: true,
                      animationDuration: 2000,
                      percent: 0.7,
                      progressColor: Colors.black,
                      center: Text(
                        "HW: 4/6\nRec: 2/2\nLec: 2/3\nOverall: 70%",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inconsolata(fontSize: 20,
                        fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height / 35),
                  Text(
                    'Your Semester Progress',
                    style: TextStyle(fontSize: 21),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 50,
                      animation: true,
                      lineHeight: 20,
                      animationDuration: 2000,
                      percent: 0.83,
                      center: Text('83%'),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.greenAccent,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 25),
                  NiceButton(
                    radius: 40,
                    padding: EdgeInsets.all(5),
                    text: "Set New Plan",
                    icon: Icons.account_box,
                    gradientColors: [Color(0xff5b86e5),Color(0xff36d1dc)],
                    onPressed: (){setNewPlanDialog(context);},
                  )
                ],
              )));
    });
  }

  starIcon(BuildContext) {
    return Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.star),
          onPressed: () {
            showStarDialog(context);
          },
        ));
  }

  showStarDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Rank"),
      backgroundColor: Colors.blueAccent,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: Text(
          "You're 43 hours away of GoStudy from people who got 90.\n\n GoStudy Tip: 53 hours from next Rank."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showEditDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("GoStudy Team"),
      backgroundColor: Colors.blueAccent,
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: Text(
          "Feature coming soon..."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  setNewPlanDialog(BuildContext context){
    TextEditingController controller = TextEditingController();

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Set New Plan"),
        content: Container(
          height: MediaQuery.of(context).size.height/3.2,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Text('Enter Excepted Average:'),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "hint: 100"
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Be Dedicated, set your's:"),
              ),
                  DedicationInput(),
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text("Submit"),
            onPressed: (){Navigator.of(context).pop(context);},
          )
        ],
      );
    });
  }
}

class DedicationInput extends StatefulWidget {
  @override
  _DedicationInputState createState() => _DedicationInputState();
}

class _DedicationInputState extends State<DedicationInput> {
  static int _dedication=1;
  List<String> labels=["low", "medium","high"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,0,0,0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Dedication", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Slider(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              value: _dedication.toDouble(),
              min: 1, //low
              max: 3, //high
              divisions: 2,
              onChanged: (val)=>setState(()=>_dedication=val.round()),
              label: labels[_dedication-1],
            ),
          ),
        ],
      ),
    );
  }
}
