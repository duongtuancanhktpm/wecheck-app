import 'dart:math';
import 'package:get/get.dart';

class Dimens {
  // iphoneX screen size
  static const _defaultScreenWidth = 375.0;
  static const _defaultScreenHeight = 812.0;
  static double _ratio = 0.0;

  static double get _getRatio {
    if (!_ratio.isEqual(0.0)) {
      return _ratio;
    }

    double ratioWidth = Get.width / _defaultScreenWidth;
    double ratioHeight = Get.height / _defaultScreenHeight;
    _ratio = ratioWidth >= ratioHeight ? ratioWidth : ratioHeight;
    _ratio = min(1, _ratio);
    return _ratio;
  }

  static double dimen(double value) => value * _getRatio;
}

extension Dimensions on num {
  double get dp => Dimens.dimen(toDouble());
}
