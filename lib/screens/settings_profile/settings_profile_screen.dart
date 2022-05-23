import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/settings_profile/controller/settings_profile_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/text_styles.dart';

class SettingsProfileScreen extends GetView<SettingsProfileController> {
  const SettingsProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTitle(),
            //_buildProfile(),
            //_buildBasicInfi(),
          ],
        ),
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      width: double.infinity,
      color: AppColors.pattensBlue,
      child: Row(
        children: [
          TextButton(
            onPressed: (){
              Navigator.pop;
            },
              child: const Icon(Icons.arrow_back_ios_new, color: AppColors.regalBlue)),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              L.current.settings,
              style: AppTextStyle.t22w700(AppColors.regalBlue),
            ),
          )
        ],
      ),
    );
  }
}
