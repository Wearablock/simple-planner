import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/database/database.dart';
import 'package:simple_planner/screens/home_screen.dart';
import 'package:simple_planner/services/ad_service.dart';
import 'package:simple_planner/services/purchase_service.dart';

late AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();

  await PurchaseService().initialize();

  await AdService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
        Locale('ja'),
        Locale('zh'), // 简体中文
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), // 繁體中文
        Locale('es'), // Español
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // 정확히 일치하는 locale 찾기 (언어 + scriptCode + 국가 코드)
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.scriptCode == locale?.scriptCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        // 번체 중국어 처리 (zh-TW, zh-HK 등은 zh_Hant로 매핑)
        if (locale?.languageCode == 'zh') {
          final isTraditional = locale?.scriptCode == 'Hant' ||
              locale?.countryCode == 'TW' ||
              locale?.countryCode == 'HK' ||
              locale?.countryCode == 'MO';
          if (isTraditional) {
            return const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant');
          }
          return const Locale('zh');
        }
        // 언어 코드만 일치하는 locale 찾기
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        // 지원하지 않는 언어인 경우 영어를 기본값으로 사용
        return const Locale('en');
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          onPrimary: AppColors.white,
          secondary: AppColors.primaryLight,
          onSecondary: AppColors.blue900,
          surface: AppColors.white,
          onSurface: AppColors.greyDark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          displayLarge: GoogleFonts.poppins(fontWeight: FontWeight.w200),
          displayMedium: GoogleFonts.poppins(fontWeight: FontWeight.w200),
          displaySmall: GoogleFonts.poppins(fontWeight: FontWeight.w200),
          headlineLarge: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          headlineMedium: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          headlineSmall: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          bodyLarge: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          bodyMedium: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          bodySmall: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          labelMedium: GoogleFonts.poppins(fontWeight: FontWeight.w300),
          labelSmall: GoogleFonts.poppins(fontWeight: FontWeight.w300),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
