import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wecheck/theme/colors.dart';

Widget indicatorSignIn(int size, int positionColor) {
  return Container(
    height: 20.h,
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: GridView.builder(
      itemCount: size,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, childAspectRatio: 6),
      itemBuilder: (BuildContext context, int index) {

        var color = index <= positionColor ? AppColors.colorCeruleanBlue:  AppColors.colorGrey;
        return Padding(padding: const EdgeInsets.only(right: 5), child: Container(
          padding: const EdgeInsets.only(right: 10),
          height: 8.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color),
        ),);
      },
    ),
  );
}
