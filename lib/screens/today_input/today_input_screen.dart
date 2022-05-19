import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/condition_list_data.dart';
import 'package:wecheck/screens/today_input/binding/today_input_binding.dart';
import 'package:wecheck/screens/today_input/controller/today_input_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';
import 'package:wecheck/utils/constants.dart';

class TodayInputScreen extends GetView<TodayInputController> {
  static const Color titleTextColor = AppColors.textRegalBlue;
  static const Color itemTextColor = AppColors.lightSlateGrey;
  static const Color valueTextColor = AppColors.ceruleanBlue;
  static const Color itemBackgrouncolor = AppColors.pattensBlue;

  const TodayInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodayInputBinding().dependencies();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              _buildTitle(),
              _divider(),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConditionItem(ConditionInput condition, int index) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: itemBackgrouncolor,
                border: Border.all(width: 2, color: itemBackgrouncolor)),
            child: SvgPicture.asset(
              condition.icon,
              color: itemTextColor,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(3),
            child: Text(
              condition.label,
              style: AppTextStyle.t14w700(itemTextColor),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCondition() {
    Widget body = SizedBox(
        height: 220,
        child: Obx(() => GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _buildConditionItem(controller.conditions1[index], index);
            },
            itemCount: controller.conditions1.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
            ))));
    return _todayInputItem(L.current.condition, body);
  }

  Widget _buildTime() {
    Widget body = Column(
      children: [
        _itemRow(
            label: L.current.dateAndTime,
            unit: controller.dateAndTimeFormated.value),
        _divider(),
        _itemRow(
          label: L.current.tag,
          icon: controller.tagItem.icon,
          unit: controller.tagItem.tagName,
        )
      ],
    );
    return _todayInputItem(L.current.time, body);
  }

  Widget _buildMain() {
    Widget body = Column(
      children: [
        _itemRow(
            pathIcon: AppIcons.icEventDrinkWater,
            label: L.current.bloodSugar,
            value: null,
            unit: Constant.bloodSugarUnit,
            initial: controller.initial),
        _divider(),
        _itemRow(
          pathIcon: AppIcons.icEventEat,
          label: L.current.meals,
          unit: Constant.mealsUnit,
          expanded: true,
          initial: controller.initial,
        ),
        _divider(),
        _itemRow(
          pathIcon: AppIcons.icEventInject,
          label: L.current.insulin,
          unit: Constant.insulinUnit,
          expanded: true,
          initial: controller.initial,
        ),
        _divider(),
        _itemRow(
          pathIcon: AppIcons.icEventTakeMedicines,
          label: L.current.medicine,
          unit: Constant.medicineUnit,
          expanded: true,
          initial: controller.initial,
        ),
      ],
    );
    return _todayInputItem(L.current.main, body);
  }

  Widget _buildOther() {
    Widget body = Column(
      children: [
        _itemRow(
            pathIcon: AppIcons.icEventDrinkWater,
            label: L.current.a1c,
            unit: Constant.a1cUnit,
            initial: controller.initial),
        _divider(),
        _itemRow(
            pathIcon: AppIcons.icEventDrinkWater,
            label: L.current.steps,
            unit: Constant.stepUnit,
            initial: controller.initial),
        _divider(),
        _itemRow(
            pathIcon: AppIcons.icEventDrinkWater,
            label: L.current.bloodPressure,
            unit: Constant.bloodPresureUnit,
            initial: controller.initial),
        _divider(),
        _itemRow(
            pathIcon: AppIcons.icEventDrinkWater,
            label: L.current.tir,
            unit: Constant.tirUnit,
            initial: controller.initial),
        _divider(),
        _itemRow(
            pathIcon: AppIcons.icEventDrinkWater,
            label: L.current.weight,
            unit: Constant.weightUnit,
            initial: controller.initial),
      ],
    );
    return _todayInputItem("Other", body);
  }

  _buildTitle() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                L.current.todayInputTitle,
                style: AppTextStyle.t22w700(titleTextColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Positioned(
              right: 0,
              child: InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  AppIcons.icEdit,
                  color: titleTextColor,
                ),
              ))
        ],
      ),
    );
  }

  _body() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCondition(),
            _divider(),
            _buildTime(),
            _divider(),
            _buildMain(),
            _divider(),
            _buildOther(),
          ],
        ),
      ),
    );
  }

  Widget _todayInputItem(String title, Widget body) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.t18w700(AppColors.textRegalBlue),
                ),
                const Spacer(),
                if (title == "Condition")
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: itemTextColor)),
                      child: const Icon(Icons.question_mark)),
              ])),
          body,
        ],
      ),
    );
  }

  Widget _itemRow(
      {String? pathIcon,
      String? label,
      String? picture,
      String? icon,
      String? value,
      String? unit,
      bool? expanded,
      bool? initial}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          if (pathIcon != null)
            Container(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(pathIcon),
            ),
          Text(
            label ?? "",
            style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
          ),
          const Spacer(),
          if (picture != null)
            SizedBox(
                //color: Colors.red,
                width: 40,
                height: 40,
                child: Image.asset(
                  picture,
                  fit: BoxFit.contain,
                )),
          if (icon != null)
            Container(
                padding: const EdgeInsets.only(right: 15),
                width: 40,
                height: 40,
                child: SvgPicture.asset(
                  icon,
                  color: itemTextColor,
                )),
          if (value != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                value,
                style: AppTextStyle.t22w700(valueTextColor),
              ),
            ),
          if (initial == true)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                "-",
                style: AppTextStyle.t22w700(itemTextColor),
              ),
            ),
          Text(
            unit ?? "null",
            style: AppTextStyle.t16w700(itemTextColor),
          ),
          if (expanded == true)
            const Icon(
              Icons.chevron_right_outlined,
              color: itemTextColor,
            )
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      color: titleTextColor,
      height: 2,
      thickness: 0.3,
    );
  }
}
