import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/home/blood_sugar_model.dart';
import 'package:wecheck/model/home/insulin_model.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/dimens.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';

class BloodSugarDialog extends StatefulWidget {
  List<BloodSugarEntity> insulinEntity;

  BloodSugarDialog({
    required this.insulinEntity,
  });

  @override
  _InsulinDialogState createState() => _InsulinDialogState();
}

class _InsulinDialogState extends State<BloodSugarDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 160.dp, right: 160.dp, top: 30, bottom: 20),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          toolbarHeight: 40,
          backgroundColor: AppColors.colorPattensBlue,
          leadingWidth: 140,
          leading: Container(
            alignment: Alignment.center,
            child: Text(
              L.current.bloodSugar,
              style: AppTextStyle.t8w700(),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: Text('April 10', style: AppTextStyle.t8w700()),
            )
          ],
        ),
        backgroundColor: AppColors.transparent,
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.insulinEntity.length,
            itemBuilder: (BuildContext context, int index) {
              var insulinIndex = widget.insulinEntity[index];
              return _itemBloodSugarDialog(insulinIndex);
            }),
      ),
    );
  }

  Widget _itemBloodSugarDialog(BloodSugarEntity insulinEntity) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.colorHawkesBlue))),
        child: ListTile(
          leading: SvgPicture.asset(
            AppIcons.icEventDrinkWater,
            width: 25.dp,
            height: 25.dp,
          ),
          title: Text(
            '145',
            style: AppTextStyle.t12w700(AppColors.colorCeruleanBlue),
          ),
          subtitle: Text(
            L.current.mgDL,
            style: AppTextStyle.t8w700(AppColors.colorGrey),
          ),
          trailing: Text(
            '20:22',
            style: AppTextStyle.t8w700(AppColors.colorGrey),
          ),
        ));
  }
}
