import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/utils/weekday_utils.dart';
import 'package:simple_planner/widgets/recurring_toggle_button.dart';
import 'package:simple_planner/widgets/time_picker_button.dart';
import 'package:simple_planner/widgets/weekday_selector.dart';

/// 할 일 입력 섹션 위젯
class TodoInputSection extends StatelessWidget {
  final TextEditingController controller;
  final bool isRecurring;
  final Weekdays selectedWeekdays;
  final int selectedHour;
  final int lockedWeekday;
  final VoidCallback onRecurringToggle;
  final ValueChanged<Weekdays> onWeekdaysChanged;
  final VoidCallback onTimePickerTap;
  final VoidCallback onSubmit;

  const TodoInputSection({
    super.key,
    required this.controller,
    required this.isRecurring,
    required this.selectedWeekdays,
    required this.selectedHour,
    required this.lockedWeekday,
    required this.onRecurringToggle,
    required this.onWeekdaysChanged,
    required this.onTimePickerTap,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        children: [
          _RecurringRow(
            isRecurring: isRecurring,
            selectedWeekdays: selectedWeekdays,
            onRecurringToggle: onRecurringToggle,
          ),
          if (isRecurring) ...[
            const SizedBox(height: AppConstants.smallPadding),
            _WeekdaySelectorContainer(
              selectedWeekdays: selectedWeekdays,
              lockedWeekday: lockedWeekday,
              onWeekdaysChanged: onWeekdaysChanged,
            ),
          ],
          const SizedBox(height: AppConstants.smallPadding),
          _InputRow(
            controller: controller,
            selectedHour: selectedHour,
            onTimePickerTap: onTimePickerTap,
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}

/// 반복 설정 행
class _RecurringRow extends StatelessWidget {
  final bool isRecurring;
  final Weekdays selectedWeekdays;
  final VoidCallback onRecurringToggle;

  const _RecurringRow({
    required this.isRecurring,
    required this.selectedWeekdays,
    required this.onRecurringToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RecurringToggleButton(
          isRecurring: isRecurring,
          onTap: onRecurringToggle,
        ),
        if (isRecurring) ...[
          const SizedBox(width: AppConstants.smallPadding),
          Text(
            selectedWeekdays.toDisplayText(context),
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: AppConstants.smallFontSize,
            ),
          ),
        ],
      ],
    );
  }
}

/// 요일 선택기 컨테이너
class _WeekdaySelectorContainer extends StatelessWidget {
  final Weekdays selectedWeekdays;
  final int lockedWeekday;
  final ValueChanged<Weekdays> onWeekdaysChanged;

  const _WeekdaySelectorContainer({
    required this.selectedWeekdays,
    required this.lockedWeekday,
    required this.onWeekdaysChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        border: Border.all(color: AppColors.greyBorder),
      ),
      child: WeekdaySelector(
        selectedWeekdays: selectedWeekdays,
        onChanged: onWeekdaysChanged,
        lockedWeekday: lockedWeekday,
      ),
    );
  }
}

/// 입력 행 (텍스트필드 + 시간 + 추가 버튼)
class _InputRow extends StatelessWidget {
  final TextEditingController controller;
  final int selectedHour;
  final VoidCallback onTimePickerTap;
  final VoidCallback onSubmit;

  const _InputRow({
    required this.controller,
    required this.selectedHour,
    required this.onTimePickerTap,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: AppConstants.defaultFontSize),
            decoration: InputDecoration(
              hintText: l10n.todoInputHint,
              hintStyle: const TextStyle(fontSize: AppConstants.defaultFontSize),
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.mediumPadding,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppConstants.defaultBorderRadius),
                borderSide: BorderSide(color: AppColors.greyBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppConstants.defaultBorderRadius),
                borderSide: BorderSide(color: AppColors.greyBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppConstants.defaultBorderRadius),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
            onSubmitted: (_) => onSubmit(),
          ),
        ),
        const SizedBox(width: AppConstants.smallPadding),
        TimePickerButton(
          hour: selectedHour,
          onTap: onTimePickerTap,
        ),
        const SizedBox(width: AppConstants.smallPadding),
        IconButton.filled(
          onPressed: onSubmit,
          icon: PhosphorIcon(
            PhosphorIcons.plus(PhosphorIconsStyle.light),
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
