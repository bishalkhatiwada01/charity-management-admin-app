import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userDb = FirebaseFirestore.instance.collection('admin_users');

  Future<UserCredential?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final token = await FirebaseMessaging.instance.getToken();
      final userData = await userDb.doc(userCredential.user!.uid).get();
      await userDb.doc(userCredential.user!.uid).update({
        'email': userData['email'],
        'username': userData['username'],
        'token': token,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
      return null;
    }
  }

  Future<void> register(String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final token = await FirebaseMessaging.instance.getToken();
      await userDb.doc(userCredential.user!.uid).set({
        'email': email.trim(),
        'username': username.trim(),
        'token': token,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error during registration: $e');
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (kDebugMode) {
        print('Error during password reset: $e');
      }
    }
  }
}
