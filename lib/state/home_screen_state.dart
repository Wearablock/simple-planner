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
