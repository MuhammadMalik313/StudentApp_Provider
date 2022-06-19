import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_app_provider/db/data_model.dart';
import 'package:student_app_provider/screens/edit_screen.dart';
import 'package:student_app_provider/screens/home_screen.dart';

class ViewStudentScreen extends StatelessWidget {
 
  final int index;
    List<StudentModel> models = allStudentController.values.toList();

  ViewStudentScreen({
    Key? key,
    required this.index
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final data=models[index];
    return Scaffold(
      appBar: AppBar(
        actions: [
           IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditDetailsScreen(index:index,),));
           }, icon: Icon(Icons.edit))
        ],
      ),
      body: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: data.image.isEmpty
                ? const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/avathar.png'),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  )
                : BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(File(data.image)), fit: BoxFit.cover),
                  ),
          ),
           Text(data.name),
           Text(data.age),
           Text(data.rollNo),
           Text(data.standard)
        ],
      ),
    );
  }
 
}
