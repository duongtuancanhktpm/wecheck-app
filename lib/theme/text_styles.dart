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
    return common(10.dp, FontWeight.w400, color, null, height);
  }

  static TextStyle t12w400([Color? color, double? height]) {
    return common(12.dp, FontWeight.w400, color, null, height);
  }

  static TextStyle t12w500([Color? color, double? height]) {
    return common(12.dp, FontWeight.w500, color, null, height);
  }

  static TextStyle t12w700([Color? color, double? height]) {
    return common(12.dp, FontWeight.w700, color, null, height);
  }

  static TextStyle t14w400([Color? color, double? height]) {
    return common(14.dp, FontWeight.w400, color, null, height);
  }

  static TextStyle t14w500([Color? color, double? height]) {
    return common(14.dp, FontWeight.w500, color, null, height);
  }

  static TextStyle t14w700([Color? color, double? height]) {
    return common(14.dp, FontWeight.w700, color, null, height);
  }

  static TextStyle t16w400([Color? color, double? height]) {
    return common(16.dp, FontWeight.w400, color, null, height);
  }

  static TextStyle t16w500([Color? color, double? height]) {
    return common(16.dp, FontWeight.w500, color, null, height);
  }

  static TextStyle t16w700([Color? color, double? height]) {
    return common(16.dp, FontWeight.w700, color, null, height);
  }

  static TextStyle t16w800([Color? color, double? height]) {
    return common(16.dp, FontWeight.w800, color, null, height);
  }

  static TextStyle t18w700([Color? color, double? height]) {
    return common(18.dp, FontWeight.w700, color, null, height);
  }

  static TextStyle t22w700([Color? color, double? height]) {
    return common(22.dp, FontWeight.w700, color, null, height);
  }

  static TextStyle t30w700([Color? color, double? height]) {
    return common(30.dp, FontWeight.w700, color, null, height);
  }
}
