import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage/Timer/HomeMain.dart';
import 'progress_pie_bar.dart';

class ShowHideDropdown extends StatefulWidget {
  @override
  ShowHideDropdownState createState() {
    return new ShowHideDropdownState();
  }
}

class ShowHideDropdownState extends State<ShowHideDropdown> {
  final List<String> _dropdownValues = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five"
  ]; //The list of values we want on the dropdown

  String _selectedValue = "";

  static bool timernNotRunning = true;
  bool _isPressed = true;
  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            timernNotRunning
                ? DropdownButton<String>(
              items: _dropdownValues
                  .map((data) => DropdownMenuItem<String>(
                child: Text(data),
                value: data,
              ))
                  .toList(),
              onChanged: (String value) {
                setState(() => _selectedValue = value);
                    _isPressed = true;},

              hint: Text('Dropdown'),
            )
                : SizedBox(),
            SizedBox(
              height: 25.0,
            ),
            RaisedButton(
              color: Colors.red,
              child: Text(timernNotRunning ? " choose course" : "stop timer before"),
              onPressed: () {
                setState(() => _isPressed = _isPressed);
              },
            ),

          ],


    );
  }
}