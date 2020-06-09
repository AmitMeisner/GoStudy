
class Courses {
  final List<String> allCourses=["Calculus 1", "Linear Algebra 1", "CS 101" , "Discrete mathematics",
                                "Probability", "Calculus 2", "Linear Algebra 2", "Software 1", "Data Structures",
                                "Statistics", "Computer Structure", "Algorithms", "Software Project", "Computational models",
                                "Operating Systems", "Logic","Complexity","Compilation"];
  static List<String> userCourses=[];

  final List<String> criterias = ["Overall Average","Percentage of HW Solved", "Percentage of  Recitations Attended","Percentage of Classes Attended", "Percentage of HW Solved Before exams","Extra"];


  // return a list of all courses.
  List<String> getAllCourses(){
    List<String> courses= new List<String>.from(allCourses);
    return courses;
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


}


