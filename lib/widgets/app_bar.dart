import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wecheck/theme/colors.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  final List<Widget>? action;
  final VoidCallback? onBackPressed;

  const AppBarWidget({Key? key, required this.title, this.action, this.onBackPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84.h,
      color: AppColors.aliceBlue,
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: IconButton(
              onPressed: () {
                onBackPressed?.call();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.catalinaBlue,
                size: 32,
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: 0,
            bottom: 0,
            child: Center(
              child: title,
            ),
          ),
          _buildActionWidget()
        ],
      ),
    );
  }

  _buildActionWidget() {
    Widget widget;
    if (action == null) {
      widget = const Positioned(
        right: 0,
        child: Center(),
      );
    } else {
      widget = Positioned(
        right: 20,
        top: 0,
        bottom: 0,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: action!,
          ),
        ),
      );
    }
    return widget;
  }

  @override
  Size get preferredSize => Size(double.infinity, 84.h);
}
