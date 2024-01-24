import 'package:charity_management_admin/features/auth/pages/login_page.dart';
import 'package:charity_management_admin/features/dashbord/views/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return LoginPage(
              onTap: () {},
            );
          }

          // user is not logged in
        },
      ),
    );
  }
}
