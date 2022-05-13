
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:wecheck/theme/icons.dart';

import '../controller/calendar_controller.dart';
import '../controller/interface/interface.dart';
import '../model/health_data.dart';


class VerticalCalendarWidget extends StatefulWidget {
  final CalendarController calendarController;

  final dynamic locale;

  final List<HealthData>? eventData;

  final OnDaySelected? onDaySelected;

  final VoidCallback? onUnavailableDaySelected;

  final OnVisibleDaysChanged? onVisibleDaysChanged;

  final DateTime? initialSelectedDay;

  final CalendarFormat calendarFormat;

  final Map<CalendarFormat, String> availableCalendarFormats;

  final FormatAnimation formatAnimation;

  final StartingDayOfWeek startingDayOfWeek;

  final HitTestBehavior dayHitTestBehavior;

  final AvailableGestures availableGestures;

  final SimpleSwipeConfig simpleSwipeConfig;

  const VerticalCalendarWidget({
    Key? key,
    required this.calendarController,
    this.locale,
    this.eventData,
    this.onDaySelected,
    this.onUnavailableDaySelected,
    this.onVisibleDaysChanged,
    this.initialSelectedDay,
    this.calendarFormat = CalendarFormat.month,
    this.availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.twoWeeks: '2 weeks',
      CalendarFormat.week: 'Week',
    },
    this.formatAnimation = FormatAnimation.slide,
    this.startingDayOfWeek = StartingDayOfWeek.sunday,
    this.dayHitTestBehavior = HitTestBehavior.deferToChild,
    this.availableGestures = AvailableGestures.all,
    this.simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
  }) : super(key: key);

  @override
  State<VerticalCalendarWidget> createState() => _VerticalCalendarWidgetState();
}

class _VerticalCalendarWidgetState extends State<VerticalCalendarWidget> {
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  final double _height = 100;

  @override
  void initState() {
    widget.calendarController.init(
      initialFormat: widget.calendarFormat,
      availableCalendarFormats: widget.availableCalendarFormats,
      startingDayOfWeek: widget.startingDayOfWeek,
      selectedDayCallback: _selectedDayCallback,
      includeInvisibleDays: true,
    );
    super.initState();
  }

  void _selectedDayCallback(DateTime day) {
    if (widget.onDaySelected != null && widget.eventData?.isNotEmpty == true) {
      var eventData = widget.calendarController.visibleEvents!
          .where((element) {
            return _isSameDay(element.dateTime, day);
          })
          .toList();
      widget.onDaySelected!(
        day,
        eventData,
      );
    }
  }

  bool _isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  void _selectPrevious() {
    setState(() {
      widget.calendarController.selectPrevious();
    });
  }

  void _selectNext() {
    setState(() {
      widget.calendarController.selectNext();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Column(
        children: [
          Expanded(flex: 1, child: _buildHeader()),
          Expanded(
            flex: 15,
            child: ValueListenableBuilder(
              valueListenable: widget.calendarController.mode,
              builder: (context, error, child) =>
                  widget.calendarController.mode.value
                      ? _buildCalendarHealthLog()
                      : _buildCalendarMonthSelected(),
            ),
          )
        ],
      ),
    );
  }

  _buildCalendarHealthLog() {
    return Column(
      children: [
        Expanded(flex: 1, child: _buildTimeMilestone()),
        Expanded(
          flex: 14,
          child: ValueListenableBuilder(
            valueListenable: widget.calendarController.visibleDayReversed,
            builder: (context, value, child) {
              return _buildContentCalendar(
                widget.calendarController.visibleDayReversed.value,
              );
            },
          ),
        ),
      ],
    );
  }

  _buildCalendarMonthSelected() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: widget.calendarController.nowToFirstMonthOfYear().length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            var focusDay = widget.calendarController.focusedDay;
            DateTime now = DateTime.now();
            DateTime daySet = DateTime(
              focusDay.year,
              index + 1,
              focusDay.day,
              now.hour,
              now.minute,
              now.second,
              now.millisecond,
              now.microsecond,
            );
            widget.calendarController.shouldRefresh.value =
                daySet.compareTo(now) != 0;
            widget.calendarController
                .setSelectedDayViewLog(daySet, runCallback: true);
            widget.calendarController.mode.value =
                !widget.calendarController.mode.value;
          },
          child: _buildItemMonth(index),
        );
      },
    );
  }

  _buildItemMonth(int month) {
    var now = DateTime.now();
    var monthDisplay = DateTime(now.year, month + 1, now.day);
    TextStyle textStyle = const TextStyle(color: Colors.grey);
    if (widget.calendarController.isCurrentMonth(monthDisplay)) {
      textStyle = const TextStyle(color: Colors.blue);
    }
    if (widget.calendarController.isCurrentMonth(monthDisplay)) {
      textStyle = const TextStyle(color: Colors.red);
    }
    return SizedBox(
      height: 100,
      child: Center(
        child: Text(
          widget.calendarController.nowToFirstMonthOfYear()[month].toString(),
          style: textStyle,
        ),
      ),
    );
  }

  _buildTimeMilestone() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(flex: 2, child: SizedBox()),
        Expanded(
          flex: 9,
          child: Container(
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Table(
              children: [
                TableRow(
                  children: List.generate(
                    8,
                    (index) => Stack(
                      children: [
                        Positioned(
                          child: Column(
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: SvgPicture.asset(
                                    AppIcons.icSettingUnSelected,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 0.25,
                            height: 10,
                            color: Colors.grey,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 0.25,
                            height: 10,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ).toList(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final children = [
      InkWell(
        child: const Icon(Icons.chevron_left),
        onTap: _selectPrevious,
      ),
      Expanded(
        child: InkWell(
          onTap: () {
            widget.calendarController.mode.value =
                !widget.calendarController.mode.value;
          },
          child: ValueListenableBuilder(
            valueListenable: widget.calendarController.lastFocusMonth,
            builder: (context, child, error) {
              return Text(
                DateFormat.yMMMM(
                  widget.locale,
                ).format(
                  widget.calendarController.lastFocusMonth.value,
                ),
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
      ),
      InkWell(
        child: const Icon(Icons.chevron_right),
        onTap: _selectNext,
      ),
    ];

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: children,
    );
  }

  _onLoadMore() {
    widget.calendarController.triggerLoadDayOfPreMonth();
    refreshController.loadComplete();
  }

  _onRefresh() {
    if (widget.calendarController.shouldRefresh.value) {
      widget.calendarController.triggerLoadDayOfNextMonth();
    }
    refreshController.refreshCompleted();
  }

  var lastIndex = 0;
  Widget _buildContentCalendar(List<DateTime> dayInWeeks) {
    var eventDateTimes = widget.eventData;
    List<Object> finalList;
    if (eventDateTimes != null) {
      finalList = dayInWeeks.map((e) {
        var sameDay = eventDateTimes.firstWhereOrNull(
          (element) => _isSameDay(
            element.dateTime,
            e,
          ),
        );
        var list = sameDay != null ? sameDay.list : <FiguresHealthData>[];
        return HealthData(e, list);
      }).toList();
    } else {
      finalList = dayInWeeks;
    }
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        setState(() {
            DateTime focusDay = widget.calendarController.visibleDayReversed.value[lastIndex];
            widget.calendarController.setTitleFocusMonth(focusDay);
        });
        return true;
      },
      child: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onLoading: _onLoadMore,
        onRefresh: _onRefresh,
        child: ListView.builder(
          reverse: true,
          itemCount: finalList.length,
          itemBuilder: (context, index) {
            lastIndex = index;
            if (finalList is List<DateTime>) {
              return _buildDaysInWeek(finalList[index]);
            }
            if (finalList is List<HealthData>) {
              return _buildDayInWeekWithEvent(finalList[index]);
            }
            return const Text("");
          },
        ),
      ),
    );
  }

  _buildDaysInWeek(DateTime dateTime) {
    return SizedBox(
      height: _height,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildItemDateTime(dateTime),
          ),
          Expanded(flex: 9, child: _buildTableEventWidget())
        ],
      ),
    );
  }

  _buildDayInWeekWithEvent(HealthData data) {
    return SizedBox(
      height: _height,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildItemDateTime(data.dateTime),
          ),
          Expanded(flex: 9, child: _buildTableWithHealthEventWidget(data.list))
        ],
      ),
    );
  }

  _buildItemDateTime(DateTime dateTime) {
    var isToday = widget.calendarController.isToday(dateTime);
    var isWeekend = widget.calendarController.isWeekend(dateTime);
    String dayDisplay = DateFormat("M/d").format(dateTime);
    String dayBottom = DateFormat.E(widget.locale).format(dateTime);
    Color textColor = Colors.black;
    if (isToday) {
      textColor = Colors.red;
    }
    if (isWeekend) {
      textColor = Colors.grey;
    }
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Text(
              "$dayDisplay \n $dayBottom",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            color: Colors.grey,
            width: 10,
            height: 0.25,
            child: const Text(""),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            color: Colors.grey,
            width: 10,
            height: 0.25,
            child: const Text(""),
          ),
        )
      ],
    );
  }

  _buildTableEventWidget() {
    return Center(
      child: Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.1,
        ),
        children: [
          TableRow(
            children: _buildDefaultTable(),
          ),
        ],
      ),
    );
  }

  _buildTableWithHealthEventWidget(List<FiguresHealthData> data) {
    return Table(
      border: TableBorder.all(
        color: Colors.black,
        width: 0.1,
      ),
      children: [
        TableRow(
          children:
              data.isEmpty ? _buildDefaultTable() : _buildListHealthEvent(data),
        )
      ],
    );
  }

  _buildDefaultTable() {
    return List.generate(
      8,
      (index) => SizedBox(
        height: _height,
        child: const Text(""),
      ),
    );
  }

  _buildListHealthEvent(List<FiguresHealthData> data) {
    var timeMilestone = [
      TimeMilestone(1),
      TimeMilestone(2),
      TimeMilestone(3),
      TimeMilestone(4),
      TimeMilestone(5),
      TimeMilestone(6),
      TimeMilestone(7),
      TimeMilestone(8),
    ];
    var finalFiguresData = timeMilestone.map((e) {
      var milestoneHasValue =
          data.firstWhereOrNull((element) => element.type == e.value);
      return milestoneHasValue != null
          ? FiguresHealthData(
              milestoneHasValue.count, milestoneHasValue.data, e.value)
          : FiguresHealthData(0, 0, 0);
    }).toList();

    return List.generate(
      finalFiguresData.length,
      (index) => SizedBox(
        height: _height,
        child: _buildItemHealthEvent(finalFiguresData[index]),
      ),
    );
  }

  _buildItemHealthEvent(FiguresHealthData data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          data.data != 0
              ? Container(
                  width: 30,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      data.data.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                )
              : const Text(""),
          const SizedBox(
            height: 10,
          ),
          data.count != 0
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.yellow,
                        ),
                      ),
                      Text(data.count.toString()),
                    ],
                  ),
                )
              : const Text(""),
        ],
      ),
    );
  }
}
