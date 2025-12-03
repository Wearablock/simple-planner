import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import '../widgets/remove_ads_button.dart';
import 'webview_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          const RemoveAdsButton(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: Colors.grey),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l10n.termsOfService),
            onTap: () => _openTermsOfService(context),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l10n.privacyPolicy),
            onTap: () => _openPrivacyPolicy(context),
          ),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              final version = snapshot.hasData
                  ? '${snapshot.data!.version}'
                  : '';
              return ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.versionInfo),
                trailing: Text(
                  version,
                  style: const TextStyle(color: Colors.grey),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _openTermsOfService(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          title: l10n.termsOfService,
          url: 'https://example.com/terms', // TODO: 실제 URL로 변경
        ),
      ),
    );
  }

  void _openPrivacyPolicy(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          title: l10n.privacyPolicy,
          url: 'https://example.com/privacy', // TODO: 실제 URL로 변경
        ),
      ),
    );
  }
}
