// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminUserProvider =
    FutureProvider.autoDispose<DocumentSnapshot<Map<String, dynamic>>>(
        (ref) async {
  final getAdminUserService = getAdminUser();
  final userData = await getAdminUserService.getAdminUserDetails();
  return userData;
});

class getAdminUser {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  Future<DocumentSnapshot<Map<String, dynamic>>> getAdminUserDetails() async {
    final data = await FirebaseFirestore.instance
        .collection('admin_users')
        .doc(currentUser)
        .get();
    return data;
  }
}
