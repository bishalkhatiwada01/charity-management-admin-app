import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationHistoryCard extends StatelessWidget {
  final String donationDate;
  final String amount;
  final String campaignName;

  const DonationHistoryCard({
    super.key,
    required this.donationDate,
    required this.amount,
    required this.campaignName,
  });

  // // Function to handle the download action
  // void _downloadPDF(BuildContext context) async {
  //   // Check if storage permission is granted
  //   var status = await Permission.storage.status;
  //   if (status.isGranted) {
  //     // Permission is already granted, proceed with download
  //     PDFService.downloadDonationHistoryPDF(campaignName, donationDate, amount);
  //   } else {
  //     // Permission is not granted, request it
  //     status = await Permission.storage.request();
  //     if (status.isGranted) {
  //       // Permission granted, proceed with download
  //       PDFService.downloadDonationHistoryPDF(
  //           campaignName, donationDate, amount);
  //     } else {
  //       // Permission denied
  //       // You may want to show a message to the user or handle this case accordingly
  //       // ignore: use_build_context_synchronously
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Storage permission required for download.'),
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Date: $donationDate',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                'Amount: $amount',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {},
            // onPressed: () =>
            //     _downloadPDF(context), // Pass the context to show SnackBar
          ),
        ),
      ),
    );
  }
}
