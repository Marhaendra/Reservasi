// calendar_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservasi/features/data/models/date_reservation_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  final ValueNotifier<DateTime> selectedDateNotifier =
      ValueNotifier(DateTime.now());
  DateTime _focusedDay = DateTime.now();
  DateTime _nowDay = DateTime.now();
  DateTime _firstDay = DateTime(2023, 1, 1);
  DateTime _lastDay = DateTime(2033, 12, 31);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateFormat _dateFormat = DateFormat('dd MMMM yyyy', 'en_US');

  DateTime get focusedDay => _focusedDay;
  DateTime get firstDay => _firstDay;
  DateTime get lastDay => _lastDay;
  CalendarFormat get calendarFormat => _calendarFormat;
  DateFormat get dateFormat => _dateFormat;
  DateTime get selectedDay => _focusedDay;
  DateTime get nowDay => _nowDay;

  var dateList = <String>[].obs;
  var dateListLong = <String>[].obs;
  var shortDateFormat = "Mon, 25".obs; // Example: "Mon, 25"
  var longDateFormat =
      "Monday, January 25, 2023".obs; // Example: "Monday, January 25, 2023"

  void tabDateList() {
    dateList.clear(); // Clear the list before adding new dates

    dateList.addAll(generateWeekDates(focusedDay).map(_formatShortDate));
    dateListLong.addAll(generateWeekDates(focusedDay).map(_formatLongDate));

    // String nowDate = dateFormat.format(DateTime.now());

    // if (dateFormat.format(focusedDay) == nowDate) {
    //   for (int i = 0; i < 7; i++) {
    //     DateTime currentDate = focusedDay.add(Duration(days: i));
    //     String shortDate = _formatShortDate(currentDate);
    //     dateList.add(shortDate);
    //   }
    // } else if (dateFormat.format(focusedDay) != nowDate) {
    //   final differenceDate = focusedDay.difference(nowDay);
    //   final maxDifference = Duration(days: 3);

    //   Duration limitedDifference = differenceDate;

    //   if (differenceDate > maxDifference) {
    //     limitedDifference = maxDifference;
    //   }

    //   for (int i = 0; i <= differenceDate.inDays; i++) {
    //     DateTime currentDate = focusedDay.subtract(Duration(days: i));
    //     String shortDate = _formatShortDate(currentDate);
    //     dateList.add(shortDate);
    //   }
    //   for (int i = 1; i < 7 - differenceDate.inDays; i++) {
    //     DateTime currentDate = focusedDay.add(Duration(days: i));
    //     String shortDate = _formatShortDate(currentDate);
    //     dateList.add(shortDate);
    //   }
    // }

    print("DateList: $dateList");
  }

  List<DateTime> generateWeekDates(DateTime selectedDay) {
    DateTime startOfWeek =
        selectedDay.subtract(Duration(days: selectedDay.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    List<DateTime> weekDates = [];
    DateTime currentDate = startOfWeek;

    for (int i = 0; i < 7; i++) {
      weekDates.add(currentDate);
      currentDate = currentDate.add(Duration(days: 1));
    }

    return weekDates;
  }

  void daySelect(DateTime selectedDay, DateTime focusedDay) {
    print("Selected Day: $selectedDay");
    print("Focused Day: $focusedDay");

    // Update the internal focusedDay
    _focusedDay = selectedDay;

    // Trigger a rebuild
    update();

    print("After update - Focused Day: $_focusedDay");
    print("$selectedDay");
  }

  void animateToDay(DateTime day) {
    // You can add any custom animation logic here if needed
    _focusedDay = day;
    update();
  }

  void refreshCalendar() {
    // Trigger a rebuild
    update();
  }

  void reset() {
    _focusedDay = DateTime.now();
    update();
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
