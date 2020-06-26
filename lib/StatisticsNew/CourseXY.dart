import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/HomeMain.dart';
import 'package:flutterapp/Global.dart';

class ShowHideDropdown extends StatefulWidget {

  final Function setStatisticsPageState;
  ShowHideDropdown(this.setStatisticsPageState);

  @override
  ShowHideDropdownState createState() {
    return new ShowHideDropdownState(setStatisticsPageState);
  }
}

class ShowHideDropdownState extends State<ShowHideDropdown> {
  final List<String> _dropdownValues = Global().getUserCourses(); //The list of values we want on the dropdown
  final List<String> _dropdownValuesX = ["Final Grade","Average","HomeWork Time","Recitation Time",
    "Lectures Time","Exam Time","Extra Time",];
  final List<String> _dropdownValuesY = ["HomeWork Time","Recitation Time",
    "Lectures Time","Exam Time","Extra Time",];

  static String selectedCourse = "Course";
  static String xAxisValue = "xAxis";
  static String yAxisValue = "yAxis";
  int varCount=1;

  final Function setStatisticsPageState;
  ShowHideDropdownState(this.setStatisticsPageState);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              items: _dropdownValues
                  .map((data) => DropdownMenuItem<String>(
                child: Text(data),
                value: data,
              ))
                  .toList(),
              onChanged: (String value) {
                setState(() {selectedCourse = value;checkValidSelection();});

              },
              hint: Text(selectedCourse),
              // value: _selectedValue,
            ),
          ),
          Text(" : ", style: TextStyle(fontWeight: FontWeight.bold),),
          varCount>=1? Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              items: _dropdownValuesX
                  .map((data) => DropdownMenuItem<String>(
                child: Text(data),
                value: data,
              ))
                  .toList(),
              onChanged: (String value) {
                setState(() {xAxisValue = value;checkValidSelection();});

              },
              hint: Text(xAxisValue),
              // value: _selectedValue,
            ),
          ):Container(),
          Icon(Icons.arrow_forward, color:varCount>=2? Colors.black: Colors.grey,),
          varCount>=2? Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              items: _dropdownValuesY
                  .map((data) => DropdownMenuItem<String>(
                child: Text(data),
                value: data,
              ))
                  .toList(),
              onChanged: (String value) {
                setState(() { yAxisValue = value;checkValidSelection();});

              },
              hint: Text(yAxisValue),
              // value: _selectedValue,
            ),
          ):Container(),
          varCount==1? IconButton(
            icon: Icon(Icons.add),
            onPressed: (){varCount++;setState(() {});},
          ):Container(),
          varCount>=2? Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              items: _dropdownValuesY
                  .map((data) => DropdownMenuItem<String>(
                child: Text(data),
                value: data,
              ))
                  .toList(),
              onChanged: (String value) {
                setState(() { yAxisValue = value;checkValidSelection();});

              },
              hint: Text(yAxisValue),
              // value: _selectedValue,
            ),
          ):Container(),
          varCount==2? IconButton(
            icon: Icon(Icons.add),
            onPressed: (){varCount++;setState(() {});},
          ):Container(),
          varCount>=3? Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              items: _dropdownValuesY
                  .map((data) => DropdownMenuItem<String>(
                child: Text(data),
                value: data,
              ))
                  .toList(),
              onChanged: (String value) {
                setState(() { yAxisValue = value;checkValidSelection();});

              },
              hint: Text(yAxisValue),
              // value: _selectedValue,
            ),
          ):Container(),
          varCount==3? IconButton(
            icon: Icon(Icons.add),
            onPressed: (){varCount++;setState(() {});},
          ):Container(),



//        Wrap(
//          spacing: 10.0,
//          children: <Widget>[
//            ActionChip(
//
//              label: Text( selectedCourse ),
//              backgroundColor: Color(0xffededed),
//
//              labelStyle: TextStyle(color: Color(0xff000000),
//                  fontSize: 14.0,
//                  fontWeight: FontWeight.bold),
//              onPressed: () {
//                showDialog(
//                  context: context,
//                  builder: (BuildContext context) {
//                    // return object of type Dialog
//                    return AlertDialog(
//                      actions: <Widget>[
//                        new FlatButton(
//                          child: Text(
//                              "Lectures"
//                          ),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Lectures");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                        new FlatButton(
//                          child: Text("Recitations"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Recitations");
//                            Navigator.of(context).pop();
//                          },
//
//                        ),
//                        new FlatButton(
//                          child: Text("HomeWorks"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "HomeWorks");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                        new FlatButton(
//                          child: Text("Exams"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Exams");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                        new FlatButton(
//                          child: Text("Extra"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Extra");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                      ],
//                    );
//                  },
//                );
//              },
//            ),
//            ActionChip(
//
//              label: Text( xAxisValue ),
//              backgroundColor: Color(0xffededed),
//
//              labelStyle: TextStyle(color: Color(0xff000000),
//                  fontSize: 14.0,
//                  fontWeight: FontWeight.bold),
//              onPressed: () {
//                showDialog(
//                  context: context,
//                  builder: (BuildContext context) {
//                    // return object of type Dialog
//                    return AlertDialog(
//                      actions: <Widget>[
//                        new FlatButton(
//                          child: Text(
//                              "Lectures"
//                          ),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Lectures");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                        new FlatButton(
//                          child: Text("Recitations"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Recitations");
//                            Navigator.of(context).pop();
//                          },
//
//                        ),
//                        new FlatButton(
//                          child: Text("HomeWorks"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "HomeWorks");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                        new FlatButton(
//                          child: Text("Exams"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Exams");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                        new FlatButton(
//                          child: Text("Extra"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Extra");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                      ],
//                    );
//                  },
//                );
//              },
//            ),
//            ActionChip(
//
//              label: Text( yAxisValue ),
//              backgroundColor: Color(0xffededed),
//
//              labelStyle: TextStyle(color: Color(0xff000000),
//                  fontSize: 14.0,
//                  fontWeight: FontWeight.bold),
//              onPressed: () {
//                showDialog(
//                  context: context,
//                  builder: (BuildContext context) {
//                    // return object of type Dialog
//                    return AlertDialog(
//                      actions: <Widget>[
//                        new FlatButton(
//                          child: Text(
//                              "Lectures"
//                          ),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Lectures");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                        new FlatButton(
//                          child: Text("Recitations"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Recitations");
//                            Navigator.of(context).pop();
//                          },
//
//                        ),
//                        new FlatButton(
//                          child: Text("HomeWorks"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "HomeWorks");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                        new FlatButton(
//                          child: Text("Exams"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Exams");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                        new FlatButton(
//                          child: Text("Extra"),
//                          onPressed: () {
//                            setState(() => xAxisValue = "Extra");
//                            Navigator.of(context).pop();
//                          },
//                        ),
//                      ],
//                    );
//                  },
//                );
//              },
//            ),
//          ],),



        ],


      ),
    );
  }



  void checkValidSelection(){
    if(selectedCourse=="Course" || xAxisValue=="xAxis" || yAxisValue=="yAxis"){
      return;
    }
    setStatisticsPageState();
  }
}