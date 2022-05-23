import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/routes/routes.dart';
import 'package:wecheck/screens/settings_profile/controller/settings_profile_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/text_styles.dart';

class SettingsProfileScreen extends GetView<SettingsProfileController> {
  const SettingsProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pattensBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTitle(context),
              _buildProfile(),
              _buildBasicInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String goto) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Text(
                title,
                style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.lightSlateGrey,
              ),
            ),
          ],
        ),
        Container(
          color: AppColors.lightSlateGrey,
          height: 1,
        ),
      ],
    );
  }

  _buildBasicInfo() {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            color: AppColors.pattensBlue,
            child: Text(
              L.current.basicInfo,
              style: AppTextStyle.t18w700(AppColors.regalBlue),
            ),
          ),
          Column(
            children: [
              _buildInfoRow(L.current.namePhoneIdPass, RouteName.home),
              _buildInfoRow(L.current.birthOfDateSexAdd, RouteName.home),
              _buildInfoRow(L.current.typeOfDiabeteHW, RouteName.home),
              _buildInfoRow(L.current.medicalHistory, RouteName.home),
              _buildInfoRow(L.current.basicInfo, RouteName.home),
            ],
          ),
        ],
      ),
    );
  }

  _buildProfile() {
    return Obx(
      () => Container(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              color: AppColors.pattensBlue,
              child: Text(
                L.current.profile,
                style: AppTextStyle.t18w700(AppColors.regalBlue),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey),
              width: 90,
              height: 90,
              child: Image.asset(controller.data.value.avatar),
              //(controller.userProfile.value.avatar),
            ),
            Text(
              controller.data.value.name,
              style: AppTextStyle.t22w700(AppColors.regalBlue),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Change cover photo",
                style: AppTextStyle.t16w400(AppColors.lightSlateGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: double.infinity,
      color: AppColors.pattensBlue,
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back_ios_new,
                  color: AppColors.regalBlue)),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              L.current.profile,
              style: AppTextStyle.t22w700(AppColors.regalBlue),
            ),
          ),
        ],
      ),
    );
  }
}
