import 'package:charity_management_admin/features/donation/model/donation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final donationServiceProvider =
    StreamProvider<List<Donation>>((ref) => DonationService().getDonations());

class DonationService {
  Stream<List<Donation>> getDonations() {
    return FirebaseFirestore.instance
        .collection('donations')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Donation.fromMap(data);
      }).toList();
    });
  }
}
