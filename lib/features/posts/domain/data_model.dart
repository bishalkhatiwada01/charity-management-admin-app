class PostDataModel {
  String postId;
  String postHeadline;
  String postContent;
  String postAddress;
  String postContact;
  String postImageUrl;
  String postCreatedAt;
  List<String> skills;
  List<String> interests;
  List<String> qualifications;

  PostDataModel({
    required this.postId,
    required this.postHeadline,
    required this.postContent,
    required this.postAddress,
    required this.postContact,
    required this.postImageUrl,
    required this.postCreatedAt,
    required this.skills,
    required this.interests,
    required this.qualifications,
  });

  factory PostDataModel.fromJson(Map<String, dynamic> json) {
    return PostDataModel(
      postId: json['postId'],
      postHeadline: json['postHeadline'],
      postContent: json['postContent'],
      postAddress: json['postAddress'],
      postContact: json['postContact'],
      postImageUrl: json['postImageUrl'],
      postCreatedAt: json['postCreatedAt'],
      skills: List<String>.from(json['skills']),
      interests: List<String>.from(json['interests']),
      qualifications: List<String>.from(json['qualifications']),
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
      'postCreatedAt': postCreatedAt,
      'skills': skills,
      'interests': interests,
      'qualifications': qualifications,
    };
  }
}
