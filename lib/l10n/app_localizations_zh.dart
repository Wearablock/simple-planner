// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '今日任务';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get delete => '删除';

  @override
  String get select => '选择';

  @override
  String get settings => '设置';

  @override
  String get todoInputHint => '输入任务';

  @override
  String get recurring => '重复';

  @override
  String get selectTime => '选择时间';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$month月$day日';
  }

  @override
  String get monday => '周一';

  @override
  String get tuesday => '周二';

  @override
  String get wednesday => '周三';

  @override
  String get thursday => '周四';

  @override
  String get friday => '周五';

  @override
  String get saturday => '周六';

  @override
  String get sunday => '周日';

  @override
  String get everyday => '每天';

  @override
  String get weekdays => '工作日';

  @override
  String get weekend => '周末';

  @override
  String get deleteConfirmTitle => '确认删除';

  @override
  String deleteConfirmMessage(String title) {
    return '删除「$title」？';
  }

  @override
  String get deleteAllRecurring => '同时删除所有未来的重复任务';

  @override
  String noTodosForDate(int month, int day) {
    return '$month月$day日没有任务';
  }

  @override
  String countText(int count) {
    return '$count个';
  }

  @override
  String get errorAddTodo => '添加任务失败';

  @override
  String get errorDeleteTodo => '删除任务失败';

  @override
  String get errorToggleTodo => '更新状态失败';

  @override
  String get errorReorderTodo => '排序失败';

  @override
  String get errorLoadTodos => '加载任务失败';

  @override
  String get cannotDeselectLockedDay => '无法取消选中日期的星期';

  @override
  String get removeAds => '移除广告';

  @override
  String get purchase => '购买';

  @override
  String get restorePurchase => '恢复购买';

  @override
  String get restorePurchaseDesc => '恢复您之前的购买';

  @override
  String get processing => '处理中...';

  @override
  String get checkingPurchase => '正在检查购买记录...';

  @override
  String get purchaseError => '无法开始购买';

  @override
  String get purchaseRestored => '购买已恢复！';

  @override
  String get noPurchaseToRestore => '没有可恢复的购买';

  @override
  String get errorStoreUnavailable => '无法连接到商店';

  @override
  String get errorLoadProduct => '无法加载商品信息';

  @override
  String get errorProductNotFound => '未找到商品';

  @override
  String get errorNoProductInfo => '没有商品信息';

  @override
  String get errorAlreadyPurchased => '已购买';

  @override
  String get errorPurchaseFailed => '购买时发生错误';

  @override
  String get errorRestoreFailed => '恢复购买时发生错误';

  @override
  String get termsOfService => '服务条款';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get versionInfo => '版本';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$month月$day日 $weekday';
  }

  @override
  String get emptyTodoTitle => '没有任务';

  @override
  String get emptyTodoSubtitle => '添加新任务开始吧';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => '今日任務';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '確認';

  @override
  String get delete => '刪除';

  @override
  String get select => '選擇';

  @override
  String get settings => '設定';

  @override
  String get todoInputHint => '輸入任務';

  @override
  String get recurring => '重複';

  @override
  String get selectTime => '選擇時間';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$month月$day日';
  }

  @override
  String get monday => '週一';

  @override
  String get tuesday => '週二';

  @override
  String get wednesday => '週三';

  @override
  String get thursday => '週四';

  @override
  String get friday => '週五';

  @override
  String get saturday => '週六';

  @override
  String get sunday => '週日';

  @override
  String get everyday => '每天';

  @override
  String get weekdays => '平日';

  @override
  String get weekend => '週末';

  @override
  String get deleteConfirmTitle => '確認刪除';

  @override
  String deleteConfirmMessage(String title) {
    return '刪除「$title」？';
  }

  @override
  String get deleteAllRecurring => '同時刪除所有未來的重複任務';

  @override
  String noTodosForDate(int month, int day) {
    return '$month月$day日沒有任務';
  }

  @override
  String countText(int count) {
    return '$count個';
  }

  @override
  String get errorAddTodo => '新增任務失敗';

  @override
  String get errorDeleteTodo => '刪除任務失敗';

  @override
  String get errorToggleTodo => '更新狀態失敗';

  @override
  String get errorReorderTodo => '排序失敗';

  @override
  String get errorLoadTodos => '載入任務失敗';

  @override
  String get cannotDeselectLockedDay => '無法取消選取日期的星期';

  @override
  String get removeAds => '移除廣告';

  @override
  String get purchase => '購買';

  @override
  String get restorePurchase => '恢復購買';

  @override
  String get restorePurchaseDesc => '恢復您之前的購買';

  @override
  String get processing => '處理中...';

  @override
  String get checkingPurchase => '正在檢查購買紀錄...';

  @override
  String get purchaseError => '無法開始購買';

  @override
  String get purchaseRestored => '購買已恢復！';

  @override
  String get noPurchaseToRestore => '沒有可恢復的購買';

  @override
  String get errorStoreUnavailable => '無法連接到商店';

  @override
  String get errorLoadProduct => '無法載入商品資訊';

  @override
  String get errorProductNotFound => '找不到商品';

  @override
  String get errorNoProductInfo => '沒有商品資訊';

  @override
  String get errorAlreadyPurchased => '已購買';

  @override
  String get errorPurchaseFailed => '購買時發生錯誤';

  @override
  String get errorRestoreFailed => '恢復購買時發生錯誤';

  @override
  String get termsOfService => '服務條款';

  @override
  String get privacyPolicy => '隱私權政策';

  @override
  String get versionInfo => '版本';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$month月$day日 $weekday';
  }

  @override
  String get emptyTodoTitle => '沒有任務';

  @override
  String get emptyTodoSubtitle => '新增任務開始吧';
}
