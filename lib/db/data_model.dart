import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String age;
  @HiveField(3)
  String standard;
  @HiveField(4)
  String rollNo;
  @HiveField(5)
  String image;
  StudentModel(
      {required this.name,
      required this.age,
      required this.standard,
      required this.rollNo,
      required this.image});
}
