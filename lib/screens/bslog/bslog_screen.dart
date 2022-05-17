import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/bslog/calendar/widgets/vertical_calendar.dart';
import 'package:wecheck/screens/bslog/controller/bslog_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';

class BloodSugarLogScreen extends StatelessWidget {
  final BloodSugarLogController _controller = Get.put(
    BloodSugarLogController(),
  );

  BloodSugarLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.aliceBlue,
        toolbarHeight: 84.h,
        title: Text(
          L.current.bsLogTitle.tr,
          style: AppTextStyle.t22w700(AppColors.catalinaBlue),
        ),
        leadingWidth: 30.w,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.catalinaBlue,
              size: 32,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AppIcons.icEdit, width: 26.w,),
          )
        ],
      ),
      body: Obx(
        () {
          var bsLogEvent = _controller.healthData.toList();
          return VerticalCalendarWidget(
            eventData: bsLogEvent,
          );
        },
      ),
    );
  }
}
