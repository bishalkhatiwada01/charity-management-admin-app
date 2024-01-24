



import 'package:firebase_auth/firebase_auth.dart';

class AuthData{

  static Future<String> login({required String email, required String password}) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Login Success';
    }

    on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }



}