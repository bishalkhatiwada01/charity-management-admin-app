class VolunteerApplication {
  final String userId;
  final String postId;
  final String volunteerName;
  final String email;
  final List<String> interests;
  final String experience;
  final String address;
  final Volunteer volunteer;
  final Post post;
  final String qualification;
  final String createdAt;
  final String contactNum;
  final String skills;

  VolunteerApplication({
    required this.userId,
    required this.postId,
    required this.email,
    required this.qualification,
    required this.volunteerName,
    required this.interests,
    required this.contactNum,
    required this.address,
    required this.experience,
    required this.volunteer,
    required this.post,
    required this.createdAt,
    required this.skills,
  });

  factory VolunteerApplication.fromJson(Map<String, dynamic> json) {
    return VolunteerApplication(
      userId: json['userId'],
      postId: json['postId'],
      email: json['email'],
      volunteerName: json['fullName'],
      contactNum: json['contactNumber'],
      interests: List<String>.from(json['interests']),
      experience: json['experience'],
      qualification: json['qualification'],
      address: json['address'],
      volunteer: json['volunteer'],
      post: json['post'],
      createdAt: json['date'],
      skills: json['skills'],
    );
  }
}

class Volunteer {
  final String volunteerName;
  final String volunteerEmail;

  Volunteer({
    required this.volunteerName,
    required this.volunteerEmail,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      volunteerName: "${json['firstname']} ${json['lastname']}",
      volunteerEmail: json['email'],
    );
  }
}

class Post {
  final String headline;
  final String content;
  final String address;
  final String contact;
  final String imageUrl;
  final String date;
  final String postId;
  Post({
    required this.headline,
    required this.content,
    required this.address,
    required this.contact,
    required this.imageUrl,
    required this.date,
    required this.postId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      address: json['address'],
      content: json['content'],
      headline: json['headline'],
      imageUrl: json['imageUrl'],
      contact: json['contact'],
      postId: json['postId'],
      date: json['createdAt'],
    );
  }
}
