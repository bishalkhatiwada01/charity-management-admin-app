import 'package:charity_management_admin/api/firebase_api.dart';
import 'package:charity_management_admin/common/themes/dark_mode.dart';
import 'package:charity_management_admin/common/themes/light_mode.dart';
import 'package:charity_management_admin/features/dashbord/views/home_page.dart';
import 'package:charity_management_admin/firebase_options.dart';
import 'package:charity_management_admin/helper/login_or_register.dart';
import 'package:charity_management_admin/shared/status_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseApi().initNotifications();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            home: const StatusPage(),
            darkTheme: darkMode,
            routes: {
              '/login_register_page': (context) => const LoginOrRegister(),
              '/home_page': (context) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}
