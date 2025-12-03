import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';

/// 반복 토글 버튼 위젯
class RecurringToggleButton extends StatelessWidget {
  final bool isRecurring;
  final VoidCallback onTap;

  const RecurringToggleButton({
    super.key,
    required this.isRecurring,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.mediumPadding,
          vertical: AppConstants.smallPadding,
        ),
        decoration: BoxDecoration(
          color: isRecurring
              ? primaryColor.withValues(alpha: AppConstants.lowOpacity)
              : Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
          border: Border.all(
            color: isRecurring ? primaryColor : AppColors.greyBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isRecurring ? Icons.check_box : Icons.check_box_outline_blank,
              size: AppConstants.defaultIconSize,
              color: isRecurring ? primaryColor : Colors.grey,
            ),
            const SizedBox(width: AppConstants.tinyPadding),
            Text(
              l10n.recurring,
              style: TextStyle(
                color: isRecurring ? primaryColor : AppColors.darkGreyText,
                fontWeight: isRecurring ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
