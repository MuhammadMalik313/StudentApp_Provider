import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/db/data_model.dart';
import 'package:student_app_provider/main.dart';
import 'package:student_app_provider/provider/profileimgprovider.dart';
import 'package:student_app_provider/provider/student_provider.dart';
import 'package:student_app_provider/screens/home_screen.dart';

class StudentDetailsScreen extends StatelessWidget {
  StudentDetailsScreen({Key? key}) : super(key: key);

// class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  XFile? image;
  Box<StudentModel> box = Hive.box<StudentModel>(dataBoxName);
  dynamic imagepath;
  final ImagePicker picker = ImagePicker();

// TextEditingController enterfield=TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController classController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  final kHeight = SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("ADD STUDENT"),
        centerTitle: true,
        actions: [
          // icon: Icon(Icons.add),
          // label: Text("ADD")),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          height: 600,
          width: 600,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration:
                            Provider.of<ProfImage>(context, listen: true)
                                            .currentimage ==
                                        null ||
                                    imagepath == null
                                ? BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/avathar.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                                    // borderRadius: BorderRadius.circular(40),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ))
                                : BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: FileImage(File(
                                            Provider.of<ProfImage>(context,
                                                    listen: true) .currentimage)),
                                        fit: BoxFit.cover),
                                  ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 100,
                    top: 120,
                    child: Container(
                      width: 47,
                      height: 47,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          )),
                      // color: Colors.red,
                      child: IconButton(
                          onPressed: () {
                            showImage(context);
                            print(imagepath);
                          },
                          icon: Padding(
                            padding:
                                const EdgeInsets.only(right: 50, bottom: 30),
                            child: Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              kHeight,
              Container(
                height: 350,
                decoration: BoxDecoration(
                    //  color: Colors.purple.withOpacity(.5),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    InputBox(
                      type: TextInputType.text,
                      enterfield: nameController,
                      label: "Student Name",
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: InputBox(
                            type: TextInputType.number,
                            label: "Mobile Number",
                            enterfield: emailController,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: InputBox(
                            type: TextInputType.number,
                            label: "Class",
                            enterfield: classController,
                          ),
                        )
                      ],
                    ),
                    InputBox(
                      type: TextInputType.text,
                      label: "Email",
                      enterfield: numberController,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // box.add(addStudent());
                        addStudentBtnClicked(context);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        "ADD",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  addStudentBtnClicked(context) {
    final name = nameController.text;
    final email = emailController.text;
    final standard = classController.text;
    final rollNo = numberController.text;

    if (name.isEmpty || email.isEmpty || standard.isEmpty || rollNo.isEmpty) {
      return;
    } else {
      final student = StudentModel(
          name: name,
          age: email,
          standard: standard,
          rollNo: rollNo,
          image: imagepath);
      return Provider.of<StudentProvider>(context, listen: false)
          .addStudent(student);

      // StudentModel(
      //     name: name,
      //     age: email,
      //     standard: standard,
      //     rollNo: rollNo,
      //     image: imagepath);
    }
  }

  Future pickImageGallery(context) async {
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    } else {
      imagepath = image!.path;

      Provider.of<ProfImage>(context, listen: false)
          .getimgview(image: imagepath);
    }

    // setState(() {

    // });

    print("...............$imagepath");
  }

  Future pickImagecamera(context) async {
    image = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);

    if (image == null) {
      return null;
    } else {
      imagepath = image!.path;

      Provider.of<ProfImage>(context, listen: false)
          .getimgview(image: imagepath);
    }
    // setState(() {

    // });

    print("...............$imagepath");
  }

  showImage(ctx) {
    return showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Column(
              children: [
                Text("Choose Your Option"),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          await pickImagecamera(context);
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.camera),
                        label: Text("Camera"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await pickImageGallery(context);
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.photo),
                        label: Text("Gallery"),
                      ),
                    ]),
              ],
            ),
          );
        });
  }
}

class InputBox extends StatelessWidget {
  String label;
  TextEditingController enterfield;
  final TextInputType type;
  //  TextEditingController ageController=TextEditingController();
  //   TextEditingController classController=TextEditingController();
  //    TextEditingController numberController=TextEditingController();

  InputBox(
      {Key? key,
      required this.enterfield,
      required this.label,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color.fromARGB(255, 189, 169, 193),
      decoration: BoxDecoration(
          // color:Color.fromARGB(255, 189, 169, 193),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
            keyboardType: type,
            style: TextStyle(fontSize: 16),
            controller: enterfield,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            )),
      ),
    );
  }
}
