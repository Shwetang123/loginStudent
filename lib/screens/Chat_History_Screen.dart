import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/Chat_History.dart';


class ChatScreen extends StatefulWidget {
  final int msgSenderID;
  final int msgReceiverID;
  final int senderType;
  final String iCode;

  ChatScreen({
    required this.msgSenderID,
    required this.msgReceiverID,
    required this.senderType,
    required this.iCode,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Future<Chat_History> chatHistory;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchChatHistory();
  }

  Future<void> fetchChatHistory() async {
    final response = await http.get(Uri.parse(
        'https://ssapi.influxinfotech.in/ssapi/GetChatHistory?iCode=${widget.iCode}&msgSenderID=${widget.msgSenderID}&msgReceiverID=${widget.msgReceiverID}&senderType=${widget.senderType}'));

    if (response.statusCode == 200) {
      setState(() {
        chatHistory = Future.value(Chat_History.fromJson(jsonDecode(response.body)));
      });
    } else {
      throw Exception('Failed to load chat history');
    }
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text;
    if (message.isEmpty) return;

    // Create the message object
    final chatMessage = Msg(
      msgHeader: '',
      msgBody: message,
      msgDocFile: '',
      msgSenderID: widget.msgSenderID,
      msgReceiverID: widget.msgReceiverID,
      msgSenderType: widget.senderType,
      msgReceiverType: 3,
      entryTime: DateTime.now().toIso8601String(),
      isRead: false, msgReceiverIDs: [],
    );

    try {
      // Use the correct HTTP method for sending the message
      final response = await http.post(
        Uri.parse('https://ssapi.influxinfotech.in/ssapi/UpdateChatHistory?iCode=${widget.iCode}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(chatMessage.toJson()),
      );

      if (response.statusCode == 200) {
        _messageController.clear();
        fetchChatHistory();
      } else {
        print('Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              fetchChatHistory();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Chat_History>(
              future: chatHistory,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.msg?.length ?? 0,
                    itemBuilder: (context, index) {
                      Msg message = snapshot.data!.msg![index];
                      bool isSender = message.msgSenderID == widget.msgSenderID;

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: isSender
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: isSender
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width *
                                          0.7),
                                  decoration: BoxDecoration(
                                    color: isSender
                                        ? Colors.blue[400]
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(20),
                                      topRight: const Radius.circular(20),
                                      bottomLeft: isSender
                                          ? const Radius.circular(20)
                                          : Radius.zero,
                                      bottomRight: isSender
                                          ? Radius.zero
                                          : const Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    message.msgBody ?? '',
                                    style: TextStyle(
                                      color: isSender
                                          ? Colors.white
                                          : Colors.black87,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              message.entryTime ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No messages found'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send, size: 35, color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
