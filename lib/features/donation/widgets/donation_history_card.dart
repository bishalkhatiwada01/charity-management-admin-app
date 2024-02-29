import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationHistoryCard extends StatelessWidget {
  final String donationDate;
  final String amount;
  final String campaignName;
  final String transactionId;

  const DonationHistoryCard({
    super.key,
    required this.donationDate,
    required this.amount,
    required this.campaignName,
    required this.transactionId,
  });

  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            campaignName,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Date: ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: donationDate,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Amount: ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "\$$amount",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Transaction Id: ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: transactionId,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.download),
            onPressed: () =>
                // _downloadPDF(context), // Pass the context to show SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('PDF Downloaded'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
