import 'package:flutter/material.dart';
import 'package:wecheck/theme/colors.dart';


enum Condition{
  HightBloodSugar,
  LowBloodSugar,
  SickDay,
  Sports,
  WokeUp,
  Bath,
  Sleep,
  ARE
}

class ConditionItem{
  late String label;
  //late IconData icon;
  String? iconPath = "";
  late Color backgroundColor;
  late Color itemColor;
  late Color borderColor;
  late Color textColor;
  Map<Condition, String> conditionLabel = {
    Condition.HightBloodSugar: "Hight Blood Sugar",
    Condition.LowBloodSugar: "Low Blood Sugar",
    Condition.SickDay: "SickDay",
    Condition.Sports: "Sports",
    Condition.WokeUp: "WokeUp",
    Condition.Bath: "Bath",
    Condition.Sleep: "Sleep",
    Condition.ARE: "ARE",
  };
  Map<Condition, String> conditionIconPath = {
    Condition.HightBloodSugar: "assets/icons/ic_event_stress_fill.svg",
    Condition.LowBloodSugar: "assets/icons/ic_event_stress_stroke.svg",
    Condition.SickDay: "assets/icons/ic_event_mask.svg",
    Condition.Sports: "assets/icons/ic_event_running.svg",
    Condition.WokeUp: "assets/icons/ic_event_running.svg",
    Condition.Bath: "assets/icons/ic_event_running.svg",
    Condition.Sleep: "assets/icons/ic_event_running.svg",
    Condition.ARE: "assets/icons/ic_event_running.svg",
  };


  List<ConditionItem> getConditions(){
    List<ConditionItem> list = [];
    conditionLabel.forEach((key, value) {
      ConditionItem newItem = ConditionItem();
      newItem.label = value;
      newItem.iconPath = conditionIconPath[key];
      newItem.itemColor = AppColors.lightSlateGrey;
      newItem.borderColor = AppColors.pattensBlue;
      newItem.textColor = AppColors.lightSlateGrey;
      newItem.backgroundColor = AppColors.pattensBlue;
      list.add(newItem);
    });

    return list;
  }
}