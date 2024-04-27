import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_database/AddStudent.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/HomePage.dart';
import 'package:student_database/provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await dataBase();
  await getStudents();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddstudentProvider()),
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          "HomePage": (context) => const HomePage(),
          "AddStudent": (context) => AddStudent(),
        },
      ),
    );
  }
}
