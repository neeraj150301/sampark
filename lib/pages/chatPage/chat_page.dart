import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sampark/controller/chat_service.dart';
import '../../controller/auth_service.dart';
import '../../widget/chat_bubble.dart';
import '../../widget/full_screen_image_view.dart';
import '../../widget/my_text_field.dart';

class ChatPage extends StatelessWidget {
  final String receiverName;
  final String receiverId;
  final String? profileImageUrl;

  ChatPage(
      {super.key,
      required this.receiverName,
      required this.profileImageUrl,
      required this.receiverId});

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
        title: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (profileImageUrl != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImagePage(
                        imageUrl: profileImageUrl!,
                        isImageMessage: false,
                      ),
                    ),
                  );
                }
              },
              child: profileImageUrl != null
                  ? CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          height: 38,
                          width: 38,
                          fit: BoxFit.cover,
                          imageUrl: profileImageUrl!,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 18,
                      child: Icon(Icons.person,
                          size: 30,
                          color: Theme.of(context)
                              .colorScheme
                              .inversePrimary
                              .withOpacity(0.6)),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(receiverName),
          ],
        ),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(child: _buildMessageList()),
        _buildMessageInput(context),
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

    bool isImageMessage = data['imageUrl'] != null;

    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ChatBubble(
            message: isImageMessage ? data['imageUrl'] : data['message'],
            // ? ClipRRect(
            //     borderRadius: BorderRadius.circular(8.0),
            //     child: CachedNetworkImage(
            //       imageUrl: data['imageUrl'],
            //       progressIndicatorBuilder:
            //           (context, url, downloadProgress) =>
            //               CircularProgressIndicator(
            //                   value: downloadProgress.progress),
            //       errorWidget: (context, url, error) => Icon(Icons.error),
            //       height: 150, // Adjust dimensions as needed
            //       width: 150,
            //       fit: BoxFit.cover,
            //     ),
            //   )
            // :
            // data['message'],
            isCurrentUser: isCurrentUser,
            isImageMessage: isImageMessage,
            timestamp: dateTime),
      ],
    ); // display message
  }

  // type message area and send button
  Widget _buildMessageInput(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          IconButton(
            iconSize: 28,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            icon:
                Icon(Icons.image, color: Theme.of(context).colorScheme.primary),
            onPressed: () => _chatService.pickAndSendImages(receiverId),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 10, top: 5),
              child: MyTextField(
                hintText: 'Type message here...',
                obscureText: false,
                controller: _messageController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, bottom: 10, top: 5),
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
