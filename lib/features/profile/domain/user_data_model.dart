import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String profileImageUrl;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImageUrl,
  });

  // Named constructor
  factory UserModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      uid: doc.id,
      firstName: data['firstname'] ?? '',
      lastName: data['lastname'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
    );
  }

  // Method to convert the UserModel object into a Map
  Map<String, dynamic> toDocument() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }
}
