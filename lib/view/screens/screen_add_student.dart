import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentdataprovider/controller/getcontroller/student_controller.dart';
import 'package:studentdataprovider/controller/services/snackfunction.dart';
import 'package:studentdataprovider/model/student_model.dart';
import 'package:studentdataprovider/view/core/constant.dart';
import 'package:studentdataprovider/view/screens/screen_details_student.dart';
import 'package:studentdataprovider/view/widgets/app_bar_widget.dart';
import 'package:studentdataprovider/view/widgets/circle_avatar_widget.dart';
import 'package:studentdataprovider/view/widgets/text_form_field_widget.dart';


class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final Controller = context.read<StudentController>();
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController departmentController = TextEditingController();
    TextEditingController phoneNoController = TextEditingController();
    final formKey = GlobalKey<FormState>();
   

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: AppBarWidget(
            title: 'Students Information',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Center(
                    child:Consumer<StudentController>(builder:(context,StudentController,child)=>   InkWell(
                      onTap: () async {
                        String? imagePath =
                            await Controller.pickImage(ImageSource.gallery);
                        // pickedimage.value = imagePath ?? '';
                        Controller.selectpickedimage(imagePath??"");
                      },
                      child: CircleAvatarWidget(pickedimage: Controller.pickedimage, radius: 80),
                    ),),
                 
                  ),
                  Constants().kheight20,
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextFielddWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 3) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          prefixicon: Icons.person,
                          controller: nameController,
                          hintText: 'Enter the name',
                          labelText: 'Name',
                          inputType: TextInputType.name,
                        ),
                        CustomTextFielddWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty || int.tryParse(value) == null) {
                              return 'Please enter a valid age';
                            }
                            int age = int.parse(value);
                            if (age <= 0 || age >= 120) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                          prefixicon: Icons.numbers,
                          controller: ageController,
                          hintText: 'Enter the age',
                          labelText: 'Age',
                          inputType: TextInputType.number,
                        ),
                        CustomTextFielddWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 3) {
                              return 'Please enter department';
                            }
                            return null;
                          },
                          prefixicon: Icons.person,
                          controller: departmentController,
                          hintText: 'Enter the department',
                          labelText: 'Department',
                          inputType: TextInputType.text,
                        ),
                        CustomTextFielddWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length != 10) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          prefixicon: Icons.mobile_friendly,
                          controller: phoneNoController,
                          hintText: 'Enter the phone number',
                          labelText: 'Phone Number',
                          inputType: TextInputType.phone,
                        ),
                        Constants().kheight10,
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            backgroundColor: MaterialStateProperty.all(Constants().kblueAsscent),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate() && Controller.pickedimage.isNotEmpty) {
                              Controller.addStudent(StudentModel(
                                name: nameController.text,
                                age: int.parse(ageController.text),
                                department: departmentController.text,
                                phoneNumber: int.parse(phoneNoController.text),
                                imageUrl: Controller.pickedimage,
                              ));
                              nameController.clear();
                              ageController.clear();
                              departmentController.clear();
                              phoneNoController.clear();
                              Controller.pickedimage = '';
                              snackBarFunction(
                               
                                title: 'Success',
                                subtitle: 'Submitted Successfully',
                                backgroundColor: Colors.green,
                                animationDuration: const Duration(milliseconds: 2000),
                                context: context,
                               
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentDetailsScreen()));

                            } else if (Controller.pickedimage.isEmpty) {
                              snackBarFunction(
                                context: context,
                                title: 'Submission Failed',
                                subtitle: 'Please select an image',
                                backgroundColor: Colors.red,
                                dismissDirection: DismissDirection.horizontal,
                               
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                color: Constants().kwhiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
