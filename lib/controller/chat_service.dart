import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
}
