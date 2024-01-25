// import 'dart:io';

// import 'package:charity_management_admin/features/posts/domain/data_model.dart';
// import 'package:charity_management_admin/features/volunteer/data_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class PostDataSource {
//   final postDb = FirebaseFirestore.instance.collection('Posts');

//   Future<String> createPost({
//     required String postHeadline,
//     required String postAddress,
//     required String postContact,
//     required String postContent,
//     required postImageUrl,
//   }) async {
//     try {
//       await postDb.add({
//         'postHeadline': postHeadline,
//         'postAddress': postAddress,
//         'postContact': postContact,
//         'postContent': postContent,
//         'postImageUrl': postImageUrl,
//         'postCreatedAt': Timestamp.now(),
//       });

//       return 'Post Created';
//     } on FirebaseException catch (err) {
//       return '${err.message}';
//     }
//   }

//   Future<File?> pickImageFromGallery() async {
//     final file = await ImagePicker().pickImage(source: ImageSource.gallery);
//     return file != null ? File(file.path) : null;
//   }

//   Future<List<PostDataModel>> getAllPost() async {
//     try {
//       final querySnapshot = await postDb.get();

//       return querySnapshot.docs
//           .map((doc) => PostDataModel.fromJson({
//                 ...doc.data(),
//                 'postId': doc.id,
//               }))
//           .toList();
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<String> deletePost({required String postId}) async {
//     try {
//       await postDb.doc(postId).delete();

//       return 'Post Deleted';
//     } on FirebaseException catch (err) {
//       return '${err.message}';
//     }
//   }

//   Future<String> updatePost({
//     required String postId,
//     required String postHeadline,
//     required String postAddress,
//     required String postContact,
//     required String postContent,
//     required String postImageUrl,
//   }) async {
//     try {
//       await postDb.doc(postId).update({
//         'postHeadline': postHeadline,
//         'postAddress': postAddress,
//         'postContact': postContact,
//         'postContent': postContent,
//         'postImageUrl': postImageUrl,
//         'postCreatedAt': Timestamp.now(),
//       });

//       return 'Post Updated';
//     } on FirebaseException catch (err) {
//       return '${err.message}';
//     }
//   }

//   Future<List<Post>> getPostByPostId({required String postId}) async {
//     try {
//       final querySnapshot =
//           await postDb.where('postId', isEqualTo: postId).get();

//       return querySnapshot.docs
//           .map((doc) => Post.fromJson({
//                 ...doc.data(),
//                 'postId': doc.id,
//               }))
//           .toList();
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

// void showError(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
// }
