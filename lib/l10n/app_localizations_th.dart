// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'งานวันนี้';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get confirm => 'ยืนยัน';

  @override
  String get delete => 'ลบ';

  @override
  String get select => 'เลือก';

  @override
  String get settings => 'ตั้งค่า';

  @override
  String get todoInputHint => 'ป้อนงาน';

  @override
  String get recurring => 'ทำซ้ำ';

  @override
  String get selectTime => 'เลือกเวลา';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get monday => 'จ.';

  @override
  String get tuesday => 'อ.';

  @override
  String get wednesday => 'พ.';

  @override
  String get thursday => 'พฤ.';

  @override
  String get friday => 'ศ.';

  @override
  String get saturday => 'ส.';

  @override
  String get sunday => 'อา.';

  @override
  String get everyday => 'ทุกวัน';

  @override
  String get weekdays => 'วันธรรมดา';

  @override
  String get weekend => 'วันหยุดสุดสัปดาห์';

  @override
  String get deleteConfirmTitle => 'ยืนยันการลบ';

  @override
  String deleteConfirmMessage(String title) {
    return 'ลบ \'$title\' หรือไม่?';
  }

  @override
  String get deleteAllRecurring => 'ลบงานที่ทำซ้ำในอนาคตทั้งหมดด้วย';

  @override
  String get timeChangeTitle => 'เปลี่ยนเวลา';

  @override
  String timeChangeMessage(String title, String newHour) {
    return 'เปลี่ยน \'$title\' เป็น $newHour:00';
  }

  @override
  String get changeAllRecurring => 'เปลี่ยนงานที่ทำซ้ำในอนาคตทั้งหมดด้วย';

  @override
  String get change => 'เปลี่ยน';

  @override
  String noTodosForDate(int month, int day) {
    return 'ไม่มีงานสำหรับวันที่ $day/$month';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'เพิ่มงานไม่สำเร็จ';

  @override
  String get errorDeleteTodo => 'ลบงานไม่สำเร็จ';

  @override
  String get errorToggleTodo => 'อัปเดตสถานะไม่สำเร็จ';

  @override
  String get errorReorderTodo => 'จัดเรียงใหม่ไม่สำเร็จ';

  @override
  String get errorLoadTodos => 'โหลดงานไม่สำเร็จ';

  @override
  String get cannotDeselectLockedDay =>
      'ไม่สามารถยกเลิกการเลือกวันของวันที่ที่เลือกได้';

  @override
  String get removeAds => 'ลบโฆษณา';

  @override
  String get purchase => 'ซื้อ';

  @override
  String get restorePurchase => 'กู้คืนการซื้อ';

  @override
  String get restorePurchaseDesc => 'กู้คืนการซื้อก่อนหน้าของคุณ';

  @override
  String get processing => 'กำลังดำเนินการ...';

  @override
  String get checkingPurchase => 'กำลังตรวจสอบประวัติการซื้อ...';

  @override
  String get purchaseError => 'ไม่สามารถเริ่มการซื้อได้';

  @override
  String get purchaseRestored => 'กู้คืนการซื้อสำเร็จ!';

  @override
  String get noPurchaseToRestore => 'ไม่มีการซื้อที่จะกู้คืน';

  @override
  String get errorStoreUnavailable => 'ไม่สามารถเชื่อมต่อกับร้านค้าได้';

  @override
  String get errorLoadProduct => 'ไม่สามารถโหลดข้อมูลสินค้าได้';

  @override
  String get errorProductNotFound => 'ไม่พบสินค้า';

  @override
  String get errorNoProductInfo => 'ไม่มีข้อมูลสินค้า';

  @override
  String get errorAlreadyPurchased => 'ซื้อแล้ว';

  @override
  String get errorPurchaseFailed => 'เกิดข้อผิดพลาดระหว่างการซื้อ';

  @override
  String get errorRestoreFailed => 'เกิดข้อผิดพลาดขณะกู้คืนการซื้อ';

  @override
  String get termsOfService => 'ข้อกำหนดการใช้งาน';

  @override
  String get privacyPolicy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get versionInfo => 'เวอร์ชัน';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday $day/$month';
  }

  @override
  String get emptyTodoTitle => 'ไม่มีงาน';

  @override
  String get emptyTodoSubtitle => 'เพิ่มงานใหม่เพื่อเริ่มต้น';

  @override
  String get alreadyPurchasedQuestion => 'ซื้อแล้วหรือยัง?';

  @override
  String get adsRemoved => 'ลบโฆษณาแล้ว';
}
