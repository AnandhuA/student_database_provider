// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/ProfilePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    getStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "AddStudent");
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListView.separated(
            itemCount: studentList.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
                  height: 10,
                ),
            itemBuilder: (BuildContext context, int index) {
              final student = studentList[index];
              return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: FileImage(
                      File(student.image),
                    ),
                  ),
                  title: Text(student.name),
                  subtitle: Text(student.email),
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            index: index,
                          ),
                        ),
                      ));
            }),
      ),
    );
  }
}
