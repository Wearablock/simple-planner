// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Heutige Aufgaben';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get delete => 'Löschen';

  @override
  String get select => 'Auswählen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get todoInputHint => 'Aufgabe eingeben';

  @override
  String get recurring => 'Wiederholen';

  @override
  String get selectTime => 'Zeit auswählen';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day.$month.';
  }

  @override
  String get monday => 'Mo';

  @override
  String get tuesday => 'Di';

  @override
  String get wednesday => 'Mi';

  @override
  String get thursday => 'Do';

  @override
  String get friday => 'Fr';

  @override
  String get saturday => 'Sa';

  @override
  String get sunday => 'So';

  @override
  String get everyday => 'Jeden Tag';

  @override
  String get weekdays => 'Wochentage';

  @override
  String get weekend => 'Wochenende';

  @override
  String get deleteConfirmTitle => 'Löschen bestätigen';

  @override
  String deleteConfirmMessage(String title) {
    return '\'$title\' löschen?';
  }

  @override
  String get deleteAllRecurring =>
      'Auch alle zukünftigen wiederkehrenden Aufgaben löschen';

  @override
  String noTodosForDate(int month, int day) {
    return 'Keine Aufgaben für $day.$month.';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'Aufgabe konnte nicht hinzugefügt werden';

  @override
  String get errorDeleteTodo => 'Aufgabe konnte nicht gelöscht werden';

  @override
  String get errorToggleTodo => 'Status konnte nicht aktualisiert werden';

  @override
  String get errorReorderTodo => 'Neuordnung fehlgeschlagen';

  @override
  String get errorLoadTodos => 'Aufgaben konnten nicht geladen werden';

  @override
  String get cannotDeselectLockedDay =>
      'Der Tag des ausgewählten Datums kann nicht abgewählt werden';

  @override
  String get removeAds => 'Werbung entfernen';

  @override
  String get purchase => 'Kaufen';

  @override
  String get restorePurchase => 'Kauf wiederherstellen';

  @override
  String get restorePurchaseDesc => 'Ihre früheren Käufe wiederherstellen';

  @override
  String get processing => 'Verarbeitung...';

  @override
  String get checkingPurchase => 'Kaufverlauf wird überprüft...';

  @override
  String get purchaseError => 'Kauf konnte nicht gestartet werden';

  @override
  String get purchaseRestored => 'Kauf wiederhergestellt!';

  @override
  String get noPurchaseToRestore => 'Kein Kauf zum Wiederherstellen';

  @override
  String get errorStoreUnavailable => 'Verbindung zum Store nicht möglich';

  @override
  String get errorLoadProduct =>
      'Produktinformationen konnten nicht geladen werden';

  @override
  String get errorProductNotFound => 'Produkt nicht gefunden';

  @override
  String get errorNoProductInfo => 'Keine Produktinformationen verfügbar';

  @override
  String get errorAlreadyPurchased => 'Bereits gekauft';

  @override
  String get errorPurchaseFailed => 'Beim Kauf ist ein Fehler aufgetreten';

  @override
  String get errorRestoreFailed =>
      'Beim Wiederherstellen des Kaufs ist ein Fehler aufgetreten';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get versionInfo => 'Version';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday, $day.$month.';
  }

  @override
  String get emptyTodoTitle => 'Keine Aufgaben';

  @override
  String get emptyTodoSubtitle =>
      'Fügen Sie eine neue Aufgabe hinzu, um zu beginnen';
}
