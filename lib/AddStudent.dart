// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/Db/model.dart';
import 'package:student_database/provider/provider.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  final formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController mobile = TextEditingController();

  late XFile file;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddstudentProvider>(context, listen: false);
    provider.clearImg();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Details"),
      ),
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 30),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formkey,
              child: Column(
                children: [
                  Consumer<AddstudentProvider>(
                    builder: (contex, addstudentProvider, _) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.photo_camera),
                                      title: const Text("Camera"),
                                      onTap: () async {
                                        file = (await ImagePicker().pickImage(
                                            source: ImageSource.camera))!;
                                        addstudentProvider
                                            .selectImage(file.path);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text("Gallery"),
                                      onTap: () async {
                                        file = (await ImagePicker().pickImage(
                                            source: ImageSource.gallery))!;
                                        addstudentProvider
                                            .selectImage(file.path);
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: addstudentProvider.profilePicturePath == null
                            ? CircleAvatar(
                                radius: 100,
                                child: Lottie.asset(
                                    "assets/animations/Animation - 1713885222787.json"),
                              )
                            : CircleAvatar(
                                radius: 100,
                                backgroundImage: FileImage(
                                  File(addstudentProvider.profilePicturePath!),
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Name";
                      }
                      return null;
                    },
                    controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.account_circle,
                      ),
                      label: const Text("Name"),
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Mobile Number";
                      } else if (value.length != 10) {
                        return "Enter valid Mobile Number";
                      }
                      return null;
                    },
                    controller: mobile,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      label: const Text("Mobile"),
                      hintText: "Mobile",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Email Address";
                      } else if (!value.contains("@gmail.com")) {
                        return "Enter Valid Email Address ";
                      }
                      return null;
                    },
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      label: const Text("Email"),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade100,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    onPressed: () {
                      addbutton(context, provider);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  addbutton(context, provider) async {
    if (provider.profilePicturePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Add photo"),
        backgroundColor: Colors.red,
      ));
    } else {
      final student = StudentModel(
          id: DateTime.now().microsecondsSinceEpoch,
          name: name.text,
          email: email.text,
          mobile: mobile.text,
          image: provider.profilePicturePath);
      if (formkey.currentState!.validate()) {
        addStudent(student);
        provider.clearImg();
        // await getStudents();
        Navigator.pop(context);
      }
    }
  }
}
