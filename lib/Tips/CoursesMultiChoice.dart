import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutterapp/Courses.dart';
import 'package:flutterapp/Tips/TipDialog.dart';




//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter ChipsChoice',
//      theme: ThemeData(
//        primarySwatch: Colors.red,
//      ),
//      home: CoursesMultiChoice(),
//    );
//  }
//}


class CoursesMultiChoice extends StatefulWidget {
  final Function updateUserTags;
  CoursesMultiChoice(this.updateUserTags);
  @override
  _CoursesMultiChoiceState createState() => _CoursesMultiChoiceState(updateUserTags);
}

class _CoursesMultiChoiceState extends State<CoursesMultiChoice> {

  Function updateUserTags;
  _CoursesMultiChoiceState(this.updateUserTags);

  int tag = 1;
  List<String> usersTags=["general"];




  List<String> courses=Courses().getAllCourses();

  @override
  Widget build(BuildContext context) {
    updateUserTags(usersTags);
    return scrollableListMultipleChoice();
  }

  Widget scrollableListMultipleChoice(){
    return Content(
      title:"Courses",
      child: ChipsChoice<String>.multiple(
        value: usersTags,
        options: ChipsChoiceOption.listFrom<String, String>(
          source: courses,
          value: (i, v) => v,
          label: (i, v) => v,
        ),
        onChanged: (val) => setState(() => usersTags = val),
          itemConfig: ChipsChoiceItemConfig(
            selectedColor: Colors.green,
            unselectedColor: Colors.black87,
            showCheckmark: true,
          )
      ),
    );
  }



}


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

class Content extends StatelessWidget {

  final String title;
  final Widget child;

  Content({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.fromLTRB(0,10,0,0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(5, 15, 0, 15),
            color: /**Color(0xff109618)*/Colors.blueAccent,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

//void _about(BuildContext context) {
//  showDialog(
//    context: context,
//    builder: (_) => Dialog(
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          ListTile(
//            title: Text(
//              'chips_choice',
//              style: Theme.of(context).textTheme.headline.copyWith(color: Colors.black87),
//            ),
//            subtitle: Text('by davigmacode'),
//            trailing: IconButton(
//              icon: Icon(Icons.close),
//              onPressed: () => Navigator.pop(context),
//            ),
//          ),
//          Flexible(
//            fit: FlexFit.loose,
//            child: Container(
//              padding: EdgeInsets.symmetric(horizontal: 15),
//              child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Text(
//                    'Easy way to provide a single or multiple choice chips.',
//                    style: Theme.of(context).textTheme.body1.copyWith(color: Colors.black54),
//                  ),
//                  Container(height: 15),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    ),
//  );
//}


//
//Widget scrollableListSingleChoice(){
//  return Content(
//    title: 'Scrollable List Single Choice',
//    child: ChipsChoice<int>.single(
//      value: tag,
//      options: ChipsChoiceOption.listFrom<int, String>(
//        source: options,
//        value: (i, v) => i,
//        label: (i, v) => v,
//      ),
//      onChanged: (val) => setState(() => tag = val),
//    ),
//  );
//}


//  Widget wrappedListSingleChoice(){
//    return Content(
//      title: 'Wrapped List Single Choice',
//      child: ChipsChoice<int>.single(
//        value: tag,
//        options: ChipsChoiceOption.listFrom<int, String>(
//          source: options,
//          value: (i, v) => i,
//          label: (i, v) => v,
//        ),
//        onChanged: (val) => setState(() => tag = val),
//        isWrapped: true,
//      ),
//    ) ;
//  }
//
//  Widget wrappedListMultipleChoice(){
//    return Content(
//      title: 'Wrapped List Multiple Choice',
//      child: ChipsChoice<String>.multiple(
//        value: tags,
//        options: ChipsChoiceOption.listFrom<String, String>(
//          source: options,
//          value: (i, v) => v,
//          label: (i, v) => v,
//        ),
//        onChanged: (val) => setState(() => tags = val),
//        isWrapped: true,
//      ),
//    );
//  }
//
//  Widget disabledChoiceItem(){
//    return Content(
//      title: 'Disabled Choice Item',
//      child: ChipsChoice<int>.single(
//        value: tag,
//        options: ChipsChoiceOption.listFrom<int, String>(
//          source: options,
//          value: (i, v) => i,
//          label: (i, v) => v,
//          disabled: (i, v) => [0, 2, 5].contains(i),
//        ),
//        onChanged: (val) => setState(() => tag = val),
//        isWrapped: true,
//      ),
//    );
//  }
//
//  Widget hiddenChoiceItem(){
//    return Content(
//      title: 'Hidden Choice Item',
//      child: ChipsChoice<String>.multiple(
//        value: tags,
//        options: ChipsChoiceOption.listFrom<String, String>(
//          source: options,
//          value: (i, v) => v,
//          label: (i, v) => v,
//          hidden: (i, v) => ['Science', 'Politics', 'News', 'Tech'].contains(v),
//        ),
//        onChanged: (val) => setState(() => tags = val),
//        isWrapped: true,
//      ),
//    );
//  }
//
//  Widget appendAnItemToOptions(){
//    return Content(
//      title: 'Append an Item to Options',
//      child: ChipsChoice<int>.single(
//        value: tag,
//        options: ChipsChoiceOption.listFrom<int, String>(
//          source: options,
//          value: (i, v) => i,
//          label: (i, v) => v,
//        )..insert(0, ChipsChoiceOption<int>(value: -1, label: 'All')),
//        onChanged: (val) => setState(() => tag = val),
//      ),
//    );
//  }
//
//  Widget selectedWithoutCheckMarkAndBrightnessDark(){
//    return Content(
//      title: 'Selected without Checkmark and Brightness Dark',
//      child: ChipsChoice<int>.single(
//        value: tag,
//        onChanged: (val) => setState(() => tag = val),
//        options: ChipsChoiceOption.listFrom<int, String>(
//          source: options,
//          value: (i, v) => i,
//          label: (i, v) => v,
//        )..insert(0, ChipsChoiceOption<int>(value: -1, label: 'All')),
//        itemConfig: const ChipsChoiceItemConfig(
//          showCheckmark: false,
//          labelStyle: TextStyle(
//              fontSize: 20
//          ),
//          selectedBrightness: Brightness.dark,
//          // unselectedBrightness: Brightness.dark,
//        ),
//      ),
//    );
//  }
//
//  Widget asyncOptionsAndBrightnessDark(){
//    return Content(
//      title: 'Async Options and Brightness Dark',
//      child: FutureBuilder<List<ChipsChoiceOption<String>>>(
//        initialData: [],
//        future: usersMemoizer.runOnce(getUsers),
//        builder: (context, snapshot) {
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return Padding(
//              padding: const EdgeInsets.all(20),
//              child: Center(
//                child: SizedBox(
//                    width: 20,
//                    height: 20,
//                    child: CircularProgressIndicator(
//                      strokeWidth: 2,
//                    )
//                ),
//              ),
//            );
//          } else {
//            if (!snapshot.hasError) {
//              return ChipsChoice<String>.single(
//                value: user,
//                options: snapshot.data,
//                onChanged: (val) => setState(() => user = val),
//                itemConfig: ChipsChoiceItemConfig(
//                  selectedColor: Colors.green,
//                  unselectedColor: Colors.blueGrey,
//                  selectedBrightness: Brightness.dark,
//                  unselectedBrightness: Brightness.dark,
//                  showCheckmark: false,
//                ),
//              );
//            } else {
//              return Container(
//                padding: const EdgeInsets.all(25),
//                child: Text(
//                  snapshot.error.toString(),
//                  style: const TextStyle(color: Colors.red),
//                ),
//              );
//            }
//          }
//        },
//      ),
//    );
//  }
//
//  Widget worksWithFormFieldAndValidator(){
//    return Content(
//      title: 'Works with FormField and Validator',
//      child: FormField<List<String>>(
//        autovalidate: true,
//        initialValue: tags,
//        validator: (value) {
//          if (value.isEmpty) {
//            return 'Please select some categories';
//          }
//          if (value.length > 5) {
//            return "Can't select more than 5 categories";
//          }
//          return null;
//        },
//        builder: (state) {
//          return Column(
//            children: <Widget>[
//              Container(
//                alignment: Alignment.centerLeft,
//                child: ChipsChoice<String>.multiple(
//                  value: state.value,
//                  options: ChipsChoiceOption.listFrom<String, String>(
//                    source: options,
//                    value: (i, v) => v,
//                    label: (i, v) => v,
//                  ),
//                  onChanged: (val) => state.didChange(val),
//                  itemConfig: ChipsChoiceItemConfig(
//                    selectedColor: Colors.indigo,
//                    selectedBrightness: Brightness.dark,
//                    unselectedColor: Colors.indigo,
//                    unselectedBorderOpacity: .3,
//                  ),
//                  isWrapped: true,
//                ),
//              ),
//              Container(
//                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
//                  alignment: Alignment.centerLeft,
//                  child: Text(
//                    state.errorText ?? state.value.length.toString() + '/5 selected',
//                    style: TextStyle(
//                        color: state.hasError
//                            ? Colors.redAccent
//                            : Colors.green
//                    ),
//                  )
//              )
//            ],
//          );
//        },
//      ),
//    );
//  }
//
//  Widget customChoiceWidget(){
//    return Content(
//      title: 'Custom Choice Widget',
//      child: ChipsChoice<String>.multiple(
//        value: tags,
//        options: ChipsChoiceOption.listFrom<String, String>(
//          source: options,
//          value: (i, v) => v,
//          label: (i, v) => v,
//        ),
//        itemBuilder: (item, selected, select) {
//          return CustomChip(item.label, selected, select);
//        },
//        onChanged: (val) => setState(() => tags = val),
//      ),
//    );
//  }