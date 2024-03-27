import 'package:intl/intl.dart';
import 'package:reservasi/presentation/controllers/calendar_controller.dart';

class DateListModel {
  String shortDateFormat; // Example: "Mon, 25"
  String longDateFormat; // Example: "Monday, January 25, 2023"

  DateListModel({required this.shortDateFormat, required this.longDateFormat});

  static List<DateListModel> getDateList(
      CalendarController calendarController) {
    List<DateListModel> dateList = [];
    DateTime currentDate = calendarController.selectedDay;

    // Set the selected date as the first date in the list
    dateList.add(DateListModel(
      shortDateFormat: _formatShortDate(currentDate),
      longDateFormat: _formatLongDate(currentDate),
    ));

    // Add dates for the remaining days in the year
    for (int i = 1; i < 365; i++) {
      currentDate = currentDate.add(Duration(days: 1));
      dateList.add(DateListModel(
        shortDateFormat: _formatShortDate(currentDate),
        longDateFormat: _formatLongDate(currentDate),
      ));
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
