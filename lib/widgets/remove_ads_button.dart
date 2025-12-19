import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/services/purchase_service.dart';

String _getErrorMessage(AppLocalizations l10n, PurchaseErrorType errorType) {
  switch (errorType) {
    case PurchaseErrorType.none:
      return '';
    case PurchaseErrorType.storeUnavailable:
      return l10n.errorStoreUnavailable;
    case PurchaseErrorType.loadProductFailed:
      return l10n.errorLoadProduct;
    case PurchaseErrorType.productNotFound:
      return l10n.errorProductNotFound;
    case PurchaseErrorType.noProductInfo:
      return l10n.errorNoProductInfo;
    case PurchaseErrorType.alreadyPurchased:
      return l10n.errorAlreadyPurchased;
    case PurchaseErrorType.purchaseFailed:
      return l10n.errorPurchaseFailed;
    case PurchaseErrorType.restoreFailed:
      return l10n.errorRestoreFailed;
  }
}

class RemoveAdsButton extends StatelessWidget {
  const RemoveAdsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: PurchaseService(),
      builder: (context, _) {
        final purchaseService = PurchaseService();

        // 처리 중
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

        // 광고 제거됨 → 완료 상태 표시
        if (purchaseService.isAdFree) {
          return ListTile(
            leading: PhosphorIcon(
              PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
              color: AppColors.success,
            ),
            title: Text(l10n.removeAds),
            subtitle: Text(l10n.adsRemoved),
          );
        }

        // 광고 제거 안됨 → 구매 버튼 + 복원 링크 표시
        final priceString = purchaseService.priceString;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: PhosphorIcon(
                PhosphorIcons.prohibit(PhosphorIconsStyle.light),
              ),
              title: Text(l10n.removeAds),
              subtitle: priceString.isNotEmpty ? Text(priceString) : null,
              trailing: FilledButton(
                onPressed: () => _handlePurchase(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.warning,
                ),
                child: Text(l10n.purchase),
              ),
            ),
            // 구매 복원 버튼 (Apple 심사 요구사항 - 명확하게 표시)
            ListTile(
              leading: PhosphorIcon(
                PhosphorIcons.arrowCounterClockwise(PhosphorIconsStyle.light),
              ),
              title: Text(l10n.restorePurchase),
              subtitle: Text(l10n.alreadyPurchasedQuestion),
              onTap: () => _handleRestore(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handlePurchase(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final purchaseService = PurchaseService();
    final success = await purchaseService.purchaseRemoveAds();

    if (!success && context.mounted) {
      final errorMessage = _getErrorMessage(l10n, purchaseService.errorType);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage.isNotEmpty ? errorMessage : l10n.purchaseError),
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
