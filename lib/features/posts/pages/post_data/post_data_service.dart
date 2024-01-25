import 'package:charity_management_admin/features/posts/pages/post_data/post_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postProvider = FutureProvider<List<PostData>>(
  (ref) => PostDataService().getAllPost(),
);

final class PostDataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<PostData>> getAllPost() async {
    try {
      final querySnapshot = await _db.collection('posts').get();

      return querySnapshot.docs
          .map((doc) => PostData.fromJson({
                ...doc.data(),
                'postId': doc.id,
              }))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
