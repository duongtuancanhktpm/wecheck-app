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

  static TextStyle commonLabel(
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

  static TextStyle t6w700([Color? color, double? height]) {
    return common(6.sp, FontWeight.w700, color, null, height);
  }
  static TextStyle t8w700([Color? color, double? height]) {
    return common(8.sp, FontWeight.w700, color, null, height);
  }
  static TextStyle t10w400([Color? color, double? height]) {
    return common(10.sp, FontWeight.w400, color, null, height);
  }

  static TextStyle t12w400([Color? color, double? height]) {
    return common(12.sp, FontWeight.w400, color, null, height);
  }

  static TextStyle t12w500([Color? color, double? height]) {
    return common(12.sp, FontWeight.w500, color, null, height);
  }

  static TextStyle t12w700([Color? color, double? height]) {
    return common(12.sp, FontWeight.w700, color, null, height);
  }

  static TextStyle t14w400([Color? color, double? height]) {
    return common(14.sp, FontWeight.w400, color, null, height);
  }

  static TextStyle t14w500([Color? color, double? height]) {
    return common(14.sp, FontWeight.w500, color, null, height);
  }

  static TextStyle t14w700([Color? color, double? height]) {
    return common(14.sp, FontWeight.w700, color, null, height);
  }

  static TextStyle t16w400([Color? color, double? height]) {
    return common(16.sp, FontWeight.w400, color, null, height);
  }

  static TextStyle t16w500([Color? color, double? height]) {
    return common(16.sp, FontWeight.w500, color, null, height);
  }

  static TextStyle t16w700([Color? color, double? height]) {
    return common(16.sp, FontWeight.w700, color, null, height);
  }

  static TextStyle t18w700([Color? color, double? height]) {
    return common(18.sp, FontWeight.w700, color, null, height);
  }
  static TextStyle t18w500([Color? color, double? height]) {
    return common(18.sp, FontWeight.w500, color, null, height);
  }

  static TextStyle t20w700([Color? color, double? height]) {
    return common(20.sp, FontWeight.w700, color, null, height);
  }

  static TextStyle t22w700([Color? color, double? height]) {
    return common(22.sp, FontWeight.w700, color, null, height);
  }

  static TextStyle t30w700([Color? color, double? height]) {
    return common(30.sp, FontWeight.w700, color, null, height);
  }

  static TextStyle t40w700([Color? color, double? height]) {
    return common(40.sp, FontWeight.w700, color, null, height);
  }
}
