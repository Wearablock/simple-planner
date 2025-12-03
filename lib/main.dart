import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      supportedLocales: const [Locale('en'), Locale('ko')],
      localeResolutionCallback: (locale, supportedLocales) {
        // 지원하는 언어인 경우 해당 언어 사용
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        // 지원하지 않는 언어인 경우 영어를 기본값으로 사용
        return const Locale('en');
      },
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
