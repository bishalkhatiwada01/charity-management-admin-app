import 'package:intl/intl.dart';

class Donation {
  final String donationDate;
  final String amount;
  final String campaignName;
  final String transactionId;

  Donation({
    required this.donationDate,
    required this.amount,
    required this.campaignName,
    required this.transactionId,
  });

  factory Donation.fromMap(Map<String, dynamic> data) {
    String amount = data['amount'].toString();
    String formattedDate = DateFormat('yyyy-MM-dd h:mm a')
        .format(data['paymentDate'].toDate());
    return Donation(
      donationDate: formattedDate.toString(),
      amount: amount,
      campaignName: data['postTitle'],
      transactionId: data['transactionId'],
    );
  }
}
