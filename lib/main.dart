import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentdataprovider/controller/getcontroller/student_controller.dart';
import 'package:studentdataprovider/view/screens/screen_add_student.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
 return MultiProvider(
  providers:[
    ChangeNotifierProvider(
      create:(context)=>StudentController(),
    )
  ],
  child:MaterialApp(
      title: 'EduSync Provider',
        debugShowCheckedModeBanner: false,
        home:AddStudentScreen(),
  ),
 ); 
 }
}
