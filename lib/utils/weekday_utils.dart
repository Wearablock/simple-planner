import 'package:flutter/material.dart';
import 'package:simple_planner/l10n/app_localizations.dart';

/// 요일 비트마스크를 추상화한 값 클래스
///
/// 내부적으로 비트마스크를 사용하지만, 외부에서는 직관적인 API를 제공합니다.
/// 불변(immutable) 객체로 설계되어 모든 수정 연산은 새 인스턴스를 반환합니다.
class Weekdays {
  final int _value;

  const Weekdays._(this._value);

  // ============================================================
  // 팩토리 생성자
  // ============================================================

  /// 빈 요일 집합
  static const Weekdays none = Weekdays._(0);

  /// 모든 요일 (월~일)
  static const Weekdays all = Weekdays._(127);

  /// 평일 (월~금)
  static const Weekdays weekdays = Weekdays._(31);

  /// 주말 (토, 일)
  static const Weekdays weekend = Weekdays._(96);

  /// 비트마스크 값으로 생성
  const Weekdays.fromValue(this._value);

  /// 단일 요일로 생성 (DateTime.weekday 값 사용, 1=월요일, 7=일요일)
  factory Weekdays.single(int weekday) {
    return Weekdays._(1 << (weekday - 1));
  }

  /// DateTime에서 해당 요일로 생성
  factory Weekdays.fromDateTime(DateTime date) {
    return Weekdays.single(date.weekday);
  }

  /// 여러 요일로 생성 (DateTime.weekday 값들 사용)
  factory Weekdays.from(List<int> weekdayList) {
    int value = 0;
    for (final weekday in weekdayList) {
      value |= 1 << (weekday - 1);
    }
    return Weekdays._(value);
  }

  // ============================================================
  // 개별 요일 상수
  // ============================================================

  static const Weekdays monday = Weekdays._(1);
  static const Weekdays tuesday = Weekdays._(2);
  static const Weekdays wednesday = Weekdays._(4);
  static const Weekdays thursday = Weekdays._(8);
  static const Weekdays friday = Weekdays._(16);
  static const Weekdays saturday = Weekdays._(32);
  static const Weekdays sunday = Weekdays._(64);

  /// 인덱스로 요일 가져오기 (0=월, 6=일)
  static Weekdays byIndex(int index) {
    return Weekdays._(1 << index);
  }

  // ============================================================
  // 조회 메서드
  // ============================================================

  /// 비트마스크 값 반환 (데이터베이스 저장용)
  int get value => _value;

  /// 특정 요일이 포함되어 있는지 확인
  bool contains(Weekdays day) {
    return (_value & day._value) != 0;
  }

  /// DateTime의 요일이 포함되어 있는지 확인
  bool containsDate(DateTime date) {
    return contains(Weekdays.fromDateTime(date));
  }

  /// 비어있는지 확인
  bool get isEmpty => _value == 0;

  /// 모든 요일이 선택되었는지 확인
  bool get isAll => _value == 127;

  /// 평일만 선택되었는지 확인
  bool get isWeekdaysOnly => _value == 31;

  /// 주말만 선택되었는지 확인
  bool get isWeekendOnly => _value == 96;

  /// 선택된 요일 개수
  int get count {
    int n = _value;
    int count = 0;
    while (n > 0) {
      count += n & 1;
      n >>= 1;
    }
    return count;
  }

  // ============================================================
  // 수정 메서드 (새 인스턴스 반환)
  // ============================================================

  /// 요일 추가
  Weekdays add(Weekdays day) {
    return Weekdays._(_value | day._value);
  }

  /// DateTime의 요일 추가
  Weekdays addDate(DateTime date) {
    return add(Weekdays.fromDateTime(date));
  }

  /// 요일 제거
  Weekdays remove(Weekdays day) {
    return Weekdays._(_value & ~day._value);
  }

  /// 요일 토글 (있으면 제거, 없으면 추가)
  Weekdays toggle(Weekdays day) {
    return Weekdays._(_value ^ day._value);
  }

  /// 두 Weekdays 합치기
  Weekdays union(Weekdays other) {
    return Weekdays._(_value | other._value);
  }

  /// 두 Weekdays의 교집합
  Weekdays intersection(Weekdays other) {
    return Weekdays._(_value & other._value);
  }

  // ============================================================
  // 표시용 메서드
  // ============================================================

  /// 요일 텍스트로 변환 (다국어 지원)
  String toDisplayText(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (isAll) return l10n.everyday;
    if (isWeekdaysOnly) return l10n.weekdays;
    if (isWeekendOnly) return l10n.weekend;

    final dayNames = [
      l10n.monday,
      l10n.tuesday,
      l10n.wednesday,
      l10n.thursday,
      l10n.friday,
      l10n.saturday,
      l10n.sunday,
    ];

    final selected = <String>[];
    for (int i = 0; i < dayNames.length; i++) {
      if ((_value & (1 << i)) != 0) {
        selected.add(dayNames[i]);
      }
    }
    return selected.join(', ');
  }

  /// 선택된 요일 인덱스 목록 반환 (0=월, 6=일)
  List<int> toIndexList() {
    final result = <int>[];
    for (int i = 0; i < 7; i++) {
      if ((_value & (1 << i)) != 0) {
        result.add(i);
      }
    }
    return result;
  }

  // ============================================================
  // 연산자 오버로딩
  // ============================================================

  /// 요일 추가 연산자
  Weekdays operator |(Weekdays other) => union(other);

  /// 교집합 연산자
  Weekdays operator &(Weekdays other) => intersection(other);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Weekdays && other._value == _value;
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => 'Weekdays($_value)';
}

/// DateTime 확장 - 요일 관련
extension WeekdayDateTimeExtension on DateTime {
  /// 해당 날짜의 요일을 Weekdays로 반환
  Weekdays get weekdaysValue => Weekdays.fromDateTime(this);
}
