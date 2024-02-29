import 'package:charity_management_admin/common/widgets/custom_app_bar.dart';
import 'package:charity_management_admin/features/profile/domain/admin_user_data_model.dart';
import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final UserModel user;

  UserDetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'USERS DETAILS',
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name: ${user.firstName} ${user.lastName} ',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            Text('Email: ${user.email}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 16,
                )),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
