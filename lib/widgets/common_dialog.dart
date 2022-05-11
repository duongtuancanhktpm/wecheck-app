import 'package:wecheck/widgets/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    Key? key,
    this.titlesSecondButton,
    this.content,
    this.headerWidget,
    this.titlesFirstButton,
    this.headerIcon,
    this.headerText = "",
    this.onTapFirstButton,
    this.onTapSecondButton,
  }) : super(key: key);
  final String? titlesFirstButton;
  final String? titlesSecondButton;
  final String? content;
  final Widget? headerWidget;
  final Widget? headerIcon;
  final String? headerText;
  final Function? onTapFirstButton;
  final Function? onTapSecondButton;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44.0, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: Get.width,
                      ),
                      headerText?.isEmpty == true
                          ? headerIcon ?? Container()
                          : Text(
                              headerText ?? "",
                              textAlign: TextAlign.center,
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        content ?? "",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: CircularButton(
                    onTap: () {
                      onTapFirstButton?.call();
                    },
                    label: titlesFirstButton ?? "",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    onTapSecondButton?.call() ?? Get.back();
                  },
                  child: Text(titlesSecondButton ?? ""),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
