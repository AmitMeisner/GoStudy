

class Courses {
  final List<String> allCourses=["general","Calculus 1", "Calculus 2","Statistic", "Linear Algebra 1","Linear Algebra 2","CS 101", "Algorithms"];
  static List<String> userCourses=[];



  List<String> getAllCourses(){
    List<String> courses= new List<String>.from(allCourses);
    return courses;
  }

  List<String> getUserCourses(){
    List<String> courses= new List<String>.from(userCourses);
    return courses;
  }

  void setUserCourses(List<String> courses){
    userCourses.clear();
    for(int i=0 ; i<courses.length ; i++){
      userCourses.add(courses[i]);
    }
  }


}


