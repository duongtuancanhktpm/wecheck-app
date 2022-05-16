import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextStyle {

  static TextStyle get button => t14w700();

  static TextStyle get appbar => t16w700(AppColors.black);

  static TextStyle common(
    double? fontSize,
    FontWeight? fontWeight,
    Color? color, [
    TextDecoration? decoration = TextDecoration.none,
    double? height = 1.25,
  ]) {
    return TextStyle(
      color: color ?? AppColors.black,
      fontWeight: fontWeight,
      fontSize: fontSize?.dp,
      decoration: decoration,
      height: height,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle t10w400([Color? color, double? height]) {
    return common(10, FontWeight.w400, color, null, height);
  }

  static TextStyle t12w400([Color? color, double? height]) {
    return common(12, FontWeight.w400, color, null, height);
  }

  static TextStyle t12w500([Color? color, double? height]) {
    return common(12, FontWeight.w500, color, null, height);
  }

  static TextStyle t12w700([Color? color, double? height]) {
    return common(12, FontWeight.w700, color, null, height);
  }

  static TextStyle t14w400([Color? color, double? height]) {
    return common(14, FontWeight.w400, color, null, height);
  }

  static TextStyle t14w500([Color? color, double? height]) {
    return common(14, FontWeight.w500, color, null, height);
  }

  static TextStyle t14w700([Color? color, double? height]) {
    return common(14, FontWeight.w700, color, null, height);
  }

  static TextStyle t16w400([Color? color, double? height]) {
    return common(16, FontWeight.w400, color, null, height);
  }

  static TextStyle t16w500([Color? color, double? height]) {
    return common(16, FontWeight.w500, color, null, height);
  }

  static TextStyle t16w700([Color? color, double? height]) {
    return common(16, FontWeight.w700, color, null, height);
  }

  static TextStyle t18w700([Color? color, double? height]) {
    return common(18, FontWeight.w700, color, null, height);
  }

  static TextStyle t22w700 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22.sp,
    color: AppColors.catalinaBlue
  );

}
