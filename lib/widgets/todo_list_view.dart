import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/database/database.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/utils/hour_brightness_utils.dart';
import 'package:simple_planner/widgets/todo_card.dart';

/// Todo 리스트 뷰 위젯 (24시간 전체 표시, 시간대 간 이동 지원)
class TodoListView extends StatelessWidget {
  final List<Todo> todos;
  final Future<void> Function(Todo todo) onTodoDelete;
  final Future<void> Function(Todo todo) onTodoToggle;
  final void Function(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) onItemReorder;

  const TodoListView({
    super.key,
    required this.todos,
    required this.onTodoDelete,
    required this.onTodoToggle,
    required this.onItemReorder,
  });

  Map<int, List<Todo>> _groupTodosByHour(List<Todo> todos) {
    final grouped = <int, List<Todo>>{};
    for (final todo in todos) {
      final hour = todo.scheduledAt.hour;
      grouped.putIfAbsent(hour, () => []).add(todo);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final todosByHour = _groupTodosByHour(todos);

    return DragAndDropLists(
      children: List.generate(AppConstants.hoursInDay, (hour) {
        final todosInHour = todosByHour[hour] ?? [];

        return DragAndDropList(
          header: _HourHeader(
            hour: hour,
            todoCount: todosInHour.length,
            isCompact: todosInHour.isEmpty,
          ),
          canDrag: false,
          contentsWhenEmpty: const SizedBox.shrink(),
          children: todosInHour
              .map(
                (todo) => DragAndDropItem(
                  child: TodoCard(
                    todo: todo,
                    index: todosInHour.indexOf(todo),
                    onDelete: () => onTodoDelete(todo),
                    onToggleComplete: () => onTodoToggle(todo),
                  ),
                ),
              )
              .toList(),
        );
      }),
      onItemReorder: onItemReorder,
      onListReorder: (oldIndex, newIndex) {},
      listPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 0,
      ),
      itemDragOnLongPress: true,
      itemDecorationWhileDragging: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      listDragOnLongPress: false,
      contentsWhenEmpty: const SizedBox.shrink(),
    );
  }
}

/// 시간 헤더 위젯
class _HourHeader extends StatelessWidget {
  final int hour;
  final int todoCount;
  final bool isCompact;

  const _HourHeader({
    required this.hour,
    required this.todoCount,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.only(
        top: isCompact ? 0.25 : 2.0,
        bottom: isCompact ? 0.25 : 6.0,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 8.0 : AppConstants.mediumPadding,
              vertical: isCompact ? 2.0 : 6.0,
            ),
            decoration: BoxDecoration(
              color: HourBrightnessUtils.getColor(hour),
              borderRadius: BorderRadius.circular(
                AppConstants.largeBorderRadius,
              ),
            ),
            child: Text(
              l10n.hourFormat(hour.toString().padLeft(2, '0')),
              style: TextStyle(
                color: HourBrightnessUtils.getOnColor(hour),
                fontSize: isCompact ? 12.0 : null,
              ),
            ),
          ),
          if (todoCount > 0) ...[
            const SizedBox(width: AppConstants.smallPadding),
            Text(
              l10n.countText(todoCount),
              style: TextStyle(
                color: AppColors.greyText,
                fontSize: AppConstants.smallFontSize,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
