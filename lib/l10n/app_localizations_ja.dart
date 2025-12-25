// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '今日のタスク';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get delete => '削除';

  @override
  String get select => '選択';

  @override
  String get settings => '設定';

  @override
  String get todoInputHint => 'タスクを入力';

  @override
  String get recurring => '繰り返し';

  @override
  String get selectTime => '時間を選択';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$month月$day日';
  }

  @override
  String get monday => '月';

  @override
  String get tuesday => '火';

  @override
  String get wednesday => '水';

  @override
  String get thursday => '木';

  @override
  String get friday => '金';

  @override
  String get saturday => '土';

  @override
  String get sunday => '日';

  @override
  String get everyday => '毎日';

  @override
  String get weekdays => '平日';

  @override
  String get weekend => '週末';

  @override
  String get deleteConfirmTitle => '削除の確認';

  @override
  String deleteConfirmMessage(String title) {
    return '「$title」を削除しますか？';
  }

  @override
  String get deleteAllRecurring => '今後の繰り返しタスクもすべて削除';

  @override
  String get timeChangeTitle => '時間の変更';

  @override
  String timeChangeMessage(String title, String newHour) {
    return '「$title」を$newHour:00に変更します';
  }

  @override
  String get changeAllRecurring => '今後の繰り返しタスクもすべて変更';

  @override
  String get change => '変更';

  @override
  String noTodosForDate(int month, int day) {
    return '$month月$day日のタスクはありません';
  }

  @override
  String countText(int count) {
    return '$count件';
  }

  @override
  String get errorAddTodo => 'タスクの追加に失敗しました';

  @override
  String get errorDeleteTodo => 'タスクの削除に失敗しました';

  @override
  String get errorToggleTodo => 'ステータスの更新に失敗しました';

  @override
  String get errorReorderTodo => '並べ替えに失敗しました';

  @override
  String get errorLoadTodos => 'タスクの読み込みに失敗しました';

  @override
  String get cannotDeselectLockedDay => '選択した日付の曜日は解除できません';

  @override
  String get removeAds => '広告を削除';

  @override
  String get purchase => '購入';

  @override
  String get restorePurchase => '購入を復元';

  @override
  String get restorePurchaseDesc => '以前の購入を復元します';

  @override
  String get processing => '処理中...';

  @override
  String get checkingPurchase => '購入履歴を確認中...';

  @override
  String get purchaseError => '購入を開始できません';

  @override
  String get purchaseRestored => '購入が復元されました！';

  @override
  String get noPurchaseToRestore => '復元する購入がありません';

  @override
  String get errorStoreUnavailable => 'ストアに接続できません';

  @override
  String get errorLoadProduct => '商品情報を読み込めません';

  @override
  String get errorProductNotFound => '商品が見つかりません';

  @override
  String get errorNoProductInfo => '商品情報がありません';

  @override
  String get errorAlreadyPurchased => 'すでに購入済みです';

  @override
  String get errorPurchaseFailed => '購入中にエラーが発生しました';

  @override
  String get errorRestoreFailed => '購入の復元中にエラーが発生しました';

  @override
  String get termsOfService => '利用規約';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get versionInfo => 'バージョン';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$month月$day日 ($weekday)';
  }

  @override
  String get emptyTodoTitle => 'タスクがありません';

  @override
  String get emptyTodoSubtitle => '新しいタスクを追加してみましょう';

  @override
  String get alreadyPurchasedQuestion => 'すでに購入済みですか？';

  @override
  String get adsRemoved => '広告が削除されました';
}
