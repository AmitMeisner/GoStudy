import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:animated_card/animated_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';


class Cards extends StatelessWidget {
//  final lista = List.generate(50, (index) => index);
//   int numbOfCards=1;
   static final String helpOthers="Add tips and links to help other students.";
//   static List<String> tips= [helpOthers];
//   static List<List<String>> tipTags=[null,];
//   static List<int> numberOfLikes=[0];
   static List<UsersTipsAndLinks> lst=[UsersTipsAndLinks(helpOthers, null, null, 0, false , null)];



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 500.0,
       child:ListView.builder(
//        itemCount: tips.length,
        itemCount: lst.length,
        itemBuilder: (context, index) {
          return AnimatedCard(
            direction: AnimatedCardDirection.top, //Initial animation direction
            initDelay: Duration(milliseconds: 0), //Delay to initial animation
            duration: Duration(milliseconds: 400), //Initial animation duration
//            onRemove: () => lista.removeAt(index), //Implement this action to active dismiss
            curve: Curves.decelerate, //Animation curve
//            child: cardContent(tags, index, tips)
              child: cardContent(context,tags, index, lst)
          );
        },
      ),
    );
  }

  void addCard(String tip, List<String> usersTags, bool isLink, String userDesc, String link){
//    tips.add(tip);
//    tipTags.add(usersTags);
//    numberOfLikes.add(0);
    UsersTipsAndLinks newTip;

    if(isLink){
      newTip=new UsersTipsAndLinks(tip, userDesc, usersTags, 0, isLink , link);
    }else {
      newTip = new UsersTipsAndLinks(tip, userDesc, usersTags, 0, isLink, link);
    }

    lst.add(newTip);
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
                Container(
                    decoration: BoxDecoration(border: Border.all(width: 2)),
                    child: Text(" tags ", style: TextStyle(backgroundColor: Colors.grey[300]))),
              ],
            ),
            Row(
//              children: _createChildren(tipTags[index]),
              children: _createChildren(lst[index].getTags()),
            ),
        ],
        ),
      ),
    );
  }

  List<Widget> _createChildren(List<String> lst) {
    return new List<Widget>.generate(lst.length, (int index) {
      return courseTag(lst[index].toString());
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
  bool isLink;
  String link;

  UsersTipsAndLinks(this.tip, this.description,
      this.tags, this.likesCount, this.isLink , this.link);

  void setTip(String tip){this.tip=tip;}
  String getTip(){return this.tip;}

  void setDescription(String description){this.description=description;}
  String getDescription(){return this.description;}

  void setTags(List<String> tags){this.tags=tags;}
  List<String> getTags(){return this.tags;}

  void addLike(){this.likesCount++;}
  void removeLike(){this.likesCount--;}
  int getLikesCount(){return this.likesCount;}

  void setIsLink(bool isLink){this.isLink=isLink;}
  bool getIsLink(){return this.isLink;}

  void setLink(String link){this.link=link;}
  String getLink(){return this.link;}

}




Widget cardContent(BuildContext context,Function tags, int index , List<UsersTipsAndLinks> tips){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Card(
      elevation: 5,
      child: ListTile(
        title: Wrap(
          children: <Widget>[
            showTagsAndLike( context,tags, index ,tips)
          ],
        ),
      ),
    ),
  );
}

Widget showTagsAndLike(BuildContext context,Function tags, int index , List<UsersTipsAndLinks> tips){
  if (index!=0) {
    return Wrap(
      children: <Widget>[
        tags(index),
//        Center(child: Text(tips[index])),
        linkOrTip(context,tips, index),
        LikeButton(index),
      ],
    );
  }
  return  Wrap(
    children: <Widget>[
      Center(child: Text(tips[index].getTip())),
    ],
  );
}

Widget linkOrTip(BuildContext context,List<UsersTipsAndLinks> tips, int index){
  bool isLink=tips[index].getIsLink();
  if(isLink){
    return linkHandle(context,tips, index);

  }else {
    return Center(child: Text(tips[index].getTip()));
  }
}


Widget linkHandle(BuildContext context,List<UsersTipsAndLinks> tips, int index){
  UsersTipsAndLinks tipCard=tips[index];
  return Column(
    children: <Widget>[
//      Row(
//          children:<Widget>[
//            Text("Description:",
//                style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    backgroundColor: Colors.grey[300]
//                )
//            ),
//            Text(" "+tipCard.getDescription()),
//          ]
//      ),
//      Text(tipCard.getLink()),
      Center(
        child: RichText(
          text:TextSpan(
            text: tipCard.getDescription(),
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()..onTap=(){launchURL(context,tipCard.getLink());}
          )
        ),
      ),
    ],
  );
}

Future launchURL(BuildContext context,String url)async{
  if(await canLaunch(url)){
    await launch(url, forceSafariVC: true,forceWebView: false);

  }else{
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Can't Open This Link")));
  showColoredToast();
  }
}


void showColoredToast() {
  Fluttertoast.showToast(
      msg: "Can't Open This Link",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.grey,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white);
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
        Text(Cards.lst[index].getLikesCount().toString()),
        IconButton(
            onPressed: (){
              alreadySaved? Cards.lst[index].removeLike() : Cards.lst[index].addLike();
              alreadySaved=alreadySaved? false:true;
              setState(() {});
            },
            icon: Icon(Icons.thumb_up, color: alreadySaved? Colors.blue: null),

        ),
      ],
    );
  }
}
