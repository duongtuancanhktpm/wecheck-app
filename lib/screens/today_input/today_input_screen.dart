import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:wecheck/screens/today_input/binding/today_input_binding.dart';
import 'package:wecheck/screens/today_input/controller/today_input_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/text_styles.dart';

class TodayInputScreen extends GetView<TodayInputController> {
  static const Color titleTextColor = AppColors.textRegalBlue;
  static const Color itemTextColor = AppColors.lightSlateGrey;
  static const Color valueTextColor = AppColors.ceruleanBlue;
  static const Color itemBackgrouncolor = AppColors.pattensBlue;

  // final TextStyle titleTextStyle =
  //     AppTextStyle.t18w700(AppColors.textRegalBlue);
  // final TextStyle AppTextStyle.t16w700(AppColors.lightSlateGrey) =
  //     AppTextStyle.t16w700(AppColors.lightSlateGrey);
  // final TextStyle AppTextStyle.t22w700(AppColors.ceruleanBlue) = AppTextStyle.t22w700(AppColors.ceruleanBlue);

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

  Widget _conditionItem(String iconPath, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: itemBackgrouncolor),
          child: SvgPicture.asset(
            iconPath,
            color: itemTextColor,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(3),
          child: Text(
            label,
            style: AppTextStyle.t14w700(AppColors.lightSlateGrey),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget _condition() {
    Widget body = SizedBox(
        height: 200,
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _conditionItem(controller.conditions[index].iconPath ?? "",
                  controller.conditions[index].label);
            },
            itemCount: controller.conditions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
            )));
    return _todayInputItem("Condition", body);
  }

  Widget _time() {
    Widget body = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                "Date & Time",
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
                "Tag",
                style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
              ),
              const Spacer(),
              const Icon(
                Icons.question_mark,
                color: itemTextColor,
              ),
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
    return _todayInputItem("Time", body);
  }

  Widget _itemRow(
      String pathIcon, String label, double value, String unit, bool expanded) {
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
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              value.toString(),
              style: AppTextStyle.t22w700(AppColors.ceruleanBlue),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              unit,
              style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
            ),
          ),
          if (expanded)
            const Icon(
              Icons.chevron_right_outlined,
              color: itemTextColor,
            )
        ],
      ),
    );
  }

  Widget _main() {
    Widget body = Column(
      children: [
        _itemRow("assets/icons/ic_event_drink_water.svg", "Blood Sugar", 155,
            "mg/dl", false),
        _divider(),
        _itemRow("assets/icons/ic_event_eat.svg", "Meal", 3, "kcal", true),
        _divider(),
        _itemRow("assets/icons/ic_event_inject_medicines.svg", "Insulin", 3,
            "unit", true),
        _divider(),
        _itemRow("assets/icons/ic_event_take_medicines.svg", "Medicine", 2,
            "pills", true),
      ],
    );
    return _todayInputItem("Main", body);
  }

  Widget _other() {
    Widget body = Column(
      children: [
        _itemRow(
            "assets/icons/ic_event_drink_water.svg", "HbA1c", 7.9, "%", false),
        _divider(),
        _itemRow("assets/icons/ic_event_drink_water.svg", "Steps", 6500,
            "steps", false),
        _divider(),
        _itemRow("assets/icons/ic_event_drink_water.svg", "Blood Pressure", 100,
            "mmhg", false),
        _divider(),
        _itemRow(
            "assets/icons/ic_event_drink_water.svg", "TIR", 54, "%", false),
        _divider(),
        _itemRow("assets/icons/ic_event_drink_water.svg", "Weight", 75.4, "kg",
            false),
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
                if (title == "Condition") const Icon(Icons.question_mark),
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
                "Today's Input",
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
