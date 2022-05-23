
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wecheck/model/home/small_menu.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/dimens.dart';
import 'package:wecheck/theme/text_styles.dart';


itemMenuSmall(SmallMenu indexEn) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          SvgPicture.asset(
            indexEn.icon,
            width: 35.dp,
            height: 35.dp,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              indexEn.name,
              style: AppTextStyle.t14w700(AppColors.colorGrey),
            ),
          )
        ],
      ),
    ),
  );
}

itemMenuSmallFinal(SmallMenu indexEn) {
  return Container(
    color: AppColors.colorPattensBlue,
    child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          SvgPicture.asset(
            indexEn.icon,
            width: 35.dp,
            height: 35.dp,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              indexEn.name,
              style: AppTextStyle.t14w700(AppColors.colorGrey),
            ),
          )
        ],
      ),
    ),
  );
}


