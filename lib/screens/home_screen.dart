import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/database/database.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/main.dart';
import 'package:simple_planner/state/home_screen_state.dart';
import 'package:simple_planner/utils/date_utils.dart';
import 'package:simple_planner/utils/result.dart';
import 'package:simple_planner/widgets/banner_ad_widget.dart';
import 'package:simple_planner/widgets/calendar_dialog.dart';
import 'package:simple_planner/widgets/date_app_bar.dart';
import 'package:simple_planner/widgets/delete_dialog.dart';
import 'package:simple_planner/widgets/hour_picker_dialog.dart';
import 'package:simple_planner/widgets/time_change_dialog.dart';
import 'package:simple_planner/widgets/todo_input_section.dart';
import 'package:simple_planner/widgets/todo_stream_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  // 날짜 상태
  DateTime _selectedDate = DateTime.now();

  // 입력 관련 상태 (그룹화)
  TodoInputState _inputState = TodoInputState.initial();

  // 현재 투두 목록 (재정렬 시 사용)
  List<Todo> _currentTodos = [];

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    database.ensureRecurringTodosExist(today, today);
  }

  // ============================================================
  // Todo 생성
  // ============================================================

  Future<void> _submitTodo() async {
    if (_controller.text.isEmpty) return;

    final Result<void> result;

    if (_inputState.isRecurring) {
      result = await _createRecurringTodo();
    } else {
      result = await _createSingleTodo();
    }

    if (result.isFailure) {
      if (mounted) {
        _showErrorSnackBar(AppLocalizations.of(context).errorAddTodo);
      }
      return;
    }

    _controller.clear();
    setState(() => _inputState = _inputState.reset());
  }

  Future<Result<void>> _createRecurringTodo() async {
    final weekdaysWithCurrentDay = _inputState.selectedWeekdays.addDate(
      _selectedDate,
    );

    final createResult = await database.createRecurringTodo(
      _controller.text,
      _inputState.selectedHour,
      weekdaysWithCurrentDay.value,
      _selectedDate,
    );

    if (createResult.isFailure) {
      return Failure(createResult);
    }

    return database.createTodoFromRecurring(
      createResult.valueOrNull!,
      _selectedDate,
    );
  }

  Future<Result<void>> _createSingleTodo() async {
    final scheduledAt = _selectedDate.withHour(_inputState.selectedHour);

    final countResult = await database.getTodoCountForHour(
      _selectedDate,
      _inputState.selectedHour,
    );

    return database.createTodo(
      _controller.text,
      scheduledAt,
      countResult.valueOr(0),
    );
  }

  // ============================================================
  // UI 피드백
  // ============================================================

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        duration: AppConstants.snackBarDuration,
      ),
    );
  }

  // ============================================================
  // 다이얼로그 표시
  // ============================================================

  Future<void> _showHourPickerDialog() async {
    final selectedHour = await showDialog<int>(
      context: context,
      builder: (context) =>
          HourPickerDialog(initialHour: _inputState.selectedHour),
    );

    if (selectedHour != null) {
      setState(() => _inputState = _inputState.withHour(selectedHour));
    }
  }

  Future<void> _showCalendarDialog() async {
    final now = DateTime.now();
    final selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (context) => CalendarDialog(
        initialDate: _selectedDate,
        firstDate: DateTime(now.year - AppConstants.calendarYearRange),
        lastDate: DateTime(now.year + AppConstants.calendarYearRange, 12, 31),
      ),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _inputState = _inputState.resetForDateChange();
      });
      await database.ensureRecurringTodosExist(selectedDate, selectedDate);
    }
  }

  // ============================================================
  // Todo 이벤트 핸들러
  // ============================================================

  Future<void> _onTodoDelete(Todo todo) async {
    final dialogResult = await DeleteDialog.show(
      context: context,
      title: todo.title,
      isRecurring: todo.recurringId != null,
    );

    if (dialogResult.confirmed) {
      final Result<void> result;
      if (dialogResult.deleteAllRecurring && todo.recurringId != null) {
        result = await database.deleteRecurringTodo(
          todo.recurringId!,
          todo.scheduledAt,
        );
      } else {
        result = await database.deleteTodo(todo.id);
      }

      if (result.isFailure && mounted) {
        _showErrorSnackBar(AppLocalizations.of(context).errorDeleteTodo);
      }
    }
  }

  Future<void> _onTodoToggleComplete(Todo todo) async {
    final result = await database.toggleTodoCompletion(todo);
    if (result.isFailure && mounted) {
      _showErrorSnackBar(AppLocalizations.of(context).errorToggleTodo);
    }
  }

  /// 시간대별로 투두를 그룹화
  Map<int, List<Todo>> _groupTodosByHour(List<Todo> todos) {
    final grouped = <int, List<Todo>>{};
    for (final todo in todos) {
      final hour = todo.scheduledAt.hour;
      grouped.putIfAbsent(hour, () => []).add(todo);
    }
    return grouped;
  }

  /// 드래그 앤 드롭으로 아이템 재정렬/이동
  Future<void> _onItemReorder(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) async {
    final todosByHour = _groupTodosByHour(_currentTodos);
    final oldHour = oldListIndex;
    final newHour = newListIndex;

    final todosInOldHour = todosByHour[oldHour] ?? [];
    if (oldItemIndex >= todosInOldHour.length) return;

    final movedTodo = todosInOldHour[oldItemIndex];

    Result<void> result;

    if (oldHour == newHour) {
      // 같은 시간대 내 순서 변경
      if (oldItemIndex == newItemIndex) return;

      final reorderedTodos = List<Todo>.from(todosInOldHour);
      reorderedTodos.removeAt(oldItemIndex);
      reorderedTodos.insert(newItemIndex, movedTodo);

      result = await database.reorderTodosInHour(
        reorderedTodos.map((t) => t.id).toList(),
      );
    } else {
      // 다른 시간대로 이동
      final isRecurring = movedTodo.recurringId != null;

      // 반복 할일인 경우 다이얼로그 표시
      if (isRecurring) {
        final dialogResult = await TimeChangeDialog.show(
          context: context,
          title: movedTodo.title,
          newHour: newHour,
          isRecurring: true,
        );

        if (!dialogResult.confirmed) return;

        if (dialogResult.changeAllRecurring) {
          // 이후 반복 일정 전체 시간 변경
          result = await database.updateRecurringTodoHour(
            movedTodo.recurringId!,
            newHour,
            movedTodo.scheduledAt,
          );
        } else {
          // 현재 투두만 시간 변경
          result = await _moveSingleTodoToHour(
            movedTodo,
            newHour,
            newItemIndex,
            todosByHour[newHour] ?? [],
          );
        }
      } else {
        // 일반 할일은 바로 이동
        result = await _moveSingleTodoToHour(
          movedTodo,
          newHour,
          newItemIndex,
          todosByHour[newHour] ?? [],
        );
      }
    }

    if (result.isFailure && mounted) {
      _showErrorSnackBar(AppLocalizations.of(context).errorReorderTodo);
    }
  }

  /// 단일 투두를 새 시간대로 이동
  Future<Result<void>> _moveSingleTodoToHour(
    Todo movedTodo,
    int newHour,
    int newItemIndex,
    List<Todo> todosInNewHour,
  ) async {
    final newPriority = newItemIndex;

    // 투두를 새 시간대로 이동
    var result = await database.moveTodoToHour(
      movedTodo.id,
      newHour,
      newPriority,
    );

    // 새 시간대의 기존 투두들 우선순위 재조정
    if (result.isSuccess && todosInNewHour.isNotEmpty) {
      final updatedNewHourTodos = <int>[];
      for (int i = 0; i < todosInNewHour.length; i++) {
        if (i == newItemIndex) {
          updatedNewHourTodos.add(movedTodo.id);
        }
        updatedNewHourTodos.add(todosInNewHour[i].id);
      }
      if (newItemIndex >= todosInNewHour.length) {
        updatedNewHourTodos.add(movedTodo.id);
      }
      await database.reorderTodosInHour(updatedNewHourTodos);
    }

    return result;
  }

  void _onRecurringToggle() {
    setState(() => _inputState = _inputState.toggleRecurring(_selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
      stream: database.streamTodosByDate(_selectedDate),
      builder: (context, snapshot) {
        final todos = snapshot.data ?? [];
        _currentTodos = todos;
        final totalCount = todos.length;
        final completedCount = todos.where((t) => t.isDone).length;

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: DateAppBar(
            selectedDate: _selectedDate,
            onDateTap: _showCalendarDialog,
            totalCount: totalCount,
            completedCount: completedCount,
          ),
          body: Column(
            children: [
              TodoInputSection(
                controller: _controller,
                isRecurring: _inputState.isRecurring,
                selectedWeekdays: _inputState.selectedWeekdays,
                selectedHour: _inputState.selectedHour,
                lockedWeekday: _selectedDate.weekday,
                onRecurringToggle: _onRecurringToggle,
                onWeekdaysChanged: (weekdays) => setState(
                  () => _inputState = _inputState.withWeekdays(weekdays),
                ),
                onTimePickerTap: _showHourPickerDialog,
                onSubmit: _submitTodo,
              ),
              Expanded(
                child: TodoStreamView(
                  selectedDate: _selectedDate,
                  onTodoDelete: _onTodoDelete,
                  onTodoToggle: _onTodoToggleComplete,
                  onItemReorder: _onItemReorder,
                ),
              ),
            ],
          ),
          bottomNavigationBar: const BannerAdWidget(),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
