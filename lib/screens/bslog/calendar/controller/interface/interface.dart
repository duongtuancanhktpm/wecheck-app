
import 'package:flutter/material.dart';


typedef SelectedDayCallback = void Function(DateTime day);

enum StartingDayOfWeek { monday, sunday }

enum CalendarFormat { month, twoWeeks, week }

typedef OnVisibleDaysChanged = void Function(
  DateTime first,
  DateTime last,
  CalendarFormat format,
);

typedef OnDaySelected = void Function(DateTime day, List events);

enum AvailableGestures { none, verticalSwipe, horizontalSwipe, all }

enum FormatAnimation { slide, scale }

class TimeMilestone {
  final int value;

  TimeMilestone(this.value);
}

typedef ItemDateEventBuilder = List<Widget> Function(List<DateTime> days, List events);