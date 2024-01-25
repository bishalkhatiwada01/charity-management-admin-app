class PostData {
  final String postHeadline;
  final String postContent;
  final String postAddress;
  final String postContact;
  final String postImageUrl;
  final String postDate;
  final String postId;
  PostData({
    required this.postHeadline,
    required this.postContent,
    required this.postAddress,
    required this.postContact,
    required this.postImageUrl,
    required this.postDate,
    required this.postId,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      postAddress: json['postAddress'],
      postContent: json['postContent'],
      postHeadline: json['postHeadline'],
      postImageUrl: json['postImageUrl'],
      postContact: json['postContact'],
      postId: json['postId'],
      postDate: json['postCreatedAt'],
    );
  }
}
