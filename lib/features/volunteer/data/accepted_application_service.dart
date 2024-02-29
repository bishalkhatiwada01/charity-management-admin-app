import 'dart:async';
import 'package:charity_management_admin/features/volunteer/domain/data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class AcceptedApplicationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<VolunteerApplication>> getAcceptedApplication() async {
    try {
      final listData = await _db.collection('accepted_applications').get();

      final applicationList = await Future.wait(listData.docs.map((e) async {
        final json = e.data();
        final volunteer = await getVolunteer(json['userId']);
        final post = await getPost(json['postId']);
        return VolunteerApplication.fromJson({
          ...json,
          'volunteer': volunteer,
          'posts': post,
          'acceptedApplicationId': e.id,
        });
      }));
      return applicationList;
    } on FirebaseException {
      rethrow;
    }
  }

  final _acceptedApplicationsRef =
      FirebaseFirestore.instance.collection('accepted_applications');

  Future<String> deleteAcceptedApplication(String volunteerApplicationId,
      {required String acceptedApplicationId}) async {
    try {
      await _acceptedApplicationsRef.doc(acceptedApplicationId).delete();
      return 'Application Deleted';
    } on FirebaseException catch (err) {
      return '${err.message}';
    }
  }

  Future<void> deleteApplication(String applicationId) async {
    await _acceptedApplicationsRef.doc(applicationId).delete();
  }

  Future<Volunteer> getVolunteer(String volunteerId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> volunteer =
          await _db.collection('users').doc(volunteerId).get();
      final userV = Volunteer.fromJson(
          {...volunteer.data()!, 'volunteerId': volunteerId});

      return userV;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<Post> getPost(String postId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> post =
          await _db.collection('posts').doc(postId).get();

      final postData = Post.fromJson({...post.data()!, 'postId': postId});
      return postData;
    } on FirebaseException {
      rethrow;
    }
  }
}
