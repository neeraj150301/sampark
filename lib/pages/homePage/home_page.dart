import 'package:flutter/material.dart';
import 'package:sampark/controller/auth_service.dart';
import 'package:sampark/controller/chat_service.dart';
import 'package:sampark/widget/my_drawer.dart';

import '../../widget/user_tile.dart';
import '../chatPage/chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "C H A T T Y",
          style: TextStyle(
              fontFamily: 'SofadiOne',
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color.fromARGB(255, 188, 85, 202)),
        ),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // has data
          return ListView(
            children: snapshot.data!
                .map((userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authService.currentUser()!.email) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: UserTile(
          user: userData['name'] ?? userData['email'],
          onTap: () {
            // tap on user to go to chat page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                    receiverName: userData['name'] ?? userData['email'],
                    receiverId: userData['uid']),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
