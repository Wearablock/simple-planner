import 'package:flutter/material.dart';

/// 투두 진행 상태
enum TodoProgressStatus {
  /// 모두 완료
  completed,

  /// 진행 중 (오늘 또는 미래)
  inProgress,

  /// 미완료 (과거)
  overdue,
}

/// 투두 진행률 관련 유틸리티
class TodoProgressUtils {
  TodoProgressUtils._();

  /// 진행 상태 계산
  static TodoProgressStatus getStatus({
    required int totalCount,
    required int completedCount,
    required DateTime selectedDate,
  }) {
    if (totalCount == 0) return TodoProgressStatus.inProgress;

    if (completedCount == totalCount) {
      return TodoProgressStatus.completed;
    }

    // 과거 날짜인지 확인 (시간 제외하고 날짜만 비교)
    final today = DateTime.now();
    final isOverdue = DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
        .isBefore(DateTime(today.year, today.month, today.day));

    if (isOverdue) {
      return TodoProgressStatus.overdue;
    }

    return TodoProgressStatus.inProgress;
  }

  /// 상태에 따른 색상 반환
  static Color getColor(TodoProgressStatus status) {
    switch (status) {
      case TodoProgressStatus.completed:
        return Colors.green;
      case TodoProgressStatus.inProgress:
        return Colors.blue;
      case TodoProgressStatus.overdue:
        return Colors.red;
    }
  }

  /// 상태에 따른 배경 색상 반환
  static Color getBackgroundColor(TodoProgressStatus status) {
    return getColor(status).withValues(alpha: 0.1);
  }

  /// 상태에 따른 아이콘 반환
  static IconData getIcon(TodoProgressStatus status) {
    switch (status) {
      case TodoProgressStatus.completed:
        return Icons.check_circle;
      case TodoProgressStatus.inProgress:
        return Icons.circle_outlined;
      case TodoProgressStatus.overdue:
        return Icons.error_outline;
    }
  }
}
