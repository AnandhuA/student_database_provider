// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/Db/model.dart';
import 'package:student_database/UpdateStudent.dart';

class Profile extends StatelessWidget {
  final StudentModel student;
  const Profile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateStudent(
                  student: student,
                ),
              ),
            ).then((_) => Navigator.pop(context)),
            // onPressed: () => Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => UpdateStudent(
            //       index: widget.index,
            //     ),
            //   ),

            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text("Delete ${student.name}"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                              onPressed: () async {
                                await deleteStudent(student);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("Yes"))
                        ]);
                  });
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: FileImage(
                    File(student.image),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  student.name,
                  style: const TextStyle(fontSize: 35),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Card(
                    color: const Color.fromARGB(248, 240, 232, 236),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const Text(
                            "Contact",
                          ),
                          ListTile(
                            leading: const Icon(Icons.phone),
                            title: Text(student.mobile),
                          ),
                          ListTile(
                            leading: const Icon(Icons.mail),
                            title: Text(student.email),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
