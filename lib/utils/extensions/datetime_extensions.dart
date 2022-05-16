import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  bool sameWith(DateTime date) {
    return year == date.year &&
        month == date.month &&
        day == date.day;
  }
}
