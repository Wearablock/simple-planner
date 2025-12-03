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

  // 재정렬 관련 상태 (그룹화)
  ReorderState _reorderState = ReorderState.initial;

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
      _showErrorSnackBar(AppLocalizations.of(context).errorAddTodo);
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
        backgroundColor: Colors.red,
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
        _reorderState = _reorderState.reset();
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

      if (result.isFailure) {
        _showErrorSnackBar(AppLocalizations.of(context).errorDeleteTodo);
      }
    }
  }

  Future<void> _onTodoToggleComplete(Todo todo) async {
    final result = await database.toggleTodoCompletion(todo);
    if (result.isFailure) {
      _showErrorSnackBar(AppLocalizations.of(context).errorToggleTodo);
    }
  }

  Future<void> _onTodoReorder(
    int hour,
    List<Todo> todosInHour,
    int oldIndex,
    int newIndex,
  ) async {
    if (oldIndex == newIndex) return;

    final reorderedTodos = ReorderHelper.reorderInHour(
      hour: hour,
      hourTodos: todosInHour,
      oldIndex: oldIndex,
      newIndex: newIndex,
      currentOptimisticTodos: _reorderState.optimisticTodos,
    );

    setState(() => _reorderState = _reorderState.startReorder(reorderedTodos));

    final reorderedIds = todosInHour.toList()
      ..removeAt(oldIndex)
      ..insert(newIndex, todosInHour[oldIndex]);

    final result = await database.reorderTodosInHour(
      reorderedIds.map((todo) => todo.id).toList(),
    );

    if (mounted) {
      setState(() => _reorderState = _reorderState.finishReorder());

      if (result.isFailure) {
        _showErrorSnackBar(AppLocalizations.of(context).errorReorderTodo);
      }
    }
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
        final totalCount = todos.length;
        final completedCount = todos.where((t) => t.isDone).length;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
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
                  reorderState: _reorderState,
                  onReorderStateChanged: (state) {
                    if (mounted) setState(() => _reorderState = state);
                  },
                  onTodoDelete: _onTodoDelete,
                  onTodoToggle: _onTodoToggleComplete,
                  onTodoReorder: _onTodoReorder,
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
