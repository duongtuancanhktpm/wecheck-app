import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:wecheck/model/health_data.dart';
import 'interface/interface.dart';

const double _dxMax = 1.2;
const double _dxMin = -1.2;

class CalendarController {
  DateTime get focusedDay => _focusedDay;

  DateTime get selectedDay => _selectedDay;

  List<DateTime> get visibleDays => _includeInvisibleDays
      ? visibleDay.value
      : visibleDay.value.where((day) => !_isExtraDay(day)).toList();

  List<HealthData>? get visibleEvents => healthData
      ?.where((entry) {
    return visibleDays.any((element) => isSameDay(entry.dateTime, element));
  }).toList();

  List<HealthData>? healthData;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late StartingDayOfWeek startingDaysOfWeek;
  late ValueNotifier<CalendarFormat> calendarFormat;
  late ValueNotifier<List<DateTime>> visibleDay;
  late ValueNotifier<List<DateTime>> visibleDayReversed;
  late Map<CalendarFormat, String> _availableCalendarFormats;
  late DateTime previousFirstDay;
  late DateTime previousLastDay;
  late int pageId;
  late double dx;
  late bool _includeInvisibleDays;
  late SelectedDayCallback _selectedDayCallback;
  DateTime now = DateTime.now();
  ValueNotifier<bool> mode = ValueNotifier(true);

  void init({
    List<HealthData>? healthData,
    DateTime? initialDay,
    required CalendarFormat initialFormat,
    required Map<CalendarFormat, String> availableCalendarFormats,
    required StartingDayOfWeek startingDayOfWeek,
    required SelectedDayCallback selectedDayCallback,
    OnVisibleDaysChanged? onVisibleDaysChanged,
    required bool includeInvisibleDays,
  }) {
    startingDaysOfWeek = startingDayOfWeek;
    _availableCalendarFormats = availableCalendarFormats;
    _selectedDayCallback = selectedDayCallback;
    _includeInvisibleDays = includeInvisibleDays;

    pageId = 0;
    dx = 0;

    _focusedDay = initialDay ?? DateTime(now.year, now.month, now.day);
    _selectedDay = _focusedDay;
    calendarFormat = ValueNotifier(initialFormat);
    visibleDay = ValueNotifier(_getVisibleDays());
    visibleDayReversed = ValueNotifier(rangeDateFromNowToPast());
    previousFirstDay = visibleDay.value.first;
    previousLastDay = visibleDay.value.last;
    calendarFormat.addListener(() {
      visibleDay.value = _getVisibleDays();
    });

    if (onVisibleDaysChanged != null) {
      visibleDay.addListener(() {
        if (!isSameDay(visibleDay.value.first, previousFirstDay) ||
            !isSameDay(visibleDay.value.last, previousLastDay)) {
          previousFirstDay = visibleDay.value.first;
          previousLastDay = visibleDay.value.last;
          onVisibleDaysChanged(
            _getFirstDay(includeInvisible: _includeInvisibleDays),
            _getLastDay(includeInvisible: _includeInvisibleDays),
            calendarFormat.value,
          );
        }
      });
    }
  }

  /// Disposes the controller.
  /// ```dart
  /// @override
  /// void dispose() {
  ///   _calendarController.dispose();
  ///   super.dispose();
  /// }
  /// ```
  void dispose() {
    calendarFormat.dispose();
    visibleDay.dispose();
    visibleDayReversed.dispose();
  }

  /// Toggles calendar format. Same as using `FormatButton`.
  void toggleCalendarFormat() {
    calendarFormat.value = _nextFormat();
  }

  /// Sets calendar format by emulating swipe.
  void swipeCalendarFormat({required bool isSwipeUp}) {
    final formats = _availableCalendarFormats.keys.toList();
    int id = formats.indexOf(calendarFormat.value);

    // Order of CalendarFormats must be from biggest to smallest,
    // eg.: [month, twoWeeks, week]
    if (isSwipeUp) {
      id = _clamp(0, formats.length - 1, id + 1);
    } else {
      id = _clamp(0, formats.length - 1, id - 1);
    }
    calendarFormat.value = formats[id];
  }

  /// Sets calendar format to a given `value`.
  void setCalendarFormat(CalendarFormat value) {
    calendarFormat.value = value;
  }

  /// Sets selected day to a given `value`.
  /// Use `runCallback: true` if this should trigger `OnDaySelected` callback.
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
    _updateVisibleDays(isProgrammatic);

    if (isProgrammatic && runCallback) {
      _selectedDayCallback(value);
    }
  }

  /// Sets displayed month/year without changing the currently selected day.
  void setFocusedDay(DateTime value) {
    _focusedDay = value;
    _updateVisibleDays(true);
  }

  void _updateVisibleDays(bool isProgrammatic) {
    if (calendarFormat.value != CalendarFormat.twoWeeks || isProgrammatic) {
      visibleDay.value = _getVisibleDays();
    }
  }

  CalendarFormat _nextFormat() {
    final formats = _availableCalendarFormats.keys.toList();
    int id = formats.indexOf(calendarFormat.value);
    id = (id + 1) % formats.length;

    return formats[id];
  }

  void selectPrevious() {
    if (calendarFormat.value == CalendarFormat.month) {
      _selectPreviousMonth();
    } else if (calendarFormat.value == CalendarFormat.twoWeeks) {
      _selectPreviousTwoWeeks();
    } else {
      _selectPreviousWeek();
    }

    visibleDay.value = _getVisibleDays();
    _focusPreDay = null;
    _focusNextDay = null;
    _decrementPage();
  }

  void selectNext() {
    if (calendarFormat.value == CalendarFormat.month) {
      _selectNextMonth();
    } else if (calendarFormat.value == CalendarFormat.twoWeeks) {
      _selectNextTwoWeeks();
    } else {
      _selectNextWeek();
    }

    visibleDay.value = _getVisibleDays();
    _focusPreDay = null;
    _focusNextDay = null;
    _incrementPage();
  }

  void _selectPreviousMonth() {
    _focusedDay = _previousMonth(_focusedDay);
  }

  void _selectNextMonth() {
    _focusedDay = _nextMonth(_focusedDay);
  }

  void _selectPreviousTwoWeeks() {
    if (visibleDay.value.take(7).contains(_focusedDay)) {
      // in top row
      _focusedDay = _previousWeek(_focusedDay);
    } else {
      // in bottom row OR not visible
      _focusedDay =
          _previousWeek(_focusedDay.subtract(const Duration(days: 7)));
    }
  }

  void _selectNextTwoWeeks() {
    if (!visibleDay.value.skip(7).contains(_focusedDay)) {
      // not in bottom row [eg: in top row OR not visible]
      _focusedDay = _nextWeek(_focusedDay);
    }
  }

  void _selectPreviousWeek() {
    _focusedDay = _previousWeek(_focusedDay);
  }

  void _selectNextWeek() {
    _focusedDay = _nextWeek(_focusedDay);
  }

  DateTime _getFirstDay({required bool includeInvisible}) {
    if (calendarFormat.value == CalendarFormat.month && !includeInvisible) {
      return _firstDayOfMonth(_focusedDay);
    } else {
      return visibleDay.value.first;
    }
  }

  DateTime _getLastDay({required bool includeInvisible}) {
    if (calendarFormat.value == CalendarFormat.month && !includeInvisible) {
      return _lastDayOfMonth(_focusedDay);
    } else {
      return visibleDay.value.last;
    }
  }

  List<DateTime> _getVisibleDays() {
    if (calendarFormat.value == CalendarFormat.month) {
      return _daysInMonth(_focusedDay);
    } else if (calendarFormat.value == CalendarFormat.twoWeeks) {
      return _daysInWeek(_focusedDay)
        ..addAll(_daysInWeek(
          _focusedDay.add(const Duration(days: 7)),
        ));
    } else {
      return _daysInWeek(_focusedDay);
    }
  }

  void _decrementPage() {
    pageId--;
    dx = _dxMin;
  }

  void _incrementPage() {
    pageId++;
    dx = _dxMax;
  }

  List<DateTime> _daysInMonth(DateTime month) {
    final first = _firstDayOfMonth(month);
    final daysBefore = startingDaysOfWeek == StartingDayOfWeek.sunday
        ? first.weekday % 7
        : first.weekday - 1;
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    final last = _lastDayOfMonth(month);
    var daysAfter = 7 - last.weekday;

    if (startingDaysOfWeek == StartingDayOfWeek.sunday) {
      // If the last day is Sunday (7) the entire week must be rendered
      if (daysAfter == 0) {
        daysAfter = 7;
      }
    } else {
      daysAfter++;
    }

    final lastToDisplay = last.add(Duration(days: daysAfter));
    return _daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  List<DateTime> _daysInWeek(DateTime week) {
    final first = _firstDayOfWeek(week);
    final last = _lastDayOfWeek(week);

    return _daysInRange(first, last).toList();
  }

  DateTime _firstDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);

    final decreaseNum = startingDaysOfWeek == StartingDayOfWeek.sunday
        ? day.weekday % 7
        : day.weekday - 1;
    return day.subtract(Duration(days: decreaseNum));
  }

  DateTime _lastDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);

    final increaseNum = startingDaysOfWeek == StartingDayOfWeek.sunday
        ? day.weekday % 7
        : day.weekday - 1;
    return day.add(Duration(days: 7 - increaseNum));
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

  DateTime _previousWeek(DateTime week) {
    return week.subtract(const Duration(days: 7));
  }

  DateTime _nextWeek(DateTime week) {
    return week.add(const Duration(days: 7));
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
    return isSameDay(day, selectedDay);
  }

  /// Returns true if `day` is the same day as `DateTime.now()`.
  bool isToday(DateTime day) {
    return isSameDay(day, now);
  }

  bool isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  bool isWeekend(DateTime day) {
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }

  bool _isExtraDay(DateTime day) {
    return _isExtraDayBefore(day) || _isExtraDayAfter(day);
  }

  bool _isExtraDayBefore(DateTime day) {
    return day.month < _focusedDay.month;
  }

  bool _isExtraDayAfter(DateTime day) {
    return day.month > _focusedDay.month;
  }

  bool isCurrentMonth(DateTime dateTime) {
    var currentMonth = now.month;
    return dateTime.month == currentMonth;
  }

  int _clamp(int min, int max, int value) {
    if (value > max) {
      return max;
    } else if (value < min) {
      return min;
    } else {
      return value;
    }
  }

  List<String> monthOfYear() {
    List<String> months = [];
    for (int i = 0; i < 12; i++) {
      DateTime dateGetMonth = DateTime(now.year, i + 1, now.day);
      String month = DateFormat.MMMM().format(dateGetMonth);
      months.add(month);
    }
    return months;
  }

  ///
  ///for vertical calendar
  ///

  ValueNotifier<bool> shouldRefresh = ValueNotifier(false);
  DateTime? _focusPreDay;
  DateTime? _focusNextDay;
  ValueNotifier<DateTime> lastFocusMonth = ValueNotifier(DateTime.now());

  List<DateTime> rangeDateFromNowToPast() {
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    final first = _firstDayOfMonth(tomorrow);

    return _daysInRange(first, tomorrow).toList().reversed.toList();
  }

  setTitleFocusMonth(DateTime dateTime) {
     lastFocusMonth.value = dateTime;
  }

  triggerLoadDayOfPreMonth() {
    if (_focusPreDay == null) {
      _focusPreDay = _previousMonth(_focusedDay);
    } else {
      _focusPreDay = _previousMonth(_focusPreDay!);
    }
    var current = visibleDayReversed.value;
    var newVisibleDay = current + calculateDaysInterval(_focusPreDay!);
    visibleDayReversed.value = newVisibleDay;
  }

  triggerLoadDayOfNextMonth() {
    if (_focusNextDay == null) {
      _focusNextDay = _nextMonth(_focusedDay);
    } else {
      _focusNextDay = _nextMonth(_focusNextDay!);
    }
    var current = visibleDayReversed.value;
    var shouldGetDayOnNow = _focusNextDay != null
        ? _focusNextDay!.month == now.month && _focusNextDay!.year == now.year
        : false;
    List<DateTime> newVisibleDay;
    if (shouldGetDayOnNow) {
      newVisibleDay = rangeDateFromNowToPast() + current;
    } else {
      newVisibleDay = calculateDaysInterval(_focusNextDay!) + current;
    }
    visibleDayReversed.value = newVisibleDay;
    var shouldNotRefresh =
        _focusNextDay != null ? _focusNextDay!.month >= now.month : false;
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

    if (calendarFormat.value != CalendarFormat.twoWeeks || isProgrammatic) {
      final first = _firstDayOfMonth(value);
      final last = _lastDayOfMonth(value);

      visibleDayReversed.value =
          _daysInRange(first, last).toList().reversed.toList();
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
}
