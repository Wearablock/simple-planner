import 'package:flutter/material.dart';
import 'package:simple_planner/database/database.dart';
import 'package:simple_planner/main.dart';
import 'package:simple_planner/state/home_screen_state.dart';
import 'package:simple_planner/widgets/todo_list_view.dart';

/// Todo 스트림을 처리하고 TodoListView를 렌더링하는 위젯
class TodoStreamView extends StatelessWidget {
  final DateTime selectedDate;
  final ReorderState reorderState;
  final ValueChanged<ReorderState> onReorderStateChanged;
  final Future<void> Function(Todo todo) onTodoDelete;
  final Future<void> Function(Todo todo) onTodoToggle;
  final Future<void> Function(
    int hour,
    List<Todo> todosInHour,
    int oldIndex,
    int newIndex,
  ) onTodoReorder;

  const TodoStreamView({
    super.key,
    required this.selectedDate,
    required this.reorderState,
    required this.onReorderStateChanged,
    required this.onTodoDelete,
    required this.onTodoToggle,
    required this.onTodoReorder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
      stream: database.streamTodosByDate(selectedDate),
      builder: (context, snapshot) {
        final todos = snapshot.data ?? [];

        final updatedReorderState = reorderState.initializeFromStream(todos);
        if (updatedReorderState != reorderState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onReorderStateChanged(updatedReorderState);
          });
        }

        return TodoListView(
          todos: todos,
          selectedDate: selectedDate,
          isReordering: reorderState.isReordering,
          optimisticTodos: reorderState.optimisticTodos,
          onTodoDelete: onTodoDelete,
          onTodoToggle: onTodoToggle,
          onTodoReorder: onTodoReorder,
        );
      },
    );
  }
}
