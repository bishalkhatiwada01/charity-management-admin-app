import 'package:charity_management_admin/features/posts/views/edit_post_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditDeleteLogic {
  static void editPost(
    BuildContext context, {
    required String headline,
    required String content,
    required String address,
    required String contact,
    required String imageUrl,
    required String postId,
    required Function(Map<String, dynamic>) onUpdate,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPostPage(
          initialHeadline: headline,
          initialContent: content,
          initialAddress: address,
          initialContact: contact,
          initialImageUrl: imageUrl,
          postId: postId,
          onUpdate: onUpdate,
        ),
      ),
    );
  }

  static void deletePost(BuildContext context, String postId) async {
    try {
      // Delete the post from Firestore
      await FirebaseFirestore.instance.collection('posts').doc(postId).delete();

      // Navigate back to the homepage after successful deletion
      Navigator.pop(context);
    } catch (error) {
      // Handle any errors that may occur during the deletion
      print('Error deleting post: $error');
      // Optionally, show a snackbar or alert the user about the error
    }
  }
}
