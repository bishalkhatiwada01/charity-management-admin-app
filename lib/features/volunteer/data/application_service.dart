import 'package:charity_management_admin/features/volunteer/domain/data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ApplicationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _volunteerApplicationsRef =
      FirebaseFirestore.instance.collection('volunteer_applications');

// accept and reject application services
  Future<String> acceptApplication({
    required VolunteerApplication application,
  }) async {
    try {
      // Convert data model to JSON-like map
      Map<String, dynamic> jsonData = application.toJson();

      // Create a new document and get its ID
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('accepted_applications')
          .add(jsonData);
      String acceptedApplicationId = docRef.id;

      // Update the document with the ID
      await docRef.update({'acceptedApplicationId': acceptedApplicationId});

      // Delete the original application
      await _volunteerApplicationsRef
          .doc(application.volunteerApplicationId)
          .delete();

      return 'Application Accepted';
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> rejectApplication({required String applicationId}) async {
    try {
      await _volunteerApplicationsRef.doc(applicationId).delete();
      return 'Application Deleted';
    } on FirebaseException catch (err) {
      return '${err.message}';
    }
  }

  // get appliction services
  Future<List<VolunteerApplication>> getApplication() async {
    try {
      final listData = await _db.collection('volunteer_applications').get();

      final applicationList = await Future.wait(
        listData.docs.map(
          (e) async {
            final json = e.data();
            final volunteer = await getVolunteer(json['userId']);
            final post = await getPost(json['postId']);
            return VolunteerApplication.fromJson({
              ...json,
              'volunteer': volunteer,
              'posts': post,
              'volunteerApplicationId': e.id,
            });
          },
        ),
      );
      return applicationList;
    } catch (e) {
      if (kDebugMode) {
        print("errorr--------------------------");
      }
      rethrow;
    }
  }

// get volunteer through appliction
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

  // get post through application

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

  // accepted application services
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
}
