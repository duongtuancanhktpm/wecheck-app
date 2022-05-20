import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/bslog/calendar/widgets/bs_log_calendar.dart';
import 'package:wecheck/screens/bslog/controller/bslog_controller.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/widgets/app_bar.dart';

class BloodSugarLogScreen extends StatelessWidget {
  final BloodSugarLogController _controller = Get.put(
    BloodSugarLogController(),
  );

  BloodSugarLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: L.current.bsLogTitle.tr,
        didBackPressed: () {
          Navigator.of(context).pop();
        },
        iconAction: SvgPicture.asset(
          AppIcons.icEdit,
          width: 26.w,
        ),
      ),
      body: Obx(
        () => BsLogCalendarWidget(
          eventData: _controller.healthData.toList(),
        ),
      ),
    );
  }
}
