import 'package:charity_management_admin/features/donation/widgets/donation_history_card.dart';
import 'package:flutter/material.dart';

class DonationHistoryPage extends StatelessWidget {
  const DonationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'DONATION HISTORY',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
              letterSpacing: 2,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DonationHistoryCard(
              donationDate: '2022-01-01',
              amount: '100 USD',
              campaignName: 'Campaign A',
            ),
            DonationHistoryCard(
              donationDate: '2022-02-15',
              amount: '50 USD',
              campaignName: 'Campaign B',
            ),
          ],
        ));
  }
}
