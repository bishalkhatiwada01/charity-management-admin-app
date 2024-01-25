import 'package:charity_management_admin/common/widgets/my_drawer.dart';
import 'package:charity_management_admin/features/AdminPost/views/createPostPage.dart';
import 'package:charity_management_admin/features/posts/pages/post_data/post_data_service.dart';
import 'package:charity_management_admin/features/posts/services/edit_delete_logic.dart';
import 'package:charity_management_admin/features/posts/utils/firestore.dart';
import 'package:charity_management_admin/features/posts/widgets/my_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
    final postData = ref.watch(postProvider);
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
          body: postData.when(
            data: (data) {
              return data.isEmpty
                  ? Text('No Posts')
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return PostCard(postData: data[index]);
                      },
                      itemCount: data.length,
                    );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => const CreatePostPage(),
                    builder: (context) => PostPage(),
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
