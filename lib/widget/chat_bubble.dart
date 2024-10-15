import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.3),
      decoration: BoxDecoration(
          color: isCurrentUser
              ? const Color.fromARGB(255, 234, 150, 245)
              : Colors.grey[400],
          borderRadius: isCurrentUser
              ? const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15))
              : const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      child: Text(
        message,
        style: const TextStyle(),
      ),
    );
  }
}
