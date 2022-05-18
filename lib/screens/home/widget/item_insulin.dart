import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';

itemInsulin() {
  var imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Siberischer_tiger_de_edit02.jpg/1280px-Siberischer_tiger_de_edit02.jpg';
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
                AppIcons.icEventInject,
                width: 26.h,
                height: 26.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  L.current.insulin.tr,
                  style: AppTextStyle.t16w700(AppColors.colorGrey),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 8.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.colorJungleGreen),
              padding: const EdgeInsets.only(left: 10),
              height: 45.h,
            ),
            Container(
              width: 160.h,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Tresiba Injection Penfill',
                style: AppTextStyle.t16w700(AppColors.colorCeruleanBlue),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '5 min. ago',
                style: AppTextStyle.t12w700(AppColors.colorGrey),
              ),
              Row(
                children: [
                  Text(
                    '3',
                    style: AppTextStyle.t18w700(AppColors.ceruleanBlue),
                  ),
                  const Padding(padding: EdgeInsets.all(2)),
                  Text(
                    L.current.unit.tr,
                    style: AppTextStyle.t14w700(AppColors.lightStaleGrey2),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
