import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';

/// 시간 변경 결과를 나타내는 클래스
class TimeChangeResult {
  final bool confirmed;
  final bool changeAllRecurring;

  const TimeChangeResult({
    required this.confirmed,
    this.changeAllRecurring = false,
  });

  static const cancelled = TimeChangeResult(confirmed: false);
}

/// 반복 할일 시간 변경 확인 다이얼로그
class TimeChangeDialog extends StatefulWidget {
  final String title;
  final int newHour;
  final bool isRecurring;

  const TimeChangeDialog({
    super.key,
    required this.title,
    required this.newHour,
    this.isRecurring = false,
  });

  /// 다이얼로그를 표시하고 결과를 반환
  static Future<TimeChangeResult> show({
    required BuildContext context,
    required String title,
    required int newHour,
    bool isRecurring = false,
  }) async {
    final result = await showDialog<TimeChangeResult>(
      context: context,
      builder: (context) => TimeChangeDialog(
        title: title,
        newHour: newHour,
        isRecurring: isRecurring,
      ),
    );
    return result ?? TimeChangeResult.cancelled;
  }

  @override
  State<TimeChangeDialog> createState() => _TimeChangeDialogState();
}

class _TimeChangeDialogState extends State<TimeChangeDialog> {
  bool _changeAllRecurring = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hourString = widget.newHour.toString().padLeft(2, '0');

    return AlertDialog(
      title: Text(l10n.timeChangeTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.timeChangeMessage(widget.title, hourString)),
          if (widget.isRecurring) ...[
            const SizedBox(height: AppConstants.defaultPadding),
            GestureDetector(
              onTap: () => setState(() => _changeAllRecurring = !_changeAllRecurring),
              child: Row(
                children: [
                  Checkbox(
                    value: _changeAllRecurring,
                    onChanged: (value) =>
                        setState(() => _changeAllRecurring = value ?? false),
                  ),
                  Expanded(child: Text(l10n.changeAllRecurring)),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, TimeChangeResult.cancelled),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            TimeChangeResult(
              confirmed: true,
              changeAllRecurring: _changeAllRecurring,
            ),
          ),
          child: Text(l10n.change),
        ),
      ],
    );
  }
}
