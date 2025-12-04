// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Tarefas de Hoje';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get delete => 'Excluir';

  @override
  String get select => 'Selecionar';

  @override
  String get settings => 'Configurações';

  @override
  String get todoInputHint => 'Digite uma tarefa';

  @override
  String get recurring => 'Repetir';

  @override
  String get selectTime => 'Selecionar horário';

  @override
  String hourFormat(String hour) {
    return '$hour:00';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get monday => 'Seg';

  @override
  String get tuesday => 'Ter';

  @override
  String get wednesday => 'Qua';

  @override
  String get thursday => 'Qui';

  @override
  String get friday => 'Sex';

  @override
  String get saturday => 'Sáb';

  @override
  String get sunday => 'Dom';

  @override
  String get everyday => 'Todos os dias';

  @override
  String get weekdays => 'Dias úteis';

  @override
  String get weekend => 'Fim de semana';

  @override
  String get deleteConfirmTitle => 'Confirmar exclusão';

  @override
  String deleteConfirmMessage(String title) {
    return 'Excluir \'$title\'?';
  }

  @override
  String get deleteAllRecurring =>
      'Excluir também todas as tarefas recorrentes futuras';

  @override
  String noTodosForDate(int month, int day) {
    return 'Nenhuma tarefa para $day/$month';
  }

  @override
  String countText(int count) {
    return '$count';
  }

  @override
  String get errorAddTodo => 'Falha ao adicionar tarefa';

  @override
  String get errorDeleteTodo => 'Falha ao excluir tarefa';

  @override
  String get errorToggleTodo => 'Falha ao atualizar status';

  @override
  String get errorReorderTodo => 'Falha ao reordenar';

  @override
  String get errorLoadTodos => 'Falha ao carregar tarefas';

  @override
  String get cannotDeselectLockedDay =>
      'Não é possível desmarcar o dia da data selecionada';

  @override
  String get removeAds => 'Remover anúncios';

  @override
  String get purchase => 'Comprar';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get restorePurchaseDesc => 'Restaurar suas compras anteriores';

  @override
  String get processing => 'Processando...';

  @override
  String get checkingPurchase => 'Verificando histórico de compras...';

  @override
  String get purchaseError => 'Não foi possível iniciar a compra';

  @override
  String get purchaseRestored => 'Compra restaurada!';

  @override
  String get noPurchaseToRestore => 'Nenhuma compra para restaurar';

  @override
  String get errorStoreUnavailable => 'Não foi possível conectar à loja';

  @override
  String get errorLoadProduct =>
      'Não foi possível carregar as informações do produto';

  @override
  String get errorProductNotFound => 'Produto não encontrado';

  @override
  String get errorNoProductInfo => 'Nenhuma informação de produto disponível';

  @override
  String get errorAlreadyPurchased => 'Já comprado';

  @override
  String get errorPurchaseFailed => 'Ocorreu um erro durante a compra';

  @override
  String get errorRestoreFailed => 'Ocorreu um erro ao restaurar a compra';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get versionInfo => 'Versão';

  @override
  String dateWithWeekday(int month, int day, String weekday) {
    return '$weekday, $day/$month';
  }

  @override
  String get emptyTodoTitle => 'Nenhuma tarefa';

  @override
  String get emptyTodoSubtitle => 'Adicione uma nova tarefa para começar';
}
