import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sampark/controller/chat_service.dart';
import '../../controller/auth_service.dart';
import '../../widget/chat_bubble.dart';
import '../../widget/my_text_field.dart';

class ChatPage extends StatelessWidget {
  final String receiverName;
  final String receiverId;

  ChatPage({super.key, required this.receiverName, required this.receiverId});

  // message controller
  final TextEditingController _messageController = TextEditingController();

  // service instance
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // scroll controller to manage scrolling
  final ScrollController _scrollController = ScrollController();

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverId, _messageController.text);
      _messageController.clear(); // clear the text field after sending message
    }
  }

  // scroll to the bottom of the chat list
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(receiverName),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(child: _buildMessageList()),
        _buildMessageInput(),
      ]),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.currentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, receiverId),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.size == 0) {
          return const Center(
            child: Text('No messages yet, chat now!!!'),
          );
        }

        // Ensure the list scrolls to bottom when data is received
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });

        return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return _buildMessageItem(snapshot.data!.docs[index]);
            });
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _authService.currentUser()!.uid;
    DateTime dateTime = data['timestamp'].toDate();
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ChatBubble(message: data['message'], isCurrentUser: isCurrentUser, timestamp: dateTime),

      ],
    ); // display message
  }

  // type message area and send button
  Widget _buildMessageInput() {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 20, top: 10),
              child: MyTextField(
                hintText: 'Type message here...',
                obscureText: false,
                controller: _messageController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0, bottom: 20, top: 10),
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 188, 85, 202)),
              child: IconButton(
                  onPressed: () {
                    sendMessage();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
