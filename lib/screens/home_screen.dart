import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/db/data_model.dart';
import 'package:student_app_provider/main.dart';
import 'package:student_app_provider/screens/view_student_screen.dart';

import '../provider/student_provider.dart';
import 'add_Student_.dart';

final allStudentController = Hive.box<StudentModel>(dataBoxName);

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
// List<StudentModel> data=[];
  @override
  Widget build(BuildContext context) {
    final models = allStudentController.values.toList();
 Box<StudentModel> box = Hive.box<StudentModel>(dataBoxName);

    // print("..................${.age}");

    return Scaffold(
      appBar: AppBar(
        title: Text("List Of Students"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => StudentDetailsScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<StudentProvider>(
        builder: (context, value, child) {
        return ListView.separated(
            itemBuilder: (ctx, index) {
              // final aju =data[index];
      
              return ListTile(
                leading: CircleAvatar(
                  child: Image.file(File(models[index].image)),
      
                  //backgroundColor: Colors.red,
                ),
                title: Text(models[index].age),
                subtitle: Text(models[index].name),
                trailing: IconButton(
                    onPressed: () {
                      // Provider.of<StudentProvider>(context, listen: false)
                      //     .deleteDetails(index);
                      context.read<StudentProvider>().deleteDetails(index);
                      
                      print(models);
                      //  box.deleteAt(index);
                    },
                    icon: Icon(Icons.delete)),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => ViewStudentScreen(index: index)))),
              );
            },
            separatorBuilder: (ctx, index) {
              return Divider();
            },
            itemCount: models.length);
  }),
    );
  }
}
