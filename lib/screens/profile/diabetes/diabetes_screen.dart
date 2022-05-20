import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/profile/diabetes/controller/diabetes_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/dimens.dart';
import 'package:wecheck/theme/text_styles.dart';

class DiabetesScreen extends GetView {

  @override
  late DiabetesController controller;
  late Function onTapNext;

  DiabetesScreen({Key? key, required this.onTapNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = Get.put(DiabetesController());
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
            child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 40),
                child: Text(
                  L.current.aboutYourDiabetes.tr,
                  style: const TextStyle(
                      color: AppColors.textRegalBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              takingDiabetesWidget(),
              takingMedicineWidget(),
              takingInsulinWidget(),
              Positioned.fill(
                child: buttonSignInFinish(),
              ),
            ],
          ),
        ])));
  }

  optionalWidget() {
    return Positioned.fill(
      child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            L.current.optional.tr,
            style: const TextStyle(color: AppColors.colorGrey),
          )),
    );
  }

  Widget takingDiabetesWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 30),
          child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => Checkbox(
                      value: controller.isHaveDiabetes.value,
                      onChanged: (value) {
                        controller.isHaveDiabetes.value = value!;
                      })),
                  Text(
                    L.current.iHaveDiabetes.tr,
                    style: const TextStyle(
                        color: AppColors.colorDarkGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  )
                ],
              )),
        ),
        Obx(() => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: DropdownButton<String>(
              value: controller.valueHaveDiabetes.value,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24.dp,
              elevation: 16,
              isExpanded: true,
              style: AppTextStyle.t18w500(AppColors.colorGrey),
              underline: Container(
                height: 1.dp,
                color: AppColors.colorDarkGrey,
              ),
              onChanged: (data) {
                controller.valueHaveDiabetes.value = data!;
              },
              items: controller.listTypeDiabetes
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ))),
      ],
    );
  }

  Widget takingMedicineWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 30),
          child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => Checkbox(
                      value: controller.isTakingMedicine.value,
                      onChanged: (value) {
                        controller.isTakingMedicine.value = value!;
                      })),
                  Text(
                    L.current.iAmTakingMedicine.tr,
                    style: const TextStyle(
                        color: AppColors.colorDarkGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  )
                ],
              )),
        ),
        Obx(() => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: DropdownButton<String>(
              value: controller.valueTakingMedicine.value,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24.dp,
              elevation: 16,
              isExpanded: true,
              style: AppTextStyle.t18w500(AppColors.colorGrey),
              underline: Container(
                height: 1.dp,
                color: AppColors.colorDarkGrey,
              ),
              onChanged: (data) {
                controller.valueTakingMedicine.value = data!;
              },
              items: controller.listTakingMedicine
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )))
      ],
    );
  }

  takingInsulinWidget() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 30),
        child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() => Checkbox(
                    value: controller.isTakingInsulin.value,
                    onChanged: (value) {
                      controller.isTakingInsulin.value = value!;
                    })),
                Text(
                  L.current.iAmTakingInsulin.tr,
                  style: const TextStyle(
                      color: AppColors.colorDarkGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                )
              ],
            )),
      ),
      Obx(() => Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: DropdownButton<String>(
            value: controller.valueTakingInsulin.value,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            isExpanded: true,
            style: AppTextStyle.t18w500(AppColors.colorGrey),
            underline: Container(
              height: 1.dp,
              color: AppColors.colorDarkGrey,
            ),
            onChanged: (data) {
              controller.valueTakingInsulin.value = data!;
            },
            items: controller.listTakingInsulin
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )))
    ]);
  }

  Widget buttonSignInFinish() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 40),
            child: InkWell(
              onTap: () => controller.goToHomeScreen(),
              child: Container(
                alignment: Alignment.center,
               width: double.infinity,
                height: 45.dp,
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Text(
                  L.current.signIn,
                  style: AppTextStyle.t14w700(AppColors.white),
                ),
                decoration: BoxDecoration(
                  color: AppColors.colorCeruleanBlue,
                  border: Border.all(color: AppColors.colorCeruleanBlue),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            )));
  }
}
