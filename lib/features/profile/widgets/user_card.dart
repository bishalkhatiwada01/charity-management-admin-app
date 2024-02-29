import 'package:charity_management_admin/features/profile/domain/user_data_model.dart';
import 'package:charity_management_admin/features/profile/views/user_detail_page.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.firstName + ' ' + user.lastName),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailPage(
              user: user,
            ),
          ),
        );
      },
    );
  }
}
