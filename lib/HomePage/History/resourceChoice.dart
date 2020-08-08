import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutterapp/Global.dart';




// class of the resources multi choice.
class ResourceChoice extends StatefulWidget {

  // updating the users tag list.
  final Function updateUserResource;

  // for refreshing the history page.
  final Function timesPageSetState;

  // distance of the title from the top.
  final double ceiling;


  //constructor/
  ResourceChoice( this.updateUserResource,this.ceiling, this.timesPageSetState);


  @override
  _ResourceChoiceState createState() => _ResourceChoiceState( updateUserResource,timesPageSetState);
}

class _ResourceChoiceState extends State<ResourceChoice> {
  final Function tipsPageSetState;
  final Function updateUserResource;
  bool addResource;

  //constructor.
  _ResourceChoiceState(this.updateUserResource, this.tipsPageSetState);


  // list of all resources
  List<String> resources = Global().getAllResources();
  static List<String> userResource = [""];


  @override
  Widget build(BuildContext context) {
    updateUserResource(userResource);
    return scrollableListSingleleChoice();
  }

  // creating the single choice list.
  Widget scrollableListSingleleChoice() {
    return ChipsChoice<String>.single(
        value: userResource[0],
        options: ChipsChoiceOption.listFrom<String, String>(
          source: resources,
          value: (i, v) => v,
          label: (i, v) => v,
        ),
        onChanged: (val) {
          setState(() => userResource[0] = val);
        },
        itemConfig: ChipsChoiceItemConfig(
          selectedColor: Global.getBackgroundColor(0),
          unselectedColor: Colors.black87,
          showCheckmark: true,
        )

    );
  }
}