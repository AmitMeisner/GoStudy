import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutterapp/Global.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';



// class of the courses multi choice.
class CoursesMultiChoice extends StatefulWidget {
  // updating the users tag list.
  final Function updateUserTags;

  // for refreshing the tips page.
  final Function tipsPageSetState;



  //indicates that this is the multi choice from the tips page
  //and not the tipDialog.
  final bool tipsPage;

  //constructor/
  CoursesMultiChoice(this.updateUserTags, this.tipsPageSetState, this.tipsPage);


  @override
  _CoursesMultiChoiceState createState() => _CoursesMultiChoiceState(updateUserTags,tipsPageSetState, tipsPage);
}

class _CoursesMultiChoiceState extends State<CoursesMultiChoice> {
  // updating the users tag list.
  Function updateUserTags;

  final Function tipsPageSetState;

  // distance of the title from the top.

  bool tipsPage;

  //constructor.
  _CoursesMultiChoiceState(this.updateUserTags, this.tipsPageSetState, this.tipsPage);


  int tag = 1;

  //users tags.
  List<String> usersTags=["general"];

  // list of all courses.
  List<String> courses=["general"]+Global().getUserCourses();

  @override
  Widget build(BuildContext context) {
    updateUserTags(usersTags);
    return scrollableListMultipleChoice();
  }

  // creating the multi choice list.
  Widget scrollableListMultipleChoice(){
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height/11,
        width: double.infinity,
        child: Content(
          title: "",
          ceiling: 0,
          child: ChipsChoice<String>.multiple(
            value: usersTags,
            options: ChipsChoiceOption.listFrom<String, String>(
              source: courses,
              value: (i, v) {
                return v;
              },
              label: (i, v) {
                return v;
              },
            ),
            onChanged: (val) {
              setState(() {
                return usersTags = val;
              });
              if(tipsPage){TipDataBase().setUserSelectedTags(usersTags,tipsPageSetState);}
              },
            itemConfig: ChipsChoiceItemConfig(
                selectedColor: Global.getBackgroundColor(500),
                unselectedColor: Colors.black87,
                showCheckmark: true,
              )
          ),
        ),
      ),
    );
  }



}

// class for the custom chip widget.
class CustomChip extends StatelessWidget {

  final String label;
  final bool selected;
  final Function(bool selected) onSelect;

  CustomChip(
      this.label,
      this.selected,
      this.onSelect,
      { Key key }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 100,
      width: 70,
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: selected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: selected ? Colors.green : Colors.grey,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Visibility(
                visible: selected,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 32,
                )
            ),
            Positioned(
              left: 9,
              right: 9,
              bottom: 7,
              child: Container(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class that creates the content of the multi choice.
class Content extends StatelessWidget {

  final String title;
  final Widget child;
  final double ceiling;

  Content({
    Key key,
    @required this.title,
    @required this.child,
    @required this.ceiling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  Global.backgroundPageColor,
      elevation: 2,
      margin: EdgeInsets.fromLTRB(0,ceiling,0,0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}