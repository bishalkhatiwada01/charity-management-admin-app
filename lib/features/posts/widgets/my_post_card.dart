import 'package:charity_management_admin/features/AdminPost/domain/data_model.dart';
import 'package:charity_management_admin/features/posts/pages/post_data/post_data_model.dart';
import 'package:charity_management_admin/features/posts/services/edit_delete_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCard extends ConsumerStatefulWidget {
  final PostDataModel postData;
  const PostCard({
    required this.postData,
    super.key,
  });

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (_) => PostDetailsPage(
        //       postModel: widget.postData,
        //     ),
        //   ),
        // );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                widget.postData.postImageUrl,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.postData.postHeadline,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // widget.postData.postCreatedAt.toString(),
                        widget.postData.postAddress,
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      EditDeleteLogic.deletePost(
                          context, widget.postData.postId);
                    },
                    icon: Icon(
                      Icons.delete_rounded,
                      size: 23.sp,
                      color: Colors.red.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
