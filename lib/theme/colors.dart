import 'package:flutter/material.dart';

/// Named color based on https://www.htmlcsscolor.com/
class AppColors {
  static const black = Colors.black;
  static const black45 = Colors.black45;
  static const white = Colors.white;
  static const transparent = Colors.transparent;
  static Color? grey350 = Colors.grey[350];
  static Color? grey600 = Colors.grey[600];
  static Color? grey400 = Colors.grey[400];
  static const grey = Colors.grey;
  static const red = Colors.red;

  static Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex = '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  static const Color labelColor = Color.fromRGBO(125, 136, 152, 1);
  static const Color labelSelectedColor = Color.fromRGBO(33, 53, 80, 1);
  static const Color appBarColor = Color.fromRGBO(234, 238, 240, 100);
  static const Color previousMonthColor = Color.fromRGBO(212, 216, 222, 1);
  static const Color currentMonthColor = Color.fromRGBO(124, 135, 153, 1);
  static const Color todayColor = Color.fromRGBO(245, 246, 247, 1);
  static const Color eventLabelColor = Color.fromRGBO(40, 89, 176, 1);
}
