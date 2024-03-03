import 'package:charity_management_admin/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DonationByCampaigns extends ConsumerStatefulWidget {
  const DonationByCampaigns({super.key});

  @override
  ConsumerState<DonationByCampaigns> createState() =>
      _DonationByCampaignsState();
}

List<Map<String, dynamic>> donationDataByPost = [];

class _DonationByCampaignsState extends ConsumerState<DonationByCampaigns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'DONATIONS',
      ),
      body: ListView.builder(
        itemCount: donationDataByPost.length,
        itemBuilder: (context, index) {
          final donationData = donationDataByPost[index];
          return ListTile(
            title: Text(donationData['postTitle']),
            // Replace 'postTitle' with the actual key for the post title in your data
            subtitle: Text(
                'Donation Amount: ${donationData['donationAmount']}'), // Replace 'donationAmount' with the actual key for the donation amount in your data
          );
        },
      ),
    );
  }
}
