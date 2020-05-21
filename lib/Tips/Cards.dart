import 'package:flutter/material.dart';
import 'package:animated_card/animated_card.dart';



class Cards extends StatelessWidget {
//  final lista = List.generate(50, (index) => index);
//   int numbOfCards=1;
   static final String helpOthers="Add tips and links to help other students.";
   static List<String> tips= [helpOthers];
   static List<List<String>> tipTags=[null,];
   static List<int> numberOfLikes=[0];




  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 500.0,
       child:ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return AnimatedCard(
            direction: AnimatedCardDirection.top, //Initial animation direction
            initDelay: Duration(milliseconds: 0), //Delay to initial animation
            duration: Duration(milliseconds: 400), //Initial animation duration
//            onRemove: () => lista.removeAt(index), //Implement this action to active dismiss
            curve: Curves.decelerate, //Animation curve
            child: cardContent(tags, index, tips)
          );
        },
      ),
    );
  }

  void addCard(String tip, List<String> usersTags, bool link, String userDesc){
    tips.add(tip);
    tipTags.add(usersTags);
    numberOfLikes.add(0);

  }

  Widget tags(int index){
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(0, 0, 0,10),
        child: Row(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("tags:", style: TextStyle(backgroundColor: Colors.grey[300]),),
              ],
            ),
            Row(
              children: _createChildren(tipTags[index]),
            ),
        ],
        ),
      ),
    );
  }

  List<Widget> _createChildren(List<String> someList) {
    return new List<Widget>.generate(someList.length, (int index) {
      return courseTag(someList[index].toString());
    });
  }


  Widget courseTag(String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.label_important, size: 14,),
          Text(text, style: TextStyle(backgroundColor: Colors.grey[300], fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

}


class UsersTipsAndLinks {
  String tip;
  String description;
  List<String> tags;
  int likesCount;



}




Widget cardContent(Function tags, int index , List<String> tips){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Card(
      elevation: 5,
      child: ListTile(
        title: Wrap(
          children: <Widget>[
            showTagsAndLike(tags, index ,tips)
          ],
        ),
      ),
    ),
  );
}

Widget showTagsAndLike(Function tags, int index , List<String> tips){
  if (index!=0) {
    return Wrap(
      children: <Widget>[
        tags(index),
        Center(child: Text(tips[index])),
        LikeButton(index),
      ],
    );
  }
  return Wrap(
    children: <Widget>[
      Center(child: Text(tips[index])),
    ],
  );
}


class LikeButton extends StatefulWidget {
  final int index;
  const LikeButton(this.index);
  @override
  _LikeButtonState createState() => _LikeButtonState(index);
}

class _LikeButtonState extends State<LikeButton> {
  bool alreadySaved=false;
  int index;
  _LikeButtonState(this.index);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(Cards.numberOfLikes[index].toString()),
        IconButton(
            onPressed: (){
              alreadySaved? Cards.numberOfLikes[index]-- : Cards.numberOfLikes[index]++;
              alreadySaved=alreadySaved? false:true;
              setState(() {});
            },
            icon: Icon(Icons.thumb_up, color: alreadySaved? Colors.blue: null),

        ),
      ],
    );
  }
}
