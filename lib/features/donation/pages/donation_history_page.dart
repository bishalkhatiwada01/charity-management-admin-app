import 'package:charity_management_admin/common/widgets/custom_app_bar.dart';
import 'package:charity_management_admin/features/donation/data/donation_service.dart';
import 'package:charity_management_admin/features/donation/widgets/donation_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationHistoryPage extends ConsumerWidget {
  const DonationHistoryPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final donationData = ref.watch(donationServiceProvider);
    return Scaffold(
        appBar: CustomAppBar(
          title: 'DONATION HISTORY',
        ),
        body: donationData.when(
          data: (donations) {
            return donations.isEmpty
                ? Center(
                    child: Text(
                    'No Posts',
                    style: TextStyle(fontSize: 20.sp),
                  ))
                : Expanded(
                    child: ListView.builder(
                      itemCount: donations.length,
                      itemBuilder: (context, index) {
                        final donation = donations[index];
                        return DonationHistoryCard(
                          donationDate: donation.donationDate,
                          amount: donation.amount,
                          campaignName: donation.campaignName,
                          transactionId: donation.transactionId,
                        );
                      },
                    ),
                  );
          },
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          error: (err, stack) => Center(
            child: Text('Error: $err'),
          ),
        ));
  }
}
