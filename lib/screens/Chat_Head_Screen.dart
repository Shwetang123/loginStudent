import 'package:flutter/material.dart';

// Import the API service
import '../models/Chat_Head.dart';
import '../services/Api_service.dart';
import 'Chat_History_Screen.dart';

class ChatHeadScreen extends StatefulWidget {
  @override
  _ChatHeadScreenState createState() => _ChatHeadScreenState();
}

class _ChatHeadScreenState extends State<ChatHeadScreen> {
  late Future<Chat_Head?> futureChatHead;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureChatHead = apiService.getChatHeads('INFLUX', 1618, 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Messages",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: "MainFont"),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<Chat_Head?>(
        future: futureChatHead,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data?.msg == null ||
              snapshot.data!.msg!.isEmpty) {
            return const Center(child: Text('No chat heads found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.msg!.length,
              itemBuilder: (context, index) {
                final chatHead = snapshot.data!.msg![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          msgSenderID: 1618,
                          msgReceiverID: 10,
                          senderType: 2, iCode: 'INFLUX',
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.red,
                        backgroundImage: chatHead.userImage != null
                            ? NetworkImage(chatHead.userImage!)
                            : const AssetImage('assets/profile.jpg',),
                      ),
                      title: Text(
                        chatHead.userName ?? '',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "MainFont",
                        fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        chatHead.caption ?? '',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "MainFont"),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
