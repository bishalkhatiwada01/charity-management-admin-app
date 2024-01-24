import 'package:intl/intl.dart';

String formatDateTime(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat.yMMMEd().add_jm().format(dateTime);
}
