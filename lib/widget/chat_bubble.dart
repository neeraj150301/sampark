import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'full_screen_image_view.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isCurrentUser;
  final bool isImageMessage;
  final DateTime timestamp;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.isImageMessage,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.5),
        child: Column(
          crossAxisAlignment: widget.isCurrentUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
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
              padding: EdgeInsets.all(widget.isImageMessage ? 5 : 12),
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              child: widget.isImageMessage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImagePage(
                              imageUrl: widget.message,
                              isImageMessage: widget.isImageMessage,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          filterQuality: FilterQuality.high,
                          imageUrl: widget.message,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          height: 150, // Adjust dimensions as needed
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Text(
                      widget.message,
                      style: const TextStyle(),
                    ),
            ),
            if (_showTimestamp) // Show timestamp when tapped
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                child: Text(
                  DateFormat('hh:mm a')
                      .format(widget.timestamp), // Format timestamp
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
