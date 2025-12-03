import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/database/database.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/widgets/hour_section.dart';

/// Todo 리스트 뷰 위젯
class TodoListView extends StatelessWidget {
  final List<Todo> todos;
  final DateTime selectedDate;
  final bool isReordering;
  final List<Todo>? optimisticTodos;
  final Future<void> Function(Todo todo) onTodoDelete;
  final Future<void> Function(Todo todo) onTodoToggle;
  final Future<void> Function(
    int hour,
    List<Todo> todosInHour,
    int oldIndex,
    int newIndex,
  ) onTodoReorder;

  const TodoListView({
    super.key,
    required this.todos,
    required this.selectedDate,
    required this.isReordering,
    required this.optimisticTodos,
    required this.onTodoDelete,
    required this.onTodoToggle,
    required this.onTodoReorder,
  });

  @override
  Widget build(BuildContext context) {
    final displayTodos =
        isReordering && optimisticTodos != null ? optimisticTodos! : todos;

    if (displayTodos.isEmpty) {
      return _EmptyTodoList(selectedDate: selectedDate);
    }

    final todosByHour = _groupTodosByHour(displayTodos);
    final sortedHours = todosByHour.keys.toList()..sort();

    return ListView.builder(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      itemCount: sortedHours.length,
      itemBuilder: (context, index) {
        final hour = sortedHours[index];
        final todosInHour = todosByHour[hour]!;

        return HourSection(
          hour: hour,
          todos: todosInHour,
          allTodos: displayTodos,
          onTodoDelete: onTodoDelete,
          onTodoToggle: onTodoToggle,
          onTodoReorder: (oldIndex, newIndex) =>
              onTodoReorder(hour, todosInHour, oldIndex, newIndex),
        );
      },
    );
  }

  Map<int, List<Todo>> _groupTodosByHour(List<Todo> todos) {
    final grouped = <int, List<Todo>>{};
    for (final todo in todos) {
      final hour = todo.scheduledAt.hour;
      grouped.putIfAbsent(hour, () => []).add(todo);
    }
    return grouped;
  }
}

/// 할 일이 없을 때 표시되는 빈 상태 위젯
class _EmptyTodoList extends StatelessWidget {
  final DateTime selectedDate;

  const _EmptyTodoList({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PhosphorIcon(
            PhosphorIcons.checkCircle(PhosphorIconsStyle.light),
            size: 64,
            color: AppColors.greyBorder,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.dateFormat(selectedDate.month, selectedDate.day),
            style: TextStyle(
              color: AppColors.greyLight,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.emptyTodoTitle,
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.emptyTodoSubtitle,
            style: TextStyle(
              color: AppColors.greyLight,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
