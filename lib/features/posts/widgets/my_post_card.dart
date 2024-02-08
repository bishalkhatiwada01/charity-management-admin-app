import 'package:charity_management_admin/common/functions/date_formatted.dart';
import 'package:charity_management_admin/features/posts/provider/post_porvider.dart';
import 'package:charity_management_admin/features/posts/domain/data_model.dart';
import 'package:charity_management_admin/features/posts/data/service/edit_delete_logic.dart';
import 'package:charity_management_admin/features/posts/pages/post_detail_page.dart';
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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PostDetailsPage(
              postData: widget.postData,
              postId: widget.postData.postId,
            ),
          ),
        );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDateTime(
                          widget.postData.postCreatedAt,
                        ),
                        style: TextStyle(
                            fontSize: 13.sp,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      IconButton(
                        onPressed: () {
                          EditDeleteLogic.deletePost(
                            context,
                            widget.postData.postId,
                          );
                          ref.read(postProvider).whenData((value) {
                            value.remove(widget.postData);
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 23.sp,
                          color: Colors.red.shade300,
                        ),
                      ),
                    ],
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
