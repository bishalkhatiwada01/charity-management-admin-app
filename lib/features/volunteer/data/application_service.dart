import 'package:charity_management_admin/features/volunteer/domain/data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationService {
  final _volunteerApplicationsRef =
      FirebaseFirestore.instance.collection('volunteer_applications');

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
}
