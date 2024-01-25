import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationService {
  final CollectionReference _applicationsRef =
      FirebaseFirestore.instance.collection('accepted_applications');

  Future<void> storeApplicationData(
      String id, Map<String, dynamic> data) async {
    try {
      await _applicationsRef.doc(id).set(data);
    } catch (error) {
      throw Exception('Failed to store application data: $error');
    }
  }

  Future<String> acceptApplication({required String applicationId}) async {
    try {
      await FirebaseFirestore.instance.collection('accepted_applications').add({
        'applicationId': applicationId,
      });
      return 'Application Accepted';
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> rejectApplication({required String applicationId}) async {
    try {
      await FirebaseFirestore.instance.collection('rejected_applications').add({
        'applicationId': applicationId,
      });
      return 'Application Rejected';
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }
}
