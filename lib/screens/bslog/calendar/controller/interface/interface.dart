import 'package:flutter/material.dart';
import 'package:wecheck/model/health_data.dart';

typedef SelectedDayCallback = void Function(DateTime day);

enum StartingDayOfWeek { monday, sunday }

typedef OnVisibleDaysChanged = void Function(DateTime first, DateTime last);

typedef OnDaySelected = void Function(DateTime day, List<HealthData> events);

class TimeMilestone {
  final int value;

  TimeMilestone(this.value);
}

typedef ItemDateEventBuilder = List<Widget> Function(
    List<DateTime> days, List events);
