// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_database/AddStudent.dart';
import 'package:student_database/ProfilePage.dart';
import 'package:student_database/provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudent(),
            ),
          ).then((value) => provider.refreshList());
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListView.separated(
          itemCount: provider.students.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            final student = provider.students[index];
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
                        builder: (context) => Profile(student: student),
                      ),
                    ).then((value) => provider.refreshList())
                // onTap: () => Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => Profile(
                //           student: provider.students[index],
                //         ),
                //       ),
                );
          },
        ),
      ),
    );
  }
}
