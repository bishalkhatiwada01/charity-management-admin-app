import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  final _notificationsRef =
      FirebaseFirestore.instance.collection('notifications');

  Future<void> uploadNotification({
    required String title,
    required String message,
    required String postId,
  }) async {
    try {
      await _notificationsRef.add({
        'title': title,
        'message': message,
        'postId': postId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error uploading notification: $e');
      throw e;
    }
  }
}
