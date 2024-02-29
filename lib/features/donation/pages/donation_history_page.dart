import 'package:charity_management_admin/common/widgets/custom_app_bar.dart';
import 'package:charity_management_admin/features/donation/widgets/donation_history_card.dart';
import 'package:charity_management_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DonationHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'DONATION HISTORY',
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donations').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              // Format the Timestamp to a String
              String formattedDate = DateFormat('yyyy-MM-dd h:mm a')
                  .format(data['paymentDate'].toDate());
              // Convert the double to a String
              String amount = data['amount'].toString();
              return DonationHistoryCard(
                donationDate: formattedDate,
                amount: amount,
                campaignName: data['postTitle'],
                transactionId: data['transactionId'],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
