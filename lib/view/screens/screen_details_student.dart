import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentdataprovider/controller/getcontroller/student_controller.dart';
import 'package:studentdataprovider/controller/services/snackfunction.dart';
import 'package:studentdataprovider/model/student_model.dart';
import 'package:studentdataprovider/view/core/constant.dart';
import 'package:studentdataprovider/view/screens/screen_edit_student.dart';
import 'package:studentdataprovider/view/widgets/app_bar_widget.dart';
import 'package:studentdataprovider/view/widgets/student_details_widget.dart';

class StudentDetailsScreen extends StatelessWidget {
  const StudentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentController = context.read<StudentController>();
    studentController.loadStudents(); // Access StudentController

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 90),
          child: AppBarWidget(
            onTapRight: () {
              _showSearchBar(context, studentController);
            },
            righticon: Icons.search,
            lefticon: Icons.arrow_back,
            onTapLeft: () {
              Navigator.of(context).pop(); // Navigate back
            },
            title: 'Students Details',
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Consumer<StudentController>(
              builder: (context, controller, child) {
                if (controller.students.isEmpty) {
                  return const Text('Student Details Not Found');
                } else {
                  final List<StudentModel> displayStudents = controller.filteredStudents.isEmpty
                      ? controller.students.toList()
                      : controller.filteredStudents.toList();

                  if (displayStudents.isEmpty) {
                    return const Text('No Data Found');
                  } else {
                    return ListView.builder(
                      itemCount: displayStudents.length,
                      itemBuilder: (context, index) {
                        var student = displayStudents[index];
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Constants().kblueAsscent,
                              ),
                              width: 250,
                              height: 300,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Constants().kwhiteColor,
                                      child: StudentImageContainerWidget(
                                        student: student,
                                        height: 135,
                                        width: 135,
                                      ),
                                    ),
                                  ),
                                  Constants().kheight10,
                                  Text(
                                    'Name: ${student.name}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Constants().kred,
                                    ),
                                  ),
                                  Constants().kheight10,
                                  Text(
                                    'Age: ${student.age}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Constants().kred,
                                    ),
                                  ),
                                  Constants().kheight10,
                                  Text(
                                    'Department: ${student.department}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Constants().kred,
                                    ),
                                  ),
                                  Constants().kheight10,
                                  Text(
                                    'Phone: ${student.phoneNumber}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Constants().kred,
                                    ),
                                  ),
                                  Constants().kheight10,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          showDeleteConfirmationDialog(context, student, controller);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => EditStudentScreen(student: student),
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showSearchBar(BuildContext context, StudentController controller) {
    TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Students'),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Enter student name',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              String query = searchController.text.trim();
              controller.filterStudents(query);
              Navigator.of(context).pop();

              if (controller.filteredStudents.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('No student found with the given name'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Show All',
                      onPressed: () {
                        _showAllStudentsDialog(context, controller);
                      },
                    ),
                  ),
                );
              } else {
                _showFilteredStudentsDialog(context, controller.filteredStudents);
              }
            },
            child: const Text('Search'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showFilteredStudentsDialog(BuildContext context, List<StudentModel> students) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtered Students'),
        content: SingleChildScrollView(
          child: Column(
            children: students.map((student) {
              return Card(
                color: Constants().kblueAsscent,
                child: ListTile(
                  leading: CircleAvatar(
                    child: StudentImageContainerWidget(
                      student: student,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  title: Text(student.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age: ${student.age}'),
                      const SizedBox(height: 10),
                      Text('Department: ${student.department}'),
                      const SizedBox(height: 10),
                      Text('Phone: ${student.phoneNumber}'),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showAllStudentsDialog(BuildContext context, StudentController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('All Students'),
        content: SingleChildScrollView(
          child: Column(
            children: controller.students.map((student) {
              return ListTile(
                title: Text(student.name),
                subtitle: Text(student.department),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
