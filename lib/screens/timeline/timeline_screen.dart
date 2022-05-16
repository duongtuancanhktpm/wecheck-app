import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';
import 'package:wecheck/utils/constants.dart';
import 'package:wecheck/utils/extensions.dart';
import 'package:wecheck/widgets/app_bar.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/model/event_data.dart';
import 'package:wecheck/screens/timeline/controller/timeline_controller.dart';

class TimeLineScreen extends GetView<TimeLineController> {
  const TimeLineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.calendarFormat.value == CalendarFormat.week) {
          controller.onChangeCalendarFormat();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarWidget(
            title: Obx(
              () => Text(
                controller.titleAppBar.value,
                style: AppTextStyle.t22w700(AppColors.catalinaBlue),
              ),
            ),
            action: [
              SvgPicture.asset(
                AppIcons.icEdit,
              ),
            ],
            onBackPressed: () {
              if (controller.calendarFormat.value == CalendarFormat.month) {
                SystemNavigator.pop();
              } else {
                controller.onChangeCalendarFormat();
              }
            },
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildCalendarEvent(),
                  _buildListEventData(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildCalendarEvent() {
    return Obx(
      () {
        var events = controller.visibleEvent.toList();
        var focusDay = controller.focusDate.value;
        var calendarFormat = controller.calendarFormat.value;
        return TableCalendar(
          eventLoader: (day) =>
              events.where((element) => day.sameWith(element)).toList(),
          firstDay: DateTime.utc(1900, 10, 16),
          lastDay: DateTime.utc(5000, 3, 14),
          focusedDay: focusDay,
          daysOfWeekHeight: 40.h,
          rowHeight: 80.h,
          calendarFormat: calendarFormat,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.catalinaBlue,
            ),
          ),
          calendarStyle: CalendarStyle(
            markersAutoAligned: false,
            markersOffset: PositionedOffset(top: 40.h),
            tableBorder: const TableBorder(
              horizontalInside: BorderSide(
                color: AppColors.lightSlateGrey,
                width: 0.1,
              ),
            ),
            selectedDecoration: const BoxDecoration(
              color: AppColors.aliceBlue2,
            ),
          ),
          selectedDayPredicate: (selectedDay) {
            return controller.selectedDayPredicate(selectedDay);
          },
          onDaySelected: (selectedDay, focusedDay) {
            controller.onDaySelected(selectedDay, focusedDay);
          },
          onPageChanged: (focusedDay) {
            controller.onPageChanged(focusedDay);
          },
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (
              BuildContext context,
              DateTime day,
              DateTime focusedDay,
            ) {
              return _buildItemSelected(day);
            },
            singleMarkerBuilder: (context, date, listEvent) {
              return _buildItemEventData(date);
            },
            todayBuilder: (
              BuildContext context,
              DateTime day,
              DateTime focusedDay,
            ) {
              return _buildItemToday(day);
            },
            outsideBuilder: (
              BuildContext context,
              DateTime day,
              DateTime focusedDay,
            ) {
              return _buildItemOutSiteMonth(day);
            },
            defaultBuilder: (
              BuildContext context,
              DateTime day,
              DateTime focusedDay,
            ) {
              return _buildItemDefault(day);
            },
            dowBuilder: (
              context,
              day,
            ) {
              return _buildItemDowBuilder(day);
            },
          ),
        );
      },
    );
  }

  Widget _buildItemDowBuilder(DateTime dateTime) {
    return Text(
      DateFormat.E().format(
        dateTime,
      ),
      style: AppTextStyle.t16w700(AppColors.catalinaBlue),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildItemDefault(DateTime dateTime) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          dateTime.day.toString(),
          style: AppTextStyle.t16w700(AppColors.lightStaleGrey2),
        ),
      ),
    );
  }

  Widget _buildItemOutSiteMonth(DateTime dateTime) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          dateTime.day.toString(),
          style: AppTextStyle.t16w700(AppColors.hawkesBlue),
        ),
      ),
    );
  }

  Widget _buildItemToday(DateTime dateTime) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9.h, horizontal: 4.h),
      color: AppColors.aliceBlue2,
      padding: EdgeInsets.only(top: 9.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          dateTime.day.toString(),
          style: AppTextStyle.t16w700(AppColors.lightStaleGrey2),
        ),
      ),
    );
  }

  Widget _buildItemSelected(DateTime dateTime) {
    var selectedDay = controller.selectedDate.value;
    Color color = Colors.white;
    if (dateTime.sameWith(selectedDay)) {
      color = AppColors.aliceBlue2;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9.h, horizontal: 4.h),
      color: color,
      padding: EdgeInsets.only(top: 9.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          dateTime.day.toString(),
          style: AppTextStyle.t16w700(AppColors.lightStaleGrey2),
        ),
      ),
    );
  }

  Widget _buildItemEventData(DateTime event) {
    EventData? eventData = controller.event.firstWhereOrNull((element) {
      var newDateData = DateFormat(
        Constant.fullDataFormat,
      ).parse(element.dateTime);
      return newDateData.sameWith(event);
    });
    return eventData != null
        ? SizedBox(
            height: 40.h,
            child: Column(
              children: [
                eventData.dayType.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 0.h),
                          child: SvgPicture.asset(
                            eventData.dayType,
                          ),
                        ),
                      )
                    : const Expanded(
                        child: SizedBox(),
                      ),
                eventData.status != 0
                    ? Expanded(
                        child: Container(
                          width: 7.w,
                          height: 7.h,
                          margin: EdgeInsets.only(top: 6.h),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : const Expanded(child: SizedBox()),
              ],
            ),
          )
        : const SizedBox();
  }

  _buildListEventData() {
    return Obx(
      () {
        var listEvent = controller.eventDetailData.toList();
        var daySelected = controller.selectedDate.value;
        return SizedBox(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 35.h,
                color: AppColors.aliceBlue,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat.E().format(
                        daySelected,
                      ),
                      style: AppTextStyle.t18w700(AppColors.lightSlateGrey),
                    ),
                  ),
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listEvent.length,
                itemBuilder: (context, index) {
                  return _buildItemEventDetailData(
                    listEvent[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                    color: AppColors.lightSlateGrey,
                  );
                },
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        );
      },
    );
  }

  _buildItemEventDetailData(EventDetailData data) {
    var time = DateFormat(Constant.fullDataFormat).parse(data.dateTime);
    return SizedBox(
      height: 67.h,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SvgPicture.asset(
              data.eventType,
            ),
          ),
          Expanded(
            flex: 8,
            child: Text(
              data.value,
              style: AppTextStyle.t30w700(AppColors.ceruleanBlue),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              DateFormat.Hm().format(time),
              style: AppTextStyle.t18w700(AppColors.lightSlateGrey),
            ),
          ),
        ],
      ),
    );
  }
}