import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginstudent/models/studnetid.dart';
import '../models/Attendance.dart';

import '../models/Chat_Head.dart';

import '../models/Chat_History.dart';
import '../models/ExamSchedule.dart';
import '../models/Student_Detail.dart';



class ApiService {
  static const String baseUrl = 'https://ssapi.influxinfotech.in/ssapi/';

  // 1st Service: Fetch Attendance
  Future<Attendance> fetchAttendance() async {
    final response = await http.get(Uri.parse(
        '${baseUrl}GetStudentAttendance?iCode=INFLUX&studentID=1618'));

    if (response.statusCode == 200) {
      return Attendance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load attendance');
    }
  }

  // 2nd Service: Fetch Students
  Future<List<StudentProfile>> fetchStudents() async {
    final response = await http.get(Uri.parse(
        '${baseUrl}GetStudentBatchMates?iCode=INFLUX&studentID=1618'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => StudentProfile.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  // 3rd Service: Fetch Exam Schedules
  Future<List<ExamSchedule>> fetchExamSchedules() async {
    final response = await http.get(Uri.parse(
        '${baseUrl}GetStudentExamSchedule?iCode=INFLUX&studentID=1618'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ExamSchedule.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load exam schedules');
    }
  }

  // 4th Service: Fetch Student Details
  Future<StudentDetails> fetchStudentDetails() async {
    final response = await http.get(Uri.parse(
        '${baseUrl}GetStudentData?iCode=INFLUX&uID=8909248671&uPass=1618'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return StudentDetails.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to load student details");
    }
  }

  // 5th Service: Fetch Student Messages
  Future<Chat_Head> getChatHeads(String iCode, int uID, int userType) async {
    final url = Uri.parse(
        '${baseUrl}GetChatHeads?iCode=$iCode&uID=$uID&userType=$userType');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Chat_Head.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load chat heads');
    }
  }


// // API Service
//   Future<List<MsgHistory>> getChatHistory(String iCode, int msgSenderID, int msgReceiverID, int senderType) async {
//     final response = await http.get(
//       Uri.parse('https://ssapi.influxinfotech.in/ssapi/GetChatHistory?iCode=$iCode&msgSenderID=$msgSenderID&msgReceiverID=$msgReceiverID&senderType=$senderType'),
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       ChatHistory chatHistory = ChatHistory.fromJson(data);
//       return chatHistory.msghistory ?? [];
//     } else {
//       throw Exception('Failed to load chat history');
//     }
 // }


}
