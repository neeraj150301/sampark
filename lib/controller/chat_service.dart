import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:sampark/controller/access_firebase_token.dart';
import 'package:sampark/model/message_model.dart';

class ChatService {
  // firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // get users
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          final user = doc.data();
          return user;
        }).toList();
      },
    );
  }

  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    // current user
    final String userID = _firebaseAuth.currentUser!.uid;
    final String userEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // message
    Message newMessage = Message(
        senderId: userID,
        senderEmail: userEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    // chat room Id
    List<String> ids = [userID, receiverId];
    ids.sort(); // sort to get a consistent id same for any 2 people
    String chatRoomId = ids.join('_');

    // add message to DB
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());

    // Fetch the receiver's FCM token
    DocumentSnapshot receiverSnapshot =
        await _firestore.collection('Users').doc(receiverId).get();
    String? receiverFcmToken = receiverSnapshot['fcmToken'];

    DocumentSnapshot senderSnapshot =
        await _firestore.collection('Users').doc(userID).get();

    // print(receiverFcmToken);
    if (receiverFcmToken != null) {
      // Send a notification
      await sendNotification(
          receiverFcmToken,
          senderSnapshot['name'] != ''
              ? senderSnapshot['name']
              : senderSnapshot['email'],
          message);
    }
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort(); // sort to get a consistent id same for any 2 people
    String chatRoomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<void> sendNotification(
      String receiverFcmToken, String senderEmail, String message) async {
    AccessFirebaseToken accessToken = AccessFirebaseToken();
    String bearerToken = await accessToken.getAccessToken();

    final body = {
      "message": {
        "token": receiverFcmToken,
        "notification": {"title": senderEmail, "body": message},
      }
    };

    try {
      await post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/chatty-4c0af/messages:send'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $bearerToken'
        },
        body: jsonEncode(body),
      );
      // print("Response statusCode: ${res.statusCode}");
      // print("Response body: ${res.body}");
    } catch (e) {
      // print("Error sending FCM notification: $e");
    }
  }
}
