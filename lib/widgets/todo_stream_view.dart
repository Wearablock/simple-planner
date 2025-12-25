import 'package:flutter/material.dart';
import 'package:simple_planner/database/database.dart';
import 'package:simple_planner/main.dart';
import 'package:simple_planner/widgets/todo_list_view.dart';

/// Todo 스트림을 처리하고 TodoListView를 렌더링하는 위젯
class TodoStreamView extends StatelessWidget {
  final DateTime selectedDate;
  final Future<void> Function(Todo todo) onTodoDelete;
  final Future<void> Function(Todo todo) onTodoToggle;
  final void Function(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) onItemReorder;

  const TodoStreamView({
    super.key,
    required this.selectedDate,
    required this.onTodoDelete,
    required this.onTodoToggle,
    required this.onItemReorder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
      stream: database.streamTodosByDate(selectedDate),
      builder: (context, snapshot) {
        final todos = snapshot.data ?? [];

        return TodoListView(
          todos: todos,
          onTodoDelete: onTodoDelete,
          onTodoToggle: onTodoToggle,
          onItemReorder: onItemReorder,
        );
      },
    );
  }
}
