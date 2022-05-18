
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';

itemSteps() {
  return Card(
    color: AppColors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.icEventDrinkWater,
                width: 26.h,
                height: 26.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  L.current.steps.tr,
                  style: AppTextStyle.t16w700(AppColors.colorGrey),
                ),
              ),
            ],
          ),
        ),
        Text(
          '6500',
          style: AppTextStyle.t40w700(AppColors.colorCeruleanBlue),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                L.current.stepsDay.tr,
                style: AppTextStyle.t14w700(AppColors.lightStaleGrey2),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
