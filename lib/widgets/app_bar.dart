import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/text_styles.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final VoidCallback? didActionPressed;
  final VoidCallback? didBackPressed;
  final Widget? iconAction;

  const AppBarWidget({
    Key? key,
    this.title,
    this.titleWidget,
    this.didActionPressed,
    this.didBackPressed,
    this.iconAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.aliceBlue,
      toolbarHeight: 84.h,
      title: titleWidget ?? Text(
        title ?? "",
        style: AppTextStyle.t22w700(AppColors.catalinaBlue),
      ),
      titleSpacing: 0,
      leading: InkWell(
        onTap: () {
          didBackPressed?.call();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.catalinaBlue,
            size: 32,
          ),
        ),
      ),
      centerTitle: false,
      actions: [
        InkWell(
          onTap: () {
            didActionPressed?.call();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: iconAction ?? Icon(
              Icons.search,
              size: 35.w,
              color: AppColors.catalinaBlue,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 84.h);
}
