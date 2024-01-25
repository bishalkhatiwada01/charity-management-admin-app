class VolunteerApplication {
  final String userId;
  final String postId;
  final String volunteerName;
  final String volunteerEmail;
  List<String>? volunteerInterests;
  final String volunteerExperience;
  final String volunteerAddress;
  final Volunteer volunteer;
  final Post post;
  String? volunteerQualification;
  // final String volunteerCreatedAt;
  final String volunteerContactNum;
  List<String>? volunteerSkills;
  final String volunteerApplicationId;

  VolunteerApplication({
    required this.userId,
    required this.postId,
    required this.volunteerName,
    required this.volunteer,
    required this.post,
    required this.volunteerEmail,
    this.volunteerInterests,
    required this.volunteerExperience,
    required this.volunteerAddress,
    this.volunteerQualification,
    // required this.volunteerCreatedAt,
    required this.volunteerApplicationId,
    required this.volunteerContactNum,
    this.volunteerSkills,
  });

  factory VolunteerApplication.fromJson(Map<String, dynamic> json) {
    return VolunteerApplication(
      userId: json['userId'],
      postId: json['postId'],
      volunteerEmail: json['volunteerEmail'],
      volunteerName: json['volunteerFullName'],
      volunteerContactNum: json['volunteerContactNumber'],
      volunteerInterests: List<String>.from(json['volunteerInterests']),
      volunteerExperience: json['volunteerExperience'],
      volunteerQualification: json['volunteerQualification'],
      volunteerAddress: json['volunteerAddress'],
      volunteer: json['volunteer'],
      post: json['posts'],
      // volunteerCreatedAt: json['volunteerDate'],
      volunteerSkills: List<String>.from(json['volunteerSkills']),
      volunteerApplicationId: json['volunteerApplicationId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'postId': postId,
      'volunteerEmail': volunteerEmail,
      'volunteerFullName': volunteerName,
      'volunteerContactNumber': volunteerContactNum,
      'volunteerInterests': volunteerInterests,
      'volunteerExperience': volunteerExperience,
      'volunteerQualification': volunteerQualification,
      'volunteerAddress': volunteerAddress,
      'volunteer': volunteer.toJson(),
      'posts': post.toJson(),
      'volunteerSkills': volunteerSkills,
      'volunteerApplicationId': volunteerApplicationId,
    };
  }
}

class Volunteer {
  final String userName;
  final String userEmail;

  Volunteer({
    required this.userName,
    required this.userEmail,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      userName: "${json['firstname']} ${json['lastname']}",
      userEmail: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
    };
  }
}

class Post {
  final String postHeadline;
  final String postContent;
  final String postAddress;
  final String postContact;
  final String postImageUrl;
  // final String postDate;
  final String? postId;
  Post({
    required this.postHeadline,
    required this.postContent,
    required this.postAddress,
    required this.postContact,
    required this.postImageUrl,
    // required this.postDate,
    required this.postId,
  });

  Map<String, dynamic> toJson() {
    return {
      'postHeadline': postHeadline,
      'postContent': postContent,
      'postAddress': postAddress,
      'postContact': postContact,
      'postImageUrl': postImageUrl,
      'postId': postId,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postAddress: json['postAddress'],
      postContent: json['postContent'],
      postHeadline: json['postHeadline'],
      postImageUrl: json['postImageUrl'],
      postContact: json['postContact'],
      postId: json['postId'],
      // postDate: json['postCreatedAt'],
    );
  }
}
