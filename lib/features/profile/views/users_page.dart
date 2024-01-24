import 'package:charity_management_admin/common/widgets/my_back_buttom.dart';
import 'package:charity_management_admin/features/profile/views/user_detail_page.dart';
import 'package:charity_management_admin/helper/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          // any errors
          if (snapshot.hasError) {
            displayMessageToUser('Something went wrong', context);
          }

          // show loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Text('No data');
          }

          // get all users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  top: 40.h,
                ),
                child: const Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  itemBuilder: (context, index) {
                    // get individual users
                    final user = users[index];

                    // get data from each user
                    String username = user['username'];
                    String email = user['email'];
                    // ignore: unused_local_variable
                    String id = user.id;



                    return Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, top: 20.h, right: 10.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(username),
                          subtitle: Text(email),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const UserDetailsPage()));
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
