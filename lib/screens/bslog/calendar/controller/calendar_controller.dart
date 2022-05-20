import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:wecheck/model/bs_log_time_milestone.dart';
import 'package:wecheck/model/health_data.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/utils/extensions.dart';
import 'interface/interface.dart';

const double _dxMax = 1.2;
const double _dxMin = -1.2;

class CalendarController {

  DateTime get focusedDay => _focusedDay;
  List<HealthData>? get visibleEvents => healthData?.where((entry) {
        return visibleDayReversed.value
            .any((element) => entry.dateTime.sameWith(element));
      }).toList();

  List<HealthData>? healthData;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late StartingDayOfWeek startingDaysOfWeek;
  late ValueNotifier<List<DateTime>> visibleDayReversed;
  late DateTime previousFirstDay;
  late DateTime previousLastDay;
  late int pageId;
  late double dx;
  late SelectedDayCallback _selectedDayCallback;
  DateTime now = DateTime.now();

  void init({
    List<HealthData>? healthData,
    required StartingDayOfWeek startingDayOfWeek,
    required SelectedDayCallback selectedDayCallback,
  }) {
    startingDaysOfWeek = startingDayOfWeek;
    _selectedDayCallback = selectedDayCallback;
    pageId = 0;
    dx = 0;
    _focusedDay = now;
    _selectedDay = _focusedDay;
    visibleDayReversed = ValueNotifier(rangeDateFromStartToNow());
  }

  void dispose() {
    visibleDayReversed.dispose();
  }

  void setSelectedDay(
    DateTime value, {
    bool isProgrammatic = true,
    bool animate = true,
    bool runCallback = false,
  }) {
    if (animate) {
      if (value.isBefore(_getFirstDay(includeInvisible: false))) {
        _decrementPage();
      } else if (value.isAfter(_getLastDay(includeInvisible: false))) {
        _incrementPage();
      }
    }

    _selectedDay = value;
    _focusedDay = value;

    if (isProgrammatic && runCallback) {
      _selectedDayCallback(value);
    }
  }

  DateTime _getFirstDay({required bool includeInvisible}) {
    return _firstDayOfMonth(_focusedDay);
  }

  DateTime _getLastDay({required bool includeInvisible}) {
    return _lastDayOfMonth(_focusedDay);
  }

  void _decrementPage() {
    pageId--;
    dx = _dxMin;
  }

  void _incrementPage() {
    pageId++;
    dx = _dxMax;
  }

  DateTime _firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1, 12);
  }

  DateTime _lastDayOfMonth(DateTime month) {
    final date = month.month < 12
        ? DateTime.utc(month.year, month.month + 1, 1, 12)
        : DateTime.utc(month.year + 1, 1, 1, 12);
    return date.subtract(const Duration(days: 1));
  }

  DateTime _previousMonth(DateTime month) {
    if (month.month == 1) {
      return DateTime(month.year - 1, 12);
    } else {
      return DateTime(month.year, month.month - 1);
    }
  }

  DateTime _nextMonth(DateTime month) {
    if (month.month == 12) {
      return DateTime(month.year + 1, 1);
    } else {
      return DateTime(month.year, month.month + 1);
    }
  }

  Iterable<DateTime> _daysInRange(DateTime firstDay, DateTime lastDay) sync* {
    var temp = firstDay;

    while (temp.isBefore(lastDay)) {
      yield DateTime.utc(temp.year, temp.month, temp.day, 12);
      temp = temp.add(const Duration(days: 1));
    }
  }

  /// Returns true if `day` is currently selected.
  bool isSelected(DateTime day) {
    return day.sameWith(_selectedDay);
  }

  bool isWeekend(DateTime day) {
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }

  ValueNotifier<bool> shouldRefresh = ValueNotifier(false);
  DateTime? _focusPreDay;
  DateTime? _focusNextDay;
  ValueNotifier<DateTime> lastFocusMonth = ValueNotifier(DateTime.now());

  List<DateTime> rangeDateFromStartToNow() {
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    final first = _firstDayOfMonth(tomorrow);

    return _daysInRange(first, tomorrow).toList().reversed.toList();
  }

  void setTitleFocusMonth(DateTime dateTime) {
    lastFocusMonth.value = dateTime;
    _focusedDay = dateTime;
  }

  void triggerLoadDayOfPreMonth() {
    if (_focusPreDay == null) {
      _focusPreDay = _previousMonth(_focusedDay);
    } else {
      _focusPreDay = _previousMonth(_focusPreDay!);
    }
    _focusedDay = _focusPreDay!;
    var current = visibleDayReversed.value;
    var newVisibleDay = current + calculateDaysInterval(_focusPreDay!);
    visibleDayReversed.value = newVisibleDay;
  }

  void triggerLoadDayOfNextMonth() {
    if (_focusNextDay == null) {
      _focusNextDay = _nextMonth(_focusedDay);
    } else {
      _focusNextDay = _nextMonth(_focusNextDay!);
    }

    var current = visibleDayReversed.value;
    var shouldGetListDayFromStartToNow = _focusNextDay != null
        ? _focusNextDay!.month >= now.month && _focusNextDay!.year >= now.year
        : false;
    List<DateTime> newVisibleDay;
    if (shouldGetListDayFromStartToNow) {
      _focusedDay = now;
      newVisibleDay = rangeDateFromStartToNow() + current;
    } else {
      _focusedDay = _focusNextDay!;
      newVisibleDay = calculateDaysInterval(_focusNextDay!) + current;
    }
    visibleDayReversed.value = newVisibleDay;
    var shouldNotRefresh = _focusNextDay != null
        ? _focusNextDay!.month >= now.month && _focusNextDay!.year >= now.year
        : false;
    if (shouldNotRefresh) {
      shouldRefresh.value = false;
      _focusNextDay = null;
    }
  }

  List<DateTime> calculateDaysInterval(DateTime month) {
    final first = _firstDayOfMonth(month);
    final last = _lastDayOfMonth(month);
    List<DateTime> days = [];
    for (int i = 0; i <= last.difference(first).inDays; i++) {
      days.add(first.add(Duration(days: i)));
    }
    return days.reversed.toList();
  }

  void setSelectedDayViewLog(
    DateTime value, {
    bool isProgrammatic = true,
    bool animate = true,
    bool runCallback = false,
  }) {
    if (animate) {
      if (value.isBefore(_getFirstDay(includeInvisible: false))) {
        _decrementPage();
      } else if (value.isAfter(_getLastDay(includeInvisible: false))) {
        _incrementPage();
      }
    }

    _selectedDay = value;
    _focusedDay = value;
    _focusPreDay = null;
    _focusNextDay = null;

    if (isProgrammatic) {
      final first = _firstDayOfMonth(value);
      final last = _lastDayOfMonth(value);

      visibleDayReversed.value = _daysInRange(
        first,
        last,
      ).toList().reversed.toList();
    }

    if (isProgrammatic && runCallback) {
      _selectedDayCallback(value);
    }
  }

  List<String> nowToFirstMonthOfYear() {
    List<String> months = [];
    var length = 12 - (now.month + 2);
    for (int i = 0; i < length; i++) {
      DateTime dateGetMonth = DateTime(now.year, i + 1, now.day);
      String month = DateFormat.MMMM().format(dateGetMonth);
      months.add(month);
    }
    return months;
  }

  List<BsLogTimeMilestone> timeMilestone = [
    BsLogTimeMilestone(AppIcons.icBeforeBreakfast, 1),
    BsLogTimeMilestone(AppIcons.icAfterBreakfast, 2),
    BsLogTimeMilestone(AppIcons.icBeforeLunch, 3),
    BsLogTimeMilestone(AppIcons.icAfterLunch, 4),
    BsLogTimeMilestone(AppIcons.icBeforeDinner, 5),
    BsLogTimeMilestone(AppIcons.icAfterDinner, 6),
    BsLogTimeMilestone(AppIcons.icBeforeBedtime, 7),
    BsLogTimeMilestone(AppIcons.icAfterBedtime, 8),
  ];

  void selectedPrevious() {
    var preMonth = _previousMonth(_focusedDay);
    visibleDayReversed.value = calculateDaysInterval(preMonth);
    shouldRefresh.value = shouldRefreshNow(preMonth) ?? false;
    lastFocusMonth.value = preMonth;
    _focusedDay = preMonth;
    _focusPreDay = null;
    _focusNextDay = null;
  }

  void selectedNext() {
    var nextMonth = _nextMonth(_focusedDay);
    var shouldGetDayOnNow =
        nextMonth.month >= now.month && nextMonth.year >= now.year;
    List<DateTime> newVisibleDay;
    if (shouldGetDayOnNow) {
      lastFocusMonth.value = now;
      _focusedDay = now;
      newVisibleDay = rangeDateFromStartToNow();
    } else {
      lastFocusMonth.value = nextMonth;
      _focusedDay = nextMonth;
      newVisibleDay = calculateDaysInterval(nextMonth);
      shouldRefresh.value = shouldRefreshNow(nextMonth) ?? false;
    }
    _focusNextDay = null;
    _focusPreDay = null;
    visibleDayReversed.value = newVisibleDay;
  }

  bool? shouldRefreshNow(DateTime? target) {
    return target?.compareTo(now) == -1;
  }
}
