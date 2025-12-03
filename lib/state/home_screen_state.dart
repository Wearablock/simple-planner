import 'package:flutter/material.dart';
import 'package:simple_planner/database/database.dart';
import 'package:simple_planner/utils/weekday_utils.dart';

/// 할 일 입력 관련 상태
///
/// 반복 설정과 요일 선택을 함께 관리합니다.
class TodoInputState {
  final bool isRecurring;
  final Weekdays selectedWeekdays;
  final int selectedHour;

  const TodoInputState({
    this.isRecurring = false,
    this.selectedWeekdays = Weekdays.all,
    required this.selectedHour,
  });

  /// 초기 상태 생성
  factory TodoInputState.initial() {
    return TodoInputState(selectedHour: DateTime.now().hour);
  }

  /// 반복 모드 토글
  TodoInputState toggleRecurring(DateTime selectedDate) {
    if (!isRecurring) {
      // 반복 모드 켜기: 현재 날짜의 요일을 추가
      return TodoInputState(
        isRecurring: true,
        selectedWeekdays: selectedWeekdays.addDate(selectedDate),
        selectedHour: selectedHour,
      );
    } else {
      // 반복 모드 끄기
      return TodoInputState(
        isRecurring: false,
        selectedWeekdays: selectedWeekdays,
        selectedHour: selectedHour,
      );
    }
  }

  /// 요일 선택 변경
  TodoInputState withWeekdays(Weekdays weekdays) {
    return TodoInputState(
      isRecurring: isRecurring,
      selectedWeekdays: weekdays,
      selectedHour: selectedHour,
    );
  }

  /// 시간 변경
  TodoInputState withHour(int hour) {
    return TodoInputState(
      isRecurring: isRecurring,
      selectedWeekdays: selectedWeekdays,
      selectedHour: hour,
    );
  }

  /// 입력 완료 후 초기화
  TodoInputState reset() {
    return TodoInputState(
      isRecurring: false,
      selectedWeekdays: Weekdays.all,
      selectedHour: selectedHour,
    );
  }

  /// 날짜 변경 시 초기화
  TodoInputState resetForDateChange() {
    return TodoInputState(
      isRecurring: false,
      selectedWeekdays: Weekdays.all,
      selectedHour: selectedHour,
    );
  }
}

/// 리스트 재정렬 관련 상태
///
/// 낙관적 UI 업데이트를 위한 상태를 관리합니다.
@immutable
class ReorderState {
  final bool isReordering;
  final List<Todo>? optimisticTodos;

  const ReorderState({
    this.isReordering = false,
    this.optimisticTodos,
  });

  /// 초기 상태
  static const initial = ReorderState();

  /// 재정렬 시작
  ReorderState startReorder(List<Todo> todos) {
    return ReorderState(
      isReordering: true,
      optimisticTodos: todos,
    );
  }

  /// 재정렬 완료
  ReorderState finishReorder() {
    return const ReorderState(
      isReordering: false,
      optimisticTodos: null,
    );
  }

  /// 날짜 변경 시 초기화
  ReorderState reset() {
    return const ReorderState(
      isReordering: false,
      optimisticTodos: null,
    );
  }

  /// Stream에서 받은 todos로 optimisticTodos 초기화 (재정렬 중일 때)
  ReorderState initializeFromStream(List<Todo> todos) {
    if (isReordering && optimisticTodos == null && todos.isNotEmpty) {
      return ReorderState(
        isReordering: true,
        optimisticTodos: todos,
      );
    }
    return this;
  }
}

/// 재정렬 로직 헬퍼
class ReorderHelper {
  /// 특정 시간대의 todos를 재정렬하고 전체 리스트 반환
  static List<Todo> reorderInHour({
    required int hour,
    required List<Todo> hourTodos,
    required int oldIndex,
    required int newIndex,
    required List<Todo>? currentOptimisticTodos,
  }) {
    final reorderedHourTodos = List<Todo>.from(hourTodos);
    final item = reorderedHourTodos.removeAt(oldIndex);
    reorderedHourTodos.insert(newIndex, item);

    final currentTodos = currentOptimisticTodos ?? [];
    final otherTodos = currentTodos.isEmpty
        ? <Todo>[]
        : currentTodos.where((t) => t.scheduledAt.hour != hour).toList();

    final reorderedAll = [...otherTodos, ...reorderedHourTodos];
    reorderedAll.sort((a, b) => a.scheduledAt.hour.compareTo(b.scheduledAt.hour));

    return reorderedAll;
  }
}
