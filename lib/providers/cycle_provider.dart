import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/database_helper.dart';
import '../models/cycle.dart';
import '../models/day_entry.dart';
import '../models/settings.dart';
import '../services/stm_engine.dart';
import '../services/notification_service.dart';

class CycleProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();

  List<Cycle> _cycles = [];
  Cycle? _currentCycle;
  List<DayEntry> _currentEntries = [];
  StmEvaluation? _currentEvaluation;
  AppSettings _settings = const AppSettings();
  DateTime _selectedDate = DateTime.now();

  List<Cycle> get cycles => _cycles;
  Cycle? get currentCycle => _currentCycle;
  List<DayEntry> get currentEntries => _currentEntries;
  StmEvaluation? get currentEvaluation => _currentEvaluation;
  AppSettings get settings => _settings;
  DateTime get selectedDate => _selectedDate;

  Future<void> initialize() async {
    await _loadSettings();
    await loadCycles();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _settings = AppSettings(
      temperatureUnit: TemperatureUnit
          .values[prefs.getInt('temperatureUnit') ?? 0],
      ruleset: StmRuleset.values[prefs.getInt('ruleset') ?? 0],
      purpose: AppPurpose.values[prefs.getInt('purpose') ?? 0],
      showCervixTracking: prefs.getBool('showCervixTracking') ?? false,
      showIntercourseTracking:
          prefs.getBool('showIntercourseTracking') ?? true,
      autoDetectCoverline: prefs.getBool('autoDetectCoverline') ?? true,
      autoDetectPeakDay: prefs.getBool('autoDetectPeakDay') ?? true,
      calendarTapAction: CalendarTapAction
          .values[prefs.getInt('calendarTapAction') ?? 0],
      dailyReminderEnabled: prefs.getBool('dailyReminderEnabled') ?? false,
      dailyReminderHour: prefs.getInt('dailyReminderHour') ?? 7,
      dailyReminderMinute: prefs.getInt('dailyReminderMinute') ?? 0,
    );
    await _applyReminderSetting();
  }

  Future<void> _applyReminderSetting() async {
    if (_settings.dailyReminderEnabled) {
      await NotificationService.instance.scheduleDailyReminder(
        hour: _settings.dailyReminderHour,
        minute: _settings.dailyReminderMinute,
      );
    } else {
      await NotificationService.instance.cancelDailyReminder();
    }
  }

  Future<void> updateSettings(AppSettings newSettings) async {
    _settings = newSettings;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('temperatureUnit', newSettings.temperatureUnit.index);
    await prefs.setInt('ruleset', newSettings.ruleset.index);
    await prefs.setInt('purpose', newSettings.purpose.index);
    await prefs.setBool('showCervixTracking', newSettings.showCervixTracking);
    await prefs.setBool(
        'showIntercourseTracking', newSettings.showIntercourseTracking);
    await prefs.setBool('autoDetectCoverline', newSettings.autoDetectCoverline);
    await prefs.setBool('autoDetectPeakDay', newSettings.autoDetectPeakDay);
    await prefs.setInt(
        'calendarTapAction', newSettings.calendarTapAction.index);
    await prefs.setBool(
        'dailyReminderEnabled', newSettings.dailyReminderEnabled);
    await prefs.setInt('dailyReminderHour', newSettings.dailyReminderHour);
    await prefs.setInt(
        'dailyReminderMinute', newSettings.dailyReminderMinute);
    await _applyReminderSetting();
    notifyListeners();
    // Re-evaluate with new settings
    if (_currentCycle != null) {
      _evaluateCurrentCycle();
    }
  }

  Future<void> loadCycles() async {
    _cycles = await _db.getAllCycles();
    _currentCycle = await _db.getCurrentCycle();
    if (_currentCycle != null) {
      await _loadEntriesForCycle(_currentCycle!);
    }
    notifyListeners();
  }

  Future<void> selectDate(DateTime date) async {
    _selectedDate = DateTime(date.year, date.month, date.day);
    notifyListeners();
  }

  Future<void> selectCycle(Cycle cycle) async {
    _currentCycle = cycle;
    await _loadEntriesForCycle(cycle);
    notifyListeners();
  }

  Future<void> _loadEntriesForCycle(Cycle cycle) async {
    _currentEntries = await _db.getEntriesForCycle(cycle.id!);
    _evaluateCurrentCycle();
  }

  void _evaluateCurrentCycle() {
    if (_currentCycle == null) return;
    final engine = StmEngine(ruleset: _settings.ruleset);

    // Gather previous completed cycles (exclude current)
    final previousCycles = _cycles
        .where((c) => c.id != _currentCycle!.id && c.length != null)
        .toList();

    // Gather first higher temperature days from previous cycles.
    // We store this in the cycle's temperatureShiftDay field.
    // For the minus-8 rule we need the FIRST high temp day, not the
    // confirmed day. We use temperatureShiftDay which stores the
    // confirmed day (3rd high), so we approximate by subtracting 2.
    // This is a reasonable approximation; for exact values we'd need
    // to re-evaluate each previous cycle.
    final previousTempShiftDays = previousCycles
        .map((c) {
          if (c.temperatureShiftDay != null) {
            // Approximate first high temp day = confirmed day - 2
            return c.temperatureShiftDay! - 2;
          }
          return null;
        })
        .toList();

    _currentEvaluation = engine.evaluate(
      _currentCycle!,
      _currentEntries,
      previousCycles: previousCycles,
      previousTempShiftDays: previousTempShiftDays,
    );
  }

  /// Start a new cycle on the given date
  Future<void> startNewCycle(DateTime date,
      {BleedingType bleeding = BleedingType.medium,
      MucusType mucus = MucusType.unrecorded}) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    // Close the current cycle if one exists
    if (_currentCycle != null) {
      final endDate = normalizedDate.subtract(const Duration(days: 1));
      final length = endDate.difference(_currentCycle!.startDate).inDays + 1;
      // Only close with valid length (new cycle must start after current)
      if (length > 0) {
        final shiftDay = _currentEvaluation?.temperatureShiftConfirmedDay;
        await _db.updateCycle(_currentCycle!.copyWith(
          endDate: endDate,
          length: length,
          temperatureShiftDay: shiftDay,
        ));
      } else {
        // New cycle starts on or before the current cycle —
        // just close it without a valid length
        await _db.updateCycle(_currentCycle!.copyWith(
          endDate: endDate,
        ));
      }
    }

    // Create new cycle
    final id = await _db.insertCycle(Cycle(startDate: normalizedDate));
    _currentCycle = await _db.getCycle(id);

    // Create day 1 entry
    await _db.insertDayEntry(DayEntry(
      cycleId: id,
      date: normalizedDate,
      cycleDay: 1,
      bleeding: bleeding,
      mucusType: mucus,
    ));

    await loadCycles();
  }

  /// Save or update a day entry
  Future<void> saveDayEntry(DayEntry entry) async {
    if (entry.id != null) {
      await _db.updateDayEntry(entry);
    } else {
      await _db.insertDayEntry(entry);
    }

    // Reload entries for the current cycle
    if (_currentCycle != null && entry.cycleId == _currentCycle!.id) {
      await _loadEntriesForCycle(_currentCycle!);
    }
    notifyListeners();
  }

  /// Get or create an entry for a specific date
  Future<DayEntry> getOrCreateEntry(DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final existing = await _db.getDayEntry(normalizedDate);
    if (existing != null) return existing;

    // Determine which cycle this belongs to
    final cycle = await _db.getCycleForDate(normalizedDate);
    if (cycle == null) {
      // No cycle exists for this date; create one
      await startNewCycle(normalizedDate);
      final created = await _db.getDayEntry(normalizedDate);
      if (created != null) return created;
      return DayEntry(
        cycleId: _currentCycle?.id ?? 0,
        date: normalizedDate,
        cycleDay: 1,
      );
    }

    final cycleDay =
        normalizedDate.difference(cycle.startDate).inDays + 1;
    return DayEntry(
      cycleId: cycle.id!,
      date: normalizedDate,
      cycleDay: cycleDay,
    );
  }

  /// Get the entry for a specific date without creating one
  DayEntry? getEntryForDate(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    try {
      return _currentEntries
          .firstWhere((e) => _isSameDay(e.date, normalized));
    } catch (_) {
      return null;
    }
  }

  /// Delete a day entry
  Future<void> deleteDayEntry(DayEntry entry) async {
    if (entry.id == null) return;
    await _db.deleteDayEntry(entry.id!);
    if (_currentCycle != null && entry.cycleId == _currentCycle!.id) {
      await _loadEntriesForCycle(_currentCycle!);
    }
    notifyListeners();
  }

  /// Delete a cycle and all its entries
  Future<void> deleteCycle(Cycle cycle) async {
    if (cycle.id == null) return;
    await _db.deleteCycle(cycle.id!);
    await loadCycles();
  }

  /// Update the coverline manually for the current cycle
  Future<void> setCoverline(double? temp) async {
    if (_currentCycle == null) return;
    final updated = _currentCycle!.copyWith(coverlineTemp: temp);
    await _db.updateCycle(updated);
    _currentCycle = updated;
    _evaluateCurrentCycle();
    notifyListeners();
  }

  /// Mark a day as Peak Day
  Future<void> setPeakDay(int cycleDay) async {
    if (_currentCycle == null) return;
    final updated = _currentCycle!.copyWith(peakDayIndex: cycleDay);
    await _db.updateCycle(updated);
    _currentCycle = updated;
    _evaluateCurrentCycle();
    notifyListeners();
  }

  /// Get entries for a date range (for calendar display)
  Future<Map<DateTime, DayEntry>> getEntriesForRange(
      DateTime start, DateTime end) async {
    final entries = await _db.getEntriesInRange(start, end);
    final map = <DateTime, DayEntry>{};
    for (final e in entries) {
      map[DateTime(e.date.year, e.date.month, e.date.day)] = e;
    }
    return map;
  }

  /// Get fertility status for a date in the current cycle
  FertilityStatus? getFertilityStatus(DateTime date) {
    if (_currentCycle == null || _currentEvaluation == null) return null;
    final cycleDay =
        date.difference(_currentCycle!.startDate).inDays + 1;
    return _currentEvaluation!.dayStatuses[cycleDay];
  }

  /// Statistics: get all completed cycle lengths (only valid ones > 0)
  List<int> get cycleLengths {
    return _cycles
        .where((c) => c.length != null && c.length! > 0)
        .map((c) => c.length!)
        .toList();
  }

  double? get averageCycleLength {
    final lengths = cycleLengths;
    if (lengths.isEmpty) return null;
    return lengths.reduce((a, b) => a + b) / lengths.length;
  }

  int? get shortestCycle {
    final lengths = cycleLengths;
    if (lengths.isEmpty) return null;
    return lengths.reduce((a, b) => a < b ? a : b);
  }

  int? get longestCycle {
    final lengths = cycleLengths;
    if (lengths.isEmpty) return null;
    return lengths.reduce((a, b) => a > b ? a : b);
  }

  /// Predicted next period start date based on average cycle length.
  /// Requires at least 2 completed cycles for a meaningful prediction.
  DateTime? get predictedNextPeriod {
    final avg = averageCycleLength;
    if (avg == null || _currentCycle == null) return null;
    // Need at least 2 completed cycles for a reliable prediction
    if (cycleLengths.length < 2) return null;
    return _currentCycle!.startDate.add(Duration(days: avg.round()));
  }

  /// Days until predicted next period (negative = overdue)
  int? get daysUntilNextPeriod {
    final predicted = predictedNextPeriod;
    if (predicted == null) return null;
    final today = DateTime.now();
    return DateTime(predicted.year, predicted.month, predicted.day)
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;
  }

  /// Standard deviation of cycle lengths
  double? get cycleLengthStdDev {
    final lengths = cycleLengths;
    if (lengths.length < 2) return null;
    final avg = averageCycleLength!;
    final variance = lengths
            .map((l) => (l - avg) * (l - avg))
            .reduce((a, b) => a + b) /
        lengths.length;
    return _sqrt(variance);
  }

  double _sqrt(double value) {
    if (value <= 0) return 0;
    double guess = value / 2;
    for (int i = 0; i < 20; i++) {
      guess = (guess + value / guess) / 2;
    }
    return guess;
  }

  /// Average temperature shift day across completed cycles
  double? get averageTempShiftDay {
    final shiftDays = _cycles
        .where((c) => c.temperatureShiftDay != null)
        .map((c) => c.temperatureShiftDay!)
        .toList();
    if (shiftDays.isEmpty) return null;
    return shiftDays.reduce((a, b) => a + b) / shiftDays.length;
  }

  /// Number of completed cycles
  int get completedCycleCount {
    return _cycles.where((c) => c.length != null).length;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
