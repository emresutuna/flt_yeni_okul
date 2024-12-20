import 'package:intl/intl.dart';

String formatStartDate(DateTime startDate) {
  String formattedDate = DateFormat('dd.MM.yyyy').format(startDate);
  String formattedTime = DateFormat('HH:mm').format(startDate);
  return '$formattedDate | Saat: $formattedTime';
}

String formatEndDate(DateTime endDate) {
  String formattedTime = DateFormat('HH:mm').format(endDate);
  return 'Saat: $formattedTime';
}

String formatDateRange(DateTime startDate, DateTime endDate) {
  String start = formatStartDate(startDate);
  String end = formatEndDate(endDate);
  return '$start - $end';
}