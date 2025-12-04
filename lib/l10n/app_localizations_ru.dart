// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Задачи на сегодня';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get delete => 'Удалить';

  @override
  String get select => 'Выбрать';

  @override
  String get settings => 'Настройки';

  @override
  String get todoInputHint => 'Введите задачу';

  @override
  String get recurring => 'Повторять';

  @override
  String get selectTime => 'Выбрать время';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day.$month';
  }

  @override
  String get monday => 'Пн';

  @override
  String get tuesday => 'Вт';

  @override
  String get wednesday => 'Ср';

  @override
  String get thursday => 'Чт';

  @override
  String get friday => 'Пт';

  @override
  String get saturday => 'Сб';

  @override
  String get sunday => 'Вс';

  @override
  String get everyday => 'Каждый день';

  @override
  String get weekdays => 'Будние дни';

  @override
  String get weekend => 'Выходные';

  @override
  String get deleteConfirmTitle => 'Подтвердите удаление';

  @override
  String deleteConfirmMessage(String title) {
    return 'Удалить \'$title\'?';
  }

  @override
  String get deleteAllRecurring =>
      'Удалить также все будущие повторяющиеся задачи';

  @override
  String noTodosForDate(int month, int day) {
    return 'Нет задач на $day.$month';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'Не удалось добавить задачу';

  @override
  String get errorDeleteTodo => 'Не удалось удалить задачу';

  @override
  String get errorToggleTodo => 'Не удалось обновить статус';

  @override
  String get errorReorderTodo => 'Не удалось изменить порядок';

  @override
  String get errorLoadTodos => 'Не удалось загрузить задачи';

  @override
  String get cannotDeselectLockedDay =>
      'Невозможно отменить выбор дня для выбранной даты';

  @override
  String get removeAds => 'Убрать рекламу';

  @override
  String get purchase => 'Купить';

  @override
  String get restorePurchase => 'Восстановить покупку';

  @override
  String get restorePurchaseDesc => 'Восстановить предыдущие покупки';

  @override
  String get processing => 'Обработка...';

  @override
  String get checkingPurchase => 'Проверка истории покупок...';

  @override
  String get purchaseError => 'Не удалось начать покупку';

  @override
  String get purchaseRestored => 'Покупка восстановлена!';

  @override
  String get noPurchaseToRestore => 'Нет покупок для восстановления';

  @override
  String get errorStoreUnavailable => 'Не удалось подключиться к магазину';

  @override
  String get errorLoadProduct => 'Не удалось загрузить информацию о продукте';

  @override
  String get errorProductNotFound => 'Продукт не найден';

  @override
  String get errorNoProductInfo => 'Нет информации о продукте';

  @override
  String get errorAlreadyPurchased => 'Уже куплено';

  @override
  String get errorPurchaseFailed => 'Произошла ошибка при покупке';

  @override
  String get errorRestoreFailed =>
      'Произошла ошибка при восстановлении покупки';

  @override
  String get termsOfService => 'Условия использования';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get versionInfo => 'Версия';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday, $day.$month';
  }

  @override
  String get emptyTodoTitle => 'Нет задач';

  @override
  String get emptyTodoSubtitle => 'Добавьте новую задачу, чтобы начать';
}
