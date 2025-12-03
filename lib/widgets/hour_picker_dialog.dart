import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';

class HourPickerDialog extends StatefulWidget {
  final int initialHour;

  const HourPickerDialog({super.key, required this.initialHour});

  @override
  State<HourPickerDialog> createState() => _HourPickerDialogState();
}

class _HourPickerDialogState extends State<HourPickerDialog> {
  late FixedExtentScrollController _controller;
  late int _selectedHour;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialHour;
    _controller = FixedExtentScrollController(initialItem: _selectedHour);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.selectTime),
      content: SizedBox(
        height: AppConstants.hourPickerHeight,
        width: AppConstants.hourPickerWidth,
        child: ListWheelScrollView.useDelegate(
          controller: _controller,
          itemExtent: AppConstants.hourPickerItemExtent,
          perspective: AppConstants.hourPickerPerspective,
          diameterRatio: AppConstants.hourPickerDiameterRatio,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            setState(() {
              _selectedHour = index;
            });
          },
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: AppConstants.hoursInDay,
            builder: (context, index) {
              final isSelected = index == _selectedHour;

              return Center(
                child: Text(
                  l10n.hourFormat(index.toString().padLeft(2, '0')),
                  style: TextStyle(
                    fontSize: isSelected
                        ? AppConstants.extraLargeFontSize
                        : AppConstants.largeFontSize,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _selectedHour),
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}
