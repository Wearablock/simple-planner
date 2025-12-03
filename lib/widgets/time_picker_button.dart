import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';

/// 시간 선택 버튼 위젯
class TimePickerButton extends StatelessWidget {
  final int hour;
  final VoidCallback onTap;

  const TimePickerButton({
    super.key,
    required this.hour,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.mediumPadding,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, size: AppConstants.defaultIconSize),
            const SizedBox(width: AppConstants.tinyPadding),
            Text(
              l10n.hourFormat(hour.toString().padLeft(2, '0')),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
