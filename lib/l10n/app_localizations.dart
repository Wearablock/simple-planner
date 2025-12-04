import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_th.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
    Locale('de'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('th'),
    Locale('vi'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// App title
  ///
  /// In en, this message translates to:
  /// **'Today\'s Tasks'**
  String get appTitle;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @todoInputHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a task'**
  String get todoInputHint;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get recurring;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @hourFormat.
  ///
  /// In en, this message translates to:
  /// **'{hour}:00'**
  String hourFormat(String hour);

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'{month}/{day}'**
  String dateFormat(int month, int day);

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunday;

  /// No description provided for @everyday.
  ///
  /// In en, this message translates to:
  /// **'Everyday'**
  String get everyday;

  /// No description provided for @weekdays.
  ///
  /// In en, this message translates to:
  /// **'Weekdays'**
  String get weekdays;

  /// No description provided for @weekend.
  ///
  /// In en, this message translates to:
  /// **'Weekend'**
  String get weekend;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete \'{title}\'?'**
  String deleteConfirmMessage(String title);

  /// No description provided for @deleteAllRecurring.
  ///
  /// In en, this message translates to:
  /// **'Also delete all future recurring tasks'**
  String get deleteAllRecurring;

  /// No description provided for @noTodosForDate.
  ///
  /// In en, this message translates to:
  /// **'No tasks for {month}/{day}'**
  String noTodosForDate(int month, int day);

  /// No description provided for @countText.
  ///
  /// In en, this message translates to:
  /// **'{count}'**
  String countText(int count);

  /// No description provided for @errorAddTodo.
  ///
  /// In en, this message translates to:
  /// **'Failed to add task'**
  String get errorAddTodo;

  /// No description provided for @errorDeleteTodo.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete task'**
  String get errorDeleteTodo;

  /// No description provided for @errorToggleTodo.
  ///
  /// In en, this message translates to:
  /// **'Failed to update status'**
  String get errorToggleTodo;

  /// No description provided for @errorReorderTodo.
  ///
  /// In en, this message translates to:
  /// **'Failed to reorder'**
  String get errorReorderTodo;

  /// No description provided for @errorLoadTodos.
  ///
  /// In en, this message translates to:
  /// **'Failed to load tasks'**
  String get errorLoadTodos;

  /// No description provided for @cannotDeselectLockedDay.
  ///
  /// In en, this message translates to:
  /// **'Cannot deselect the selected date\'s day'**
  String get cannotDeselectLockedDay;

  /// No description provided for @removeAds.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAds;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @restorePurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get restorePurchase;

  /// No description provided for @restorePurchaseDesc.
  ///
  /// In en, this message translates to:
  /// **'Restore your previous purchases'**
  String get restorePurchaseDesc;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @checkingPurchase.
  ///
  /// In en, this message translates to:
  /// **'Checking purchase history...'**
  String get checkingPurchase;

  /// No description provided for @purchaseError.
  ///
  /// In en, this message translates to:
  /// **'Unable to start purchase'**
  String get purchaseError;

  /// No description provided for @purchaseRestored.
  ///
  /// In en, this message translates to:
  /// **'Purchase restored!'**
  String get purchaseRestored;

  /// No description provided for @noPurchaseToRestore.
  ///
  /// In en, this message translates to:
  /// **'No purchase to restore'**
  String get noPurchaseToRestore;

  /// No description provided for @errorStoreUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to store'**
  String get errorStoreUnavailable;

  /// No description provided for @errorLoadProduct.
  ///
  /// In en, this message translates to:
  /// **'Unable to load product information'**
  String get errorLoadProduct;

  /// No description provided for @errorProductNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get errorProductNotFound;

  /// No description provided for @errorNoProductInfo.
  ///
  /// In en, this message translates to:
  /// **'No product information available'**
  String get errorNoProductInfo;

  /// No description provided for @errorAlreadyPurchased.
  ///
  /// In en, this message translates to:
  /// **'Already purchased'**
  String get errorAlreadyPurchased;

  /// No description provided for @errorPurchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during purchase'**
  String get errorPurchaseFailed;

  /// No description provided for @errorRestoreFailed.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while restoring purchase'**
  String get errorRestoreFailed;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @versionInfo.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionInfo;

  /// No description provided for @dateWithWeekday.
  ///
  /// In en, this message translates to:
  /// **'{weekday}, {month}/{day}'**
  String dateWithWeekday(int month, int day, String weekday);

  /// No description provided for @emptyTodoTitle.
  ///
  /// In en, this message translates to:
  /// **'No tasks'**
  String get emptyTodoTitle;

  /// No description provided for @emptyTodoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a new task to get started'**
  String get emptyTodoSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'id',
    'it',
    'ja',
    'ko',
    'pt',
    'th',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'th':
      return AppLocalizationsTh();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
