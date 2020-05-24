import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class resourcesButtons extends StatefulWidget {
  @override
  resourcesButtonsState createState() => resourcesButtonsState();
}

class resourcesButtonsState extends State<resourcesButtons> {

  @override
  Widget build(BuildContext context) {

    return Listener(

      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Align
              (
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Wrap(
                    spacing: 5.0,
                    alignment: WrapAlignment.center,
                    runSpacing: 3.0,
                    children: <Widget>[
                      filterChipWidget(chipName: ' Homeworks '),
                      filterChipWidget(chipName: 'Recitations'),
                      filterChipWidget(chipName: ' Lectures  '),
                      filterChipWidget(chipName: '   Exams   '),
                      filterChipWidget(chipName: '   HomePage.Extra   '),


                    ],
                  )
              ),
            ),
          ),
          Divider(color: Colors.blueGrey, height: 10.0,),

        ],
      ),
    );
  }

}



class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Color(0xff6200ee),fontSize: 16.0,fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Color(0xffaaaffd),);
  }
}
