import 'package:flutter/material.dart';
import 'package:student_database/Db/function.dart';

class AddstudentProvider extends ChangeNotifier {
  String? profilePicturePath;

  selectImage(String img) {
    profilePicturePath = img;
    notifyListeners();
  }

  addImage(String img) {
    profilePicturePath = img;
  }

  clearImg() {
    profilePicturePath = null;
  }
}

class HomePageProvider extends ChangeNotifier {
  List students = [];

  HomePageProvider() {
    refreshList();
  }

  refreshList() async {
    students = await getStudents();
    notifyListeners();
  }
}
