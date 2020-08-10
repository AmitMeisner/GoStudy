import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsDataBase {
   int itemsCount;
   List<String> coursesSelected;
   List<String> resourceSelected;
  double total = 0.0;
  StatisticsDataBase(this.itemsCount, this.coursesSelected,
      this.resourceSelected);


  static Future<List<int>> queryValues(String course, String resource) async{
    List<int> res=[];

    res= List<int>.from(
        (await Firestore.instance.collection('AllUsers').where('course', isEqualTo: course).getDocuments())
            .documents.map((snapshot){
                  if(snapshot.data[resource]==null){
                    return null;
                  }
                  return snapshot.data[resource].round();}
                  ).toList());


    return res;
  }


}


class DataModel{
  String exam;
  String homework;
  String grade;
  String docId;
  DataModel({this.exam,this.grade,this.homework,this.docId});
  DataModel.fromJson(Map<String,dynamic>data,String id)
      :exam=data['Exams'],
        docId=id,
        grade=data['Final Grade'],
        homework=data['Homeworks'];
}

class DataService {
  Firestore firestore = Firestore.instance;

  Stream<List<DataModel>> getData() {
    return firestore.collection("AllUsers").snapshots().map((sanpshot) =>
        sanpshot.documents.map((e) => DataModel.fromJson(e.data,e.documentID)).toList());

  }
}

