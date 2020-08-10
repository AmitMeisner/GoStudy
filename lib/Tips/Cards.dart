import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:animated_card/animated_card.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Global.dart';



class Cards extends StatelessWidget {
  // content of the first card in the tips page.
  static final String _helpOthers="Add tips and links to help other students.";
  static final List<String> emptyList=[];
  static final int maxLikeCount=100000000;
  // list of all tip cards.
  static final _firstTip=[TipCard(_helpOthers, null, null,maxLikeCount , emptyList,false , null,DateTime.now(),null,null,[])];
  static List<TipCard> _tipCards;

  Function updateTipsPageState;
  Cards(this.updateTipsPageState);


  @override
  Widget build(BuildContext context){
    _tipCards=null;
     updateTipList(context);
      if(_tipCards==null){
        return Loading();
      }
      _tipCards=_firstTip+_tipCards;
      return Container(
        color: Global.backgroundPageColor,
        height: MediaQuery.of(context).size.height/1.35,
        padding: EdgeInsets.only(bottom: 50.0),
        child: ListView.builder(
          itemCount: _tipCards.length,
          itemBuilder: (context, index) {
            return AnimatedCard(
                direction: AnimatedCardDirection.top,
                //Initial animation direction
                initDelay: Duration(milliseconds: 0),
                //Delay to initial animation
                duration: Duration(milliseconds: 400),
                //Initial animation duration
                onRemove: (FirebaseAPI().getUid()==_tipCards[index].getUid()) ? ()=>removeTip(_tipCards[index],updateTipsPageState):null,
                curve: Curves.decelerate,
                //Animation curve
                child: cardContent(context, _tags, index, _tipCards, updateTipsPageState),
            );
          },
        ),
      );
  }


  void removeTip(TipCard tipCard,Function updateTipsPageState ){
    TipDataBase().deleteTipCard(tipCard);
    updateTipsPageState();
  }


  //get the tip cards from firebase.
  Future<List<TipCard>> updateTipList(BuildContext context) async{
    _tipCards=Provider.of<List<TipCard>>(context);
    return _tipCards;
  }

  // creating a card with the users tip and adding it to the tips list.
  void addCard(String tip, List<String> usersTags, bool isLink, String userDesc, String link, DateTime date){
    TipCard newTip;
    String uid=FirebaseAPI().getUid();
    if(isLink){
      newTip=new TipCard(tip, userDesc, usersTags, 0,emptyList, isLink , link, date,null, uid,createSearchTokens(userDesc));
    }else {
      newTip = new TipCard(tip, userDesc, usersTags, 0,emptyList,isLink, link, date,null, uid,createSearchTokens(tip));
    }
    TipDataBase().addTip(newTip);
    _tipCards.add(newTip);
    updateTipsPageState();
  }

  List<String> createSearchTokens(String tip){
    List<String> res=tip.toUpperCase().split(" ");
    List<String> tmp=[];
    int len;
    for(String elem in res){
      print(elem);
      len=elem.length;
      for(int firstIndex=0; firstIndex<(len-1);firstIndex++){
        for(int lastIndex=firstIndex+1;lastIndex<=len;lastIndex++){
          tmp.add(elem.substring(firstIndex,lastIndex).toUpperCase());
        }
      }
    }
    res.addAll(tmp);
    return res;
  }

  // creating the tags widget for the cards.
  Widget _tags(int index){
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Row(
              children: _createChildren(_tipCards[index].getTags()),
            ),
        ],
        ),
      ),
    );
  }

  // creating list of the users tags.
  List<Widget> _createChildren(List<String> lst) {
    return new List<Widget>.generate(lst.length, (int index) {
      return _courseTag(lst[index].toString());
    });
  }

  // creating the design for the tags.
  Widget _courseTag(String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.label_important, size: 14,),
          Text(text, style: TextStyle( fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

}

// class for a tip card.
// contains the tip, description, tags, like count,
// if it is a link, link and the date.
class TipCard {
  String _tip;
  String _description;
  List<String> _tags;
  int _likesCount;
  List<String> _likes;
  bool _isLink;
  String _link;
  DateTime _date;
  String _docId;
  String uid;
  List<String> _search=[];

  TipCard(this._tip, this._description,
      this._tags, this._likesCount,this._likes, this._isLink ,
      this._link, this._date, this._docId, this.uid,this._search);

  void setTip(String tip){this._tip=tip;}
  String getTip(){return this._tip;}

  void setDescription(String description){this._description=description;}
  String getDescription(){return this._description;}

  void setTags(List<String> tags){this._tags=tags;}
  List<String> getTags(){return this._tags;}
  int getLikesCount(){return this._likesCount;}

  void setIsLink(bool isLink){this._isLink=isLink;}
  bool getIsLink(){return this._isLink;}

  void setLink(String link){this._link=link;}
  String getLink(){return this._link;}

  DateTime getDate(){
    return _date;
  }

  List<String> getLikes(){
    return this._likes;
  }

  String getDocId(){
    return _docId ?? "";
  }

  void setDocId(String id){
    _docId=id;
  }

  String getUid(){
    return uid;
  }

  void setSearch(List<String> lst){
    this._search=lst;
  }

  List<String> getSearch(){
    return this._search;
  }

}


// creating the cards content.
Widget cardContent(BuildContext context,Function tags, int index , List<TipCard> tips, Function updateTipsPageState){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Card(
      color: cardColor( index, tips),
      elevation: 5,
      child: ListTile(
        title: Wrap(
          children: <Widget>[
            showTagsAndLike( context,tags, index ,tips, updateTipsPageState),
          ],
        ),
      ),
    ),
  );
}

Color cardColor(int index, List<TipCard> tips){
  if(index!=0 && FirebaseAPI().getUid()==tips[index].getUid()){
    return Global.getBackgroundColor(100);
  }
  return Colors.white;
 }



// creating the cards tags, date and like for the all the cards, except fot the first one.
Widget showTagsAndLike(BuildContext context,Function tags, int index , List<TipCard> tips, Function updateTipsPageState){
  if (index!=0) {
    return Wrap(
      children: <Widget>[
        tags(index),
        linkOrTip(context,tips, index),
        Row(
          children: <Widget>[
            Text(createDateForm(tips[index].getDate().toString())),
            Spacer(),
            LikeButton(index, updateTipsPageState),
          ],
        ),
      ],
    );
  }
  return  Wrap(
    children: <Widget>[
      Center(
          child: Text(tips[index].getTip(),
            style:GoogleFonts.cabin( fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width/19),
        )
      ),
    ],
  );
}



String createDateForm(String str){
  if(str==null || str.length<11){return "";}
  String day=str.substring(8,10);
  String month=str.substring(5,7);
  String year=str.substring(0,4);
  return(day+"/"+month+"/"+year);
}



// create the cards content based on it's type (tip or link).
Widget linkOrTip(BuildContext context,List<TipCard> tips, int index){
  bool isLink=tips[index].getIsLink();
  if(isLink){
    return linkHandle(context,tips, index);
  }else {
    return Center(child: Text(tips[index].getTip()));
  }
}

// create the link in the card.
Widget linkHandle(BuildContext context,List<TipCard> tips, int index){
  TipCard tipCard=tips[index];
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RichText(
            text:TextSpan(
                text: tipCard.getDescription(),
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic ),
                recognizer: TapGestureRecognizer()..onTap=(){launchURL(context,tipCard.getLink());}
            )
        ),
          Icon(Icons.public, size: 17,),

        ],
      ),
    ],
  );
}

// handle launching the link in the card.
Future launchURL(BuildContext context,String url)async{
  if(await canLaunch(url)){
    await launch(url, forceSafariVC: true,forceWebView: false);

  }else{
  showColoredToast("Can't Open This Link");
  }
}

// display error to the user.
void showColoredToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Global.backgroundPageColor,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white);
}

// class of the like button.
class LikeButton extends StatefulWidget {
  final int index;
  final Function updateTipsPageState;
  LikeButton(this.index, this.updateTipsPageState);
  @override
  _LikeButtonState createState() => _LikeButtonState(index, updateTipsPageState);
}

class _LikeButtonState extends State<LikeButton> {
  TipCard card;
  bool alreadySaved=false;
  Function updateTipsPageState;
  int index;
  _LikeButtonState(this.index, this.updateTipsPageState);
  @override
  Widget build(BuildContext context) {
    card= Cards._tipCards[index];
    alreadySaved=TipDataBase().isLiked(card);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(card.getLikesCount().toString()),
        IconButton(
            onPressed: (){
                if(alreadySaved){
                TipDataBase().removeLike(card);
                }else{
                TipDataBase().addLike(card);
                }
                updateTipsPageState();
            },
            icon: Icon(Icons.thumb_up, color: alreadySaved? Colors.blue: null),

        ),
      ],
    );
  }
}
