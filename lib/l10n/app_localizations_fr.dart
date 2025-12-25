// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tâches du jour';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get delete => 'Supprimer';

  @override
  String get select => 'Sélectionner';

  @override
  String get settings => 'Paramètres';

  @override
  String get todoInputHint => 'Entrez une tâche';

  @override
  String get recurring => 'Répéter';

  @override
  String get selectTime => 'Sélectionner l\'heure';

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
  String get thursday => 'Jeu';

  @override
  String get friday => 'Ven';

  @override
  String get saturday => 'Sam';

  @override
  String get sunday => 'Dim';

  @override
  String get everyday => 'Tous les jours';

  @override
  String get weekdays => 'Jours ouvrables';

  @override
  String get weekend => 'Week-end';

  @override
  String get deleteConfirmTitle => 'Confirmer la suppression';

  @override
  String deleteConfirmMessage(String title) {
    return 'Supprimer \'$title\' ?';
  }

  @override
  String get deleteAllRecurring =>
      'Supprimer également toutes les tâches récurrentes futures';

  @override
  String get timeChangeTitle => 'Modifier l\'heure';

  @override
  String timeChangeMessage(String title, String newHour) {
    return 'Modifier \'$title\' à $newHour:00';
  }

  @override
  String get changeAllRecurring =>
      'Modifier également toutes les tâches récurrentes futures';

  @override
  String get change => 'Modifier';

  @override
  String noTodosForDate(int month, int day) {
    return 'Aucune tâche pour le $day/$month';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'Échec de l\'ajout de la tâche';

  @override
  String get errorDeleteTodo => 'Échec de la suppression de la tâche';

  @override
  String get errorToggleTodo => 'Échec de la mise à jour du statut';

  @override
  String get errorReorderTodo => 'Échec de la réorganisation';

  @override
  String get errorLoadTodos => 'Échec du chargement des tâches';

  @override
  String get cannotDeselectLockedDay =>
      'Impossible de désélectionner le jour de la date sélectionnée';

  @override
  String get removeAds => 'Supprimer les publicités';

  @override
  String get purchase => 'Acheter';

  @override
  String get restorePurchase => 'Restaurer l\'achat';

  @override
  String get restorePurchaseDesc => 'Restaurer vos achats précédents';

  @override
  String get processing => 'Traitement...';

  @override
  String get checkingPurchase => 'Vérification de l\'historique des achats...';

  @override
  String get purchaseError => 'Impossible de démarrer l\'achat';

  @override
  String get purchaseRestored => 'Achat restauré !';

  @override
  String get noPurchaseToRestore => 'Aucun achat à restaurer';

  @override
  String get errorStoreUnavailable => 'Impossible de se connecter au magasin';

  @override
  String get errorLoadProduct =>
      'Impossible de charger les informations du produit';

  @override
  String get errorProductNotFound => 'Produit non trouvé';

  @override
  String get errorNoProductInfo => 'Aucune information produit disponible';

  @override
  String get errorAlreadyPurchased => 'Déjà acheté';

  @override
  String get errorPurchaseFailed =>
      'Une erreur s\'est produite lors de l\'achat';

  @override
  String get errorRestoreFailed =>
      'Une erreur s\'est produite lors de la restauration de l\'achat';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get versionInfo => 'Version';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday, $day/$month';
  }

  @override
  String get emptyTodoTitle => 'Aucune tâche';

  @override
  String get emptyTodoSubtitle => 'Ajoutez une nouvelle tâche pour commencer';

  @override
  String get alreadyPurchasedQuestion => 'Déjà acheté ?';

  @override
  String get adsRemoved => 'Publicités supprimées';
}
