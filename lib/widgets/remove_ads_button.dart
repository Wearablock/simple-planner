import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/services/purchase_service.dart';

class RemoveAdsButton extends StatelessWidget {
  const RemoveAdsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: PurchaseService(),
      builder: (context, _) {
        final purchaseService = PurchaseService();

        // 광고 제거됨 → 구매 복원 표시
        if (purchaseService.isAdFree) {
          return ListTile(
            leading: PhosphorIcon(
              PhosphorIcons.arrowCounterClockwise(PhosphorIconsStyle.light),
            ),
            title: Text(l10n.restorePurchase),
            subtitle: Text(l10n.restorePurchaseDesc),
            onTap: () => _handleRestore(context),
          );
        }

        if (purchaseService.status == AdPurchaseState.pending) {
          return ListTile(
            leading: const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            title: Text(l10n.processing),
          );
        }

        // 광고 제거 안됨 → 광고 제거 버튼 표시
        return ListTile(
          leading: PhosphorIcon(
            PhosphorIcons.prohibit(PhosphorIconsStyle.light),
          ),
          title: Text(l10n.removeAds),
          subtitle: Text(purchaseService.priceString),
          trailing: FilledButton(
            onPressed: () => _handlePurchase(context),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.warning,
            ),
            child: Text(l10n.purchase),
          ),
        );
      },
    );
  }

  Future<void> _handlePurchase(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final purchaseService = PurchaseService();
    final success = await purchaseService.purchaseRemoveAds();

    if (!success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(purchaseService.errorMessage ?? l10n.purchaseError),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _handleRestore(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final purchaseService = PurchaseService();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(l10n.checkingPurchase),
          ],
        ),
      ),
    );

    await purchaseService.restorePurchases();

    if (context.mounted) {
      Navigator.of(context).pop();

      if (purchaseService.isAdFree) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.purchaseRestored),
            backgroundColor: AppColors.success,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.noPurchaseToRestore)),
        );
      }
    }
  }
}
