import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // fireAuth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // get current user
  User? currentUser() => _firebaseAuth.currentUser;

  // Sign In
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // login
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      // save user to firestore if does'nt exist
      await _fireStore.collection('Users').doc(result.user!.uid).set(
        {
          'uid': result.user!.uid,
          'email': email,
        },
      );

      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Sign Up
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      // create user
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // save user to firestore
      await _fireStore.collection('Users').doc(result.user!.uid).set(
        {
          'uid': result.user!.uid,
          'email': email,
        },
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
