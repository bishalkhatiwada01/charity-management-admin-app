import 'package:charity_management_admin/features/donation/pages/donation_history_page.dart';
import 'package:charity_management_admin/features/profile/data/get_user_service.dart';
import 'package:charity_management_admin/features/profile/widgets/my_card_profile.dart';
import 'package:charity_management_admin/features/volunteer/presentation/pages/volunteer_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(adminUserProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'PROFILE',
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              letterSpacing: 4),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
      ),
      body: user.when(
        data: (userData) {
          final Map<String, dynamic> user = userData.data()!;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 65,
                      backgroundImage: AssetImage("assets/6195145.jpg"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/download.png"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/GooglePlus-logo-red.png"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/1_Twitter-new-icon-mobile-app.jpg"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/600px-LinkedIn_logo_initials.png"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user['username'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 22),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user['email'],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    children: [
                      // cards for profile
                      MyCardProfile(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ()));
                        },
                        title: 'Personal Information',
                        leading: const Icon(
                          Icons.privacy_tip_sharp,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      MyCardProfile(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DonationHistoryPage(),
                            ),
                          );
                        },
                        title: 'Donation History',
                        leading: const Icon(
                          Icons.history,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 6.h),

                      MyCardProfile(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VolunteerHistoryPage()));
                        },
                        title: 'Volunteer History',
                        leading: const Icon(
                          Icons.history,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 6.h),

                      MyCardProfile(
                        onPressed: () {
                          Navigator.pushNamed(context, '/invite_friend');
                        },
                        title: 'Invite a Friend',
                        leading: const Icon(
                          Icons.add_reaction_sharp,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 6.h),

                      MyCardProfile(
                        onPressed: () {
                          Navigator.pushNamed(context, '/logout');
                        },
                        title: 'Logout',
                        leading: const Icon(
                          Icons.logout,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 6.h),

                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return null;
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
