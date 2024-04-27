// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/Db/model.dart';
import 'package:student_database/provider/provider.dart';

class UpdateStudent extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final StudentModel student;
  UpdateStudent({super.key, required this.student});

  final formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController mobile = TextEditingController();

  late XFile file;

  String selectfile = "";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddstudentProvider>(context, listen: false);

    name.text = student.name;
    email.text = student.email;
    mobile.text = student.mobile;
    provider.addImage(student.image);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Details"),
      ),
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 30),
            child: Form(
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
                        child: CircleAvatar(
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
                    maxLength: 10,
                    controller: mobile,
                    keyboardType: TextInputType.phone,
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
                      if (formkey.currentState!.validate()) {
                        // student.name = name.text;
                        // student.email = email.text;
                        // student.mobile = mobile.text;
                        // student.image = provider.profilePicturePath!;

                        StudentModel val = StudentModel(
                          name: name.text,
                          email: email.text,
                          mobile: mobile.text,
                          image: provider.profilePicturePath!,
                          id: student.id,
                        );

                        update(val);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Update",
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
}
