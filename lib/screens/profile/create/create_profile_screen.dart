import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/create_profile_data.dart';
import 'package:wecheck/screens/profile/create/controller/create_profile_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/dimens.dart';
import 'package:wecheck/theme/text_styles.dart';

class CreateProfileScreen extends GetView {
  @override
  late CreateProfileController controller;

  late Function onTapNext;

  CreateProfileScreen({Key? key, required this.onTapNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = Get.put(CreateProfileController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 40),
                child: Text(
                  L.current.createYourProfile.tr,
                  style: const TextStyle(
                      color: AppColors.textRegalBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              inputNameLayout(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 30, right: 30, bottom: 10),
                child: Text(
                  L.current.dateOfBirth.tr,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              dateOfBirthLayout(),
              Obx(() => Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  child: dropMenuCountry())),
              Obx(() => Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  child: dropMenuGender())),
              inputHeightWidget(),
              inputWeightWidget(),
              nextButton()
            ],
          ),
        ),
      ),
    );
  }

  optionalWidget() {
    return const Positioned.fill(
      child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Optional',
            style: TextStyle(color: AppColors.colorGrey),
          )),
    );
  }

  Widget inputNameLayout() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    fillColor: AppColors.white,
                    floatingLabelStyle:
                        AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorDarkGrey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorDarkGrey),
                    ),
                    labelText: L.current.firstName.tr,
                    labelStyle: const TextStyle(
                        color: AppColors.colorDarkGrey,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    floatingLabelStyle:
                        AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
                    fillColor: AppColors.white,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorDarkGrey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorDarkGrey),
                    ),
                    labelText: L.current.lastName.tr,
                    labelStyle: const TextStyle(
                        color: AppColors.colorDarkGrey,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  dateOfBirthLayout() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    fillColor: AppColors.white,
                    floatingLabelStyle:
                        AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorDarkGrey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorDarkGrey),
                    ),
                    labelText: L.current.day.tr,
                    labelStyle: const TextStyle(
                        color: AppColors.colorDarkGrey,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextFormField(
              decoration: InputDecoration(
                  fillColor: AppColors.white,
                  floatingLabelStyle:
                      AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.colorDarkGrey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.colorDarkGrey),
                  ),
                  labelText: L.current.month.tr,
                  labelStyle: const TextStyle(
                      color: AppColors.colorDarkGrey,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    fillColor: AppColors.white,
                    floatingLabelStyle:
                        AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorDarkGrey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorDarkGrey),
                    ),
                    labelText: L.current.year.tr,
                    labelStyle: AppTextStyle.t14w700(AppColors.colorDarkGrey)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropMenuCountry() {
    return DropdownButton<String>(
      value: controller.valueCountry.value,
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
        controller.valueCountry.value = data!;
      },
      items:
          controller.listCountry.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  dropMenuGender() {
    DropdownButton<String>(
      value: controller.valueGender.value,
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
        controller.valueGender.value = data!;
      },
      items:
          controller.listGender.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget inputHeightWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: Stack(
        children: [
          TextFormField(
            decoration: InputDecoration(
                fillColor: AppColors.white,
                floatingLabelStyle:
                    AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.colorDarkGrey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.colorDarkGrey),
                ),
                labelText: L.current.height.tr,
                labelStyle: AppTextStyle.t14w700(AppColors.colorDarkGrey)),
          ),
          optionalWidget()
        ],
      ),
    );
  }

  Widget inputWeightWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Stack(
        children: [
          TextFormField(
            style:
                const TextStyle(color: AppColors.textRegalBlue, fontSize: 16),
            decoration: InputDecoration(
                fillColor: AppColors.white,
                filled: true,
                //  contentPadding: const EdgeInsets.only(top: 25, bottom: 15),
                floatingLabelStyle:
                    AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.colorDarkGrey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.colorDarkGrey),
                ),
                labelText: L.current.weight.tr,
                labelStyle: const TextStyle(
                    height: 20,
                    fontSize: 16,
                    color: AppColors.colorDarkGrey,
                    fontWeight: FontWeight.bold)),
          ),
          optionalWidget()
        ],
      ),
    );
  }

  Widget nextButton() {
    return Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
        child: InkWell(
          onTap: () => clickCreateProfile(),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Text(
              L.current.next.tr,
              style: AppTextStyle.t16w700(AppColors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(color: Colors.blueAccent),
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ));
  }

  clickCreateProfile() {
    var createProfileData = CreateProfileData();
    controller.createProfileRepository
        .callInputCode(createProfileData)
        .then((value) {
      onTapNext();
    });
  }
}
