// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Attività di oggi';

  @override
  String get cancel => 'Annulla';

  @override
  String get confirm => 'Conferma';

  @override
  String get delete => 'Elimina';

  @override
  String get select => 'Seleziona';

  @override
  String get settings => 'Impostazioni';

  @override
  String get todoInputHint => 'Inserisci un\'attività';

  @override
  String get recurring => 'Ripeti';

  @override
  String get selectTime => 'Seleziona orario';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get monday => 'Lun';

  @override
  String get tuesday => 'Mar';

  @override
  String get wednesday => 'Mer';

  @override
  String get thursday => 'Gio';

  @override
  String get friday => 'Ven';

  @override
  String get saturday => 'Sab';

  @override
  String get sunday => 'Dom';

  @override
  String get everyday => 'Ogni giorno';

  @override
  String get weekdays => 'Giorni feriali';

  @override
  String get weekend => 'Fine settimana';

  @override
  String get deleteConfirmTitle => 'Conferma eliminazione';

  @override
  String deleteConfirmMessage(String title) {
    return 'Eliminare \'$title\'?';
  }

  @override
  String get deleteAllRecurring =>
      'Elimina anche tutte le attività ricorrenti future';

  @override
  String get timeChangeTitle => 'Cambia orario';

  @override
  String timeChangeMessage(String title, String newHour) {
    return 'Cambiare \'$title\' a $newHour:00';
  }

  @override
  String get changeAllRecurring =>
      'Cambia anche tutte le attività ricorrenti future';

  @override
  String get change => 'Cambia';

  @override
  String noTodosForDate(int month, int day) {
    return 'Nessuna attività per il $day/$month';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'Impossibile aggiungere l\'attività';

  @override
  String get errorDeleteTodo => 'Impossibile eliminare l\'attività';

  @override
  String get errorToggleTodo => 'Impossibile aggiornare lo stato';

  @override
  String get errorReorderTodo => 'Impossibile riordinare';

  @override
  String get errorLoadTodos => 'Impossibile caricare le attività';

  @override
  String get cannotDeselectLockedDay =>
      'Impossibile deselezionare il giorno della data selezionata';

  @override
  String get removeAds => 'Rimuovi pubblicità';

  @override
  String get purchase => 'Acquista';

  @override
  String get restorePurchase => 'Ripristina acquisto';

  @override
  String get restorePurchaseDesc => 'Ripristina i tuoi acquisti precedenti';

  @override
  String get processing => 'Elaborazione...';

  @override
  String get checkingPurchase => 'Verifica cronologia acquisti...';

  @override
  String get purchaseError => 'Impossibile avviare l\'acquisto';

  @override
  String get purchaseRestored => 'Acquisto ripristinato!';

  @override
  String get noPurchaseToRestore => 'Nessun acquisto da ripristinare';

  @override
  String get errorStoreUnavailable => 'Impossibile connettersi allo store';

  @override
  String get errorLoadProduct =>
      'Impossibile caricare le informazioni del prodotto';

  @override
  String get errorProductNotFound => 'Prodotto non trovato';

  @override
  String get errorNoProductInfo =>
      'Nessuna informazione sul prodotto disponibile';

  @override
  String get errorAlreadyPurchased => 'Già acquistato';

  @override
  String get errorPurchaseFailed =>
      'Si è verificato un errore durante l\'acquisto';

  @override
  String get errorRestoreFailed =>
      'Si è verificato un errore durante il ripristino dell\'acquisto';

  @override
  String get termsOfService => 'Termini di servizio';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get versionInfo => 'Versione';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday, $day/$month';
  }

  @override
  String get emptyTodoTitle => 'Nessuna attività';

  @override
  String get emptyTodoSubtitle => 'Aggiungi una nuova attività per iniziare';

  @override
  String get alreadyPurchasedQuestion => 'Già acquistato?';

  @override
  String get adsRemoved => 'Pubblicità rimosse';
}
