import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/today_input/binding/today_input_binding.dart';
import 'package:wecheck/screens/today_input/controller/today_input_controller.dart';
import 'package:wecheck/screens/today_input/today_input_models/condition_item.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/text_styles.dart';

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
              _title(),
              _divider(),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _conditionItem(ConditionItem condition, int index) {
    return Obx(() => InkWell(
          onTap: () {
            controller.onConditionTap(index);
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.conditions.value[index].backgroundColor,
                    border: Border.all(
                        width: 2,
                        color: controller.conditions.value[index].borderColor)),
                child: SvgPicture.asset(
                  condition.iconPath ?? "",
                  color: controller.conditions.value[index].itemColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(3),
                child: Text(
                  condition.label,
                  style: AppTextStyle.t14w700(
                      controller.conditions.value[index].textColor),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _condition() {
    Widget body = SizedBox(
        height: 200,
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _conditionItem(controller.conditions[index], index);
            },
            itemCount: controller.conditions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
            )));
    return _todayInputItem(L.current.condition, body);
  }

  Widget _time() {
    Widget body = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                L.current.dateAndTime,
                style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
              ),
              const Spacer(),
              Text(
                controller.DnTValue.value,
                style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
              ),
            ],
          ),
        ),
        _divider(),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                L.current.tag,
                style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
              ),
              const Spacer(),
              SvgPicture.asset("assets/icons/ic_event_drink_water.svg"),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Tag name",
                  style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return _todayInputItem(L.current.time, body);
  }

  Widget _itemRow(String pathIcon, String label, Widget detail, bool expanded) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset(pathIcon),
          ),
          Text(
            label,
            style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
          ),
          const Spacer(),
          detail,
          if (expanded)
            const Icon(
              Icons.chevron_right_outlined,
              color: itemTextColor,
            )
        ],
      ),
    );
  }

  Widget _detail(String? value, String? unit, {String? imagePath}) {
    return Row(
      children: [
        SizedBox(
            //color: Colors.red,
            width: 40,
            height: 40,
            child: imagePath != null
                ? Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  )
                : Container()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            value ?? "null",
            style: AppTextStyle.t22w700(valueTextColor),
          ),
        ),
        Text(
          unit ?? "null",
          style: AppTextStyle.t16w700(itemTextColor),
        )
      ],
    );
  }

  Widget _main() {
    Widget body = Column(
      children: [
        _itemRow("assets/icons/ic_event_drink_water.svg", "Blood Sugar",
            _detail("7.9", "%"), false),
        _divider(),
        _itemRow("assets/icons/ic_event_eat.svg", "Meal",
            _detail("3", "kcal", imagePath: "assets/images/meal.jpg"), true),
        _divider(),
        _itemRow("assets/icons/ic_event_inject_medicines.svg", "Insulin",
            _detail("3", "unit"), true),
        _divider(),
        _itemRow("assets/icons/ic_event_take_medicines.svg", "Medicine",
            _detail("2", "pills"), true),
      ],
    );
    return _todayInputItem("Main", body);
  }

  Widget _other() {
    Widget body = Column(
      children: [
        _itemRow("assets/icons/ic_event_drink_water.svg", "HbA1c",
            _detail("7.9", "%"), false),
        _divider(),
        _itemRow("assets/icons/ic_event_drink_water.svg", "Steps",
            _detail("6500", "steps"), false),
        _divider(),
        _itemRow("assets/icons/ic_event_drink_water.svg", "Blood Pressure",
            _detail("100", "mmhg"), false),
        _divider(),
        _itemRow("assets/icons/ic_event_drink_water.svg", "TIR",
            _detail("54", "%"), false),
        _divider(),
        _itemRow("assets/icons/ic_event_drink_water.svg", "Weight",
            _detail("75", "kg"), false),
      ],
    );
    return _todayInputItem("Other", body);
  }

  Widget _body() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _condition(),
            _divider(),
            _time(),
            _divider(),
            _main(),
            _divider(),
            _other(),
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
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.all(0),
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

  Widget _title() {
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
                child: const Icon(
                  Icons.cancel,
                  color: titleTextColor,
                ),
              ))
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
