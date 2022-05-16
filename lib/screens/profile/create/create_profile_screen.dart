import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/profile/create/controller/create_profile_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/utils/widget/back_skip_sign_in.dart';
import 'package:wecheck/utils/widget/indicator_sign_in.dart';

class CreateProfileScreen extends GetView<CreateProfileController> {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backAndSkipSignIn(()=> controller.goToHomePage()),
              indicatorSignIn(
                  AppColors.colorBlueLabel,
                  AppColors.colorBlueLabel,
                  AppColors.colorBlueLabel,
                  AppColors.colorBlueLabel,
                  AppColors.colorBlueLabel,
                  AppColors.colorBottomSignIn),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 40),
                child: Text(
                  L.current.createYourProfile.tr,
                  style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 30, right: 30, bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              fillColor: AppColors.white,
                              floatingLabelStyle: TextStyle(
                                  height: 0.2,
                                  color: AppColors.colorBlueLabel,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorTextSignIn),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorTextSignIn),
                              ),
                              labelText: 'First Name',
                              labelStyle: TextStyle(
                                  color: AppColors.colorTextSignIn,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              floatingLabelStyle: TextStyle(
                                  height: 0.2,
                                  color: AppColors.colorBlueLabel,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              fillColor: AppColors.white,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorTextSignIn),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorTextSignIn),
                              ),
                              labelText: 'Last Name',
                              labelStyle: TextStyle(
                                  color: AppColors.colorTextSignIn,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
                child: Text(
                  'Date Of bird',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
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
                          decoration: const InputDecoration(
                              fillColor: AppColors.white,
                              floatingLabelStyle: TextStyle(
                                  height: 0.2,
                                  color: AppColors.colorBlueLabel,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorTextSignIn),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorTextSignIn),
                              ),
                              labelText: 'Day',
                              labelStyle: TextStyle(
                                  color: AppColors.colorTextSignIn,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            fillColor: AppColors.white,
                            floatingLabelStyle: TextStyle(
                                height: 0.2,
                                color: AppColors.colorBlueLabel,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.colorTextSignIn),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.colorTextSignIn),
                            ),
                            labelText: 'Month',
                            labelStyle: TextStyle(
                                color: AppColors.colorTextSignIn,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              fillColor: AppColors.white,
                              floatingLabelStyle: TextStyle(
                                  height: 0.2,
                                  color: AppColors.colorBlueLabel,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorTextSignIn),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorTextSignIn),
                              ),
                              labelText: 'Year',
                              labelStyle: TextStyle(
                                  color: AppColors.colorTextSignIn,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  child: DropdownButton<String>(
                    value: controller.valueCountry.value,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    style: const TextStyle(
                        color: AppColors.colorBottomSignIn, fontSize: 18),
                    underline: Container(
                      height: 1,
                      color: AppColors.colorTextSignIn,
                    ),
                    onChanged: (data) {
                      controller.valueCountry.value = data!;
                    },
                    items: controller.listCountry
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ))),
              Obx(() => Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  child: DropdownButton<String>(
                    value: controller.valueGender.value,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    style: const TextStyle(
                        color: AppColors.colorBottomSignIn, fontSize: 18),
                    underline: Container(
                      height: 1,
                      color: AppColors.colorTextSignIn,
                    ),
                    onChanged: (data) {
                      controller.valueGender.value = data!;
                    },
                    items: controller.listGender
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ))),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Stack(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          fillColor: AppColors.white,
                          floatingLabelStyle: TextStyle(
                              height: 0.2,
                              color: AppColors.colorBlueLabel,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.colorTextSignIn),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.colorTextSignIn),
                          ),
                          labelText: 'Height',
                          labelStyle: TextStyle(
                              color: AppColors.colorTextSignIn,
                              fontWeight: FontWeight.bold)),
                    ),
                    optionalWidget()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: Stack(
                  children: [
                    TextFormField(
                      style: const TextStyle(
                          color: AppColors.textColor, fontSize: 16),
                      decoration: const InputDecoration(
                          fillColor: AppColors.white,
                          filled: true,
                          //  contentPadding: const EdgeInsets.only(top: 25, bottom: 15),
                          floatingLabelStyle: TextStyle(
                              height: 0.2,
                              color: AppColors.colorBlueLabel,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.colorTextSignIn),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.colorTextSignIn),
                          ),
                          labelText: 'Weight',
                          labelStyle: TextStyle(
                              height: 20,
                              fontSize: 16,
                              color: AppColors.colorTextSignIn,
                              fontWeight: FontWeight.bold)),
                    ),
                    optionalWidget()
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 30, right: 30, bottom: 20),
                  child: InkWell(
                    onTap: () => controller.goToDiabetesScreen(),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ))
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
            style: TextStyle(color: AppColors.colorBottomSignIn),
          )),
    );
  }
}
