import 'package:flutter/material.dart';

class HourBrightnessUtils {
  HourBrightnessUtils._();

  static const Color _baseColor = Colors.blue;

  /// 00시: 가장 밝음 (shade 200) → 23시: 가장 어두움 (shade 900)
  static Color getColor(int hour) {
    // 0~23시를 shade 200~900 범위로 매핑
    // shade 값: 200, 300, 400, 500, 600, 700, 800, 900 (8단계)
    final int shadeValue = 200 + ((hour / 23) * 700).round();

    // 100 단위로 반올림
    final int roundedShade = ((shadeValue / 100).round() * 100).clamp(200, 900);

    return Colors.blue[roundedShade]!;
  }

  /// 텍스트 색상 (밝은 배경에서는 어두운 텍스트, 어두운 배경에서는 밝은 텍스트)
  static Color getOnColor(int hour) {
    // shade 400 이하 (약 0~6시)는 배경이 밝아서 어두운 텍스트 필요
    if (hour <= 6) {
      return Colors.blue.shade900;
    }
    return Colors.white;
  }
}
