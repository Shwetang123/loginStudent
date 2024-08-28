import 'package:flutter/material.dart';
import '../Widgets/HeadProfiles.dart';
import '../models/studnetid.dart';

import '../services/Api_service.dart';


class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late Future<List <StudentProfile>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = ApiService().fetchStudents();
  }

  Future<void> _refreshStudents() async {
    setState(() {
      _studentsFuture = ApiService().fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Class Mates",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "MainFont"),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,

      ),
      body: Column(
        children: [
          const HeadProfile(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshStudents,
              child: FutureBuilder<List<StudentProfile>>(
                future: _studentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No students found'));
                  } else {
                    return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        StudentProfile student = snapshot.data![index];
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: student.studentPhotoPath != null
                                    ? NetworkImage(student.studentPhotoPath!)
                                    : const AssetImage('assets/profile.jpg')
                                as ImageProvider,
                                radius: 90,
                              ),
                              //const SizedBox(height: 5),
                              Text(student.SName ?? 'Unknown',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontFamily: "MainFont",
                                      fontWeight: FontWeight.w600
                                  )),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
