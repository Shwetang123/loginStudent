// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class ApiService {
//   static const String baseUrl = 'https://ssapi.influxinfotech.in/ssapi/';
//
//   // Method to fetch ChatHeads
//   Future<ChatHead?> getChatHeads(String iCode, int uID, int userType) async {
//     final url = Uri.parse('${baseUrl}GetChatHeads?iCode=$iCode&uID=$uID&userType=$userType');
//
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       return ChatHead.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load chat heads');
//     }
//   }
//
//   // Method to fetch ChatHistory
//   Future<List<ChatHistory>> getChatHistory(String iCode, int msgSenderID, int msgReceiverID, int senderType) async {
//     final url = Uri.parse('${baseUrl}GetChatHistory?iCode=$iCode&msgSenderID=$msgSenderID&msgReceiverID=$msgReceiverID&senderType=$senderType');
//
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       return data.map((chat) => ChatHistory.fromJson(chat)).toList();
//     } else {
//       throw Exception('Failed to load chat history');
//     }
//   }
//
// // Additional methods for other API calls can be added here
// }