// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Tareas de Hoy';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get delete => 'Eliminar';

  @override
  String get select => 'Seleccionar';

  @override
  String get settings => 'Ajustes';

  @override
  String get todoInputHint => 'Ingresa una tarea';

  @override
  String get recurring => 'Repetir';

  @override
  String get selectTime => 'Seleccionar hora';

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
  String get wednesday => 'Mié';

  @override
  String get thursday => 'Jue';

  @override
  String get friday => 'Vie';

  @override
  String get saturday => 'Sáb';

  @override
  String get sunday => 'Dom';

  @override
  String get everyday => 'Todos los días';

  @override
  String get weekdays => 'Días laborales';

  @override
  String get weekend => 'Fin de semana';

  @override
  String get deleteConfirmTitle => 'Confirmar eliminación';

  @override
  String deleteConfirmMessage(String title) {
    return '¿Eliminar \'$title\'?';
  }

  @override
  String get deleteAllRecurring =>
      'Eliminar también todas las tareas recurrentes futuras';

  @override
  String noTodosForDate(int month, int day) {
    return 'No hay tareas para $day/$month';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'Error al agregar tarea';

  @override
  String get errorDeleteTodo => 'Error al eliminar tarea';

  @override
  String get errorToggleTodo => 'Error al actualizar estado';

  @override
  String get errorReorderTodo => 'Error al reordenar';

  @override
  String get errorLoadTodos => 'Error al cargar tareas';

  @override
  String get cannotDeselectLockedDay =>
      'No se puede deseleccionar el día de la fecha seleccionada';

  @override
  String get removeAds => 'Eliminar anuncios';

  @override
  String get purchase => 'Comprar';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get restorePurchaseDesc => 'Restaurar tus compras anteriores';

  @override
  String get processing => 'Procesando...';

  @override
  String get checkingPurchase => 'Verificando historial de compras...';

  @override
  String get purchaseError => 'No se puede iniciar la compra';

  @override
  String get purchaseRestored => '¡Compra restaurada!';

  @override
  String get noPurchaseToRestore => 'No hay compras para restaurar';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get versionInfo => 'Versión';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday, $day/$month';
  }

  @override
  String get emptyTodoTitle => 'No hay tareas';

  @override
  String get emptyTodoSubtitle => 'Agrega una nueva tarea para comenzar';
}
