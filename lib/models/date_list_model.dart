import 'package:intl/intl.dart';

class DateListModel {
  String date;

  DateListModel({required this.date});

  static List<DateListModel> getDateList(DateTime selectedDate,
      {int limit = 5}) {
    List<DateListModel> dateList = [];
    DateTime currentDate = selectedDate;

    // Add dates for the previous 4 days and the next 4 days
    for (int i = 0; i < limit; i++) {
      dateList.add(DateListModel(date: _formatDate(currentDate)));
      currentDate = currentDate.add(Duration(days: 1));
    }

    return dateList;
  }

  static String _formatDate(DateTime date) {
    return "${_formatDay(date)},${_formatDayNumber(date)}";
  }

  static String _formatDay(DateTime date) {
    return DateFormat('E').format(date).substring(0, 3);
  }

  static String _formatDayNumber(DateTime date) {
    return DateFormat('d').format(date);
  }
}
