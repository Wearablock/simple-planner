// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '오늘 할 일';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get delete => '삭제';

  @override
  String get select => '선택';

  @override
  String get settings => '설정';

  @override
  String get todoInputHint => '할 일을 입력하세요';

  @override
  String get recurring => '반복';

  @override
  String get selectTime => '시간 선택';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$month월 $day일';
  }

  @override
  String get monday => '월';

  @override
  String get tuesday => '화';

  @override
  String get wednesday => '수';

  @override
  String get thursday => '목';

  @override
  String get friday => '금';

  @override
  String get saturday => '토';

  @override
  String get sunday => '일';

  @override
  String get everyday => '매일';

  @override
  String get weekdays => '평일';

  @override
  String get weekend => '주말';

  @override
  String get deleteConfirmTitle => '삭제 확인';

  @override
  String deleteConfirmMessage(String title) {
    return '\'$title\'을(를) 삭제하시겠습니까?';
  }

  @override
  String get deleteAllRecurring => '이후 반복 일정도 모두 삭제';

  @override
  String noTodosForDate(int month, int day) {
    return '$month월 $day일에 할 일이 없습니다';
  }

  @override
  String countText(int count) {
    return '$count개';
  }

  @override
  String get errorAddTodo => '할 일 추가에 실패했습니다';

  @override
  String get errorDeleteTodo => '할 일 삭제에 실패했습니다';

  @override
  String get errorToggleTodo => '상태 변경에 실패했습니다';

  @override
  String get errorReorderTodo => '순서 변경에 실패했습니다';

  @override
  String get errorLoadTodos => '할 일을 불러오는데 실패했습니다';

  @override
  String get cannotDeselectLockedDay => '선택한 날짜의 요일은 해제할 수 없습니다';

  @override
  String get removeAds => '광고 제거';

  @override
  String get purchase => '구매';

  @override
  String get restorePurchase => '구매 복원';

  @override
  String get restorePurchaseDesc => '이전에 구매한 항목을 복원합니다';

  @override
  String get processing => '처리 중...';

  @override
  String get checkingPurchase => '구매 내역을 확인 중...';

  @override
  String get purchaseError => '구매를 시작할 수 없습니다';

  @override
  String get purchaseRestored => '구매가 복원되었습니다!';

  @override
  String get noPurchaseToRestore => '복원할 구매 내역이 없습니다';

  @override
  String get termsOfService => '이용약관 및 정책';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get versionInfo => '버전 정보';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$month월 $day일 $weekday';
  }

  @override
  String get emptyTodoTitle => '할 일이 없어요';

  @override
  String get emptyTodoSubtitle => '새로운 할 일을 추가해보세요';
}
