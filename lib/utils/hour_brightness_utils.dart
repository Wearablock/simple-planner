import 'package:simple_planner/constants/app_constants.dart';
import 'package:flutter/material.dart';

class HourBrightnessUtils {
  HourBrightnessUtils._();

  // Blue 500 기준 색상 팔레트
  static const List<Color> _hourColors = [
    AppColors.blue100, // 00시
    AppColors.blue100, // 01시
    AppColors.blue200, // 02시
    AppColors.blue200, // 03시
    AppColors.blue300, // 04시
    AppColors.blue300, // 05시
    AppColors.blue400, // 06시
    AppColors.blue400, // 07시
    AppColors.blue400, // 08시
    AppColors.blue500, // 09시 (기준)
    AppColors.blue500, // 10시
    AppColors.blue500, // 11시
    AppColors.blue500, // 12시
    AppColors.blue500, // 13시
    AppColors.blue400, // 14시
    AppColors.blue400, // 15시
    AppColors.blue400, // 16시
    AppColors.blue300, // 17시
    AppColors.blue300, // 18시
    AppColors.blue200, // 19시
    AppColors.blue200, // 20시
    AppColors.blue100, // 21시
    AppColors.blue100, // 22시
    AppColors.blue100, // 23시
  ];

  /// 시간대별 배경색
  static Color getColor(int hour) {
    return _hourColors[hour.clamp(0, 23)];
  }

  /// 텍스트 색상 (배경 밝기에 따라 조정)
  static Color getOnColor(int hour) {
    // Blue 500 (09~13시)은 배경이 진해서 흰색 텍스트
    if (hour >= 9 && hour <= 13) {
      return AppColors.white;
    }
    // Blue 400 (06~08시, 14~16시)도 흰색 텍스트
    if ((hour >= 6 && hour <= 8) || (hour >= 14 && hour <= 16)) {
      return AppColors.white;
    }
    // 나머지는 어두운 파란색 텍스트
    return AppColors.blue800;
  }
}
