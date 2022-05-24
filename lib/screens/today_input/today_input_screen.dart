import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/today_input_data.dart';
import 'package:wecheck/screens/today_input/binding/today_input_binding.dart';
import 'package:wecheck/screens/today_input/controller/today_input_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';

class TodayInputScreen extends GetView<TodayInputController> {
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
              const Divider(
                thickness: 2,
              ),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                L.current.todayInputTitle,
                style: AppTextStyle.t22w700(AppColors.textRegalBlue),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.cancel_outlined,
                color: AppColors.textRegalBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    List<Widget> todayInputs = [
      _buildTodayInputItem(L.current.condition, _buildConditions()),
      _buildTodayInputItem(
          L.current.time, Obx(() => _buildListRow(controller.time.value))),
      _buildTodayInputItem(
          L.current.main, Obx(() => _buildListRow(controller.main.value))),
      _buildTodayInputItem(
          L.current.other, Obx(() => _buildListRow(controller.other.value))),
    ];
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 2,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return todayInputs[index];
        },
        itemCount: todayInputs.length,
      ),
    );
  }

  Widget _buildListRow(List<dynamic> rows) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return (_buildRow(rows[index]));
      },
      itemCount: rows.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 2,
        );
      },
    );
  }

  Widget _buildRow(InputRow rowData) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          if (rowData.firstIcon != null)
            Container(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(rowData.firstIcon ?? ""),
            ),
          Text(
            rowData.title ?? "",
            style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
          ),
          const Spacer(),
          if (rowData.picture != null)
            SizedBox(
              //color: Colors.red,
              width: 40,
              height: 40,
              child: Image.asset(
                rowData.picture ?? "",
                fit: BoxFit.contain,
              ),
            ),
          if (rowData.icon != null)
            Container(
              padding: const EdgeInsets.only(right: 15),
              width: 40,
              height: 40,
              child: SvgPicture.asset(
                rowData.icon ?? "",
                color: AppColors.lightSlateGrey,
              ),
            ),
          if (rowData.value != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                rowData.value ?? "",
                style: AppTextStyle.t22w700(AppColors.ceruleanBlue),
              ),
            ),
          Text(
            rowData.unit ?? "",
            style: AppTextStyle.t16w700(AppColors.lightSlateGrey),
          ),
          if (rowData.expanded == true)
            const Icon(
              Icons.chevron_right_outlined,
              color: AppColors.lightSlateGrey,
            ),
        ],
      ),
    );
  }

  Widget _buildConditionItem(ConditionItem condition, int index) {
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
                color: AppColors.pattensBlue,
                border: Border.all(width: 2, color: AppColors.pattensBlue)),
            child: SvgPicture.asset(
              condition.icon,
              color: AppColors.lightSlateGrey,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(3),
            child: Text(
              condition.label,
              style: AppTextStyle.t14w700(AppColors.lightSlateGrey),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditions() {
    return SizedBox(
      height: 220,
      child: Obx(
        () => GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _buildConditionItem(
                controller.conditionList.value[index], index);
          },
          itemCount: controller.conditionList.value.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
          ),
        ),
      ),
    );
  }

  Widget _buildTodayInputItem(String title, Widget body) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
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
                        border: Border.all(color: AppColors.lightSlateGrey)),
                    child: const Icon(
                      Icons.question_mark,
                      color: AppColors.lightSlateGrey,
                    ),
                  ),
              ],
            ),
          ),
          body,
        ],
      ),
    );
  }
}
