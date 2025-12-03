import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/l10n/app_localizations.dart';
import 'package:simple_planner/main.dart';
import 'package:simple_planner/utils/date_utils.dart';
import 'package:simple_planner/utils/todo_progress_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const CalendarDialog({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  late DateTime _focusedDay;
  late DateTime _selectedDate;
  Map<DateTime, Map<String, int>> _todoStatsMap = {};

  /// 이미 로드된 월을 추적하여 중복 로드 방지
  final Set<String> _loadedMonths = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate;
    _selectedDate = widget.initialDate;
    _initializeDateFormatting();
    _loadTodoStats();
  }

  /// 모든 지원 locale에 대한 날짜 포맷 초기화
  Future<void> _initializeDateFormatting() async {
    await initializeDateFormatting('en');
    await initializeDateFormatting('ko');
    await initializeDateFormatting('ja');
    await initializeDateFormatting('zh');
    await initializeDateFormatting('zh_TW'); // 번체 중국어
    await initializeDateFormatting('es'); // 스페인어
  }

  /// 현재 locale에 맞는 캘린더 locale 문자열 반환
  String _getCalendarLocale(BuildContext context) {
    final locale = Localizations.localeOf(context);
    // table_calendar/intl이 지원하는 locale 형식으로 변환
    // 번체 중국어는 zh_TW로 매핑 (intl 패키지가 zh_Hant를 지원하지 않음)
    if (locale.languageCode == 'zh' && locale.scriptCode == 'Hant') {
      return 'zh_TW';
    }
    if (locale.countryCode != null) {
      return '${locale.languageCode}_${locale.countryCode}';
    }
    return locale.languageCode;
  }

  /// 월 키 생성 (캐시 확인용)
  String _getMonthKey(DateTime date) => '${date.year}-${date.month}';

  Future<void> _loadTodoStats({bool forceReload = false}) async {
    final monthKey = _getMonthKey(_focusedDay);

    // 이미 로드된 월은 건너뛰기 (강제 리로드가 아닌 경우)
    if (!forceReload && _loadedMonths.contains(monthKey)) return;

    final today = DateTime.now().dateOnly;
    final (startDate, endDate) = _getCalendarVisibleRange(_focusedDay);

    if (endDate.isAfter(today) || endDate.isAtSameMomentAs(today)) {
      await database.ensureRecurringTodosExist(startDate, endDate);
    }

    final result = await database.getTodosByDateRange(startDate, endDate);

    if (result.isFailure) return;

    final todos = result.valueOrNull!;
    final newStatsMap = Map<DateTime, Map<String, int>>.from(_todoStatsMap);
    for (final todo in todos) {
      final date = todo.scheduledAt.dateOnly;
      newStatsMap[date] = {'completed': 0, 'total': 0};
    }

    for (final todo in todos) {
      final date = todo.scheduledAt.dateOnly;
      newStatsMap[date]!['total'] = newStatsMap[date]!['total']! + 1;
      if (todo.isDone) {
        newStatsMap[date]!['completed'] = newStatsMap[date]!['completed']! + 1;
      }
    }

    _loadedMonths.add(monthKey);

    setState(() {
      _todoStatsMap = newStatsMap;
    });
  }

  (DateTime, DateTime) _getCalendarVisibleRange(DateTime focusedDay) {
    final firstDayOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);

    final daysToSubtract = firstDayOfMonth.weekday % 7;
    final startOfCalendar = firstDayOfMonth.subtract(
      Duration(days: daysToSubtract),
    );

    final endOfCalendar = startOfCalendar.add(const Duration(days: 41));

    return (startOfCalendar, endOfCalendar);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              locale: _getCalendarLocale(context),
              focusedDay: _focusedDay,
              firstDay: widget.firstDate,
              lastDay: widget.lastDate,
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
                _loadTodoStats();
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final stats = _todoStatsMap[date.dateOnly];
                  if (stats == null) return null;

                  final completed = stats['completed'] ?? 0;
                  final total = stats['total'] ?? 0;

                  if (total > 0) {
                    final status = TodoProgressUtils.getStatus(
                      totalCount: total,
                      completedCount: completed,
                      selectedDate: date,
                    );
                    final statusColor = TodoProgressUtils.getColor(status);

                    return Positioned(
                      bottom: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$completed/$total',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context).cancel),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => Navigator.pop(context, _selectedDate),
                  child: Text(AppLocalizations.of(context).select),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
