import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isCurrentUser;
  final DateTime timestamp;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.timestamp,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool _showTimestamp = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showTimestamp = !_showTimestamp; // Toggle timestamp visibility
        });
      },
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.3),
            decoration: BoxDecoration(
                color: widget.isCurrentUser
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                    : Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer
                        .withOpacity(0.3),
                borderRadius: widget.isCurrentUser
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
              widget.message,
              style: const TextStyle(),
            ),
          ),
          if (_showTimestamp) // Show timestamp when tapped
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                DateFormat('hh:mm a')
                    .format(widget.timestamp), // Format timestamp
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
