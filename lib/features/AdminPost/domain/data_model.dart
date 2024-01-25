import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostDataModel {
  String postId;
  String postHeadline;
  String postContent;
  String postAddress;
  String postContact;
  String postImageUrl;
  // Timestamp postCreatedAt;

  PostDataModel({
    required this.postId,
    required this.postHeadline,
    required this.postContent,
    required this.postAddress,
    required this.postContact,
    required this.postImageUrl,
    // required this.postCreatedAt,
  });

  factory PostDataModel.fromJson(Map<String, dynamic> json) {
    return PostDataModel(
      postId: json['postId'],
      postHeadline: json['postHeadline'],
      postContent: json['postContent'],
      postAddress: json['postAddress'],
      postContact: json['postContact'],
      postImageUrl: json['postImageUrl'],
      // postCreatedAt: json['postCreatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'postHeadline': postHeadline,
      'postContent': postContent,
      'postAddress': postAddress,
      'postContact': postContact,
      'postImageUrl': postImageUrl,
      // 'postCreatedAt': postCreatedAt,
    };
  }
  // String formattedDate() {
  //   DateTime dateTime = postCreatedAt.toDate();
  //   return DateFormat.yMd().add_Hms().format(dateTime);
  // }
}
