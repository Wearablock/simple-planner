import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import '../widgets/remove_ads_button.dart';
import 'webview_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 24),
                // 로고
                Center(
                  child: Image.asset(
                    'assets/icon/app_icon_small.png',
                    width: 72,
                    height: 72,
                  ),
                ),
                const SizedBox(height: 12),
                // 앱 이름
                Center(
                  child: Text(
                    'Simple Planner',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      color: AppColors.greyDark,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const RemoveAdsButton(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: AppColors.grey),
                ),
                ListTile(
                  leading: PhosphorIcon(
                    PhosphorIcons.fileText(PhosphorIconsStyle.light),
                  ),
                  title: Text(l10n.termsOfService),
                  onTap: () => _openTermsOfService(context),
                ),
                ListTile(
                  leading: PhosphorIcon(
                    PhosphorIcons.shieldCheck(PhosphorIconsStyle.light),
                  ),
                  title: Text(l10n.privacyPolicy),
                  onTap: () => _openPrivacyPolicy(context),
                ),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    final version =
                        snapshot.hasData ? snapshot.data!.version : '';
                    return ListTile(
                      leading: PhosphorIcon(
                        PhosphorIcons.info(PhosphorIconsStyle.light),
                      ),
                      title: Text(l10n.versionInfo),
                      trailing: Text(
                        version,
                        style: TextStyle(color: AppColors.grey),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // 회사명 (하단 고정)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              'Wearablock INC.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getUrlLangCode(BuildContext context) {
    final locale = Localizations.localeOf(context);
    // 번체 중국어 처리 (scriptCode가 Hant인 경우)
    if (locale.languageCode == 'zh' && locale.scriptCode == 'Hant') {
      return 'zh-Hant';
    }
    // 포르투갈어 처리 (pt -> pt-BR)
    if (locale.languageCode == 'pt') {
      return 'pt-BR';
    }
    return locale.languageCode;
  }

  void _openTermsOfService(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langCode = _getUrlLangCode(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          title: l10n.termsOfService,
          url: 'https://wearablock.github.io/simple-planner/terms.html#$langCode',
        ),
      ),
    );
  }

  void _openPrivacyPolicy(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langCode = _getUrlLangCode(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          title: l10n.privacyPolicy,
          url: 'https://wearablock.github.io/simple-planner/privacy.html#$langCode',
        ),
      ),
    );
  }
}
