// calendar_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservasi/models/date_reservation_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  late List<DateListModel> dateList;
  final ValueNotifier<DateTime> selectedDateNotifier =
      ValueNotifier(DateTime.now());
  DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime(2023, 1, 1);
  DateTime _lastDay = DateTime(2033, 12, 31);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateFormat _dateFormat = DateFormat('dd MMMM yyyy', 'en_US');
  DateTime _now = DateTime.now();

  DateTime get focusedDay => _focusedDay;
  DateTime get firstDay => _firstDay;
  DateTime get lastDay => _lastDay;
  CalendarFormat get calendarFormat => _calendarFormat;
  DateFormat get dateFormat => _dateFormat;
  DateTime get selectedDay => _focusedDay;

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
}
