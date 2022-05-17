import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';

itemMeals() {
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
                AppIcons.icEventEat,
                width: 26.h,
                height: 26.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Meals',
                  style: AppTextStyle.t16w700(AppColors.colorGrey),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Image.network(
                imageUrl,
                height: 45.h,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                '2150',
                style: AppTextStyle.t40w700(AppColors.colorCeruleanBlue),
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
                '1 hour. ago',
                style: AppTextStyle.t12w700(AppColors.colorGrey),
              ),
              Text(
                'kcal/day',
                style: AppTextStyle.t14w700(AppColors.lightStaleGrey2),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
