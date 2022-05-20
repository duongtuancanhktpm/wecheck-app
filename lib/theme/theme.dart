import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/dimens.dart';
import 'package:wecheck/theme/text_styles.dart';
import 'package:flutter/material.dart';

export 'colors.dart';
export 'dimens.dart';
export 'icons.dart';
export 'images.dart';
export 'text_styles.dart';

class AppTheme {
  static AppTheme? _instance;

  static late final ThemeData _defaultThemeData;

  factory AppTheme.base(ThemeData theme) {
    if (_instance != null) return _instance!;

    _instance = AppTheme._init(theme);
    return _instance!;
  }

  AppTheme._init(ThemeData theme) {
    _defaultThemeData = theme;
  }

  ThemeData get appTheme {
    return _defaultThemeData.copyWith(
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      primaryColor: AppColors.black,
      primaryColorDark: AppColors.black,
      primaryColorLight: AppColors.black,
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: AppColors.black),
      scaffoldBackgroundColor: AppColors.black,
      dialogTheme: dialogTheme,
      inputDecorationTheme: inputDecorationTheme,
      tabBarTheme: tabbarTheme,
    );
  }

  TabBarTheme get tabbarTheme {
    return _defaultThemeData.tabBarTheme.copyWith(
      labelStyle: AppTextStyle.t14w700(),
      labelColor: AppColors.black,
      unselectedLabelColor: AppColors.black,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.black, width: 1.dp),
        insets: EdgeInsets.symmetric(horizontal: 16.dp),
      ),
    );
  }

  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: AppColors.black,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
        isDense: true,
        hintStyle: AppTextStyle.t14w400(AppColors.black),
      );

  DialogTheme get dialogTheme {
    return _defaultThemeData.dialogTheme.copyWith(
      backgroundColor: AppColors.black,
    );
  }

  AppBarTheme? get appBarTheme {
    return _defaultThemeData.appBarTheme.copyWith(
      backgroundColor: AppColors.white,
      centerTitle: true,
      titleTextStyle: AppTextStyle.appbar,
      elevation: 0,
      iconTheme: _defaultThemeData.iconTheme.copyWith(color: AppColors.black),
      actionsIconTheme: _defaultThemeData.iconTheme.copyWith(
        color: AppColors.black,
      ),
    );
  }

  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.any((state) => state == MaterialState.disabled)) {
                return AppColors.black;
              }
              return AppColors.colorCeruleanBlue;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              return AppColors.white;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith(
            (states) => AppTextStyle.button,
          ),
        ),
      );

  OutlinedButtonThemeData? get outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.dp),
          ),
        ),
        side: MaterialStateProperty.resolveWith(
          (states) {
            if (states.any((state) => state == MaterialState.disabled)) {
              return const BorderSide(color: AppColors.black);
            }
            return const BorderSide(color: AppColors.black);
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.any((state) => state == MaterialState.disabled)) {
              return AppColors.black;
            }
            return AppColors.black;
          },
        ),
        backgroundColor: MaterialStateColor.resolveWith((states) => AppColors.white),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => AppTextStyle.button,
        ),
        padding: MaterialStateProperty.resolveWith(
          (states) => EdgeInsets.symmetric(vertical: 14.dp, horizontal: 30),
        ),
      ),
    );
  }
}
