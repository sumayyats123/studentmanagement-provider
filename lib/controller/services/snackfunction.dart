import 'package:flutter/material.dart';
import 'package:studentdataprovider/controller/getcontroller/student_controller.dart';
import 'package:studentdataprovider/model/student_model.dart';

void snackBarFunction({
  required BuildContext context,
  required String title,
  required String subtitle,
  Duration? animationDuration,
  Color? backgroundColor,
  DismissDirection? dismissDirection,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(subtitle),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Dismis',
     onPressed: (){},
     ),
    )
  );
}

void showDeleteConfirmationDialog(BuildContext context, StudentModel student,StudentController studentController) {
 showDialog(context: context,
 builder: (context) {
   return AlertDialog(
    title:Text ('Delete Student',),
      content: Text('Are you sure you want to delete ${student.name}?'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("cancel"),
        ),
        TextButton(onPressed: (){
          Navigator.pop(context);
              studentController.deleteStudent(int.parse(student.id.toString()));
        }, child: Text("Delete"),
        ),
      ],
   );
 },
);
}

//  void showSearchBar(BuildContext context, StudentController controller) {
//     TextEditingController searchController = TextEditingController();

//     Get.defaultDialog(
//       title: 'Search Students',
//       content: TextField(
//         controller: searchController,
//         decoration: const InputDecoration(
//           hintText: 'Enter student name',
//         ),
//       ),
//       confirm: ElevatedButton(
//         onPressed: () {
//           String query = searchController.text.trim();
//           controller.filterStudents(query);
//           Get.back();

//           if (controller.filteredStudents.isEmpty) {
//             Get.snackbar(
//               'No Data Found',
//               'No student found with the given name',
//               snackPosition: SnackPosition.BOTTOM,
//               duration: const Duration(seconds: 2),
//               onTap: (_) {
//                 _showAllStudentsDialog(controller);
//               },
//             );
//           } else {
//             _showFilteredStudentsDialog(controller.filteredStudents);
//           }
//         },
//         child: const Text('Search'),
//       ),
//       cancel: TextButton(
//         onPressed: () {
//           Get.back();
//         },
//         child: const Text('Cancel'),
//       ),
//     );
//   }

  // void _showFilteredStudentsDialog(List<StudentModel> students) {
  //   Get.defaultDialog(
  //     title: 'Filtered Students',
  //     content: SingleChildScrollView(
  //       child: Column(
  //         children: students.map((student) {
  //           return Card(
  //             color: Constants().kblueAsscent,
  //             child: ListTile(
  //               leading: CircleAvatar(
  //                 child: StudentImageContainerWidget(
  //                   student: student,
  //                   height: 50,
  //                   width: 50,
  //                 ),
  //               ),
  //               title: Text(student.name),
  //               subtitle: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Age: ${student.age}'),
  //                   Constants().kWidth10,
  //                   Text('Department: ${student.department}'),
  //                   Constants().kWidth10,
  //                   Text('Phone: ${student.phoneNumber}'),
  //                   Constants().kWidth10,
  //                 ],
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }

  // void _showAllStudentsDialog(StudentController controller) {
  //   Get.defaultDialog(
  //     title: 'All Students',
  //     content: SingleChildScrollView(
  //       child: Column(
  //         children: controller.students.map((student) {
  //           return ListTile(
  //             title: Text(student.name),
  //             subtitle: Text(student.department),
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }