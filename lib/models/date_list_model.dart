import 'package:intl/intl.dart';

class DateListModel {
  String shortDateFormat; // Example: "Mon, 25"
  String longDateFormat; // Example: "Monday, January 25, 2023"

  DateListModel({required this.shortDateFormat, required this.longDateFormat});

  static List<DateListModel> getDateList(DateTime selectedDate,
      {int limit = 5}) {
    List<DateListModel> dateList = [];
    DateTime currentDate = selectedDate;

    // Add dates for the previous 4 days and the next 4 days
    for (int i = 0; i < limit; i++) {
      dateList.add(DateListModel(
        shortDateFormat: _formatShortDate(currentDate),
        longDateFormat: _formatLongDate(currentDate),
      ));
      currentDate = currentDate.add(Duration(days: 1));
    }

    return dateList;
  }

  static String _formatShortDate(DateTime date) {
    return "${_formatDay(date)},${_formatDayNumber(date)}";
  }

  static String _formatLongDate(DateTime date) {
    return DateFormat('EEEE, d MMMM y').format(date);
  }

  static String _formatDay(DateTime date) {
    return DateFormat('E').format(date).substring(0, 3);
  }

  static String _formatDayNumber(DateTime date) {
    return DateFormat('d').format(date);
  }
}
