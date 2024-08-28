import 'package:flutter/material.dart';
import 'package:loginstudent/screens/Chat_Head_Screen.dart';
import 'package:loginstudent/screens/Default_screen.dart';
import 'package:loginstudent/screens/Exam_Schedule_Screen.dart';
import 'package:loginstudent/screens/GatePass_Screen.dart';
import 'package:loginstudent/screens/MySchool.dart';
import 'package:loginstudent/screens/Splash_screen.dart';
import '../Extra/Animation.dart';
import 'MyAttendance.dart';
import 'MyClassMate_Screen.dart';



class MenuItemScreen extends StatelessWidget {
  const MenuItemScreen({super.key});

  Widget buildMenuItem(BuildContext context, IconData icon, String title, Widget screen) {
    return SizedBox(
      height: 38,
      child: ListTile(
        leading: Icon(icon, size: 20),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: "MainFont",
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 25),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Image.asset("assets/logo1.png"),
              ),
              const SizedBox(width: 15),
              const Flexible(
                child: Text(
                  "Edu Influx School",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "MainFont",
                  ),
                ),
              ),
            ],
          ),
          buildMenuItem(context, Icons.home, 'Home',  const DefaultScreen()),
          buildMenuItem(context, Icons.school, 'My School', const MySchool()),
          buildMenuItem(context, Icons.notes, 'Notice Board', const DefaultScreen()),
          buildMenuItem(context, Icons.video_call, 'Online Class', const DefaultScreen()),
          buildMenuItem(context, Icons.calendar_month, 'My Attendance',  MyAttendanceScreen()),
          buildMenuItem(context, Icons.currency_rupee, 'Fees', const DefaultScreen()),
          buildMenuItem(context, Icons.menu_book, 'Academics', const DefaultScreen()),
          buildMenuItem(context, Icons.menu_book, 'Homeworks', const DefaultScreen()),
          buildMenuItem(context, Icons.menu_book, 'Syllabus', const DefaultScreen()),
          buildMenuItem(context, Icons.menu_book, 'Assignments', const DefaultScreen()),
          buildMenuItem(context, Icons.download, 'My Downloads', const DefaultScreen()),
          buildMenuItem(context, Icons.photo, 'Albums', const DefaultScreen()),
          buildMenuItem(context, Icons.video_camera_front, 'Video', const YoutubePlayerScreen()),
          buildMenuItem(context, Icons.video_camera_front, 'Study Videos', const DefaultScreen()),
          buildMenuItem(context, Icons.group, 'My Class Mates', const StudentListScreen()),
          buildMenuItem(context, Icons.man, 'My Teachers', const DefaultScreen()),
          buildMenuItem(context, Icons.calendar_month, 'Time Table', const DefaultScreen()),
          buildMenuItem(context, Icons.message, 'My Messages', ChatHeadScreen()),
          buildMenuItem(context, Icons.calendar_month, 'Exam Schedule', const ExamScheduleScreen()),
          buildMenuItem(context, Icons.calendar_month, 'Monthly Planner', const DefaultScreen()),
          buildMenuItem(context, Icons.newspaper, 'Leave Application', const DefaultScreen()),
          buildMenuItem(context, Icons.menu_book, 'Student Book', const DefaultScreen()),
          buildMenuItem(context, Icons.local_post_office_outlined, 'Suggestion', const DefaultScreen()),
          buildMenuItem(context, Icons.car_repair_sharp, 'Gate Pass', const GatePass()),
          buildMenuItem(context, Icons.settings, 'Settings', const DefaultScreen()),
          buildMenuItem(context, Icons.phone, 'Help & Support', const DefaultScreen()),
          buildMenuItem(context, Icons.star_rate, 'Rate Us', const DefaultScreen()),
          ListTile(
            leading: const Icon(Icons.lock, size: 20),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "MainFont",
              ),
            ),
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
