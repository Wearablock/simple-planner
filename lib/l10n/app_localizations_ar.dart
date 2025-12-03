// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مهام اليوم';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get delete => 'حذف';

  @override
  String get select => 'اختيار';

  @override
  String get settings => 'الإعدادات';

  @override
  String get todoInputHint => 'أدخل مهمة';

  @override
  String get recurring => 'تكرار';

  @override
  String get selectTime => 'اختر الوقت';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get monday => 'الإثنين';

  @override
  String get tuesday => 'الثلاثاء';

  @override
  String get wednesday => 'الأربعاء';

  @override
  String get thursday => 'الخميس';

  @override
  String get friday => 'الجمعة';

  @override
  String get saturday => 'السبت';

  @override
  String get sunday => 'الأحد';

  @override
  String get everyday => 'كل يوم';

  @override
  String get weekdays => 'أيام الأسبوع';

  @override
  String get weekend => 'نهاية الأسبوع';

  @override
  String get deleteConfirmTitle => 'تأكيد الحذف';

  @override
  String deleteConfirmMessage(String title) {
    return 'حذف \'$title\'؟';
  }

  @override
  String get deleteAllRecurring => 'حذف جميع المهام المتكررة المستقبلية أيضاً';

  @override
  String noTodosForDate(int month, int day) {
    return 'لا توجد مهام ليوم $day/$month';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'فشل في إضافة المهمة';

  @override
  String get errorDeleteTodo => 'فشل في حذف المهمة';

  @override
  String get errorToggleTodo => 'فشل في تحديث الحالة';

  @override
  String get errorReorderTodo => 'فشل في إعادة الترتيب';

  @override
  String get errorLoadTodos => 'فشل في تحميل المهام';

  @override
  String get cannotDeselectLockedDay =>
      'لا يمكن إلغاء تحديد يوم التاريخ المحدد';

  @override
  String get removeAds => 'إزالة الإعلانات';

  @override
  String get purchase => 'شراء';

  @override
  String get restorePurchase => 'استعادة المشتريات';

  @override
  String get restorePurchaseDesc => 'استعادة مشترياتك السابقة';

  @override
  String get processing => 'جارٍ المعالجة...';

  @override
  String get checkingPurchase => 'جارٍ التحقق من سجل الشراء...';

  @override
  String get purchaseError => 'تعذر بدء عملية الشراء';

  @override
  String get purchaseRestored => 'تم استعادة المشتريات!';

  @override
  String get noPurchaseToRestore => 'لا توجد مشتريات للاستعادة';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get versionInfo => 'الإصدار';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday، $day/$month';
  }

  @override
  String get emptyTodoTitle => 'لا توجد مهام';

  @override
  String get emptyTodoSubtitle => 'أضف مهمة جديدة للبدء';
}
