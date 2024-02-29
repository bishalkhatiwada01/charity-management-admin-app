import 'package:charity_management_admin/features/donation/pages/donation_history_page.dart';
import 'package:charity_management_admin/features/volunteer/presentation/pages/application_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("TEST"),
            // replace with actual user name
            accountEmail: Text("test@example.com"),
            // replace with actual user email
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(
                "U", // replace with the first letter of the user name
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),

          // drawer header
          SizedBox(height: 20.h),
          SizedBox(
            height: 15.h,
          ),

          // home tile
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

                // navigate to home page
                Navigator.pushNamed(context, '/users_page');
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
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // logout
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
