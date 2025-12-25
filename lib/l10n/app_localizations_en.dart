// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Today\'s Tasks';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get delete => 'Delete';

  @override
  String get select => 'Select';

  @override
  String get settings => 'Settings';

  @override
  String get todoInputHint => 'Enter a task';

  @override
  String get recurring => 'Repeat';

  @override
  String get selectTime => 'Select Time';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get monday => 'Mon';

  @override
  String get tuesday => 'Tue';

  @override
  String get wednesday => 'Wed';

  @override
  String get thursday => 'Thu';

  @override
  String get friday => 'Fri';

  @override
  String get saturday => 'Sat';

  @override
  String get sunday => 'Sun';

  @override
  String get everyday => 'Everyday';

  @override
  String get weekdays => 'Weekdays';

  @override
  String get weekend => 'Weekend';

  @override
  String get deleteConfirmTitle => 'Confirm Delete';

  @override
  String deleteConfirmMessage(String title) {
    return 'Delete \'$title\'?';
  }

  @override
  String get deleteAllRecurring => 'Also delete all future recurring tasks';

  @override
  String get timeChangeTitle => 'Change Time';

  @override
  String timeChangeMessage(String title, String newHour) {
    return 'Change \'$title\' to $newHour:00';
  }

  @override
  String get changeAllRecurring => 'Also change all future recurring tasks';

  @override
  String get change => 'Change';

  @override
  String noTodosForDate(int month, int day) {
    return 'No tasks for $month/$day';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'Failed to add task';

  @override
  String get errorDeleteTodo => 'Failed to delete task';

  @override
  String get errorToggleTodo => 'Failed to update status';

  @override
  String get errorReorderTodo => 'Failed to reorder';

  @override
  String get errorLoadTodos => 'Failed to load tasks';

  @override
  String get cannotDeselectLockedDay =>
      'Cannot deselect the selected date\'s day';

  @override
  String get removeAds => 'Remove Ads';

  @override
  String get purchase => 'Purchase';

  @override
  String get restorePurchase => 'Restore Purchase';

  @override
  String get restorePurchaseDesc => 'Restore your previous purchases';

  @override
  String get processing => 'Processing...';

  @override
  String get checkingPurchase => 'Checking purchase history...';

  @override
  String get purchaseError => 'Unable to start purchase';

  @override
  String get purchaseRestored => 'Purchase restored!';

  @override
  String get noPurchaseToRestore => 'No purchase to restore';

  @override
  String get errorStoreUnavailable => 'Unable to connect to store';

  @override
  String get errorLoadProduct => 'Unable to load product information';

  @override
  String get errorProductNotFound => 'Product not found';

  @override
  String get errorNoProductInfo => 'No product information available';

  @override
  String get errorAlreadyPurchased => 'Already purchased';

  @override
  String get errorPurchaseFailed => 'An error occurred during purchase';

  @override
  String get errorRestoreFailed => 'An error occurred while restoring purchase';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get versionInfo => 'Version';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday, $month/$day';
  }

  @override
  String get emptyTodoTitle => 'No tasks';

  @override
  String get emptyTodoSubtitle => 'Add a new task to get started';

  @override
  String get alreadyPurchasedQuestion => 'Already purchased?';

  @override
  String get adsRemoved => 'Ads removed';
}
