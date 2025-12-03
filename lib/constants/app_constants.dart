import 'package:flutter/material.dart';

/// 앱 전반에서 사용되는 상수들
class AppConstants {
  AppConstants._();

  // 시간 관련
  static const int hoursInDay = 24;
  static const int calendarYearRange = 5;

  // 레이아웃 관련
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double tinyPadding = 4.0;
  static const double mediumPadding = 12.0;

  // 테두리 반경
  static const double smallBorderRadius = 8.0;
  static const double defaultBorderRadius = 12.0;
  static const double largeBorderRadius = 16.0;

  // 아이콘 크기
  static const double smallIconSize = 16.0;
  static const double defaultIconSize = 20.0;
  static const double largeIconSize = 24.0;

  // 폰트 크기
  static const double smallFontSize = 12.0;
  static const double defaultFontSize = 14.0;
  static const double largeFontSize = 18.0;
  static const double extraLargeFontSize = 36.0;

  // 시간 선택기 관련
  static const double hourPickerHeight = 200.0;
  static const double hourPickerWidth = 100.0;
  static const double hourPickerItemExtent = 50.0;
  static const double hourPickerPerspective = 0.005;
  static const double hourPickerDiameterRatio = 1.2;

  // 요일 선택기 관련
  static const double weekdayButtonSize = 32.0;

  // 투명도
  static const double lowOpacity = 0.1;
  static const double mediumOpacity = 0.3;
  static const double highOpacity = 0.7;

  // Snackbar 지속 시간
  static const Duration snackBarDuration = Duration(seconds: 2);
}

/// 앱 전반에서 사용되는 색상들
class AppColors {
  AppColors._();

  static const Color scaffoldBackground = Color(0xFFF5F5F5); // Colors.grey[100]
  static Color get greyBackground => Colors.grey[200]!;
  static Color get greyBorder => Colors.grey[300]!;
  static Color get greyText => Colors.grey[600]!;
  static Color get darkGreyText => Colors.grey[700]!;
  static Color get lightGreyIcon => Colors.grey[400]!;
}
