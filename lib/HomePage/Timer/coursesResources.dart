import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';

/// Course and resource selection widgets.
class ShowHideDropdown extends StatefulWidget {
  @override
  ShowHideDropdownState createState() {
    return new ShowHideDropdownState();
  }
}

class ShowHideDropdownState extends State<ShowHideDropdown> {

  final List<String> _dropdownValues = Global().getUserCourses(); //The list of values we want on the dropdown
  final List<String> _dropdownResources = Global().allResources;
  static String selectedValue = "Select course";
  static bool notRunning = false;
  static String resource = " Select resource";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
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
              ),
              SizedBox(height: 15,),
              DropdownButton<String>(
                items: _dropdownResources
                    .map((data) => DropdownMenuItem<String>(
                  child: Text(data),
                  value: data,
                ))
                    .toList(),
                onChanged: (String value) {
                  setState(() => resource = value);

                },
                hint: Text(resource),
                // value: _selectedValue,
              ),
            ],
        ),
    );

  }

}