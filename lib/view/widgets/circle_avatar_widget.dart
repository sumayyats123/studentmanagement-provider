import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentdataprovider/controller/getcontroller/student_controller.dart'; // Import your controller if not already imported
import 'package:studentdataprovider/view/core/constant.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    Key? key,
    required this.radius, required String pickedimage,
  }) : super(key: key);

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentController>(
      builder: (context, studentController, child) {
        String pickedImage = studentController.pickedimage;
        return CircleAvatar(
          radius: radius,
          backgroundColor: const Color.fromARGB(255, 158, 186, 235),
          backgroundImage: pickedImage.isNotEmpty
              ? FileImage(File(pickedImage))
              : null,
          child: pickedImage.isEmpty
              ? Icon(
                  Icons.person,
                  color: Constants().kwhiteColor,
                  size: 35,
                )
              : null,
        );
      },
    );
  }
}
