import 'package:charity_management_admin/common/widgets/custom_app_bar.dart';
import 'package:charity_management_admin/features/profile/domain/admin_user_data_model.dart';
import 'package:charity_management_admin/features/profile/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersProvider = StreamProvider<List<UserModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel.fromDocument(doc);
    }).toList();
  });
});

class UsersPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final usersAsyncValue = ref.watch(usersProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'USERS',
      ),
      body: usersAsyncValue.when(
        data: (users) {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return UserCard(user: users[index]);
            },
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}
