
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Global {
  final List<String> allCourses=["Calculus 1", "Linear Algebra 1", "CS 101" , "Discrete mathematics",
                                "Probability", "Calculus 2", "Linear Algebra 2", "Software 1", "Data Structures",
                                "Statistics", "Computer Structure", "Algorithms", "Software Project", "Computational models",
                                "Operating Systems", "Logic","Complexity","Compilation"];
  static List<String> userCourses=[];
  final List<double> allHours = [32.5,38,43,48,53,58,63,67,85];
  final List<double> allGrades = [62,67,72,77,82,87,92,97];


  static Color backgroundPageColor=Colors.grey[300];
  static Color backgroundUserTipColor=Colors.blue[100];
  static Color goldStars=Colors.yellow[600];




  final List<String> criterias = ["Overall Average","Percentage of HW Solved", "Percentage of  Recitations Attended","Percentage of Classes Attended", "Percentage of HW Solved Before exams","Extra"];

  final List<String> allResources = ["Lectures", "Recitations", "Homeworks", "Exams", "Extra"];
  // return a list of all courses.
  List<String> getAllCourses(){
    List<String> courses= new List<String>.from(allCourses);
    return courses;
  }

  List<double> getAllGrades(){
    List<double> grades= new List<double>.from(allGrades);
    return grades;
  }

  List<double> getAllHours(){
    List<double> hours= new List<double>.from(allHours);
    return hours;
  }

  // return a list of resources.
  List<String> getAllResources(){
    List<String> resources= new List<String>.from(allResources);
    return resources;
  }

  //return a list of the users courses.
  List<String> getUserCourses(){
    List<String> courses= new List<String>.from(userCourses);
    return courses;
  }

  //setting the list of the users courses.
  void setUserCourses(List<String> courses){
    userCourses.clear();
    for(int i=0 ; i<courses.length ; i++){
      userCourses.add(courses[i]);
    }
  }

  static Color getBackgroundColor(int shade){
    if(shade==0){return Colors.teal;}
    else{return Colors.teal[shade];}
  }

}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(150.0),
        child: SpinKitSpinningCircle(
          color:  Global.getBackgroundColor(0),
          size: 50.0,
        ),
      ),

    );
  }
}
