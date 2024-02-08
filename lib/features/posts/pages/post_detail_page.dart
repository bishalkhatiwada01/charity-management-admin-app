import 'package:charity_management_admin/common/functions/date_formatted.dart';
import 'package:charity_management_admin/features/posts/domain/data_model.dart';
import 'package:charity_management_admin/features/posts/data/service/edit_delete_logic.dart';
import 'package:charity_management_admin/features/posts/pages/edit_post_page.dart';
import 'package:charity_management_admin/features/posts/pages/full_screen_image.dart';
import 'package:charity_management_admin/features/posts/widgets/edit_delete_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostDetailsPage extends StatefulWidget {
  final String postId;
  final PostDataModel postData;

  const PostDetailsPage({
    super.key,
    required this.postId,
    required this.postData,
  });

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final EditDeleteLogic editDeleteLogic = EditDeleteLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          'POST DETAILS',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle the onTap event to show the image in full screen
                      // You can navigate to a new screen with the full-screen image, or show a dialog, etc.
                      // For example, you can use Navigator to navigate to a new fullscreen image screen:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImage(
                              imageUrl: widget.postData.postImageUrl),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12.0)),
                      child: Image.network(
                        widget.postData.postImageUrl,
                        height: 200.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.postData.postHeadline,
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Address: ',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: widget.postData.postAddress,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Date: ',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: formatDateTime(
                                  widget.postData.postCreatedAt,
                                ),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Contact no: ',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: widget.postData.postContact,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Khalti no: ',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: widget.postData.khaltiNo,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Content: ',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: widget.postData.postContent,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: ExpansionTile(
                            shape: const BeveledRectangleBorder(
                              side: BorderSide.none,
                            ),
                            title: Text(
                              'For Volunteer:',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Interests: ',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.postData.interests
                                                .join(", "),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Qualifications: ',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.postData.qualifications
                                                .join(", "),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Skills: ',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.postData.skills
                                                .join(", "),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: EditDeleteButtons(
                onEditPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPostPage(
                        postDataModel: widget.postData,
                      ),
                    ),
                  );
                },
                onDeletePressed: () {
                  EditDeleteLogic.deletePost(context, widget.postData.postId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
