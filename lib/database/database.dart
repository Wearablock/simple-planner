import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:simple_planner/utils/date_utils.dart';
import 'package:simple_planner/utils/result.dart';
import 'package:simple_planner/utils/weekday_utils.dart';

part 'database.g.dart';

/// Todo 중복 체크를 위한 키 클래스
///
/// 문자열 연결 대신 해시 기반 비교를 사용하여 성능 향상
class TodoKey {
  final int recurringId;
  final int year;
  final int month;
  final int day;
  final int hour;

  const TodoKey({
    required this.recurringId,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
  });

  factory TodoKey.fromTodo(Todo todo) {
    final date = todo.scheduledAt;
    return TodoKey(
      recurringId: todo.recurringId!,
      year: date.year,
      month: date.month,
      day: date.day,
      hour: date.hour,
    );
  }

  factory TodoKey.fromTemplate(RecurringTodo template, DateTime date) {
    return TodoKey(
      recurringId: template.id,
      year: date.year,
      month: date.month,
      day: date.day,
      hour: template.hour,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoKey &&
          recurringId == other.recurringId &&
          year == other.year &&
          month == other.month &&
          day == other.day &&
          hour == other.hour;

  @override
  int get hashCode => Object.hash(recurringId, year, month, day, hour);
}

class RecurringTodos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  IntColumn get hour => integer()();
  IntColumn get weekdays => integer().withDefault(const Constant(127))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  DateTimeColumn get scheduledAt => dateTime()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  IntColumn get recurringId =>
      integer().nullable().references(RecurringTodos, #id)();
}

/// 앱의 메인 데이터베이스
///
/// Todo와 RecurringTodo 테이블을 관리합니다.
@DriftDatabase(tables: [Todos, RecurringTodos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) => m.createAll(),
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.database.customStatement(
          'ALTER TABLE todos ADD COLUMN scheduled_at INTEGER NOT NULL DEFAULT 0',
        );
        await m.database.customStatement(
          'UPDATE todos SET scheduled_at = created_at',
        );
        await m.addColumn(todos, todos.priority);
      }

      if (from < 3) {
        await m.createTable(recurringTodos);
        await m.addColumn(todos, todos.recurringId);
      }

      if (from < 4) {
        await m.database.customStatement(
          'ALTER TABLE todos ADD COLUMN is_deleted INTEGER NOT NULL DEFAULT 0',
        );
      }
    },
  );

  // ============================================================
  // Todo CRUD 작업
  // ============================================================

  /// 새 할 일을 추가합니다.
  ///
  /// [title] 할 일 제목
  /// [scheduledAt] 예정 시간
  /// [priority] 우선순위 (낮을수록 먼저 표시)
  ///
  /// 성공 시 생성된 Todo의 ID를 반환합니다.
  Future<Result<int>> createTodo(
    String title,
    DateTime scheduledAt,
    int priority,
  ) async {
    try {
      final id = await into(todos).insert(
        TodosCompanion.insert(
          title: title,
          scheduledAt: scheduledAt,
          priority: Value(priority),
        ),
      );
      return Success(id);
    } catch (e, s) {
      debugPrint('createTodo 실패: $e');
      return Failure(e, s);
    }
  }

  /// 할 일의 완료 상태를 토글합니다.
  Future<Result<void>> toggleTodoCompletion(Todo todo) async {
    try {
      await update(todos).replace(todo.copyWith(isDone: !todo.isDone));
      return successVoid;
    } catch (e, s) {
      debugPrint('toggleTodoCompletion 실패: $e');
      return Failure(e, s);
    }
  }

  /// 할 일을 삭제합니다 (소프트 삭제).
  Future<Result<void>> deleteTodo(int id) async {
    try {
      await (update(todos)..where((row) => row.id.equals(id))).write(
        const TodosCompanion(isDeleted: Value(true)),
      );
      return successVoid;
    } catch (e, s) {
      debugPrint('deleteTodo 실패: $e');
      return Failure(e, s);
    }
  }

  /// 할 일의 우선순위를 업데이트합니다.
  Future<Result<void>> updateTodoPriority(int id, int newPriority) async {
    try {
      await (update(todos)..where((row) => row.id.equals(id))).write(
        TodosCompanion(priority: Value(newPriority)),
      );
      return successVoid;
    } catch (e, s) {
      debugPrint('updateTodoPriority 실패: $e');
      return Failure(e, s);
    }
  }

  // ============================================================
  // Todo 조회 작업
  // ============================================================

  /// 특정 날짜의 할 일 목록을 실시간으로 스트림합니다.
  ///
  /// 삭제되지 않은 Todo만 반환하며, 시간과 우선순위 순으로 정렬됩니다.
  /// 에러 발생 시 빈 리스트를 반환합니다.
  Stream<List<Todo>> streamTodosByDate(DateTime date) {
    final range = DateRange.forDay(date);

    return (select(todos)
          ..where((row) => row.scheduledAt.isBetweenValues(range.start, range.end))
          ..where((row) => row.isDeleted.equals(false))
          ..orderBy([
            (row) => OrderingTerm(expression: row.scheduledAt),
            (row) => OrderingTerm(expression: row.priority),
          ]))
        .watch()
        .handleError((e, s) {
      debugPrint('streamTodosByDate 실패: $e');
      return <Todo>[];
    });
  }

  /// 특정 날짜, 특정 시간의 할 일 개수를 반환합니다.
  Future<Result<int>> getTodoCountForHour(DateTime date, int hour) async {
    try {
      final range = DateRange.forHour(date, hour);
      final result = await (select(todos)
            ..where(
                (row) => row.scheduledAt.isBetweenValues(range.start, range.end)))
          .get();
      return Success(result.length);
    } catch (e, s) {
      debugPrint('getTodoCountForHour 실패: $e');
      return Failure(e, s);
    }
  }

  /// 특정 날짜 범위의 할 일 목록을 반환합니다.
  ///
  /// 삭제되지 않은 Todo만 반환하며, 시간과 우선순위 순으로 정렬됩니다.
  Future<Result<List<Todo>>> getTodosByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final range = DateRange.between(startDate, endDate);
      final result = await (select(todos)
            ..where(
                (row) => row.scheduledAt.isBetweenValues(range.start, range.end))
            ..where((row) => row.isDeleted.equals(false))
            ..orderBy([
              (row) => OrderingTerm(expression: row.scheduledAt),
              (row) => OrderingTerm(expression: row.priority),
            ]))
          .get();
      return Success(result);
    } catch (e, s) {
      debugPrint('getTodosByDateRange 실패: $e');
      return Failure(e, s);
    }
  }

  /// 특정 시간대의 할 일 순서를 재정렬합니다.
  ///
  /// 배치 업데이트를 사용하여 성능 향상
  Future<Result<void>> reorderTodosInHour(List<int> orderedIds) async {
    try {
      await batch((b) {
        for (int i = 0; i < orderedIds.length; i++) {
          b.update(
            todos,
            TodosCompanion(priority: Value(i)),
            where: (row) => row.id.equals(orderedIds[i]),
          );
        }
      });
      return successVoid;
    } catch (e, s) {
      debugPrint('reorderTodosInHour 실패: $e');
      return Failure(e, s);
    }
  }

  // ============================================================
  // 반복 Todo 관리
  // ============================================================

  /// 새 반복 할 일 템플릿을 생성합니다.
  ///
  /// [title] 할 일 제목
  /// [hour] 매일 실행할 시간 (0-23)
  /// [weekdays] 반복할 요일 비트마스크
  ///
  /// 성공 시 생성된 RecurringTodo의 ID를 반환합니다.
  Future<Result<int>> createRecurringTodo(
    String title,
    int hour,
    int weekdays,
  ) async {
    try {
      final id = await into(recurringTodos).insert(
        RecurringTodosCompanion.insert(
          title: title,
          hour: hour,
          weekdays: Value(weekdays),
        ),
      );
      return Success(id);
    } catch (e, s) {
      debugPrint('createRecurringTodo 실패: $e');
      return Failure(e, s);
    }
  }

  /// 반복 할 일을 비활성화하고 이후 일정을 삭제합니다.
  ///
  /// [recurringId] 반복 할 일 ID
  /// [fromDate] 이 날짜 이후의 할 일을 삭제
  Future<Result<void>> deleteRecurringTodo(
    int recurringId,
    DateTime fromDate,
  ) async {
    try {
      await (update(todos)
            ..where((row) => row.recurringId.equals(recurringId))
            ..where(
                (row) => row.scheduledAt.isBiggerOrEqualValue(fromDate.startOfDay)))
          .write(const TodosCompanion(isDeleted: Value(true)));

      await (update(recurringTodos)..where((row) => row.id.equals(recurringId)))
          .write(const RecurringTodosCompanion(isActive: Value(false)));

      return successVoid;
    } catch (e, s) {
      debugPrint('deleteRecurringTodo 실패: $e');
      return Failure(e, s);
    }
  }

  /// 특정 날짜에 반복 할 일 인스턴스를 생성합니다.
  ///
  /// 해당 요일이 반복 설정에 포함되어 있고,
  /// 같은 날짜에 이미 생성된 인스턴스가 없는 경우에만 생성합니다.
  Future<Result<void>> createTodoFromRecurring(
    int recurringId,
    DateTime date,
  ) async {
    try {
      final template = await (select(recurringTodos)
            ..where((row) => row.id.equals(recurringId))
            ..where((row) => row.isActive.equals(true)))
          .getSingleOrNull();

      if (template == null) return successVoid;
      if (!Weekdays.fromValue(template.weekdays).containsDate(date)) {
        return successVoid;
      }

      final range = DateRange.forDay(date);
      final existing = await (select(todos)
            ..where((row) => row.recurringId.equals(recurringId))
            ..where(
                (row) => row.scheduledAt.isBetweenValues(range.start, range.end)))
          .getSingleOrNull();

      if (existing != null) return successVoid;

      await into(todos).insert(
        TodosCompanion.insert(
          title: template.title,
          scheduledAt: date.withHour(template.hour),
          priority: const Value(0),
          recurringId: Value(template.id),
        ),
      );
      return successVoid;
    } catch (e, s) {
      debugPrint('createTodoFromRecurring 실패: $e');
      return Failure(e, s);
    }
  }

  /// 날짜 범위에 대해 반복 할 일 인스턴스를 일괄 생성합니다.
  ///
  /// 오늘 이전 날짜는 무시하며, 이미 존재하는 인스턴스는 건너뜁니다.
  Future<Result<void>> ensureRecurringTodosExist(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final today = DateTime.now().dateOnly;
      if (endDate.isBefore(today)) return successVoid;

      final effectiveStart = startDate.isAfter(today) ? startDate : today;

      final templates = await _fetchActiveTemplates();
      if (templates.isEmpty) return successVoid;

      final existingKeys = await _buildExistingTodoKeys(effectiveStart, endDate);
      final todosToInsert = _buildTodosToInsert(
        templates,
        effectiveStart,
        endDate,
        existingKeys,
      );

      if (todosToInsert.isNotEmpty) {
        await batch((b) => b.insertAll(todos, todosToInsert));
      }
      return successVoid;
    } catch (e, s) {
      debugPrint('ensureRecurringTodosExist 실패: $e');
      return Failure(e, s);
    }
  }

  // ============================================================
  // Private 헬퍼 메서드
  // ============================================================

  Future<List<RecurringTodo>> _fetchActiveTemplates() {
    return (select(recurringTodos)
          ..where((row) => row.isActive.equals(true)))
        .get();
  }

  Future<Set<TodoKey>> _buildExistingTodoKeys(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final range = DateRange.between(startDate, endDate);
    final existingTodos = await (select(todos)
          ..where((row) => row.recurringId.isNotNull())
          ..where((row) => row.scheduledAt.isBetweenValues(range.start, range.end)))
        .get();

    return existingTodos.map(TodoKey.fromTodo).toSet();
  }

  List<TodosCompanion> _buildTodosToInsert(
    List<RecurringTodo> templates,
    DateTime startDate,
    DateTime endDate,
    Set<TodoKey> existingKeys,
  ) {
    final result = <TodosCompanion>[];

    for (var date = startDate;
        !date.isAfter(endDate);
        date = date.add(const Duration(days: 1))) {
      for (final template in templates) {
        if (!_isTemplateActiveOnDate(template, date)) continue;

        final key = TodoKey.fromTemplate(template, date);
        if (existingKeys.contains(key)) continue;

        result.add(_buildTodoCompanion(template, date));
      }
    }

    return result;
  }

  bool _isTemplateActiveOnDate(RecurringTodo template, DateTime date) {
    return Weekdays.fromValue(template.weekdays).containsDate(date);
  }

  TodosCompanion _buildTodoCompanion(RecurringTodo template, DateTime date) {
    return TodosCompanion.insert(
      title: template.title,
      scheduledAt: date.withHour(template.hour),
      priority: const Value(0),
      recurringId: Value(template.id),
    );
  }

  // ============================================================
  // Demo Data (스크린샷용 - 출시 후 삭제)
  // ============================================================

  /// 스크린샷용 더미 데이터를 생성합니다.
  /// 출시 후 이 메서드와 호출 코드를 삭제하세요.
  Future<void> seedDemoData() async {
    // 이미 데이터가 있으면 스킵
    final existingTodos = await select(todos).get();
    if (existingTodos.isNotEmpty) return;

    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    // 오늘의 할 일들
    final todayTasks = [
      ('Morning workout', 6, true),
      ('Check emails', 8, true),
      ('Team standup meeting', 9, true),
      ('Review project proposal', 10, false),
      ('Lunch break', 12, false),
      ('Client presentation', 14, false),
      ('Code review', 15, false),
      ('Plan tomorrow', 18, false),
      ('Read a book', 21, false),
    ];

    // 내일의 할 일들
    final tomorrowTasks = [
      ('Gym session', 7, false),
      ('Weekly planning', 9, false),
      ('Doctor appointment', 11, false),
      ('Grocery shopping', 17, false),
    ];

    // 오늘 할 일 삽입
    for (var i = 0; i < todayTasks.length; i++) {
      final (title, hour, isDone) = todayTasks[i];
      await into(todos).insert(
        TodosCompanion.insert(
          title: title,
          scheduledAt: today.dateOnly.add(Duration(hours: hour)),
          priority: Value(i),
          isDone: Value(isDone),
        ),
      );
    }

    // 내일 할 일 삽입
    for (var i = 0; i < tomorrowTasks.length; i++) {
      final (title, hour, isDone) = tomorrowTasks[i];
      await into(todos).insert(
        TodosCompanion.insert(
          title: title,
          scheduledAt: tomorrow.dateOnly.add(Duration(hours: hour)),
          priority: Value(i),
          isDone: Value(isDone),
        ),
      );
    }

    debugPrint('✅ Demo data seeded successfully!');
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final docFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(docFolder.path, 'planner.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
