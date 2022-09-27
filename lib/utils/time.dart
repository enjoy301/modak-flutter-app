import 'package:intl/intl.dart';


String getFormattedDate({String format = "yyyy-MM-dd", DateTime? dateTime}) {
  dateTime ??= DateTime.now();
  return DateFormat(format).format(dateTime);
}

DateTime getFirstDayOfWeek(DateTime dateTime) {
  DateTime firstDate = dateTime.subtract(Duration(
      days: dateTime.weekday == 7 ? 0 : dateTime.weekday));
  return firstDate;
}