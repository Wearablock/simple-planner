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
