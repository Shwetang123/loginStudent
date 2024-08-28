import 'package:flutter/material.dart';
import 'package:loginstudent/screens/Chat_Head_Screen.dart';
import 'package:loginstudent/screens/Splash_screen.dart';


import 'package:loginstudent/screens/student_data_screen.dart';

import 'package:provider/provider.dart';
import 'providers/student_provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: MaterialApp(
        title: 'Student Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home:SplashScreen(),
      ),
    );
  }
}
