
class Courses {
  final List<String> allCourses=["general","Calculus 1", "Calculus 2","Statistic", "Linear Algebra 1","Linear Algebra 2","CS 101", "Algorithms"];
  static List<String> userCourses=[];

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


