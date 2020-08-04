
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


  static Color backgroundPageColor=Colors.white;
  static Color backgroundUserTipColor=Colors.blue[100];
  static Color goldStars=Colors.yellow[600];




  final List<String> criterias = ["Overall Average","Percentage of HW Solved", "Percentage of  Recitations Attended","Percentage of Classes Attended", "Percentage of HW Solved Before exams","Extra"];

  final List<String> allResources = ["Lectures", "Recitations", "Homeworks", "Exams", "Extra"];
  // return a list of all courses.
  double getAllGrades(String grade){
    switch(grade) {
      case "0-60": {  return 60.0; }
      break;
      case "60-65": {  return 62.0; }
      break;
      case "65-70": {  return 67.0;  }
      break;
      case "70-75": {  return 72.0;  }
      break;
      case "75-80": {  return 77.0;  }
      break;
      case "80-85": {  return 82.0;  }
      break;
      case "85-90": {  return 87.0;  }
      break;
      case "90-95": {  return 92;  }
      break;
      case "95-100": {  return 97.0;  }
      break;
      default: { print("Invalid choice"); }
      break;
    }

  }

  List<String> getAllCourses(){
    List<String> courses= new List<String>.from(allCourses);
    return courses;
  }

  double getHour(String hour){
    //List<double> hours= new List<double>.from(allHours);
    switch(hour) {
      case "30-35": {  return 32.0; }
      break;
      case "35-40": {  return 37.0; }
      break;
      case "40-45": {  return 42.0;  }
      break;
      case "45-50": {  return 47.0;  }
      break;
      case "50-55": {  return 52.0;  }
      break;
      case "55-60": {  return 57.0;  }
      break;
      case "60-65": {  return 62.0;  }
      break;
      case "65-70": {  return 67;  }
      break;
      case "70+": {  return 70.0;  }
      break;
      default: { print("Invalid choice"); }
      break;
    }

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
    if(shade==0){return Colors.blueAccent;}
    else{return Colors.blue[shade];}
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
