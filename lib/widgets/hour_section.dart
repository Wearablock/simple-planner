import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/database/database.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/utils/hour_brightness_utils.dart';
import 'package:simple_planner/widgets/todo_card.dart';

/// 시간별 섹션 위젯
class HourSection extends StatelessWidget {
  final int hour;
  final List<Todo> todos;
  final List<Todo> allTodos;
  final Future<void> Function(Todo todo) onTodoDelete;
  final Future<void> Function(Todo todo) onTodoToggle;
  final void Function(int oldIndex, int newIndex) onTodoReorder;

  const HourSection({
    super.key,
    required this.hour,
    required this.todos,
    required this.allTodos,
    required this.onTodoDelete,
    required this.onTodoToggle,
    required this.onTodoReorder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HourHeader(hour: hour, todoCount: todos.length),
        _ReorderableTodoList(
          todos: todos,
          onTodoDelete: onTodoDelete,
          onTodoToggle: onTodoToggle,
          onTodoReorder: onTodoReorder,
        ),
      ],
    );
  }
}

/// 시간 헤더 위젯
class _HourHeader extends StatelessWidget {
  final int hour;
  final int todoCount;

  const _HourHeader({required this.hour, required this.todoCount});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.smallPadding),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.mediumPadding,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: HourBrightnessUtils.getColor(hour),
              borderRadius: BorderRadius.circular(
                AppConstants.largeBorderRadius,
              ),
            ),
            child: Text(
              l10n.hourFormat(hour.toString().padLeft(2, '0')),
              style: TextStyle(color: HourBrightnessUtils.getOnColor(hour)),
            ),
          ),
          const SizedBox(width: AppConstants.smallPadding),
          Text(
            l10n.countText(todoCount),
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: AppConstants.smallFontSize,
            ),
          ),
        ],
      ),
    );
  }
}

/// 재정렬 가능한 Todo 리스트 위젯
class _ReorderableTodoList extends StatelessWidget {
  final List<Todo> todos;
  final Future<void> Function(Todo todo) onTodoDelete;
  final Future<void> Function(Todo todo) onTodoToggle;
  final void Function(int oldIndex, int newIndex) onTodoReorder;

  const _ReorderableTodoList({
    required this.todos,
    required this.onTodoDelete,
    required this.onTodoToggle,
    required this.onTodoReorder,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: todos.length,
      proxyDecorator: (child, index, animation) {
        return Material(color: Colors.transparent, child: child);
      },
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex--;
        onTodoReorder(oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoCard(
          key: ValueKey(todo.id),
          todo: todo,
          index: index,
          onDelete: () => onTodoDelete(todo),
          onToggleComplete: () => onTodoToggle(todo),
        );
      },
    );
  }
}
