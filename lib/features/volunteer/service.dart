import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data_model.dart';

final volunteerApplicationProvider = FutureProvider<List<VolunteerApplication>>(
    (ref) => DataService().getApplication());

class DataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<VolunteerApplication>> getApplication() async {
    print('yeta pugyo');
    try {
      final listData = await _db.collection('volunteer_applications').get();

      final applicationList = await Future.wait(listData.docs.map((e) async {
        final json = e.data();
        final volunteer = await getVolunteer(json['userId']);
        final post = await getPost(json['postId']);
        return VolunteerApplication.fromJson({
          ...json,
          'volunteer': volunteer,
          'post': post,
        });
      }));
      return applicationList;
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<Volunteer> getVolunteer(String volunteerId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> volunteer =
          await _db.collection('users').doc(volunteerId).get();

      final userV = Volunteer.fromJson(volunteer.data()!);
      print(userV.runtimeType);
      return userV;
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<Post> getPost(String postId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> post =
          await _db.collection('posts').doc(postId).get();

      final postData = Post.fromJson(post.data()!);
      return postData;
    } on FirebaseException catch (e) {
      throw e;
    }
  }
}
