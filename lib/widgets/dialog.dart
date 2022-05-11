import 'package:wecheck/theme/dimens.dart';
import 'package:wecheck/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogBase extends StatelessWidget {
  const DialogBase({
    Key? key,
    required this.builder,
    this.positionLabel,
    this.negativeLabel,
    this.showNegativeButton = false,
    this.showPositionButton = true,
    required this.onPositionPressed,
    this.onNegativePressed,
  }) : super(key: key);

  final String? positionLabel;
  final String? negativeLabel;
  final bool showNegativeButton;
  final bool showPositionButton;
  final Widget Function(BuildContext context) builder;

  final VoidCallback? onPositionPressed;
  final VoidCallback? onNegativePressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.dp),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Get.theme.dialogTheme.backgroundColor,
                    borderRadius: _borderRadius,
                  ),
                  padding: EdgeInsets.all(32.dp),
                  child: IntrinsicHeight(
                    child: Center(
                      child: content(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      children: [
        builder(context),
        space(h: 20.dp),
        if (showPositionButton) positionButton(context),
        if (showNegativeButton) ...[
          space(h: 4.dp),
          negativeButton(context),
        ]
      ],
    );
  }

  Widget negativeButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: OutlinedButton(
        onPressed: onNegativePressed?.call,
        child: Text(negativeLabel ?? 'Cancel'),
      ),
    );
  }

  Widget positionButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: ElevatedButton(
        onPressed: onPositionPressed?.call,
        child: Text(positionLabel ?? 'Ok'),
      ),
    );
  }

  BorderRadiusGeometry get _borderRadius => BorderRadius.circular(16.dp);

  bool get cancelable => true;
}
