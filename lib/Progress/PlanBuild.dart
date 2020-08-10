import 'package:flutterapp/FirstInfo/InformationPage.dart';
import 'package:flutterapp/Global.dart';
import 'package:flutterapp/firebase/FirebaseAPI.dart';

class PlanBuild{

  List<UserStatForCourse> users=[];
  double hw=1.0;
  double recitation=1.0;
  double lectures=1.0;
  double exams=1.0;
  double extra=1.0;
  double semesterHours=1.0;
  UserProgress user;
  List<UserStatForCourse> tmp=[];
  List<String> Goals=[];
  int dedication;


  PlanBuild(this.users,this.dedication);

  void setAvg() {
    int i=0;
    hw=5.0;
    recitation=5.0;
    lectures=5.0;
    exams=5.0;
    extra=5.0;
    for (UserStatForCourse user in tmp) {
      hw+=(user.getHWTime());
      recitation+=(user.getRecTime());
      lectures+=(user.getLectureTime());
      exams+=(user.getExamTime());
      extra+=(user.getExtraTime());
      i++;
    }
    if(i==0){i=1;}
    hw=hw/i;
    recitation=recitation/i;
    lectures=lectures/i;
    exams=exams/i;
    extra=extra/i;
    semesterHours+=(hw+recitation+lectures+exams+extra)*13;
  }

  List<double> getPlan(){
    setAvg();
    List<double> res=[hw,recitation,lectures,exams,extra];
    return res;
  }

  Future<void> createPlan()async{
    user=await UserProgressDataBase().getUser(FirebaseAPI().getUid());
    user.resetGoals();
    List<String> courses=Global().getUserCourses();
    for(String course in courses){
      tmp=[];
      for(UserStatForCourse student in users){
        if(student.getCourse()==course){
          tmp.add(student);
        }
      }
      List<double> res=getPlan();
      user.addGoal(course, Activities.HomeWork, res[0]);
      user.addGoal(course, Activities.Recitation, res[1]);
      user.addGoal(course, Activities.Lectures, res[2]);
      user.addGoal(course, Activities.Exams, res[3]);
      user.addGoal(course, Activities.Extra, res[4]);
    }
    user.addGoal(null, null, semesterHours);
    user.setDedication(dedication);
    await UserProgressDataBase().updateUser(user);
  }


}



