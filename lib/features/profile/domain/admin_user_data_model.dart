import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUserModel {
  final String uid;
  final String username;
  final String email;
  final String profileImageUrl;

  AdminUserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.profileImageUrl,
  });

  // Named constructor
  factory AdminUserModel.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return AdminUserModel(
      uid: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? 'No Image',
    );
  }

  // Method to convert the UserModel object into a Map
  Map<String, dynamic> toDocument() {
    return {
      'name': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }
}
