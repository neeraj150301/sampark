
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String user;
  const ChatPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar:  AppBar(
        title: Text(user),
      ),
    );
  }
}
