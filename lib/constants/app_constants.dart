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

  // ===== Blue 테마 색상 =====
  static const Color primary = Color(0xFF2196F3); // Blue 500
  static const Color primaryLight = Color(0xFF64B5F6); // Blue 300
  static const Color primaryDark = Color(0xFF1565C0); // Blue 800

  // Blue 팔레트 (시간대별 배경 등)
  static const Color blue50 = Color(0xFFE3F2FD);
  static const Color blue100 = Color(0xFFBBDEFB);
  static const Color blue200 = Color(0xFF90CAF9);
  static const Color blue300 = Color(0xFF64B5F6);
  static const Color blue400 = Color(0xFF42A5F5);
  static const Color blue500 = Color(0xFF2196F3);
  static const Color blue800 = Color(0xFF1565C0);
  static const Color blue900 = Color(0xFF0D47A1);

  // ===== 상태 색상 =====
  static const Color success = Color(0xFF4CAF50); // Green 500
  static const Color error = Color(0xFFF44336); // Red 500
  static const Color warning = Color(0xFFFF9800); // Orange 500

  // ===== Grey 색상 =====
  static const Color scaffoldBackground = Color(0xFFF5F5F5); // Grey 100
  static const Color greyBackground = Color(0xFFEEEEEE); // Grey 200
  static const Color greyBorder = Color(0xFFE0E0E0); // Grey 300
  static const Color greyLight = Color(0xFFBDBDBD); // Grey 400
  static const Color grey = Color(0xFF9E9E9E); // Grey 500
  static const Color greyText = Color(0xFF757575); // Grey 600
  static const Color darkGreyText = Color(0xFF616161); // Grey 700
  static const Color greyDark = Color(0xFF424242); // Grey 800

  // ===== 기본 색상 =====
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // ===== 카드 색상 =====
  static const Color cardBlueWhite = Color(0xFFF8FBFF); // 약간 푸른빛 흰색
}
