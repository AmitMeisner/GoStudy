


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Global.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'InformationPage.dart';


class InfoCourse extends StatefulWidget {
  int courseIndex;
  InfoCourse(this.courseIndex);
  @override
  InfoCourseState createState() => InfoCourseState(courseIndex);
}

  class InfoCourseState extends State<InfoCourse> {
    int courseIndex;
    int examHours ;
    int extraHours ;
    int homeworkHours ;
    int recitationHours ;
    int lecturesHours  ;
    int grade ;

    InfoCourseState(this.courseIndex);
    String userId = FirebaseAPI().getUid();
    double average = 80.0;

    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
            title: new Text("Flutter GridView")
        ),
        body: buildChild(context, 1),
      );
    }


    Widget buildChild(BuildContext context, int courseIndex) {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
//        decoration: BoxDecoration(
//            shape: BoxShape.rectangle,
//            borderRadius: BorderRadius.all(Radius.circular(12))
//        ),
        children: <Widget>[
          SizedBox(height: 24,),
          Text('how long in total(hours) did you study for the exam?',
            style: TextStyle(fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          totalExamHours(),
          SizedBox(height: 40,),
          Text(
            'how long in total(hours) did you study for the homeworks ?',
            style: TextStyle(fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          totalHomeworkHours(),
          SizedBox(height: 40,),
          Text(
            'how long in total(hours) did you study for the recitations ?',
            style: TextStyle(fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          totalRecitationsHours(),
          SizedBox(height: 40,),
          Text(
            'how long in total(hours) did you study for the lectures ?',
            style: TextStyle(fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          totalLecturesHours(),
          SizedBox(height: 40,),
          Text(
            'how long in total(hours) did you study using extra material ?',
            style: TextStyle(fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          totalExtraHours(),
          SizedBox(height: 40,),
          Text('what is your final grade?', style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          totalGrade(),
          SizedBox(height: 8,),
          Row(
          children: <Widget>[
          RaisedButton(
            onPressed: () {
            return Navigator.of(context).pop(true);
          },
            child: Text('BACK'),
            color: Colors.white,
            textColor: Colors.redAccent,),
          RaisedButton(
            onPressed: () {
              onClick(context);
            },
            child: Text('ENTER INFO'),
            color: Colors.white,
            textColor: Colors.redAccent,)
            ],
          ),
        ],
      );
    }


     void onClick(BuildContext context){
      if(examHours == null || homeworkHours == null || recitationHours==null
      ||lecturesHours==null || extraHours == null || grade ==null){
         return showColoredToast("please select all fields before you enter the data");

      } else{
        return enterData(context);

      }

    }

    void enterData(BuildContext context) {
      UserStatForCourse userInfo = new UserStatForCourse(
        Global().getAllCourses()[courseIndex],
        average,
        Global().getAllHours()[homeworkHours - 1],
        Global().getAllHours()[lecturesHours - 1],
        Global().getAllHours()[recitationHours - 1],
        Global().getAllHours()[examHours - 1],
        Global().getAllHours()[extraHours - 1],
        Global().getAllGrades()[grade - 1],
        userId,

      );
      AllUserDataBase().addUserData(userInfo);
      return Navigator.of(context).pop(true);
    }

    Widget totalRecitationsHours() {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 1,
                  groupValue: recitationHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      recitationHours=T;
                    });
                  }),
              Text("30-35"),
              Radio(
                  value: 2,
                  groupValue: recitationHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      recitationHours=T;
                    });
                  }),
              Text("36-40"),
              Radio(
                  value: 3,
                  groupValue: recitationHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      recitationHours=T;
                    });
                  }),
              Text("41-45"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 4,
                  groupValue: recitationHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      recitationHours=T;
                    });
                  }),
              Text("46-50"),
              Radio(
                  value: 5,
                  groupValue: recitationHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      recitationHours=T;
                    });
                  }),
              Text("51-55"),
              Radio(
                  value: 6,
                  groupValue: recitationHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      recitationHours=T;
                    });
                  }),
              Text("56-60"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 7,
                  groupValue: recitationHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      recitationHours=T;
                    });
                  }),
              Text("61-65"),
              Radio(
                  value: 8,
                  groupValue: recitationHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      recitationHours=T;
                    });
                  }),
              Text("66-70"),
              Radio(
                  value: 9,
                  groupValue: recitationHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      recitationHours=T;
                    });
                  }),
              Text("70+"),
            ],
          ),
        ],

      );
    }


    Widget totalHomeworkHours() {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 1,
                  groupValue: homeworkHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      homeworkHours=T;
                    });
                  }),
              Text("30-35"),
              Radio(
                  value: 2,
                  groupValue: homeworkHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      homeworkHours=T;
                    });
                  }),
              Text("36-40"),
              Radio(
                  value: 3,
                  groupValue: homeworkHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      homeworkHours=T;
                    });
                  }),
              Text("41-45"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 4,
                  groupValue: homeworkHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      homeworkHours=T;
                    });
                  }),
              Text("46-50"),
              Radio(
                  value: 5,
                  groupValue: homeworkHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      homeworkHours=T;
                    });
                  }),
              Text("51-55"),
              Radio(
                  value: 6,
                  groupValue: homeworkHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      homeworkHours=T;
                    });
                  }),
              Text("56-60"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 7,
                  groupValue: homeworkHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      homeworkHours=T;
                    });
                  }),
              Text("61-65"),
              Radio(
                  value: 8,
                  groupValue: homeworkHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      homeworkHours=T;
                    });
                  }),
              Text("66-70"),
              Radio(
                  value: 9,
                  groupValue: homeworkHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      homeworkHours=T;
                    });
                  }),
              Text("70+"),
            ],
          ),
        ],

      );
    }



    Widget totalLecturesHours() {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 1,
                  groupValue: lecturesHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      lecturesHours=T;
                    });
                  }),
              Text("30-35"),
              Radio(
                  value: 2,
                  groupValue: lecturesHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      lecturesHours=T;
                    });
                  }),
              Text("36-40"),
              Radio(
                  value: 3,
                  groupValue: lecturesHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      lecturesHours=T;
                    });
                  }),
              Text("41-45"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 4,
                  groupValue: lecturesHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      lecturesHours=T;
                    });
                  }),
              Text("46-50"),
              Radio(
                  value: 5,
                  groupValue: lecturesHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      lecturesHours=T;
                    });
                  }),
              Text("51-55"),
              Radio(
                  value: 6,
                  groupValue: lecturesHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      lecturesHours=T;
                    });
                  }),
              Text("56-60"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 7,
                  groupValue: lecturesHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      lecturesHours=T;
                    });
                  }),
              Text("61-65"),
              Radio(
                  value: 8,
                  groupValue: lecturesHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      lecturesHours=T;
                    });
                  }),
              Text("66-70"),
              Radio(
                  value: 9,
                  groupValue: lecturesHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      lecturesHours=T;
                    });
                  }),
              Text("70+"),
            ],
          ),
        ],

      );
    }


    Widget totalExtraHours() {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 1,
                  groupValue: extraHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      extraHours=T;
                    });
                  }),
              Text("30-35"),
              Radio(
                  value: 2,
                  groupValue: extraHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      extraHours=T;
                    });
                  }),
              Text("36-40"),
              Radio(
                  value: 3,
                  groupValue: extraHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      extraHours=T;
                    });
                  }),
              Text("41-45"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 4,
                  groupValue: extraHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      extraHours=T;
                    });
                  }),
              Text("46-50"),
              Radio(
                  value: 5,
                  groupValue: extraHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      extraHours=T;
                    });
                  }),
              Text("51-55"),
              Radio(
                  value: 6,
                  groupValue: extraHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      extraHours=T;
                    });
                  }),
              Text("56-60"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                  value: 7,
                  groupValue: extraHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      extraHours=T;
                    });
                  }),
              Text("61-65"),
              Radio(
                  value: 8,
                  groupValue: extraHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      extraHours=T;
                    });
                  }),
              Text("66-70"),
              Radio(
                  value: 9,
                  groupValue: extraHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      extraHours=T;
                    });
                  }),
              Text("70+"),
            ],
          ),
        ],

      );
    }


    Widget totalExamHours() {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: examHours,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    examHours=T;
                  });
                  }),
              Text("30-35"),
              Radio(
                value: 2,
                  groupValue: examHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      examHours=T;
                    });
                  }),
              Text("36-40"),
              Radio(
                value: 3,
                  groupValue: examHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      examHours=T;
                    });
                  }),
              Text("41-45"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                value: 4,
                  groupValue: examHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      examHours=T;
                    });
                  }),
              Text("46-50"),
              Radio(
                value: 5,
                  groupValue: examHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      examHours=T;
                    });
                  }),
              Text("51-55"),
              Radio(
                value: 6,
                  groupValue: examHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      examHours=T;
                    });
                  }),
              Text("56-60"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                value: 7,
                  groupValue: examHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      examHours=T;
                    });
                  }),
              Text("61-65"),
              Radio(
                value: 8,
                  groupValue: examHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      examHours=T;
                    });
                  }),
              Text("66-70"),
              Radio(
                value: 9,
                  groupValue: examHours,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                    setState(() {
                      examHours=T;
                    });
                  }),
              Text("70+"),
            ],
          ),
        ],

      );
    }


    Widget totalGrade() {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: grade,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                  setState(() {
                    grade=T;
                  });
          }),

              Text("60-64"),
              Radio(
                value: 2,
                  groupValue: grade,
                  activeColor: InformationPage.focusColor,
                  onChanged: (T){
                  setState(() {
                  grade=T;
                  });}
              ),
              Text("65-69"),
              Radio(
                value: 3,
                groupValue: grade,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                setState(() {
                grade=T;
                });}
              ),
              Text("70-74"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                value: 4,
                groupValue: grade,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                setState(() {
                grade=T;
                });}
              ),
              Text("75-79"),
              Radio(
                value: 5,
                groupValue: grade,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                setState(() {
                grade=T;
                });}
              ),
              Text("80-84"),
              Radio(
                value: 6,
                groupValue: grade,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                setState(() {
                grade=T;
                });}
              ),
              Text("85-89"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                value: 7,
                groupValue: grade,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                setState(() {
                grade=T;
                });}
              ),
              Text("90-95"),
              Radio(
                value: 8,
                groupValue: grade,
                activeColor: InformationPage.focusColor,
                onChanged: (T){
                setState(() {
                grade=T;
                });}
              ),
              Text("96-100"),
            ],
          ),
        ],

      );
    }
  }

void showColoredToast(String msg) {
  Fluttertoast.showToast(
      fontSize: 18,
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.black,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white);
}