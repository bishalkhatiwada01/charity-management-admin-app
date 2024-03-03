import 'package:charity_management_admin/features/donation/data/pdf_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

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

  void _downloadPDF(BuildContext context) async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isGranted) {
      // Permission is already granted, proceed with download
      PDFService.downloadDonationHistoryPDF(
          campaignName, donationDate, amount, transactionId);
      print("PDF Downloaded");
    } else {
      // Permission is not granted, request it
      status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        // Permission granted, proceed with download
        PDFService.downloadDonationHistoryPDF(
            campaignName, donationDate, amount, transactionId);
      } else {
        // Permission denied
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Storage permission required for download.'),
          ),
        );
      }
    }
  }

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
                        fontSize: 15.sp,
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
                        fontSize: 15.sp,
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
                _downloadPDF(context), // Pass the context to show SnackBar
            //     ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('PDF Downloaded'),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
