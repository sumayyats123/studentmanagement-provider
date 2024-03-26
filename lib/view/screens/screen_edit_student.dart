import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentdataprovider/controller/getcontroller/student_controller.dart';// Import the correct path for StudentController
import 'package:studentdataprovider/model/student_model.dart';

class EditStudentScreen extends StatelessWidget {
  final StudentModel student;

  const EditStudentScreen({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentController = context.read<StudentController>(); // Access StudentController

    final TextEditingController nameController = TextEditingController(text: student.name);
    final TextEditingController ageController = TextEditingController(text: student.age.toString());
    final TextEditingController departmentController = TextEditingController(text: student.department);
    final TextEditingController phoneNumberController = TextEditingController(text: student.phoneNumber.toString());

    return AlertDialog(
      title: const Text('Edit Student Details'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: departmentController,
              decoration: const InputDecoration(labelText: 'Department'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final updatedStudent = StudentModel(
              id: student.id,
              name: nameController.text,
              age: int.tryParse(ageController.text) ?? 0,
              department: departmentController.text,
              phoneNumber: int.tryParse(phoneNumberController.text) ?? 0,
              imageUrl: student.imageUrl,
            );
            studentController.updateStudent(updatedStudent);
            ImageCache().clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

