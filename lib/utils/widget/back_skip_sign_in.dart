

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/theme/colors.dart';

Widget backAndSkipSignIn(GestureTapCallback onTabSkip){
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () => Get.back(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(
                Icons.arrow_back_ios,
                color: AppColors.colorBlueLabel,
              ),
              Text(
                L.current.back,
                style: const TextStyle(
                    color: AppColors.colorBlueLabel,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),InkWell(
        onTap: onTabSkip,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                L.current.skip.tr,
                style: const TextStyle(
                    color: AppColors.colorBlueLabel,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget backSignInButton(GestureTapCallback onTabSkip){
  return InkWell(
    onTap: onTabSkip,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Icon(
            Icons.arrow_back_ios,
            color: AppColors.colorBlueLabel,
          ),
          Text(
            L.current.back,
            style: const TextStyle(
                color: AppColors.colorBlueLabel,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}