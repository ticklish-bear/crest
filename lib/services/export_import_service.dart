import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import '../models/cycle.dart';
import '../models/day_entry.dart';
import '../database/database_helper.dart';

// Conditional imports for platform-specific file operations
import 'export_io.dart' if (dart.library.html) 'export_web.dart' as platform;

class ExportImportService {
  final DatabaseHelper _db = DatabaseHelper();
  static final _dateFormat = DateFormat('yyyy-MM-dd');

  /// Export all data as CSV. Returns the file path (mobile) or triggers
  /// a browser download (web).
  Future<String> exportToCsv() async {
    final cycles = await _db.getAllCycles();
    final entries = await _db.getAllEntries();

    final rows = <List<dynamic>>[
      // Header row
      [
        'Date',
        'Cycle Day',
        'Temperature (°C)',
        'Temperature Time',
        'Temp Excluded',
        'Mucus Type',
        'Mucus Appearance',
        'Bleeding',
        'Cervix Position',
        'Cervix Openness',
        'Cervix Firmness',
        'Peak Day',
        'Intercourse',
        'Notes',
        'Cycle Start',
        'Coverline',
      ],
    ];

    for (final entry in entries) {
      final cycle = cycles.where((c) => c.id == entry.cycleId).firstOrNull;
      rows.add([
        _dateFormat.format(entry.date),
        entry.cycleDay,
        entry.temperature?.toStringAsFixed(2) ?? '',
        entry.temperatureTime ?? '',
        entry.temperatureExcluded ? 'yes' : '',
        entry.mucusType.name,
        entry.mucusAppearance.name,
        entry.bleeding.name,
        entry.cervixPosition.name,
        entry.cervixOpenness.name,
        entry.cervixFirmness.name,
        entry.isPeakDay ? 'yes' : '',
        entry.intercourse ? 'yes' : '',
        entry.notes ?? '',
        entry.cycleDay == 1 ? 'yes' : '',
        cycle?.coverlineTemp?.toStringAsFixed(2) ?? '',
      ]);
    }

    final csv = const ListToCsvConverter().convert(rows);
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final filename = 'stm_export_$timestamp.csv';

    return platform.saveCsvFile(csv, filename);
  }

  /// Import from STM CSV format
  Future<int> importFromCsv(String csvContent) async {
    final rows = const CsvToListConverter().convert(csvContent);
    if (rows.length < 2) return 0;

    // Skip header
    final dataRows = rows.sublist(1);
    int importedCount = 0;

    int? currentCycleId;
    DateTime? currentCycleStart;

    for (final row in dataRows) {
      if (row.length < 14) continue;

      final dateStr = row[0].toString();
      final date = _dateFormat.parse(dateStr);
      final cycleDay = int.tryParse(row[1].toString()) ?? 1;
      final tempStr = row[2].toString();
      final temperature =
          tempStr.isNotEmpty ? double.tryParse(tempStr) : null;
      final tempTime = row[3].toString();
      final tempExcluded = row[4].toString().toLowerCase() == 'yes';
      final isCycleStart = row.length > 14 &&
          row[14].toString().toLowerCase() == 'yes';

      // Start a new cycle if needed
      if (isCycleStart || cycleDay == 1 || currentCycleId == null) {
        // Close previous cycle
        if (currentCycleId != null && currentCycleStart != null) {
          final prevDate =
              date.subtract(const Duration(days: 1));
          final length =
              prevDate.difference(currentCycleStart).inDays + 1;
          final cycle = (await _db.getCycle(currentCycleId))!;
          await _db.updateCycle(cycle.copyWith(
            endDate: prevDate,
            length: length,
          ));
        }

        currentCycleStart = date;
        final coverlineStr =
            row.length > 15 ? row[15].toString() : '';
        final coverline = coverlineStr.isNotEmpty
            ? double.tryParse(coverlineStr)
            : null;

        currentCycleId = await _db.insertCycle(Cycle(
          startDate: date,
          coverlineTemp: coverline,
        ));
      }

      final mucusType = _parseMucusType(row[5].toString());
      final mucusAppearance =
          _parseMucusAppearance(row[6].toString());
      final bleeding = _parseBleeding(row[7].toString());

      await _db.insertDayEntry(DayEntry(
        cycleId: currentCycleId,
        date: date,
        cycleDay: cycleDay,
        temperature: temperature,
        temperatureTime: tempTime.isNotEmpty ? tempTime : null,
        temperatureExcluded: tempExcluded,
        mucusType: mucusType,
        mucusAppearance: mucusAppearance,
        bleeding: bleeding,
        isPeakDay: row[11].toString().toLowerCase() == 'yes',
        intercourse: row[12].toString().toLowerCase() == 'yes',
        notes: row[13].toString().isNotEmpty ? row[13].toString() : null,
      ));
      importedCount++;
    }

    return importedCount;
  }

  /// Attempt to import Kindara CSV data.
  /// Kindara exports: Date, Temp, Cervical Fluid, Period, Intercourse, Notes
  Future<int> importFromKindara(String csvContent) async {
    final rows = const CsvToListConverter().convert(csvContent);
    if (rows.length < 2) return 0;

    final dataRows = rows.sublist(1);
    int importedCount = 0;
    int? currentCycleId;
    DateTime? currentCycleStart;
    int cycleDay = 1;

    for (final row in dataRows) {
      if (row.length < 4) continue;

      final date = _dateFormat.parse(row[0].toString());
      final tempStr = row[1].toString();
      final temperature =
          tempStr.isNotEmpty ? double.tryParse(tempStr) : null;
      final cfStr = row[2].toString().toLowerCase();
      final periodStr = row[3].toString().toLowerCase();

      // Detect cycle start from period
      final hasPeriod = periodStr == 'heavy' ||
          periodStr == 'medium' ||
          periodStr == 'light' ||
          periodStr == 'spotting';

      final isNewCycle =
          hasPeriod && (currentCycleId == null || cycleDay > 20);

      if (isNewCycle || currentCycleId == null) {
        if (currentCycleId != null && currentCycleStart != null) {
          final prevDate = date.subtract(const Duration(days: 1));
          final length = prevDate.difference(currentCycleStart).inDays + 1;
          final cycle = (await _db.getCycle(currentCycleId))!;
          await _db.updateCycle(cycle.copyWith(
            endDate: prevDate,
            length: length,
          ));
        }

        currentCycleStart = date;
        cycleDay = 1;
        currentCycleId = await _db.insertCycle(Cycle(startDate: date));
      }

      final mucusType = _kindaraMucus(cfStr);
      final bleeding = _kindaraBleeding(periodStr);

      await _db.insertDayEntry(DayEntry(
        cycleId: currentCycleId,
        date: date,
        cycleDay: cycleDay,
        temperature: temperature,
        mucusType: mucusType,
        bleeding: bleeding,
        intercourse: row.length > 4 &&
            row[4].toString().toLowerCase() == 'yes',
        notes: row.length > 5 && row[5].toString().isNotEmpty
            ? row[5].toString()
            : null,
      ));

      cycleDay++;
      importedCount++;
    }

    return importedCount;
  }

  MucusType _parseMucusType(String value) {
    return MucusType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MucusType.dry,
    );
  }

  MucusAppearance _parseMucusAppearance(String value) {
    return MucusAppearance.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MucusAppearance.none,
    );
  }

  BleedingType _parseBleeding(String value) {
    return BleedingType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => BleedingType.none,
    );
  }

  MucusType _kindaraMucus(String value) {
    if (value.contains('egg') || value.contains('stretchy')) {
      return MucusType.eggWhite;
    }
    if (value.contains('watery') || value.contains('wet')) {
      return MucusType.wet;
    }
    if (value.contains('creamy') || value.contains('sticky')) {
      return MucusType.moist;
    }
    if (value.contains('dry')) return MucusType.dry;
    return MucusType.nothing;
  }

  BleedingType _kindaraBleeding(String value) {
    if (value.contains('heavy')) return BleedingType.heavy;
    if (value.contains('medium')) return BleedingType.medium;
    if (value.contains('light')) return BleedingType.light;
    if (value.contains('spot')) return BleedingType.spotting;
    return BleedingType.none;
  }
}
