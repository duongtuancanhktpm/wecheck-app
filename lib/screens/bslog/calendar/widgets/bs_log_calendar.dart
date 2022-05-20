import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wecheck/model/bs_log_time_milestone.dart';
import 'package:wecheck/model/figures_health_data.dart';
import 'package:wecheck/screens/bslog/calendar/controller/calendar_controller.dart';
import 'package:wecheck/screens/bslog/calendar/controller/interface/interface.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/model/health_data.dart';
import 'package:wecheck/theme/text_styles.dart';
import 'package:wecheck/utils/constants.dart';
import 'package:wecheck/utils/extensions.dart';

class BsLogCalendarWidget extends StatefulWidget {
  final dynamic locale;

  final List<HealthData>? eventData;

  final OnDaySelected? onDaySelected;

  final StartingDayOfWeek startingDayOfWeek;

  const BsLogCalendarWidget({
    Key? key,
    this.locale,
    this.eventData,
    this.onDaySelected,
    this.startingDayOfWeek = StartingDayOfWeek.sunday,
  }) : super(key: key);

  @override
  State<BsLogCalendarWidget> createState() => _BsLogCalendarWidgetState();
}

class _BsLogCalendarWidgetState extends State<BsLogCalendarWidget> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  final CalendarController _calendarController = CalendarController();
  final double _height = 80.h;

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _calendarController.init(
      startingDayOfWeek: widget.startingDayOfWeek,
      selectedDayCallback: _selectedDayCallback,
    );
    super.initState();
  }

  void _selectedDayCallback(DateTime day) {
    if (widget.onDaySelected != null && widget.eventData?.isNotEmpty == true) {
      List<HealthData> eventData = _calendarController.visibleEvents!.where(
        (element) {
          return element.dateTime.sameWith(day);
        },
      ).toList();
      widget.onDaySelected!(
        day,
        eventData,
      );
    }
  }

  void _selectPrevious() {
    setState(() {
      _calendarController.selectedPrevious();
      _refreshController.refreshCompleted();
    });
  }

  void _selectNext() {
    setState(() {
      _calendarController.selectedNext();
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          flex: 15,
          child: _buildCalendarHealthLog(),
        )
      ],
    );
  }

  Widget _buildCalendarHealthLog() {
    return Column(
      children: [
        Expanded(flex: 1, child: _buildTimeMilestone()),
        Expanded(
          flex: 14,
          child: ValueListenableBuilder(
            valueListenable: _calendarController.visibleDayReversed,
            builder: (context, value, child) {
              return _buildContentCalendar(
                _calendarController.visibleDayReversed.value,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeMilestone() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 60.w,
        ),
        Expanded(
          flex: 9,
          child: Container(
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Table(
              children: [
                TableRow(
                  children: List.generate(
                    _calendarController.timeMilestone.length,
                    (index) {
                      BsLogTimeMilestone bsLog =
                          _calendarController.timeMilestone[index];
                      return Stack(
                        children: [
                          Positioned(
                            child: Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 30.w,
                                    height: 30.h,
                                    child: SvgPicture.asset(
                                      bsLog.imgUrl,
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
                      );
                    },
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
    var focusDay = _calendarController.focusedDay;
    var now = _calendarController.now;
    var isCurrentMonth =
        focusDay.month >= now.month && focusDay.year >= now.year;
    Color iconColor = AppColors.catalinaBlue;
    var dateTimeHeader = DateFormat(Constant.dayFormat)
        .format(_calendarController.lastFocusMonth.value);
    if (isCurrentMonth) {
      iconColor = AppColors.hawkesBlue;
    }
    final children = [
      const Spacer(
        flex: 1,
      ),
      Expanded(
        flex: 1,
        child: InkWell(
          child: Icon(
            Icons.chevron_left,
            size: 37.w,
            color: AppColors.catalinaBlue,
          ),
          onTap: _selectPrevious,
        ),
      ),
      Expanded(
        flex: 10,
        child: ValueListenableBuilder(
          valueListenable: _calendarController.lastFocusMonth,
          builder: (context, child, error) {
            return Text(
              dateTimeHeader,
              style: AppTextStyle.t18w700(AppColors.catalinaBlue),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
      Expanded(
        flex: 1,
        child: InkWell(
          child: Icon(
            Icons.chevron_right,
            size: 37.w,
            color: iconColor,
          ),
          onTap: _selectNext,
        ),
      ),
      const Spacer(
        flex: 1,
      )
    ];

    return SizedBox(
      height: 80.h,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    );
  }

  void _onLoadMore() {
    setState(() {
      _calendarController.triggerLoadDayOfPreMonth();
      _refreshController.loadComplete();
    });
  }

  void _onRefresh() {
    setState(() {
      if (_calendarController.shouldRefresh.value) {
        _calendarController.triggerLoadDayOfNextMonth();
      }
      _refreshController.refreshCompleted();
    });
  }

  var lastIndex = 0;

  Widget _buildContentCalendar(List<DateTime> dayInWeeks) {
    var eventDateTimes = widget.eventData;
    List<Object> finalList;
    if (eventDateTimes != null) {
      finalList = dayInWeeks.map((e) {
        var sameDay = eventDateTimes.firstWhereOrNull(
          (element) => element.dateTime.sameWith(e),
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
          DateTime focusDay =
              _calendarController.visibleDayReversed.value[lastIndex];
          _calendarController.setTitleFocusMonth(focusDay);
        });
        return true;
      },
      child: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        onLoading: _onLoadMore,
        onRefresh: _onRefresh,
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
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

  Widget _buildDaysInWeek(DateTime dateTime) {
    return SizedBox(
      height: _height,
      child: Row(
        children: [
          _buildItemDateTime(dateTime),
          Expanded(flex: 9, child: _buildTableEventWidget())
        ],
      ),
    );
  }

  Widget _buildDayInWeekWithEvent(HealthData data) {
    return SizedBox(
      width: 60.w,
      height: _height,
      child: Row(
        children: [
          _buildItemDateTime(data.dateTime),
          Expanded(flex: 10, child: _buildTableWithHealthEventWidget(data.list))
        ],
      ),
    );
  }

  Widget _buildItemDateTime(DateTime dateTime) {
    var isWeekend = _calendarController.isWeekend(dateTime);
    String dayDisplay = DateFormat("M/d").format(dateTime);
    String dayBottom = DateFormat.E(widget.locale).format(dateTime);
    Color textColor = AppColors.lightStaleGrey2;
    if (isWeekend) {
      textColor = AppColors.hawkesBlue;
    }
    return SizedBox(
      width: 60.w,
      height: _height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Text(
                "$dayDisplay \n $dayBottom",
                textAlign: TextAlign.center,
                style: AppTextStyle.t16w700(textColor),
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
      ),
    );
  }

  Widget _buildTableEventWidget() {
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

  Widget _buildTableWithHealthEventWidget(List<FiguresHealthData> data) {
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

  List<Widget> _buildDefaultTable() {
    return List.generate(
      8,
      (index) => SizedBox(
        height: _height,
        child: const Text(""),
      ),
    );
  }

  List<Widget> _buildListHealthEvent(List<FiguresHealthData> data) {
    var finalFiguresData = _calendarController.timeMilestone.map(
      (e) {
        var milestoneHasValue = data.firstWhereOrNull(
          (element) => element.type == e.type,
        );
        return milestoneHasValue != null
            ? FiguresHealthData(
                milestoneHasValue.count,
                milestoneHasValue.data,
                e.type,
              )
            : FiguresHealthData(0, 0, 0);
      },
    ).toList();

    return List.generate(
      finalFiguresData.length,
      (index) => SizedBox(
        height: _height,
        child: _buildItemHealthEvent(finalFiguresData[index]),
      ),
    );
  }

  Widget _buildItemHealthEvent(FiguresHealthData data) {
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
