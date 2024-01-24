import 'package:charity_management_admin/common/widgets/my_drawer.dart';
import 'package:charity_management_admin/features/posts/pages/create_post_page.dart';
import 'package:charity_management_admin/features/posts/services/edit_delete_logic.dart';
import 'package:charity_management_admin/features/posts/utils/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EditDeleteLogic editDeleteLogic = EditDeleteLogic();

  // firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // text controller
  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    // only post if there something in textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    // clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            elevation: 0,
            title: const Text(
              'POSTS',
              style: TextStyle(letterSpacing: 6),
            ),
          ),
          drawer: const MyDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // posts
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePostPage(),
                  ));
            },
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            child: Icon(
              Icons.add,
              size: 20.w,
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
    );
  }
}
