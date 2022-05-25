import 'package:flutter/material.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTitle(),
              _buildProfile(),
              _buildSettings(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      width: double.infinity,
      color: AppColors.pattensBlue,
      child: Center(
        child: Text(
          L.current.settings,
          style: AppTextStyle.t22w700(AppColors.regalBlue),
        ),
      ),
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
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            color: AppColors.pattensBlue,
            child: Text(
              L.current.profile,
              style: AppTextStyle.t18w700(AppColors.regalBlue),
            ),
          ),
          Obx(
            () => Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  width: 60,
                  height: 60,
                  child: Image.asset(controller.userProfile.value.avatar),
                  //(controller.userProfile.value.avatar),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.profile.value.firstName} ${controller.profile.value.lastName}",
                      style: AppTextStyle.t18w700(AppColors.regalBlue),
                    ),
                    Text(
                      controller.profile.value.email ?? "loading",
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
            ),
          ),
        ],
      ),
    );
  }

  _buildSettings() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          color: AppColors.pattensBlue,
          child: Text(
            L.current.settings,
            style: AppTextStyle.t18w700(AppColors.regalBlue),
          ),
        ),
        _buildSettingsRow(
            icon: AppIcons.icEventInject,
            label: L.current.insulinMedicine,
            route: RouteName.insulinMedicine),
        _buildSettingsRow(
            icon: AppIcons.icEventDrinkWater,
            label: L.current.pairing,
            route: RouteName.insulinMedicine),
        _buildSettingsRow(
            icon: AppIcons.icEventDrinkWater,
            label: L.current.notification,
            route: RouteName.insulinMedicine),
        _buildSettingsRow(
            icon: AppIcons.icEventDrinkWater,
            label: L.current.personalGoal,
            route: RouteName.insulinMedicine),
        _buildSettingsRow(
            icon: AppIcons.icEventDrinkWater,
            label: L.current.link,
            route: RouteName.insulinMedicine),
      ],
    );
  }

  Widget _buildSettingsRow(
      {required String icon, required String label, required String route}) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 90,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 16, bottom: 16),
                  child: SvgPicture.asset(icon),
                ),
              ),
              Text(
                label,
                style: AppTextStyle.t18w700(AppColors.lightSlateGrey),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => controller.goto(route),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: Icon(Icons.arrow_forward_ios,
                      color: AppColors.lightSlateGrey),
                ),
              ),
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
