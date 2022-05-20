import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/vacancies.dart';
import 'package:wecheck/model/vacancies_calendar.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/dimens.dart';
import 'package:wecheck/theme/text_styles.dart';
import 'package:wecheck/utils/constants.dart';

class VacanciesWidget extends StatefulWidget {
  final VacanciesCalendar? vacanciesCalendar;

  const VacanciesWidget({Key? key, this.vacanciesCalendar}) : super(key: key);

  @override
  State<VacanciesWidget> createState() => _VacanciesWidgetState();
}

class _VacanciesWidgetState extends State<VacanciesWidget> {
  var isRotate = false;

  @override
  Widget build(BuildContext context) {
    if (widget.vacanciesCalendar == null) {
      return Container(
        height: 34.dp,
        color: AppColors.aliceBlue,
      );
    }
    var timeDisplay = Constant.nAn;
    if (widget.vacanciesCalendar!.dateReverse != null) {
      var timeReverse = DateFormat(Constant.fullDataFormat).parse(
        widget.vacanciesCalendar!.dateReverse!,
      );
      timeDisplay = DateFormat(Constant.monthSuffixDateFormat).format(
        timeReverse,
      );
    }
    return Container(
      color: AppColors.aliceBlue,
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 5,
                child: Text(
                  timeDisplay,
                  style: AppTextStyle.t14w700(AppColors.lightSlateGrey),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "${widget.vacanciesCalendar?.vacancies?.length} ${L.current.vacancies.tr}",
                  textAlign: TextAlign.end,
                  style: AppTextStyle.t14w700(AppColors.lightSlateGrey),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isRotate = !isRotate;
                    });
                  },
                  child: isRotate
                      ? const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppColors.lightSlateGrey,
                        )
                      : const Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: AppColors.lightSlateGrey,
                        ),
                ),
              ),
              SizedBox(
                width: 10.dp,
              ),
            ],
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isRotate
                ? _buildListVacancies(widget.vacanciesCalendar!.vacancies)
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildListVacancies(List<Vacancies>? vacancies) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
        );
      },
      itemCount: vacancies?.length ?? 0,
      itemBuilder: (context, index) => _buildItemVacancies(
        vacancies?[index],
      ),
    );
  }

  Widget _buildItemVacancies(Vacancies? vacancies) {
    if (vacancies == null) {
      return Container(
        height: 64.dp,
        color: Colors.white,
        child: const Text(""),
      );
    }
    var startTimeDisplay = Constant.nAn;
    if (vacancies.startTime != null) {
      var startTime = DateFormat(Constant.fullDataFormat).parse(
        vacancies.startTime!,
      );
      startTimeDisplay = DateFormat.Hm().format(startTime);
    }
    var endTimeDisplay = Constant.nAn;
    if (vacancies.endTime != null) {
      var endTime = DateFormat(Constant.fullDataFormat).parse(
        vacancies.endTime!,
      );
      endTimeDisplay = DateFormat.Hm().format(endTime);
    }
    return Container(
      height: 64.dp,
      color: Colors.white,
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "$startTimeDisplay - $endTimeDisplay",
                style: AppTextStyle.t18w700(AppColors.catalinaBlue),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(onPressed: () {

              }, child: Text(L.current.reserve.tr),),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
