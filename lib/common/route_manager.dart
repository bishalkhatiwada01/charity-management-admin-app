// ignore_for_file: unused_import

import 'package:charity_management_admin/features/auth/pages/login_page.dart';
import 'package:charity_management_admin/features/auth/pages/register_page.dart';
import 'package:charity_management_admin/features/dashbord/views/home_page.dart';
import 'package:charity_management_admin/features/notifications/views/notification_page.dart';
import 'package:charity_management_admin/features/profile/views/profile_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String notificationRoute = '/notification';
  static const String profileRoute = '/profile';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Invalid Route'),
        ),
        body: const Center(child: Text('Route does not exist')),
      ),
    );
  }
}
