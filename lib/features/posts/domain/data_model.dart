class PostDataModel {
  String postId;
  String postHeadline;
  String postContent;
  String postAddress;
  String postContact;
  String postImageUrl;
  String postCreatedAt;

  PostDataModel({
    required this.postId,
    required this.postHeadline,
    required this.postContent,
    required this.postAddress,
    required this.postContact,
    required this.postImageUrl,
    required this.postCreatedAt,
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
    };
  }
}
