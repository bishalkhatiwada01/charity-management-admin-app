import 'package:charity_management_admin/common/widgets/my_drawer.dart';
import 'package:charity_management_admin/features/posts/data/provider/post_porvider.dart';
import 'package:charity_management_admin/features/posts/pages/create_post_page.dart';
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
              'MY POSTS',
              style: TextStyle(letterSpacing: 6),
            ),
          ),
          drawer: const MyDrawer(),
          body: postData.when(
            data: (data) {
              return data.isEmpty
                  ? Center(
                      child: Text(
                      'No Posts',
                      style: TextStyle(fontSize: 20.sp),
                    ))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return PostCard(
                          postData: data[index],
                        );
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
            onPressed: () async {
              var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePostPage(),
                  ));
              if (result == 'postCreated') {
                setState(() {});
              }
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
