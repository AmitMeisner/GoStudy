import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/HomeMain.dart';
import 'progress_pie_bar.dart';

class ShowHideDropdown extends StatefulWidget {
  @override
  ShowHideDropdownState createState() {
    return new ShowHideDropdownState();
  }
}

class ShowHideDropdownState extends State<ShowHideDropdown> {
  final List<String> _dropdownValues = [
    "Hedva",
    "Hedva2",
    "Linear",
    "Linear2",
    "Statistics"
  ]; //The list of values we want on the dropdown

  static String selectedValue = "Select course";
  static bool notRunning = false;
  static String resource = " Select resource";
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        DropdownButton<String>(
          items: _dropdownValues
              .map((data) => DropdownMenuItem<String>(
            child: Text(data),
            value: data,
          ))
              .toList(),
          onChanged: (String value) {
            setState(() => selectedValue = value);

          },
          hint: Text(selectedValue),
          // value: _selectedValue,
        ),
        Wrap(
          spacing: 10.0,
          children: <Widget>[
            ActionChip(

              label: Text( resource ),
              backgroundColor: Color(0xffededed),

              labelStyle: TextStyle(color: Color(0xff000000),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      actions: <Widget>[
                        new FlatButton(
                          child: Text(
                              "Lectures"
                          ),
                          onPressed: () {
                            setState(() => resource = "Lectures");
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                          child: Text("Recitations"),
                          onPressed: () {
                            setState(() => resource = "Recitations");
                            Navigator.of(context).pop();
                          },

                        ),
                        new FlatButton(
                          child: Text("Homeworks"),
                          onPressed: () {
                            setState(() => resource = "Homeworks");
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                          child: Text("Exams"),
                          onPressed: () {
                            setState(() => resource = "Exams");
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                          child: Text("Extra"),
                          onPressed: () {
                            setState(() => resource = "Extra");
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],),



      ],


    );
  }
}