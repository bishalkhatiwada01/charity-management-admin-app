/*
this databse stores posts that user have published in the app.
it is stored in the collection called 'Posts' in firebase.

Each post contains:
- a message
- email of user
- timestamps
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // current logged in user

  User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'username': user!.displayName,
      'PostMessage': message,
      'dateString': '${DateTime.now()}',
      
      
    });
  }

  // read the post from database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('dateString', descending: true)
        .snapshots();

    return postsStream;
  }
}
