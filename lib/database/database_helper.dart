import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/cycle.dart';
import '../models/day_entry.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path;
    if (kIsWeb) {
      path = 'crest.db';
    } else {
      final dbPath = await getDatabasesPath();
      path = join(dbPath, 'crest.db');
    }
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cycles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        startDate TEXT NOT NULL,
        endDate TEXT,
        length INTEGER,
        coverlineTemp REAL,
        peakDayIndex INTEGER,
        temperatureShiftDay INTEGER,
        notes TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE day_entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cycleId INTEGER NOT NULL,
        date TEXT NOT NULL UNIQUE,
        cycleDay INTEGER NOT NULL,
        temperature REAL,
        temperatureTime TEXT,
        temperatureExcluded INTEGER DEFAULT 0,
        temperatureExcludeReason TEXT,
        mucusType INTEGER DEFAULT 0,
        mucusAppearance INTEGER DEFAULT 0,
        bleeding INTEGER DEFAULT 0,
        cervixPosition INTEGER DEFAULT 0,
        cervixOpenness INTEGER DEFAULT 0,
        cervixFirmness INTEGER DEFAULT 0,
        isPeakDay INTEGER DEFAULT 0,
        intercourse INTEGER DEFAULT 0,
        notes TEXT,
        FOREIGN KEY (cycleId) REFERENCES cycles(id) ON DELETE CASCADE
      )
    ''');

    await db.execute(
        'CREATE INDEX idx_entries_cycle ON day_entries(cycleId)');
    await db.execute(
        'CREATE INDEX idx_entries_date ON day_entries(date)');
  }

  // --- Cycle operations ---

  Future<int> insertCycle(Cycle cycle) async {
    final db = await database;
    return await db.insert('cycles', cycle.toMap()..remove('id'));
  }

  Future<void> updateCycle(Cycle cycle) async {
    final db = await database;
    await db.update('cycles', cycle.toMap(),
        where: 'id = ?', whereArgs: [cycle.id]);
  }

  Future<void> deleteCycle(int id) async {
    final db = await database;
    await db.delete('cycles', where: 'id = ?', whereArgs: [id]);
  }

  Future<Cycle?> getCycle(int id) async {
    final db = await database;
    final maps = await db.query('cycles', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Cycle.fromMap(maps.first);
  }

  Future<List<Cycle>> getAllCycles() async {
    final db = await database;
    final maps =
        await db.query('cycles', orderBy: 'startDate DESC');
    return maps.map((m) => Cycle.fromMap(m)).toList();
  }

  Future<Cycle?> getCurrentCycle() async {
    final db = await database;
    final maps = await db.query('cycles',
        where: 'endDate IS NULL', orderBy: 'startDate DESC', limit: 1);
    if (maps.isEmpty) return null;
    return Cycle.fromMap(maps.first);
  }

  Future<Cycle?> getCycleForDate(DateTime date) async {
    final db = await database;
    final dateStr = DateTime(date.year, date.month, date.day).toIso8601String();
    final maps = await db.query('cycles',
        where: 'startDate <= ? AND (endDate IS NULL OR endDate >= ?)',
        whereArgs: [dateStr, dateStr],
        orderBy: 'startDate DESC',
        limit: 1);
    if (maps.isEmpty) return null;
    return Cycle.fromMap(maps.first);
  }

  // --- DayEntry operations ---

  Future<int> insertDayEntry(DayEntry entry) async {
    final db = await database;
    return await db.insert('day_entries', entry.toMap()..remove('id'),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateDayEntry(DayEntry entry) async {
    final db = await database;
    await db.update('day_entries', entry.toMap(),
        where: 'id = ?', whereArgs: [entry.id]);
  }

  Future<void> deleteDayEntry(int id) async {
    final db = await database;
    await db.delete('day_entries', where: 'id = ?', whereArgs: [id]);
  }

  Future<DayEntry?> getDayEntry(DateTime date) async {
    final db = await database;
    final dateStr = DateTime(date.year, date.month, date.day).toIso8601String();
    final maps = await db.query('day_entries',
        where: 'date = ?', whereArgs: [dateStr]);
    if (maps.isEmpty) return null;
    return DayEntry.fromMap(maps.first);
  }

  Future<List<DayEntry>> getEntriesForCycle(int cycleId) async {
    final db = await database;
    final maps = await db.query('day_entries',
        where: 'cycleId = ?',
        whereArgs: [cycleId],
        orderBy: 'cycleDay ASC');
    return maps.map((m) => DayEntry.fromMap(m)).toList();
  }

  Future<List<DayEntry>> getEntriesInRange(
      DateTime start, DateTime end) async {
    final db = await database;
    final maps = await db.query('day_entries',
        where: 'date >= ? AND date <= ?',
        whereArgs: [
          DateTime(start.year, start.month, start.day).toIso8601String(),
          DateTime(end.year, end.month, end.day).toIso8601String(),
        ],
        orderBy: 'date ASC');
    return maps.map((m) => DayEntry.fromMap(m)).toList();
  }

  Future<List<DayEntry>> getAllEntries() async {
    final db = await database;
    final maps = await db.query('day_entries', orderBy: 'date ASC');
    return maps.map((m) => DayEntry.fromMap(m)).toList();
  }

  // --- Bulk operations for import/export ---

  Future<void> importData(List<Cycle> cycles, List<DayEntry> entries) async {
    final db = await database;
    await db.transaction((txn) async {
      for (final cycle in cycles) {
        await txn.insert('cycles', cycle.toMap()..remove('id'));
      }
      for (final entry in entries) {
        await txn.insert('day_entries', entry.toMap()..remove('id'),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('day_entries');
      await txn.delete('cycles');
    });
  }
}
