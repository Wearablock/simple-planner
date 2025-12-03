import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/utils/todo_progress_utils.dart';
import 'package:simple_planner/widgets/settings_icon_button.dart';

/// 날짜 선택 기능이 있는 앱바
class DateAppBar extends StatelessWidget implements PreferredSizeWidget {
  final DateTime selectedDate;
  final VoidCallback onDateTap;
  final int totalCount;
  final int completedCount;

  const DateAppBar({
    super.key,
    required this.selectedDate,
    required this.onDateTap,
    this.totalCount = 0,
    this.completedCount = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  List<String> _getWeekdayNames(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      l10n.monday,
      l10n.tuesday,
      l10n.wednesday,
      l10n.thursday,
      l10n.friday,
      l10n.saturday,
      l10n.sunday,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final weekdayNames = _getWeekdayNames(context);

    final status = TodoProgressUtils.getStatus(
      totalCount: totalCount,
      completedCount: completedCount,
      selectedDate: selectedDate,
    );
    final statusColor = TodoProgressUtils.getColor(status);
    final statusBgColor = TodoProgressUtils.getBackgroundColor(status);
    final statusIcon = TodoProgressUtils.getIcon(status);

    return AppBar(
      leadingWidth: totalCount > 0 ? 100 : 0,
      leading: totalCount > 0
          ? Center(
              child: Container(
                margin: const EdgeInsets.only(
                  left: AppConstants.defaultPadding,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.smallPadding,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(
                    AppConstants.largeBorderRadius,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: AppConstants.smallIconSize,
                      color: statusColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$completedCount/$totalCount',
                      style: TextStyle(
                        fontSize: AppConstants.smallFontSize,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
      title: GestureDetector(
        onTap: onDateTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.dateWithWeekday(
                selectedDate.month,
                selectedDate.day,
                weekdayNames[selectedDate.weekday - 1],
              ),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: AppConstants.tinyPadding),
            const Icon(Icons.arrow_drop_down, size: AppConstants.largeIconSize),
          ],
        ),
      ),
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.scaffoldBackground,
      actions: const [SettingsIconButton()],
    );
  }
}
