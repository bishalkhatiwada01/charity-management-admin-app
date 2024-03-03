import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PDFService {
  static Future<void> downloadDonationHistoryPDF(String campaignName,
      String donationDate, String amount, String transactionId) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text('Campaign Name: $campaignName'),
                pw.Text('Date: $donationDate'),
                pw.Text('Amount: $amount'),
                pw.Text('Transaction ID: $transactionId'),
              ],
            ),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/donation_history_$campaignName.pdf');
    await file.writeAsBytes(await pdf.save());
    print(directory);
  }
}
