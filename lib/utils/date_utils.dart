/// DateTime 관련 유틸리티 확장 메서드
extension DateTimeExtensions on DateTime {
  /// 시간을 제외한 날짜만 반환 (00:00:00)
  DateTime get dateOnly => DateTime(year, month, day);

  /// 해당 날짜의 시작 시간 (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// 해당 날짜의 끝 시간 (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  /// 특정 시간의 시작 (HH:00:00)
  DateTime startOfHour(int hour) => DateTime(year, month, day, hour);

  /// 특정 시간의 끝 (HH:59:59)
  DateTime endOfHour(int hour) => DateTime(year, month, day, hour, 59, 59);

  /// 특정 시간으로 설정된 새 DateTime 반환
  DateTime withHour(int hour) => DateTime(year, month, day, hour);
}

/// 날짜 범위를 나타내는 클래스
class DateRange {
  final DateTime start;
  final DateTime end;

  const DateRange(this.start, this.end);

  /// 날짜로 하루 범위 생성 (00:00:00 ~ 23:59:59)
  factory DateRange.forDay(DateTime date) {
    return DateRange(date.startOfDay, date.endOfDay);
  }

  /// 특정 날짜, 특정 시간의 범위 생성 (HH:00:00 ~ HH:59:59)
  factory DateRange.forHour(DateTime date, int hour) {
    return DateRange(date.startOfHour(hour), date.endOfHour(hour));
  }

  /// 시작일부터 종료일까지 범위 생성 (종료일은 23:59:59)
  factory DateRange.between(DateTime startDate, DateTime endDate) {
    return DateRange(startDate.startOfDay, endDate.endOfDay);
  }
}
