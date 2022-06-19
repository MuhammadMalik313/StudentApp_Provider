import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app_provider/db/data_model.dart';
import 'package:student_app_provider/main.dart';
import 'package:student_app_provider/screens/home_screen.dart';

class EditDetailsScreen extends StatefulWidget {
  int index;
  EditDetailsScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<EditDetailsScreen> createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  List<StudentModel> models = allStudentController.values.toList();

  XFile? image;
  Box<StudentModel> box = Hive.box<StudentModel>(dataBoxName);
  dynamic imagepath;

// TextEditingController enterfield=TextEditingController();
  TextEditingController ageController = TextEditingController();

  TextEditingController classController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  final kHeight = SizedBox(
    height: 20,
  );
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagepath = image!.path;
    } else {
      return null;
    }
    // setState(() {

    // });

    print("...............$imagepath");
  }

  @override
  Widget build(BuildContext context) {
    final data = models[widget.index];
    nameController.text = data.name;
    ageController.text = data.age;
    classController.text = data.standard;
    numberController.text = data.rollNo;
    // int index;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("STUDENT DETAILS"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            image == null
                ? CircleAvatar(
                    backgroundColor: Colors.red,
                  )
                : CircleAvatar(child: Image.file(File(imagepath))),
            kHeight,
            IconButton(
                onPressed: () {
                  pickImage();
                  print(imagepath);
                },
                icon: Icon(Icons.image)),
            InputBox(
              hint: "enter Your Name",
              enterfield: nameController,
            ),
            kHeight,
            InputBox(
              hint: "Enter Your Age",
              enterfield: ageController,
            ),
            kHeight,
            InputBox(
              hint: "Enter Your Class",
              enterfield: classController,
            ),
            kHeight,
            InputBox(
              hint: "Enter Your Roll Number",
              enterfield: numberController,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    box.putAt(widget.index, updateStudent());
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
                },
                icon: Icon(Icons.edit),
                label: Text("edit")),
          ],
        ),
      )),
    );
  }

  updateStudent() {
    return StudentModel(
        name: nameController.text,
        age: ageController.text,
        standard: classController.text,
        rollNo: numberController.text,
        image: imagepath);
  }
}

class InputBox extends StatelessWidget {
  String hint;
  TextEditingController enterfield;
  //  TextEditingController ageController=TextEditingController();
  //   TextEditingController classController=TextEditingController();
  //    TextEditingController numberController=TextEditingController();

  InputBox({Key? key, required this.hint, required this.enterfield})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: enterfield,
      decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
