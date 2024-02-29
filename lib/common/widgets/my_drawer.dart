import 'package:charity_management_admin/features/auth/data/auth_service.dart';
import 'package:charity_management_admin/features/donation/pages/donation_history_page.dart';
import 'package:charity_management_admin/features/profile/provider/admin_user_provider.dart';
import 'package:charity_management_admin/features/profile/views/users_page.dart';
import 'package:charity_management_admin/features/volunteer/presentation/pages/application_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, ref) {
    FirebaseAuth _authService = FirebaseAuth.instance;
    final adminUserData = ref.watch(adminUserProvider);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),

          adminUserData.when(
            data: (user) {
              return Column(
                children: [
                  CircleAvatar(
                    backgroundImage: Image.asset('assets/admin.png').image,
                    radius: 70,
                  ),
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
          SizedBox(
            height: 10.h,
          ),

          Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 4,
          ),
          SizedBox(
            height: 10.h,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: Text(
                'HOME',
                style: TextStyle(
                  letterSpacing: 4.w,
                ),
              ),
              onTap: () {
                // navigate to home page
                Navigator.pop(context);
              },
            ),
          ),

          // profile tile
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: ListTile(
              leading: const Icon(
                Icons.monetization_on,
              ),
              title: Text(
                'DONATION HISTORY',
                style: TextStyle(
                  fontSize: 13.sp,
                  letterSpacing: 4.w,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DonationHistoryPage(),
                ));
              },
            ),
          ),
          // Applications
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: ListTile(
              leading: const Icon(
                Icons.newspaper_outlined,
              ),
              title: const Text(
                'APPLICATIONS',
                style: TextStyle(
                  letterSpacing: 4,
                ),
              ),
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // navigate to home page
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ApplicationsPage(),
                ));
              },
            ),
          ),

          // user tile
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: ListTile(
              leading: const Icon(
                Icons.group,
              ),
              title: Text(
                'USERS',
                style: TextStyle(
                  letterSpacing: 4.w,
                ),
              ),
              onTap: () {
                // pop drawer
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => UsersPage()));
              },
            ),
          ),

          // logout tile
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: Text(
                'LOGOUT',
                style: TextStyle(
                  letterSpacing: 4.w,
                ),
              ),
              onTap: () async {
                // pop drawer
                Navigator.pop(context);
                await _authService.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
