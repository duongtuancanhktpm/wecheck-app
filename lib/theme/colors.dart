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

  static const Color lightSlateGrey = Color.fromRGBO(125, 136, 152, 1);
  static const Color catalinaBlue = Color.fromRGBO(33, 53, 80, 1);
  static const Color aliceBlue = Color.fromRGBO(234, 238, 240, 1);
  static const Color hawkesBlue = Color.fromRGBO(212, 216, 222, 1);
  static const Color lightStaleGrey2 = Color.fromRGBO(124, 135, 153, 1);
  static const Color aliceBlue2 = Color.fromRGBO(245, 246, 247, 1);
  static const Color ceruleanBlue = Color.fromRGBO(40, 89, 176, 1);

  static const Color magicMint = Color(0xFF1B3553);
  static const Color colorDarkGrey = Color(0xFFB1B1B1);
  static const Color textRegalBlue = Color(0xFF1B3553);
  static const Color colorCeruleanBlue = Color(0xFF2A61B9);
  static const Color colorGrey = Color(0xFF848484);
  static const Color colorHawkesBlue = Color(0xFFD8DEE6);
  static const Color colorPattensBlue = Color(0xFFE9EEF0);
  static const Color colorJungleGreen = Color(0xFF24AB82);
  static const Color colorCatalinaBlue = Color(0xFF243D5A);
  static const Color pattensBlue = Color(0xFFE9EEF0);
  static const Color regalBlue = Color(0xFF1B3553);
  static const Color buddhaGold = Color(0xFFBC9920);
  static const Color blueStone = Color(0xFF14645E);
  static const Color ochre = Color(0xFFCB7D1C);
  static const Color lightSeaGreen = Color(0xFF2FB0B6);
  static const Color summerSky = Color(0xFF3B9BEC);
  static const Color solitude = Color(0xFFE6EEF8);
}