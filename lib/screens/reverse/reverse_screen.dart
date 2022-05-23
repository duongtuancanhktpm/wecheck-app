import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/reverse.dart';
import 'package:wecheck/screens/reverse/controller/reverse_controller.dart';
import 'package:wecheck/screens/reverse/widget/vacancies.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/dimens.dart';
import 'package:wecheck/theme/text_styles.dart';
import 'package:wecheck/utils/constants.dart';

class ReverseScreen extends StatelessWidget {
  ReverseScreen({Key? key}) : super(key: key);

  var controller = Get.put(ReverseController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var reverseHospital = controller.hospitalReverse.toList();
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildItemReverseHospital(reverseHospital[index]);
          },
          itemCount: reverseHospital.length,
        );
      },
    );
  }

  Widget _buildItemReverseHospital(HospitalReverse hospitalReverse) {
    return Container(
      margin: EdgeInsets.only(left: 20.dp, right: 20.dp, top: 20.dp,),
      padding: EdgeInsets.only(bottom: 10.dp,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.dp,),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.hawkesBlue,
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeaderItem(hospitalReverse),
          const Divider(color: AppColors.lightSlateGrey, height: 1,),
          _buildBodyItem(hospitalReverse),
          const Divider(color: AppColors.lightSlateGrey, height: 1,),
        ],
      ),
    );
  }

  Widget _buildBodyItem(HospitalReverse hospitalReverse) {
    var vacanciesList = hospitalReverse.vacancies;
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider(height: 1, color: AppColors.lightSlateGrey,);
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vacanciesList?.length ?? 0,
      itemBuilder: (context, index) => VacanciesWidget(
        vacanciesCalendar: vacanciesList?[index],
      ),
    );
  }

  Widget _buildHeaderItem(HospitalReverse hospitalReverse) {
    String dateTimeDisplay = Constant.nAn;
    if (hospitalReverse.lastTimeReverse != null) {
      var dateTime = DateFormat(Constant.fullDataFormat).parse(
        hospitalReverse.lastTimeReverse!,
      );
      dateTimeDisplay = DateFormat(Constant.daySuffixDateFormat).format(dateTime);
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.dp,),
      child: Row(
        children: [
          SizedBox(
            width: 20.dp,
          ),
          _buildAvatar(hospitalReverse.imageUrl),
          SizedBox(
            width: 20.dp,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  hospitalReverse.name ?? "",
                  style: AppTextStyle.t18w700(AppColors.catalinaBlue),
                ),
                Text(
                  "${L.current.lastReverseTime} $dateTimeDisplay",
                  style: AppTextStyle.t14w400(AppColors.lightSlateGrey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAvatar(String? imageUrl) {
    if (imageUrl == null) {
      return Container(
        width: 62.dp,
        height: 62.dp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.lightSlateGrey),
        child: const Text(""),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        imageUrl,
        width: 62.dp,
        height: 62.dp,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }
}
