import 'package:charity_management_admin/features/volunteer/pages/application_page.dart';
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
          // drawer header
          DrawerHeader(
            child: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          SizedBox(
            height: 15.h,
          ),

          // home tile
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('H O M E'),
              onTap: () {
                // navigate to home page
                Navigator.pop(context);
              },
            ),
          ),

          // profile tile
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: ListTile(
              leading: const Icon(
                Icons.person,
              ),
              title: const Text('P R O F I L E'),
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // navigate to profile page
                Navigator.pushNamed(context, '/profile_page');
              },
            ),
          ),
          // Applications
          Padding(
            padding: EdgeInsets.only(left: 20.w),
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
                  builder: (context) => ApplicationsPage(),
                ));
              },
            ),
          ),

          // user tile
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: ListTile(
              leading: const Icon(
                Icons.group,
              ),
              title: const Text('U S E R S'),
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
            padding: EdgeInsets.only(left: 20.w),
            child: ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('L O G O U T'),
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
