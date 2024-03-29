import 'package:charity_management_admin/api/api_keys.dart';
import 'package:charity_management_admin/api/end_points.dart';
import 'package:charity_management_admin/features/posts/domain/data_model.dart';
import 'package:charity_management_admin/features/volunteer/domain/volunteer_application_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostDataSource {
  final postDb = FirebaseFirestore.instance.collection('posts');

  Future<String> createPost({
    required String postHeadline,
    required String postAddress,
    required String postContact,
    required String postContent,
    required String postImageUrl,
    required List<String> skills,
    required List<String> interests,
    required List<String> qualifications,
    required String targetAmount,
  }) async {
    try {
      await postDb.add({
        'postHeadline': postHeadline,
        'postAddress': postAddress,
        'postContact': postContact,
        'postContent': postContent,
        'postImageUrl': postImageUrl,
        'skills': skills,
        'interests': interests,
        'qualifications': qualifications,
        'postCreatedAt': DateTime.now().toIso8601String(),
        'targetAmount': targetAmount,
      });
      await sendNotificationToSubscribedUsers(postHeadline, postContent);

      return 'Post Created';
    } on FirebaseException catch (err) {
      return '${err.message}';
    }
  }

  Future<void> sendNotificationToSubscribedUsers(
      String title, String message) async {
    try {
      final dio = Dio(BaseOptions(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      }));
      await dio.post(
        ApiEndPoints.baseNotificationUrl,
        data: {
          "to": "/topics/posts",
          "notification": {
            "title": "New Post Created!!",
            "body": title,
          },
          "data": {
            "type": 'post',
            "story_id": "story_12345",
          },
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
    }
  }

  Future<List<PostDataModel>> getAllPost() async {
    try {
      final querySnapshot = await postDb.get();

      return querySnapshot.docs
          .map((doc) => PostDataModel.fromJson({
                ...doc.data(),
                'postId': doc.id,
              }))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updatePost({
    required PostDataModel postDataModel,
  }) async {
    try {
      await postDb.doc(postDataModel.postId).update({
        'postHeadline': postDataModel.postHeadline,
        'postAddress': postDataModel.postAddress,
        'postContact': postDataModel.postContact,
        'postContent': postDataModel.postContent,
        'postImageUrl': postDataModel.postImageUrl,
        'postCreatedAt': DateTime.now().toIso8601String(),
        'skills': postDataModel.skills,
        'interests': postDataModel.interests,
        'qualifications': postDataModel.qualifications,
        'targetAmount': postDataModel.targetAmount,
      });

      return 'Post Updated';
    } on FirebaseException catch (err) {
      return '${err.message}';
    }
  }
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
