import 'package:wecheck/theme/theme.dart';
import 'package:wecheck/widgets/common_widgets.dart';
import 'package:wecheck/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static Future confirm(
    String message, {
    bool showNegativeButton = false,
    VoidCallback? onPositionPressed,
    VoidCallback? onNegativePressed,
    String? positionLabel,
    String? negativeLabel,
  }) {
    return Get.dialog(
      DialogBase(
        builder: (context) => Text(message, textAlign: TextAlign.center),
        positionLabel: positionLabel,
        negativeLabel: negativeLabel,
        onPositionPressed: () {
          Get.back();
          onPositionPressed?.call();
        },
        onNegativePressed: () {
          Get.back();
          onNegativePressed?.call();
        },
        showNegativeButton: showNegativeButton,
      ),
    );
  }

  static Future bottomList<T>({List<T> options = const [], T? selected}) async {
    Widget item(option, {bool selected = false}) {
      return GestureDetector(
        onTap: () => Get.back(result: option),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.dp),
          child: Row(
            children: [
              Expanded(
                child: Text(option.toString(), style: AppTextStyle.t14w700()),
              ),
              space(w: 8.dp),
              if (!selected) Icon(Icons.radio_button_off_rounded, size: 16),
              if (selected) Icon(Icons.radio_button_on_rounded, size: 16),
            ],
          ),
        ),
      );
    }

    return Get.bottomSheet<T?>(Container(
      color: AppColors.white,
      padding: EdgeInsets.all(16.dp),
      child: ListView.separated(
        itemBuilder: (context, index) => item(
          options[index],
          selected: options[index] == selected,
        ),
        separatorBuilder: (context, index) => divider(),
        itemCount: options.length,
      ),
    ));
  }
}
