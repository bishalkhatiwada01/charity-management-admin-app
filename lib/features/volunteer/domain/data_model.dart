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
  List<String>? volunteerQualification;
  final String volunteerCreatedAt;
  final String volunteerContactNum;
  List<String>? volunteerSkills;
  final String volunteerApplicationId;
  final String? applicationAcceptedDate;
  final String acceptedApplicationId;

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
    required this.volunteerCreatedAt,
    required this.volunteerApplicationId,
    required this.volunteerContactNum,
    this.volunteerSkills,
    required this.applicationAcceptedDate,
    required this.acceptedApplicationId,
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
      volunteerQualification: List<String>.from(json['volunteerQualification']),
      volunteerAddress: json['volunteerAddress'],
      volunteer: json['volunteer'],
      post: json['posts'],
      volunteerCreatedAt: json['volunteerDate'],
      volunteerSkills: List<String>.from(json['volunteerSkills']),
      volunteerApplicationId: json['volunteerApplicationId'],
      applicationAcceptedDate: json['applicationAcceptedDate'],
      acceptedApplicationId: json['acceptedApplicationId'],
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
      'volunteerDate': volunteerCreatedAt,
      'applicationAcceptedDate': applicationAcceptedDate,
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
  final String postDate;
  final String? postId;
  List<String> skills;
  List<String> interests;
  List<String> qualifications;

  Post({
    required this.postHeadline,
    required this.postContent,
    required this.postAddress,
    required this.postContact,
    required this.postImageUrl,
    required this.postDate,
    required this.postId,
    required this.skills,
    required this.interests,
    required this.qualifications,
  });

  Map<String, dynamic> toJson() {
    return {
      'postHeadline': postHeadline,
      'postContent': postContent,
      'postAddress': postAddress,
      'postContact': postContact,
      'postImageUrl': postImageUrl,
      'postId': postId,
      'postCreatedAt': postDate,
      'skills': skills,
      'interests': interests,
      'qualifications': qualifications,
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
      postDate: json['postCreatedAt'],
      skills: List<String>.from(json['skills']),
      interests: List<String>.from(json['interests']),
      qualifications: List<String>.from(json['qualifications']),
    );
  }
}
