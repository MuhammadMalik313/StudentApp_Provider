import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/db/data_model.dart';
import 'package:student_app_provider/provider/profileimgprovider.dart';
import 'package:student_app_provider/provider/student_provider.dart';
import 'package:student_app_provider/screens/add_Student_.dart';
import 'package:student_app_provider/screens/home_screen.dart';

const dataBoxName = "data";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox<StudentModel>(dataBoxName);

  // Box<StudentModel> allStudentController=Hive.box(dataBoxName);
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfImage(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
