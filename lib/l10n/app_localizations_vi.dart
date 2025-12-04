// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Công việc hôm nay';

  @override
  String get cancel => 'Hủy';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get delete => 'Xóa';

  @override
  String get select => 'Chọn';

  @override
  String get settings => 'Cài đặt';

  @override
  String get todoInputHint => 'Nhập công việc';

  @override
  String get recurring => 'Lặp lại';

  @override
  String get selectTime => 'Chọn thời gian';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get monday => 'T2';

  @override
  String get tuesday => 'T3';

  @override
  String get wednesday => 'T4';

  @override
  String get thursday => 'T5';

  @override
  String get friday => 'T6';

  @override
  String get saturday => 'T7';

  @override
  String get sunday => 'CN';

  @override
  String get everyday => 'Hàng ngày';

  @override
  String get weekdays => 'Ngày trong tuần';

  @override
  String get weekend => 'Cuối tuần';

  @override
  String get deleteConfirmTitle => 'Xác nhận xóa';

  @override
  String deleteConfirmMessage(String title) {
    return 'Xóa \'$title\'?';
  }

  @override
  String get deleteAllRecurring =>
      'Xóa tất cả công việc lặp lại trong tương lai';

  @override
  String noTodosForDate(int month, int day) {
    return 'Không có công việc cho ngày $day/$month';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'Không thể thêm công việc';

  @override
  String get errorDeleteTodo => 'Không thể xóa công việc';

  @override
  String get errorToggleTodo => 'Không thể cập nhật trạng thái';

  @override
  String get errorReorderTodo => 'Không thể sắp xếp lại';

  @override
  String get errorLoadTodos => 'Không thể tải công việc';

  @override
  String get cannotDeselectLockedDay =>
      'Không thể bỏ chọn ngày của ngày đã chọn';

  @override
  String get removeAds => 'Xóa quảng cáo';

  @override
  String get purchase => 'Mua';

  @override
  String get restorePurchase => 'Khôi phục mua hàng';

  @override
  String get restorePurchaseDesc => 'Khôi phục các giao dịch mua trước đó';

  @override
  String get processing => 'Đang xử lý...';

  @override
  String get checkingPurchase => 'Đang kiểm tra lịch sử mua hàng...';

  @override
  String get purchaseError => 'Không thể bắt đầu mua hàng';

  @override
  String get purchaseRestored => 'Đã khôi phục mua hàng!';

  @override
  String get noPurchaseToRestore => 'Không có giao dịch mua để khôi phục';

  @override
  String get errorStoreUnavailable => 'Không thể kết nối với cửa hàng';

  @override
  String get errorLoadProduct => 'Không thể tải thông tin sản phẩm';

  @override
  String get errorProductNotFound => 'Không tìm thấy sản phẩm';

  @override
  String get errorNoProductInfo => 'Không có thông tin sản phẩm';

  @override
  String get errorAlreadyPurchased => 'Đã mua';

  @override
  String get errorPurchaseFailed => 'Đã xảy ra lỗi khi mua hàng';

  @override
  String get errorRestoreFailed => 'Đã xảy ra lỗi khi khôi phục mua hàng';

  @override
  String get termsOfService => 'Điều khoản dịch vụ';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get versionInfo => 'Phiên bản';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday, $day/$month';
  }

  @override
  String get emptyTodoTitle => 'Không có công việc';

  @override
  String get emptyTodoSubtitle => 'Thêm công việc mới để bắt đầu';
}
