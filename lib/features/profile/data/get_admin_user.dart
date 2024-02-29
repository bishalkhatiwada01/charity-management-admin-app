import 'package:charity_management_admin/features/profile/domain/admin_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AdminUser> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      final docSnapshot =
          await _firestore.collection('admin_users').doc(user.uid).get();
      return AdminUser(
        name: docSnapshot.get('username'),
        email: docSnapshot.get('email'),
      );
    } else {
      throw Exception('No user is currently logged in.');
    }
  }
}
