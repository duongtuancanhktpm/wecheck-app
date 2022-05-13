
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wecheck/utils/constants.dart';

import '../calendar/model/event_data.dart';
import '../repository/timeline_repository.dart';

class TimeLineController extends GetxController {
  var currentYear = 0.obs;
  var timelineRepository = TimelineRepository();
  var event = <EventData>[];
  var visibleEvent = [].obs;
  var selectedDate = DateTime.now().obs;
  var focusDate = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month.obs;
  var eventDetailData = <EventDetailData>[].obs;
  var titleAppBar = "".obs;

  @override
  void onInit() {
    currentYear.value = DateTime.now().year;
    titleAppBar.value = DateFormat.y().format(selectedDate.value);
    timelineRepository.doGetListEventData().then((value) {
      event = value;
      final eventConvert = event.map((e) {
        var day = DateFormat(Constant.fullDataFormat).parse(e.dateTime);
        return day;
      }).toList();
      visibleEvent.assignAll(eventConvert);
    });
    super.onInit();
  }

  bool isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  bool selectedDayPredicate(DateTime selectedDay) {
    return isSameDay(selectedDate.value, selectedDay);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDate.value, selectedDay)) {
        selectedDate.value = selectedDay;
        focusDate.value = focusedDay;
        calendarFormat.value = CalendarFormat.week;
        var listEventDetail = event.firstWhereOrNull((element) {
          var dayFilter = DateFormat(Constant.fullDataFormat).parse(element.dateTime);
          return isSameDay(dayFilter, selectedDay);
        })?.listEvent ?? [];
        eventDetailData.value = listEventDetail;
        titleAppBar.value = DateFormat.MMMM().format(selectedDay);
    }
  }

  void onPageChanged(DateTime focusDay) {
    focusDate.value = focusDay;
  }

  void onChangeCalendarFormat() {
    titleAppBar.value = DateFormat.y().format(selectedDate.value);
    if (calendarFormat.value == CalendarFormat.week) {
      calendarFormat.value = CalendarFormat.month;
    }
  }
}