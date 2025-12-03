import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/screens/settings_screen.dart';
import 'package:simple_planner/services/purchase_service.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: PurchaseService(),
      builder: (context, _) {
        final isAdFree = PurchaseService().isAdFree;

        return GestureDetector(
          onTap: () => _openSettings(context),
          child: Padding(
            padding: const EdgeInsets.only(right: AppConstants.defaultPadding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                PhosphorIcon(
                  PhosphorIcons.gear(PhosphorIconsStyle.light),
                  size: AppConstants.largeIconSize,
                ),
                if (!isAdFree)
                  Positioned(
                    right: -8,
                    bottom: -12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        l10n.removeAds,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }
}
