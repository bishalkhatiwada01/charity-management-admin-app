// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FormattedDate extends StatelessWidget {
//   final Timestamp timestamp;

//   FormattedDate({required this.timestamp});

//   @override
//   Widget build(BuildContext context) {
//     String formattedDate = DateFormatter.formatTimestamp(timestamp);

//     return Text('Formatted Date: $formattedDate');
//   }
// }

// class DateFormatter {
//   static String formatTimestamp(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();
//     return DateFormat.yMd().add_Hms().format(dateTime);
//   }
// }
