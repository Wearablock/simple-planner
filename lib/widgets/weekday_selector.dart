import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/utils/weekday_utils.dart';

class WeekdaySelector extends StatelessWidget {
  final Weekdays selectedWeekdays;
  final ValueChanged<Weekdays> onChanged;
  final int? lockedWeekday;

  const WeekdaySelector({
    super.key,
    required this.selectedWeekdays,
    required this.onChanged,
    this.lockedWeekday,
  });

  List<String> _getDayNames(BuildContext context) {
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
    final dayNames = _getDayNames(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final day = Weekdays.byIndex(index);
        final isSelected = selectedWeekdays.contains(day);
        final isLocked = lockedWeekday != null && (index + 1) == lockedWeekday;

        return GestureDetector(
          onTap: isLocked
              ? () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.cannotDeselectLockedDay),
                      duration: AppConstants.snackBarDuration,
                    ),
                  )
              : () => onChanged(selectedWeekdays.toggle(day)),
          child: Container(
            width: AppConstants.weekdayButtonSize,
            height: AppConstants.weekdayButtonSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : AppColors.greyBackground,
            ),
            child: Center(
              child: Text(
                dayNames[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.greyText,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: AppConstants.defaultFontSize,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
