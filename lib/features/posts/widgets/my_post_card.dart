import 'package:charity_management_admin/common/functions/date_formatted.dart';
import 'package:charity_management_admin/features/posts/pages/post_detail_page.dart';
import 'package:charity_management_admin/features/posts/services/edit_delete_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final String headline;
  final String content;
  final String address;
  final String contact;
  final String imageUrl;
  final String date;
  final String postId;

  PostCard({
    required this.headline,
    required this.imageUrl,
    required this.content,
    required this.address,
    required this.contact,
    required this.date,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {

    
    String formattedDate = formatDateTime(date);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PostDetailsPage(
              headline: headline,
              content: content,
              address: address,
              contact: contact,
              imageUrl: imageUrl,
              date: formattedDate,
              postId: postId,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                imageUrl,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headline,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$formattedDate',
                            style: TextStyle(),
                          ),
                          IconButton(
                            onPressed: () {
                              EditDeleteLogic.deletePost(context, postId);
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                              size: 23.sp,
                              color: Colors.red.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
