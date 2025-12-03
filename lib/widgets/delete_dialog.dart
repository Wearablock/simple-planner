import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';

/// 삭제 결과를 나타내는 클래스
class DeleteResult {
  final bool confirmed;
  final bool deleteAllRecurring;

  const DeleteResult({
    required this.confirmed,
    this.deleteAllRecurring = false,
  });

  static const cancelled = DeleteResult(confirmed: false);
}

/// 통합 삭제 확인 다이얼로그
class DeleteDialog extends StatefulWidget {
  final String title;
  final bool isRecurring;

  const DeleteDialog({
    super.key,
    required this.title,
    this.isRecurring = false,
  });

  /// 다이얼로그를 표시하고 결과를 반환
  static Future<DeleteResult> show({
    required BuildContext context,
    required String title,
    bool isRecurring = false,
  }) async {
    final result = await showDialog<DeleteResult>(
      context: context,
      builder: (context) => DeleteDialog(
        title: title,
        isRecurring: isRecurring,
      ),
    );
    return result ?? DeleteResult.cancelled;
  }

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  bool _deleteAllRecurring = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.deleteConfirmTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.deleteConfirmMessage(widget.title)),
          if (widget.isRecurring) ...[
            const SizedBox(height: AppConstants.defaultPadding),
            GestureDetector(
              onTap: () => setState(() => _deleteAllRecurring = !_deleteAllRecurring),
              child: Row(
                children: [
                  Checkbox(
                    value: _deleteAllRecurring,
                    onChanged: (value) =>
                        setState(() => _deleteAllRecurring = value ?? false),
                  ),
                  Expanded(child: Text(l10n.deleteAllRecurring)),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, DeleteResult.cancelled),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            DeleteResult(
              confirmed: true,
              deleteAllRecurring: _deleteAllRecurring,
            ),
          ),
          child: Text(l10n.delete),
        ),
      ],
    );
  }
}
