// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Tugas Hari Ini';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get delete => 'Hapus';

  @override
  String get select => 'Pilih';

  @override
  String get settings => 'Pengaturan';

  @override
  String get todoInputHint => 'Masukkan tugas';

  @override
  String get recurring => 'Ulangi';

  @override
  String get selectTime => 'Pilih Waktu';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get monday => 'Sen';

  @override
  String get tuesday => 'Sel';

  @override
  String get wednesday => 'Rab';

  @override
  String get thursday => 'Kam';

  @override
  String get friday => 'Jum';

  @override
  String get saturday => 'Sab';

  @override
  String get sunday => 'Min';

  @override
  String get everyday => 'Setiap Hari';

  @override
  String get weekdays => 'Hari Kerja';

  @override
  String get weekend => 'Akhir Pekan';

  @override
  String get deleteConfirmTitle => 'Konfirmasi Hapus';

  @override
  String deleteConfirmMessage(String title) {
    return 'Hapus \'$title\'?';
  }

  @override
  String get deleteAllRecurring =>
      'Hapus juga semua tugas berulang di masa depan';

  @override
  String noTodosForDate(int month, int day) {
    return 'Tidak ada tugas untuk $day/$month';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'Gagal menambah tugas';

  @override
  String get errorDeleteTodo => 'Gagal menghapus tugas';

  @override
  String get errorToggleTodo => 'Gagal memperbarui status';

  @override
  String get errorReorderTodo => 'Gagal mengurutkan ulang';

  @override
  String get errorLoadTodos => 'Gagal memuat tugas';

  @override
  String get cannotDeselectLockedDay =>
      'Tidak dapat membatalkan pilihan hari dari tanggal yang dipilih';

  @override
  String get removeAds => 'Hapus Iklan';

  @override
  String get purchase => 'Beli';

  @override
  String get restorePurchase => 'Pulihkan Pembelian';

  @override
  String get restorePurchaseDesc => 'Pulihkan pembelian sebelumnya';

  @override
  String get processing => 'Memproses...';

  @override
  String get checkingPurchase => 'Memeriksa riwayat pembelian...';

  @override
  String get purchaseError => 'Tidak dapat memulai pembelian';

  @override
  String get purchaseRestored => 'Pembelian dipulihkan!';

  @override
  String get noPurchaseToRestore => 'Tidak ada pembelian untuk dipulihkan';

  @override
  String get errorStoreUnavailable => 'Tidak dapat terhubung ke toko';

  @override
  String get errorLoadProduct => 'Tidak dapat memuat informasi produk';

  @override
  String get errorProductNotFound => 'Produk tidak ditemukan';

  @override
  String get errorNoProductInfo => 'Tidak ada informasi produk';

  @override
  String get errorAlreadyPurchased => 'Sudah dibeli';

  @override
  String get errorPurchaseFailed => 'Terjadi kesalahan saat pembelian';

  @override
  String get errorRestoreFailed =>
      'Terjadi kesalahan saat memulihkan pembelian';

  @override
  String get termsOfService => 'Ketentuan Layanan';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get versionInfo => 'Versi';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday, $day/$month';
  }

  @override
  String get emptyTodoTitle => 'Tidak ada tugas';

  @override
  String get emptyTodoSubtitle => 'Tambahkan tugas baru untuk memulai';
}
