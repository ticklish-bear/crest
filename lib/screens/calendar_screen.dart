import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../providers/cycle_provider.dart';
import '../models/cycle.dart';
import '../models/day_entry.dart';
import '../models/settings.dart';
import '../services/stm_engine.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import 'day_entry_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, DayEntry> _entriesMap = {};
  DateTime? _lastTappedDay; // For double-tap detection
  DateTime _lastTapTime = DateTime(2000);

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    try {
      final provider = context.read<CycleProvider>();
      final start = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
      final end = DateTime(_focusedDay.year, _focusedDay.month + 2, 0);
      final entries = await provider.getEntriesForRange(start, end);
      if (mounted) {
        setState(() => _entriesMap = entries);
      }
    } catch (_) {
      // Database might not be ready yet
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Consumer<CycleProvider>(
      builder: (context, provider, _) {
        final currentCycle = provider.currentCycle;
        final evaluation = provider.currentEvaluation;

        return Column(
          children: [
            _buildCycleHeader(context, provider, currentCycle),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Quick-entry for today
                    _buildTodayQuickEntry(context, provider, evaluation, colors),
                    TableCalendar(
                      firstDay: DateTime(2020, 1, 1),
                      lastDay:
                          DateTime.now().add(const Duration(days: 365)),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) =>
                          isSameDay(provider.selectedDate, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        provider.selectDate(selectedDay);
                        setState(() => _focusedDay = focusedDay);
                        // Double-tap mode: open editor on second tap of same day
                        if (provider.settings.calendarTapAction ==
                            CalendarTapAction.doubleTap) {
                          if (isSameDay(_lastTappedDay, selectedDay) &&
                              DateTime.now().difference(_lastTapTime).inMilliseconds < 500) {
                            _openDayEntry(selectedDay);
                            _lastTappedDay = null;
                          } else {
                            _lastTappedDay = selectedDay;
                            _lastTapTime = DateTime.now();
                          }
                        }
                      },
                      onDayLongPressed: provider.settings.calendarTapAction ==
                              CalendarTapAction.longPress
                          ? (selectedDay, focusedDay) {
                              provider.selectDate(selectedDay);
                              setState(() => _focusedDay = focusedDay);
                              _openDayEntry(selectedDay);
                            }
                          : null,
                      onFormatChanged: (format) {
                        setState(() => _calendarFormat = format);
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                        _loadEntries();
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: colors.primary, width: 2),
                        ),
                        todayTextStyle: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: colors.primary,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        outsideDaysVisible: false,
                        weekendTextStyle:
                            TextStyle(color: colors.onSurfaceVariant),
                        defaultTextStyle: TextStyle(color: colors.onSurface),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: true,
                        titleCentered: true,
                        formatButtonShowsNext: false,
                        titleTextStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                        ),
                        formatButtonDecoration: BoxDecoration(
                          border: Border.all(color: colors.outlineVariant),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        formatButtonTextStyle: TextStyle(
                          fontSize: 12,
                          color: colors.onSurfaceVariant,
                        ),
                        leftChevronIcon: Icon(Icons.chevron_left,
                            color: colors.onSurfaceVariant),
                        rightChevronIcon: Icon(Icons.chevron_right,
                            color: colors.onSurfaceVariant),
                      ),
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, date, events) {
                          // No separate markers — status shown via background
                          return null;
                        },
                        defaultBuilder: (context, date, focusedDay) {
                          return _buildDayCell(
                              date, currentCycle, evaluation, colors,
                              provider.settings);
                        },
                        todayBuilder: (context, date, focusedDay) {
                          return _buildDayCell(
                              date, currentCycle, evaluation, colors,
                              provider.settings,
                              isToday: true);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child:
                          _buildDaySummary(context, provider, colors),
                    ),
                    const SizedBox(height: 16),
                    _buildLegend(provider.settings.purpose),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodayQuickEntry(BuildContext context,
      CycleProvider provider, StmEvaluation? evaluation,
      ColorScheme colors) {
    final l = AppLocalizations.of(context)!;
    final today = DateTime.now();
    final todayEntry = provider.getEntryForDate(today);
    final hasTodayData = todayEntry != null &&
        (todayEntry.temperature != null ||
            todayEntry.mucusType != MucusType.dry ||
            todayEntry.bleeding != BleedingType.none);

    // Don't show if today already has data
    if (hasTodayData) return const SizedBox.shrink();

    // Only show if there's an active cycle
    if (provider.currentCycle == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Material(
        color: colors.primaryContainer.withAlpha(60),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _openDayEntry(today),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.add_circle_outline,
                    size: 20, color: colors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.logTodayTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: colors.primary,
                          )),
                      Text(
                        l.logTodaySub,
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right,
                    size: 20, color: colors.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildDayCell(DateTime date, Cycle? currentCycle,
      StmEvaluation? evaluation, ColorScheme colors,
      AppSettings settings,
      {bool isToday = false}) {
    final normalized = DateTime(date.year, date.month, date.day);
    final entry = _entriesMap[normalized];

    Color? bgColor;
    FertilityStatus? status;
    int? cycleDay;
    if (currentCycle != null) {
      final cd =
          normalized.difference(currentCycle.startDate).inDays + 1;
      if (cd >= 1) {
        cycleDay = cd;
        if (evaluation != null) {
          status = evaluation.dayStatuses[cd];
          if (status != null) {
            // Use bleeding-intensity colors for menstruation days
            if (status == FertilityStatus.menstruation &&
                entry != null &&
                entry.bleeding != BleedingType.none) {
              bgColor = AppTheme.bleedingColor(entry.bleeding.index);
            } else {
              bgColor = _statusBgColor(status);
            }
          }
        }
      }
    }

    final hasTemp = entry != null && entry.temperature != null;
    final hasData = entry != null &&
        (entry.temperature != null ||
            entry.hasMucusRecorded ||
            entry.bleeding != BleedingType.none);
    // Show secondary line: temperature > cycle day > data dot
    final bool hasSecondLine = hasTemp || cycleDay != null;

    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: isToday
            ? Border.all(color: colors.primary, width: 2)
            : null,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${date.day}',
            style: TextStyle(
              color: bgColor != null
                  ? Colors.white
                  : isToday
                      ? colors.primary
                      : colors.onSurface,
              fontSize: hasSecondLine ? 11 : 14,
              fontWeight:
                  isToday ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          if (hasTemp)
            Text(
              settings.displayTemp(entry.temperature!).toStringAsFixed(1),
              style: TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.w500,
                color: bgColor != null
                    ? Colors.white.withAlpha(200)
                    : colors.onSurfaceVariant,
              ),
            )
          else if (cycleDay != null)
            Text(
              '$cycleDay',
              style: TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.w300,
                color: bgColor != null
                    ? Colors.white.withAlpha(160)
                    : colors.onSurfaceVariant.withAlpha(150),
              ),
            ),
          // Small dot for non-temp data when cycle day is shown
          if (!hasTemp && hasData && cycleDay != null)
            Container(
              width: 3,
              height: 3,
              margin: const EdgeInsets.only(top: 1),
              decoration: BoxDecoration(
                color: bgColor != null
                    ? Colors.white.withAlpha(180)
                    : colors.primary.withAlpha(150),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCycleHeader(
      BuildContext context, CycleProvider provider, Cycle? cycle) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    if (cycle == null) {
      return Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: colors.primaryContainer.withAlpha(80),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.noActiveCycle,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l.noActiveCycleSub,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            FilledButton.tonal(
              onPressed: () => _startNewCycle(context, provider),
              child: Text(l.start),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              l.cycleDayBadge(cycle.currentDayCount),
              style: TextStyle(
                color: colors.onPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l.cycleStarted(DateFormat('MMM d', locale).format(cycle.startDate)),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline,
                color: colors.primary, size: 22),
            tooltip: l.startNewCycleTooltip,
            onPressed: () => _startNewCycle(context, provider),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySummary(
      BuildContext context, CycleProvider provider, ColorScheme colors) {
    final l = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final entry = provider.getEntryForDate(provider.selectedDate);
    final status = provider.getFertilityStatus(provider.selectedDate);
    final cycle = provider.currentCycle;
    final purpose = provider.settings.purpose;

    // Compute cycle day for rule explanations
    int? cycleDay;
    if (cycle != null) {
      cycleDay = provider.selectedDate
              .difference(cycle.startDate)
              .inDays +
          1;
      if (cycleDay < 1) cycleDay = null;
    }

    return Card(
      child: InkWell(
        onTap: () => _openDayEntry(provider.selectedDate),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      DateFormat('EEEE, MMM d', locale)
                          .format(provider.selectedDate),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (status != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusChipColor(status).withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _statusChipColor(status).withAlpha(80),
                        ),
                      ),
                      child: Text(
                        _localizedStatusLabel(l, status, purpose,
                            cycleDay, provider.currentEvaluation),
                        style: TextStyle(
                          color: _statusChipColor(status),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (cycleDay != null)
                      GestureDetector(
                        onTap: () => _showRuleExplanation(
                            context, status, cycleDay!, purpose,
                            provider.currentEvaluation),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(Icons.info_outline,
                              size: 16,
                              color: colors.onSurfaceVariant
                                  .withAlpha(150)),
                        ),
                      ),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              if (entry != null) ...[
                if (entry.temperature != null)
                  _infoRow(
                      Icons.thermostat_outlined,
                      l.sectionTemperature,
                      '${provider.settings.displayTemp(entry.temperature!).toStringAsFixed(2)} ${provider.settings.tempUnitLabel}',
                      colors),
                if (entry.hasMucusRecorded && entry.mucusType != MucusType.dry)
                  _infoRow(Icons.water_drop_outlined, l.mucusShort,
                      _mucusLabel(entry.mucusType), colors),
                if (entry.bleeding != BleedingType.none)
                  _infoRow(Icons.circle, l.sectionBleeding,
                      _bleedingLabel(entry.bleeding), colors,
                      iconColor: AppColors.menstruation),
              ] else
                Row(
                  children: [
                    Icon(Icons.add_circle_outline,
                        size: 16, color: colors.primary),
                    const SizedBox(width: 8),
                    Text(
                      l.tapToAddEntry,
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      ColorScheme colors,
      {Color? iconColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon,
              size: 16, color: iconColor ?? colors.onSurfaceVariant),
          const SizedBox(width: 8),
          Text('$label: ',
              style: TextStyle(
                  color: colors.onSurfaceVariant, fontSize: 13)),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildLegend(AppPurpose purpose) {
    final l = AppLocalizations.of(context)!;
    final isAnti = purpose == AppPurpose.anticonception;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 12,
        runSpacing: 6,
        children: [
          _legendItem(AppColors.menstruation,
              isAnti ? l.legendPeriodInfertile : l.legendPeriod),
          _legendItem(AppColors.infertilePre,
              isAnti ? l.legendPotFertile : l.legendPhase1),
          _legendItem(AppColors.fertile, l.statusFertile),
          _legendItem(AppColors.infertilePost,
              isAnti ? l.legendInfertileConfirmed : l.legendPostOv),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  void _openDayEntry(DateTime date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DayEntryScreen(date: date),
      ),
    ).then((_) => _loadEntries());
  }

  Future<void> _startNewCycle(
      BuildContext context, CycleProvider provider) async {
    final l = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
      helpText: l.periodStartHelp,
    );

    if (date != null && context.mounted) {
      final result = await showDialog<_NewCycleResult>(
        context: context,
        builder: (ctx) => _NewCycleDialog(
          date: date,
          hasExistingCycle: provider.currentCycle != null,
        ),
      );

      if (result != null) {
        await provider.startNewCycle(date, bleeding: result.bleeding);
        _loadEntries();
      }
    }
  }

  Color _statusBgColor(FertilityStatus status) {
    switch (status) {
      case FertilityStatus.menstruation:
        return AppColors.menstruation.withAlpha(140);
      case FertilityStatus.fertile:
        return AppColors.fertile.withAlpha(100);
      case FertilityStatus.fertileWaitingForDoubleCheck:
        // Still fertile — use fertile color but slightly different alpha
        // to hint that something has been detected
        return AppColors.fertile.withAlpha(70);
      case FertilityStatus.infertilePreOvulation:
        return AppColors.infertilePre.withAlpha(100);
      case FertilityStatus.infertilePostOvulation:
        return AppColors.infertilePost.withAlpha(100);
      case FertilityStatus.unknown:
        return Colors.transparent;
    }
  }

  void _showRuleExplanation(BuildContext context,
      FertilityStatus status, int cycleDay, AppPurpose purpose,
      StmEvaluation? evaluation) {
    final l = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;
    final explanation =
        _statusExplanation(status, cycleDay, purpose, evaluation, lang);
    final ruleDetail =
        _statusRuleDetail(status, cycleDay, purpose, evaluation, lang);

    showDialog(
      context: context,
      builder: (ctx) {
        final colors = Theme.of(ctx).colorScheme;
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.school_outlined,
                  size: 20, color: colors.primary),
              const SizedBox(width: 8),
              Text(l.stmRuleTitle, style: const TextStyle(fontSize: 16)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _statusChipColor(status).withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _localizedStatusLabel(l, status, purpose, cycleDay,
                      evaluation),
                  style: TextStyle(
                    color: _statusChipColor(status),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(explanation,
                  style: const TextStyle(fontSize: 14, height: 1.4)),
              if (ruleDetail != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest
                        .withAlpha(120),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.menu_book_outlined,
                          size: 14,
                          color: colors.onSurfaceVariant),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(ruleDetail,
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.onSurfaceVariant,
                              height: 1.4,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l.gotIt),
            ),
          ],
        );
      },
    );
  }

  /// Short explanation for inline display
  String _statusExplanation(FertilityStatus status, int cycleDay,
      AppPurpose purpose, StmEvaluation? evaluation, String lang) {
    if (lang == 'de') {
      return _statusExplanationDe(status, cycleDay, purpose, evaluation);
    }
    if (lang == 'es') {
      return _statusExplanationEs(status, cycleDay, purpose, evaluation);
    }
    switch (status) {
      case FertilityStatus.menstruation:
        if (purpose == AppPurpose.anticonception) {
          final limit = evaluation?.lastInfertilePreOvDay ?? 5;
          if (cycleDay <= limit) {
            final ruleDesc = evaluation != null
                ? StmEngine.preOvRuleDescription(
                    evaluation.appliedPreOvRule)
                : '5-day rule';
            return 'Cycle day $cycleDay of $limit \u2014 '
                'infertile per $ruleDesc. '
                'No fertile mucus must be observed.';
          } else {
            return 'Cycle day $cycleDay \u2014 bleeding after day $limit '
                'is not automatically infertile. '
                'Ovulation may be approaching.';
          }
        }
        return 'Cycle day $cycleDay \u2014 menstruation';

      case FertilityStatus.infertilePreOvulation:
        if (purpose == AppPurpose.anticonception) {
          return 'Cycle day $cycleDay \u2014 ovulation not yet confirmed by '
              'temperature shift; treat as potentially fertile';
        }
        return 'Cycle day $cycleDay \u2014 pre-ovulatory phase, '
            'no fertile signs observed';

      case FertilityStatus.fertile:
        if (evaluation?.peakDay != null) {
          return 'Cycle day $cycleDay \u2014 fertile signs present '
              '(Peak Day: day ${evaluation!.peakDay})';
        }
        return 'Cycle day $cycleDay \u2014 fertile signs present, '
            'ovulation not yet confirmed';

      case FertilityStatus.fertileWaitingForDoubleCheck:
        final shiftDay = evaluation?.temperatureShiftConfirmedDay;
        final peakDay = evaluation?.peakDay;
        if (shiftDay != null && peakDay == null) {
          return 'Cycle day $cycleDay \u2014 temperature shift detected '
              '(day $shiftDay), but Peak Day has not been confirmed yet. '
              'STILL FERTILE \u2014 the double-check requires both.';
        } else if (peakDay != null && shiftDay == null) {
          return 'Cycle day $cycleDay \u2014 Peak Day detected '
              '(day $peakDay), but temperature shift has not been confirmed. '
              'STILL FERTILE \u2014 the double-check requires both.';
        }
        return 'Cycle day $cycleDay \u2014 awaiting double-check confirmation. '
            'STILL FERTILE.';

      case FertilityStatus.infertilePostOvulation:
        final shiftDay = evaluation?.temperatureShiftConfirmedDay;
        final peakDay = evaluation?.peakDay;
        return 'Cycle day $cycleDay \u2014 infertile phase confirmed by '
            'double-check: temp shift confirmed day $shiftDay '
            'AND Peak Day $peakDay + 3';

      case FertilityStatus.unknown:
        return 'Cycle day $cycleDay \u2014 insufficient data for evaluation';
    }
  }

  /// Detailed rule citation for the info popup
  String? _statusRuleDetail(FertilityStatus status, int cycleDay,
      AppPurpose purpose, StmEvaluation? evaluation, String lang) {
    if (lang == 'de') {
      return _statusRuleDetailDe(status, cycleDay, purpose, evaluation);
    }
    if (lang == 'es') {
      return _statusRuleDetailEs(status, cycleDay, purpose, evaluation);
    }
    switch (status) {
      case FertilityStatus.menstruation:
        if (purpose == AppPurpose.anticonception) {
          final limit = evaluation?.lastInfertilePreOvDay ?? 5;
          if (cycleDay <= limit) {
            return _preOvRuleDetailText(evaluation, lang);
          } else {
            return 'Bleeding after cycle day $limit does not '
                'automatically indicate infertility. Ovulation may '
                'be approaching. Continue observing cervical mucus '
                'and temperature.';
          }
        }
        return null;

      case FertilityStatus.infertilePreOvulation:
        if (purpose == AppPurpose.anticonception) {
          return 'In the symptothermal method, the pre-ovulatory '
              'phase after menstruation cannot be confirmed as '
              'infertile without a temperature shift. Fertile mucus '
              'may appear at any time. For avoiding pregnancy, '
              'treat these days with caution.';
        }
        return 'No fertile cervical mucus signs observed. '
            'This phase ends when mucus quality increases or '
            'other fertile signs appear.';

      case FertilityStatus.fertile:
        return 'The fertile window is identified by cervical mucus '
            'changes (increasing wetness, clarity, or stretchiness) '
            'and remains open until BOTH the temperature shift and '
            'Peak Day + 3 rule confirm ovulation has occurred '
            '(double-check / Doppelte Kontrolle).';

      case FertilityStatus.fertileWaitingForDoubleCheck:
        return 'The symptothermal method requires a DOUBLE-CHECK '
            '(Doppelte Kontrolle) to confirm ovulation:\n\n'
            '\u2776 Temperature shift: 3 consecutive temps above '
            'the coverline (3-over-6 rule, 3rd \u2265 0.2\u00B0C above)\n'
            '\u2777 Mucus dry-up: 3 days past Peak Day\n\n'
            'Only when BOTH are confirmed does the infertile phase '
            'begin (on the evening of whichever comes later). '
            'Until then, this day is considered FERTILE.\n\n'
            'This is the core safety principle of the method \u2014 '
            'a single indicator is never sufficient.';

      case FertilityStatus.infertilePostOvulation:
        return 'Post-ovulatory infertility confirmed by double-check '
            '(Doppelte Kontrolle):\n\n'
            '\u2713 Temperature shift: 3 consecutive temps above the '
            'coverline (3-over-6 rule, 3rd \u2265 0.2\u00B0C above)\n'
            '\u2713 Mucus dry-up: 3 days past Peak Day\n\n'
            'The infertile phase begins on the evening of whichever '
            'marker came later. This is the most reliable phase '
            'in the symptothermal method.';

      case FertilityStatus.unknown:
        return null;
    }
  }

  /// Generate detailed text explaining which pre-ov rule is active and why
  String _preOvRuleDetailText(StmEvaluation? evaluation, String lang) {
    if (lang == 'de') return _preOvRuleDetailTextDe(evaluation);
    if (lang == 'es') return _preOvRuleDetailTextEs(evaluation);
    if (evaluation == null) {
      return 'AG NFP / Sensiplan: The first 5 days are considered '
          'infertile for beginners (fewer than 12 recorded cycles), '
          'provided no fertile mucus is observed. This is the most '
          'conservative default rule.';
    }

    final rule = evaluation.appliedPreOvRule;
    final limit = evaluation.lastInfertilePreOvDay;
    final cycleCount = evaluation.completedCycleCount;

    final buf = StringBuffer();

    // Explain the active rule
    switch (rule) {
      case PreOvRule.fiveDayRule:
        buf.write('5-day rule (beginner default): The first 5 days '
            'are considered infertile. This rule applies when fewer '
            'than 12 completed cycles have been recorded '
            '(currently: $cycleCount). ');
        buf.write('Condition: no fertile cervical mucus observed.');
        break;

      case PreOvRule.roetzerSixDayRule:
        buf.write('Rötzer 6-day rule: The first 6 days are '
            'considered infertile because all $cycleCount recorded '
            'cycles were at least 26 days long. ');
        buf.write('Condition: no fertile cervical mucus observed.');
        break;

      case PreOvRule.minus20Rule:
        buf.write('Minus-20 rule: Shortest recorded cycle '
            '(${evaluation.shortestCycleUsed} days) minus 20 = '
            'day $limit is the last infertile day. ');
        buf.write('Based on $cycleCount completed cycles. ');
        if (evaluation.minus8Value != null) {
          buf.write('Minus-8 would give day ${evaluation.minus8Value} '
              '(earliest temp rise day ${evaluation.earliestTempRiseUsed} '
              '− 8). ');
        }
        buf.write('The most conservative value was used.');
        break;

      case PreOvRule.minus8Rule:
        buf.write('Minus-8 rule: Earliest first higher temperature '
            '(day ${evaluation.earliestTempRiseUsed}) minus 8 = '
            'day $limit is the last infertile day. ');
        if (evaluation.minus20Value != null) {
          buf.write('Minus-20 would give day ${evaluation.minus20Value} '
              '(shortest cycle ${evaluation.shortestCycleUsed} − 20). ');
        }
        buf.write('The most conservative value was used.');
        break;

      default:
        buf.write('The first $limit days are considered infertile '
            'based on the symptothermal method rules.');
    }

    buf.write('\n\nImportant: Any observation of fertile cervical '
        'mucus immediately overrides this calculation and marks '
        'the beginning of the fertile phase.');

    return buf.toString();
  }

  // ── German variants of the rule-explanation prose ──────────────────────────

  String _preOvRuleDescDe(PreOvRule rule) {
    switch (rule) {
      case PreOvRule.fiveDayRule:
        return '5-Tage-Regel (Anfänger-Standard)';
      case PreOvRule.roetzerSixDayRule:
        return 'Rötzer 6-Tage-Regel (alle Zyklen ≥ 26 Tage)';
      case PreOvRule.minus20Rule:
        return 'Minus-20-Regel (kürzester Zyklus − 20)';
      case PreOvRule.minus8Rule:
        return 'Minus-8-Regel (frühester Temperaturanstieg − 8)';
      case PreOvRule.mucusOverride:
        return 'Schleim-Override (fruchtbare Zeichen erkannt)';
      case PreOvRule.none:
        return 'Keine Regel angewendet';
    }
  }

  String _statusExplanationDe(FertilityStatus status, int cycleDay,
      AppPurpose purpose, StmEvaluation? evaluation) {
    switch (status) {
      case FertilityStatus.menstruation:
        if (purpose == AppPurpose.anticonception) {
          final limit = evaluation?.lastInfertilePreOvDay ?? 5;
          if (cycleDay <= limit) {
            final ruleDesc = evaluation != null
                ? _preOvRuleDescDe(evaluation.appliedPreOvRule)
                : '5-Tage-Regel';
            return 'Zyklustag $cycleDay von $limit — '
                'unfruchtbar laut $ruleDesc. '
                'Es darf kein fruchtbarer Schleim beobachtet werden.';
          } else {
            return 'Zyklustag $cycleDay — eine Blutung nach Tag $limit '
                'ist nicht automatisch unfruchtbar. '
                'Der Eisprung könnte sich nähern.';
          }
        }
        return 'Zyklustag $cycleDay — Menstruation';

      case FertilityStatus.infertilePreOvulation:
        if (purpose == AppPurpose.anticonception) {
          return 'Zyklustag $cycleDay — Eisprung noch nicht durch '
              'Temperaturanstieg bestätigt; als evtl. fruchtbar behandeln';
        }
        return 'Zyklustag $cycleDay — Phase vor dem Eisprung, '
            'keine fruchtbaren Zeichen beobachtet';

      case FertilityStatus.fertile:
        if (evaluation?.peakDay != null) {
          return 'Zyklustag $cycleDay — fruchtbare Zeichen vorhanden '
              '(Höhepunkt: Tag ${evaluation!.peakDay})';
        }
        return 'Zyklustag $cycleDay — fruchtbare Zeichen vorhanden, '
            'Eisprung noch nicht bestätigt';

      case FertilityStatus.fertileWaitingForDoubleCheck:
        final shiftDay = evaluation?.temperatureShiftConfirmedDay;
        final peakDay = evaluation?.peakDay;
        if (shiftDay != null && peakDay == null) {
          return 'Zyklustag $cycleDay — Temperaturanstieg erkannt '
              '(Tag $shiftDay), aber der Höhepunkt ist noch nicht bestätigt. '
              'WEITERHIN FRUCHTBAR — die Doppelkontrolle braucht beides.';
        } else if (peakDay != null && shiftDay == null) {
          return 'Zyklustag $cycleDay — Höhepunkt erkannt '
              '(Tag $peakDay), aber der Temperaturanstieg ist noch nicht '
              'bestätigt. WEITERHIN FRUCHTBAR — die Doppelkontrolle '
              'braucht beides.';
        }
        return 'Zyklustag $cycleDay — warte auf die Bestätigung der '
            'Doppelkontrolle. WEITERHIN FRUCHTBAR.';

      case FertilityStatus.infertilePostOvulation:
        final shiftDay = evaluation?.temperatureShiftConfirmedDay;
        final peakDay = evaluation?.peakDay;
        return 'Zyklustag $cycleDay — unfruchtbare Phase durch '
            'Doppelkontrolle bestätigt: Temperaturanstieg bestätigt an '
            'Tag $shiftDay UND Höhepunkt $peakDay + 3';

      case FertilityStatus.unknown:
        return 'Zyklustag $cycleDay — nicht genug Daten für eine '
            'Auswertung';
    }
  }

  String? _statusRuleDetailDe(FertilityStatus status, int cycleDay,
      AppPurpose purpose, StmEvaluation? evaluation) {
    switch (status) {
      case FertilityStatus.menstruation:
        if (purpose == AppPurpose.anticonception) {
          final limit = evaluation?.lastInfertilePreOvDay ?? 5;
          if (cycleDay <= limit) {
            return _preOvRuleDetailTextDe(evaluation);
          } else {
            return 'Eine Blutung nach Zyklustag $limit bedeutet nicht '
                'automatisch Unfruchtbarkeit. Der Eisprung könnte sich '
                'nähern. Beobachte weiter Zervixschleim und Temperatur.';
          }
        }
        return null;

      case FertilityStatus.infertilePreOvulation:
        if (purpose == AppPurpose.anticonception) {
          return 'In der symptothermalen Methode kann die Phase vor dem '
              'Eisprung nach der Menstruation ohne Temperaturanstieg nicht '
              'als unfruchtbar bestätigt werden. Fruchtbarer Schleim kann '
              'jederzeit auftreten. Zur Verhütung diese Tage mit Vorsicht '
              'behandeln.';
        }
        return 'Keine fruchtbaren Zervixschleim-Zeichen beobachtet. Diese '
            'Phase endet, wenn die Schleimqualität steigt oder andere '
            'fruchtbare Zeichen auftreten.';

      case FertilityStatus.fertile:
        return 'Das fruchtbare Fenster wird durch Veränderungen des '
            'Zervixschleims erkannt (zunehmende Nässe, Klarheit oder '
            'Dehnbarkeit) und bleibt offen, bis SOWOHL der Temperaturanstieg '
            'ALS AUCH die Höhepunkt-+3-Regel den Eisprung bestätigen '
            '(Doppelte Kontrolle).';

      case FertilityStatus.fertileWaitingForDoubleCheck:
        return 'Die symptothermale Methode verlangt eine DOPPELTE KONTROLLE, '
            'um den Eisprung zu bestätigen:\n\n'
            '❶ Temperaturanstieg: 3 aufeinanderfolgende Werte über der '
            'Hilfslinie (3-über-6-Regel, der 3. ≥ 0,2 °C darüber)\n'
            '❷ Abtrocknen des Schleims: 3 Tage nach dem Höhepunkt\n\n'
            'Erst wenn BEIDES bestätigt ist, beginnt die unfruchtbare Phase '
            '(am Abend des jeweils späteren Zeitpunkts). Bis dahin gilt '
            'dieser Tag als FRUCHTBAR.\n\n'
            'Das ist das zentrale Sicherheitsprinzip der Methode — ein '
            'einzelnes Zeichen reicht nie aus.';

      case FertilityStatus.infertilePostOvulation:
        return 'Unfruchtbarkeit nach dem Eisprung durch Doppelte Kontrolle '
            'bestätigt:\n\n'
            '✓ Temperaturanstieg: 3 aufeinanderfolgende Werte über der '
            'Hilfslinie (3-über-6-Regel, der 3. ≥ 0,2 °C darüber)\n'
            '✓ Abtrocknen des Schleims: 3 Tage nach dem Höhepunkt\n\n'
            'Die unfruchtbare Phase beginnt am Abend des jeweils späteren '
            'Markers. Dies ist die zuverlässigste Phase der symptothermalen '
            'Methode.';

      case FertilityStatus.unknown:
        return null;
    }
  }

  String _preOvRuleDetailTextDe(StmEvaluation? evaluation) {
    if (evaluation == null) {
      return 'AG NFP / Sensiplan: Die ersten 5 Tage gelten für '
          'Anfängerinnen (weniger als 12 aufgezeichnete Zyklen) als '
          'unfruchtbar, sofern kein fruchtbarer Schleim beobachtet wird. '
          'Das ist die konservativste Standardregel.';
    }

    final rule = evaluation.appliedPreOvRule;
    final limit = evaluation.lastInfertilePreOvDay;
    final cycleCount = evaluation.completedCycleCount;

    final buf = StringBuffer();

    switch (rule) {
      case PreOvRule.fiveDayRule:
        buf.write('5-Tage-Regel (Anfänger-Standard): Die ersten 5 Tage '
            'gelten als unfruchtbar. Diese Regel gilt, solange weniger als '
            '12 abgeschlossene Zyklen aufgezeichnet sind '
            '(aktuell: $cycleCount). ');
        buf.write('Bedingung: kein fruchtbarer Zervixschleim beobachtet.');
        break;

      case PreOvRule.roetzerSixDayRule:
        buf.write('Rötzer 6-Tage-Regel: Die ersten 6 Tage gelten als '
            'unfruchtbar, weil alle $cycleCount aufgezeichneten Zyklen '
            'mindestens 26 Tage lang waren. ');
        buf.write('Bedingung: kein fruchtbarer Zervixschleim beobachtet.');
        break;

      case PreOvRule.minus20Rule:
        buf.write('Minus-20-Regel: Kürzester aufgezeichneter Zyklus '
            '(${evaluation.shortestCycleUsed} Tage) minus 20 = '
            'Tag $limit ist der letzte unfruchtbare Tag. ');
        buf.write('Basierend auf $cycleCount abgeschlossenen Zyklen. ');
        if (evaluation.minus8Value != null) {
          buf.write('Minus-8 ergäbe Tag ${evaluation.minus8Value} '
              '(frühester Temperaturanstieg Tag '
              '${evaluation.earliestTempRiseUsed} − 8). ');
        }
        buf.write('Der konservativste Wert wurde verwendet.');
        break;

      case PreOvRule.minus8Rule:
        buf.write('Minus-8-Regel: Frühester erster höherer '
            'Temperaturwert (Tag ${evaluation.earliestTempRiseUsed}) '
            'minus 8 = Tag $limit ist der letzte unfruchtbare Tag. ');
        if (evaluation.minus20Value != null) {
          buf.write('Minus-20 ergäbe Tag ${evaluation.minus20Value} '
              '(kürzester Zyklus ${evaluation.shortestCycleUsed} − 20). ');
        }
        buf.write('Der konservativste Wert wurde verwendet.');
        break;

      default:
        buf.write('Die ersten $limit Tage gelten nach den Regeln der '
            'symptothermalen Methode als unfruchtbar.');
    }

    buf.write('\n\nWichtig: Jede Beobachtung von fruchtbarem '
        'Zervixschleim hebt diese Berechnung sofort auf und markiert '
        'den Beginn der fruchtbaren Phase.');

    return buf.toString();
  }

  // ── Spanish variants of the rule-explanation prose ─────────────────────────

  String _preOvRuleDescEs(PreOvRule rule) {
    switch (rule) {
      case PreOvRule.fiveDayRule:
        return 'regla de los 5 días (predeterminada para principiantes)';
      case PreOvRule.roetzerSixDayRule:
        return 'regla de los 6 días de Rötzer (todos los ciclos ≥ 26 días)';
      case PreOvRule.minus20Rule:
        return 'regla menos-20 (ciclo más corto − 20)';
      case PreOvRule.minus8Rule:
        return 'regla menos-8 (subida de temperatura más temprana − 8)';
      case PreOvRule.mucusOverride:
        return 'prioridad del moco (signos fértiles detectados)';
      case PreOvRule.none:
        return 'ninguna regla aplicada';
    }
  }

  String _statusExplanationEs(FertilityStatus status, int cycleDay,
      AppPurpose purpose, StmEvaluation? evaluation) {
    switch (status) {
      case FertilityStatus.menstruation:
        if (purpose == AppPurpose.anticonception) {
          final limit = evaluation?.lastInfertilePreOvDay ?? 5;
          if (cycleDay <= limit) {
            final ruleDesc = evaluation != null
                ? _preOvRuleDescEs(evaluation.appliedPreOvRule)
                : 'regla de los 5 días';
            return 'Día del ciclo $cycleDay de $limit — '
                'infértil según la $ruleDesc. '
                'No debe observarse moco fértil.';
          } else {
            return 'Día del ciclo $cycleDay — un sangrado tras el día '
                '$limit no es automáticamente infértil. '
                'La ovulación podría estar acercándose.';
          }
        }
        return 'Día del ciclo $cycleDay — menstruación';

      case FertilityStatus.infertilePreOvulation:
        if (purpose == AppPurpose.anticonception) {
          return 'Día del ciclo $cycleDay — ovulación aún no confirmada '
              'por el cambio térmico; trátalo como potencialmente fértil';
        }
        return 'Día del ciclo $cycleDay — fase preovulatoria, '
            'sin signos fértiles observados';

      case FertilityStatus.fertile:
        if (evaluation?.peakDay != null) {
          return 'Día del ciclo $cycleDay — signos fértiles presentes '
              '(día cúspide: día ${evaluation!.peakDay})';
        }
        return 'Día del ciclo $cycleDay — signos fértiles presentes, '
            'ovulación aún no confirmada';

      case FertilityStatus.fertileWaitingForDoubleCheck:
        final shiftDay = evaluation?.temperatureShiftConfirmedDay;
        final peakDay = evaluation?.peakDay;
        if (shiftDay != null && peakDay == null) {
          return 'Día del ciclo $cycleDay — cambio térmico detectado '
              '(día $shiftDay), pero el día cúspide aún no está '
              'confirmado. AÚN FÉRTIL — la doble comprobación requiere '
              'ambos.';
        } else if (peakDay != null && shiftDay == null) {
          return 'Día del ciclo $cycleDay — día cúspide detectado '
              '(día $peakDay), pero el cambio térmico aún no está '
              'confirmado. AÚN FÉRTIL — la doble comprobación requiere '
              'ambos.';
        }
        return 'Día del ciclo $cycleDay — esperando la confirmación de la '
            'doble comprobación. AÚN FÉRTIL.';

      case FertilityStatus.infertilePostOvulation:
        final shiftDay = evaluation?.temperatureShiftConfirmedDay;
        final peakDay = evaluation?.peakDay;
        return 'Día del ciclo $cycleDay — fase infértil confirmada por la '
            'doble comprobación: cambio térmico confirmado el día '
            '$shiftDay Y día cúspide $peakDay + 3';

      case FertilityStatus.unknown:
        return 'Día del ciclo $cycleDay — datos insuficientes para la '
            'evaluación';
    }
  }

  String? _statusRuleDetailEs(FertilityStatus status, int cycleDay,
      AppPurpose purpose, StmEvaluation? evaluation) {
    switch (status) {
      case FertilityStatus.menstruation:
        if (purpose == AppPurpose.anticonception) {
          final limit = evaluation?.lastInfertilePreOvDay ?? 5;
          if (cycleDay <= limit) {
            return _preOvRuleDetailTextEs(evaluation);
          } else {
            return 'Un sangrado tras el día del ciclo $limit no indica '
                'automáticamente infertilidad. La ovulación podría estar '
                'acercándose. Sigue observando el moco cervical y la '
                'temperatura.';
          }
        }
        return null;

      case FertilityStatus.infertilePreOvulation:
        if (purpose == AppPurpose.anticonception) {
          return 'En el método sintotérmico, la fase preovulatoria tras '
              'la menstruación no puede confirmarse como infértil sin un '
              'cambio térmico. El moco fértil puede aparecer en cualquier '
              'momento. Para evitar el embarazo, trata estos días con '
              'precaución.';
        }
        return 'No se observan signos de moco cervical fértil. Esta fase '
            'termina cuando aumenta la calidad del moco o aparecen otros '
            'signos fértiles.';

      case FertilityStatus.fertile:
        return 'La ventana fértil se identifica por los cambios del moco '
            'cervical (mayor humedad, claridad o elasticidad) y permanece '
            'abierta hasta que TANTO el cambio térmico COMO la regla del '
            'día cúspide + 3 confirman que la ovulación ha ocurrido '
            '(doble comprobación).';

      case FertilityStatus.fertileWaitingForDoubleCheck:
        return 'El método sintotérmico requiere una DOBLE COMPROBACIÓN '
            'para confirmar la ovulación:\n\n'
            '❶ Cambio térmico: 3 temperaturas consecutivas por encima de '
            'la línea base (regla 3 sobre 6, la 3.ª ≥ 0,2 °C por '
            'encima)\n'
            '❷ Secado del moco: 3 días tras el día cúspide\n\n'
            'Solo cuando AMBOS están confirmados comienza la fase '
            'infértil (la tarde del que ocurra más tarde). Hasta '
            'entonces, este día se considera FÉRTIL.\n\n'
            'Este es el principio de seguridad central del método: un '
            'solo indicador nunca es suficiente.';

      case FertilityStatus.infertilePostOvulation:
        return 'Infertilidad posovulatoria confirmada por la doble '
            'comprobación:\n\n'
            '✓ Cambio térmico: 3 temperaturas consecutivas por encima de '
            'la línea base (regla 3 sobre 6, la 3.ª ≥ 0,2 °C por '
            'encima)\n'
            '✓ Secado del moco: 3 días tras el día cúspide\n\n'
            'La fase infértil comienza la tarde del marcador que ocurra '
            'más tarde. Esta es la fase más fiable del método '
            'sintotérmico.';

      case FertilityStatus.unknown:
        return null;
    }
  }

  String _preOvRuleDetailTextEs(StmEvaluation? evaluation) {
    if (evaluation == null) {
      return 'AG NFP / Sensiplan: los primeros 5 días se consideran '
          'infértiles para principiantes (menos de 12 ciclos '
          'registrados), siempre que no se observe moco fértil. Es la '
          'regla predeterminada más conservadora.';
    }

    final rule = evaluation.appliedPreOvRule;
    final limit = evaluation.lastInfertilePreOvDay;
    final cycleCount = evaluation.completedCycleCount;

    final buf = StringBuffer();

    switch (rule) {
      case PreOvRule.fiveDayRule:
        buf.write('Regla de los 5 días (predeterminada para '
            'principiantes): los primeros 5 días se consideran '
            'infértiles. Esta regla se aplica mientras haya menos de 12 '
            'ciclos completos registrados (actualmente: $cycleCount). ');
        buf.write('Condición: no se observa moco cervical fértil.');
        break;

      case PreOvRule.roetzerSixDayRule:
        buf.write('Regla de los 6 días de Rötzer: los primeros 6 días se '
            'consideran infértiles porque todos los $cycleCount ciclos '
            'registrados duraron al menos 26 días. ');
        buf.write('Condición: no se observa moco cervical fértil.');
        break;

      case PreOvRule.minus20Rule:
        buf.write('Regla menos-20: ciclo más corto registrado '
            '(${evaluation.shortestCycleUsed} días) menos 20 = el día '
            '$limit es el último día infértil. ');
        buf.write('Basado en $cycleCount ciclos completos. ');
        if (evaluation.minus8Value != null) {
          buf.write('Menos-8 daría el día ${evaluation.minus8Value} '
              '(subida de temperatura más temprana el día '
              '${evaluation.earliestTempRiseUsed} − 8). ');
        }
        buf.write('Se usó el valor más conservador.');
        break;

      case PreOvRule.minus8Rule:
        buf.write('Regla menos-8: primera temperatura más alta más '
            'temprana (día ${evaluation.earliestTempRiseUsed}) menos 8 = '
            'el día $limit es el último día infértil. ');
        if (evaluation.minus20Value != null) {
          buf.write('Menos-20 daría el día ${evaluation.minus20Value} '
              '(ciclo más corto ${evaluation.shortestCycleUsed} − 20). ');
        }
        buf.write('Se usó el valor más conservador.');
        break;

      default:
        buf.write('Los primeros $limit días se consideran infértiles '
            'según las reglas del método sintotérmico.');
    }

    buf.write('\n\nImportante: cualquier observación de moco cervical '
        'fértil anula de inmediato este cálculo y marca el inicio de la '
        'fase fértil.');

    return buf.toString();
  }

  Color _statusChipColor(FertilityStatus status) {
    switch (status) {
      case FertilityStatus.menstruation:
        return AppColors.menstruation;
      case FertilityStatus.fertile:
      case FertilityStatus.fertileWaitingForDoubleCheck:
        return AppColors.fertile;
      case FertilityStatus.infertilePreOvulation:
        return AppColors.infertilePre;
      case FertilityStatus.infertilePostOvulation:
        return AppColors.infertilePost;
      case FertilityStatus.unknown:
        return AppColors.unknown;
    }
  }

  String _mucusLabel(MucusType type) {
    final l = AppLocalizations.of(context)!;
    switch (type) {
      case MucusType.dry:
        return l.mucusDry;
      case MucusType.nothing:
        return l.mucusNothing;
      case MucusType.moist:
        return l.mucusMoist;
      case MucusType.wet:
        return l.mucusWet;
      case MucusType.slippery:
        return l.mucusSlippery;
      case MucusType.eggWhite:
        return l.mucusEggWhite;
      case MucusType.unrecorded:
        return l.mucusNotRecorded;
    }
  }

  String _bleedingLabel(BleedingType type) {
    final l = AppLocalizations.of(context)!;
    switch (type) {
      case BleedingType.none:
        return l.bleedNone;
      case BleedingType.spotting:
        return l.bleedSpotting;
      case BleedingType.light:
        return l.bleedLight;
      case BleedingType.medium:
        return l.bleedMedium;
      case BleedingType.heavy:
        return l.bleedHeavy;
    }
  }

  /// Localized fertility-status label, mirroring StmEngine.statusLabel's logic
  /// so the engine can stay pure/English while the UI renders per locale.
  String _localizedStatusLabel(AppLocalizations l, FertilityStatus status,
      AppPurpose purpose, int? cycleDay, StmEvaluation? evaluation) {
    switch (status) {
      case FertilityStatus.infertilePreOvulation:
        return purpose == AppPurpose.anticonception
            ? l.statusPotentiallyFertile
            : l.statusInfertilePreOv;
      case FertilityStatus.fertile:
        return l.statusFertile;
      case FertilityStatus.fertileWaitingForDoubleCheck:
        if (evaluation != null) {
          if (evaluation.temperatureShiftConfirmedDay != null &&
              evaluation.peakDay == null) {
            return l.statusFertileAwaitingMucus;
          } else if (evaluation.peakDay != null &&
              evaluation.temperatureShiftConfirmedDay == null) {
            return l.statusFertileAwaitingTemp;
          }
        }
        return l.statusFertileAwaitingCheck;
      case FertilityStatus.infertilePostOvulation:
        return purpose == AppPurpose.anticonception
            ? l.statusInfertile
            : l.statusInfertilePostOv;
      case FertilityStatus.menstruation:
        if (purpose == AppPurpose.anticonception) {
          final limit = evaluation?.lastInfertilePreOvDay;
          if (cycleDay != null && limit != null && cycleDay <= limit) {
            return l.statusInfertileDay(cycleDay, limit);
          }
        }
        return l.statusMenstruation;
      case FertilityStatus.unknown:
        return l.statusUnknown;
    }
  }
}

class _NewCycleResult {
  final BleedingType bleeding;
  _NewCycleResult({required this.bleeding});
}

class _NewCycleDialog extends StatefulWidget {
  final DateTime date;
  final bool hasExistingCycle;

  const _NewCycleDialog({
    required this.date,
    required this.hasExistingCycle,
  });

  @override
  State<_NewCycleDialog> createState() => _NewCycleDialogState();
}

class _NewCycleDialogState extends State<_NewCycleDialog> {
  BleedingType _bleeding = BleedingType.medium;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    return AlertDialog(
      title: Text(l.newCycleTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.newCycleStarting(
                DateFormat('MMM d, y', locale).format(widget.date)),
            style: TextStyle(color: colors.onSurfaceVariant),
          ),
          if (widget.hasExistingCycle) ...[
            const SizedBox(height: 4),
            Text(
              l.newCycleWillClose,
              style: TextStyle(
                  color: colors.onSurfaceVariant, fontSize: 13),
            ),
          ],
          const SizedBox(height: 20),
          Text(_isToday(widget.date)
                  ? l.bleedingTodayQ
                  : l.bleedingOnDayQ(
                      DateFormat('MMM d', locale).format(widget.date)),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: colors.onSurface,
              )),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              BleedingType.spotting,
              BleedingType.light,
              BleedingType.medium,
              BleedingType.heavy,
            ].map((type) {
              return ChoiceChip(
                label: Text(_bleedingLabel(type)),
                selected: _bleeding == type,
                selectedColor: AppColors.menstruation.withAlpha(60),
                onSelected: (selected) {
                  if (selected) setState(() => _bleeding = type);
                },
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
              context, _NewCycleResult(bleeding: _bleeding)),
          child: Text(l.startCycle),
        ),
      ],
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String _bleedingLabel(BleedingType type) {
    final l = AppLocalizations.of(context)!;
    switch (type) {
      case BleedingType.none:
        return l.bleedNone;
      case BleedingType.spotting:
        return l.bleedSpotting;
      case BleedingType.light:
        return l.bleedLight;
      case BleedingType.medium:
        return l.bleedMedium;
      case BleedingType.heavy:
        return l.bleedHeavy;
    }
  }
}
