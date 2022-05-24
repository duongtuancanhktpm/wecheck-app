import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/insulin_medicine/controller/insulin_medicine_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/text_styles.dart';

class InsulinMedicineScreen extends GetView<InsulinMedicineController> {
  const InsulinMedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pattensBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTitle(context),
              _buildInsulin(),
              _buildMedicine(),
            ],
          ),
        ),
      ),
    );
  }

  _buildMedicine() {
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
              L.current.medicine,
              style: AppTextStyle.t18w700(AppColors.regalBlue),
            ),
          ),
          _buildRow("Med 01", () {}),
          _buildRow("Med 02", () {}),
          _buildRow("Med 03", () {}),
        ],
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
              L.current.insulinMedicine,
              style: AppTextStyle.t22w700(AppColors.regalBlue),
            ),
          ),
        ],
      ),
    );
  }

  _buildInsulin() {
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
              L.current.insulin,
              style: AppTextStyle.t18w700(AppColors.regalBlue),
            ),
          ),
          _buildRow(
            L.current.rapidCactingInsulin,
            () {},
            color: AppColors.ochre,
          ),
          _buildRow(
            L.current.shortActingIsulin,
            () {},
            color: AppColors.buddhaGold,
          ),
          _buildRow(
            L.current.longActingIsulin,
            () {},
            color: AppColors.blueStone,
          ),
          _buildRow(
            L.current.intermediateActingInsulin,
            () {},
            color: AppColors.lightSeaGreen,
          ),
          _buildRow(
            L.current.mixedInsulin,
            () {},
            color: AppColors.summerSky,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, void Function()? action, {Color? color}) {
    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 25, top: 30, bottom: 30),
            ),
            if (color != null)
              Container(
                width: 13,
                height: 13,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                title,
                style: AppTextStyle.t18w700(AppColors.lightSlateGrey),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: action,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.lightSlateGrey,
              ),
            ),
          ],
        ),
        Container(
          height: 0.5,
          color: AppColors.lightSlateGrey,
        ),
      ],
    );
  }
}
