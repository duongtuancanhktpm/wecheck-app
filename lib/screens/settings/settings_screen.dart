import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/routes/routes.dart';
import 'package:wecheck/screens/settings/controller/settings_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pattensBlue,
      body: SafeArea(
        child: Column(
          children: [
            _buildTitle(),
            _buildProfile(),
            _buildSettings(),
          ],
        ),
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding:
          EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
      width: double.infinity,
      color: AppColors.pattensBlue,
      child: Center(
          child: Text(
        L.current.settings,
        style: AppTextStyle.t22w700(AppColors.regalBlue),
      )),
    );
  }

  _buildProfile() {
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
            color: AppColors.pattensBlue,
            child: Text(
              L.current.profile,
              style: AppTextStyle.t18w700(AppColors.regalBlue),
            ),
          ),
         Obx(()=>  Row(
           children: [
             Container(
               margin: EdgeInsets.only(
                   left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
               decoration: const BoxDecoration(
                   shape: BoxShape.circle, color: Colors.grey),
               width: 60,
               height: 60,
               child: //SvgPicture.asset("assetName")
               Container(),
             ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   controller.userProfile.value.name,
                   style: AppTextStyle.t18w700(AppColors.regalBlue),
                 ),
                 Text(
                   controller.userProfile.value.email,
                   style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
                 ),
               ],
             ),
             const Spacer(),
             TextButton(
               onPressed: () => controller.gotoSettingsProfile(),
               child: const Icon(
                 Icons.arrow_forward_ios,
                 color: AppColors.lightSlateGrey,
               ),
             ),
           ],
         )),
        ],
      ),
    );
  }

  _buildSettings() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
              left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
          color: AppColors.pattensBlue,
          child: Text(
            L.current.settings,
            style: AppTextStyle.t18w700(AppColors.regalBlue),
          ),
        ),
        _buildSettingsRow(
            icon: AppIcons.icEventInject, label: L.current.insulinMedicine, route: RouteName.insulinMedicine),
        _buildSettingsRow(
            icon: AppIcons.icEventDrinkWater, label: L.current.pairing, route: RouteName.insulinMedicine),
        _buildSettingsRow(
            icon: AppIcons.icEventDrinkWater, label: L.current.notification, route: RouteName.insulinMedicine),
        _buildSettingsRow(
            icon: AppIcons.icEventDrinkWater, label: L.current.personalGoal, route: RouteName.insulinMedicine),
        _buildSettingsRow(
            icon: AppIcons.icEventDrinkWater, label: L.current.link, route: RouteName.insulinMedicine),
      ],
    );
  }

  Widget _buildSettingsRow({required String icon, required String label, required String route}) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(
                        left: 30.w, right: 30.w, top: 16.h, bottom: 16.h),
                child: SvgPicture.asset(icon),
              ),
              Text(
                label,
                style: AppTextStyle.t18w700(AppColors.lightSlateGrey),
              ),
              const Spacer(),
              TextButton(
                onPressed: () =>controller.goto(route),
                child: Padding(
                  padding:  EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                  child: const Icon(Icons.arrow_forward_ios,
                      color: AppColors.lightSlateGrey),
                ),
              )
            ],
          ),
          Container(
            height: 0.5,
            color: AppColors.lightSlateGrey,
          )
        ],
      ),
    );
  }
}
