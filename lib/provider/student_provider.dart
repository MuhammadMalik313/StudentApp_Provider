import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_app_provider/db/data_model.dart';

import '../main.dart';

class StudentProvider extends ChangeNotifier{

  

  Box<StudentModel> box = Hive.box<StudentModel>(dataBoxName);

addStudent(StudentModel value ){
  box.add(value);
  print(".................................${box.values}");
  notifyListeners();


}
void deleteDetails(int index){
  box.deleteAt(index);
  print(index);
  notifyListeners();
}



  

}