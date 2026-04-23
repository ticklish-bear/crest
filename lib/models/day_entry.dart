enum MucusType {
  dry,
  nothing, // nothing felt, nothing seen
  moist,
  wet,
  slippery,
  eggWhite,
  unrecorded, // default — user hasn't recorded mucus yet
}

enum MucusAppearance {
  none,
  cloudy,
  yellowish,
  sticky,
  creamy,
  clear,
  stretchy,
  transparent,
}

enum BleedingType {
  none,
  spotting,
  light,
  medium,
  heavy,
}

enum CervixPosition {
  unset,
  low,
  medium,
  high,
}

enum CervixOpenness {
  unset,
  closed,
  partiallyOpen,
  open,
}

enum CervixFirmness {
  unset,
  firm,
  medium,
  soft,
}

// Sentinel to distinguish "not provided" from "explicitly set to null"
const _sentinel = Object();

class DayEntry {
  final int? id;
  final int cycleId;
  final DateTime date;
  final int cycleDay; // 1-based
  final double? temperature;
  final String? temperatureTime;
  final bool temperatureExcluded;
  final String? temperatureExcludeReason;
  final MucusType mucusType;
  final MucusAppearance mucusAppearance;
  final BleedingType bleeding;
  final CervixPosition cervixPosition;
  final CervixOpenness cervixOpenness;
  final CervixFirmness cervixFirmness;
  final bool isPeakDay;
  final bool intercourse;
  final String? notes;

  DayEntry({
    this.id,
    required this.cycleId,
    required this.date,
    required this.cycleDay,
    this.temperature,
    this.temperatureTime,
    this.temperatureExcluded = false,
    this.temperatureExcludeReason,
    this.mucusType = MucusType.unrecorded,
    this.mucusAppearance = MucusAppearance.none,
    this.bleeding = BleedingType.none,
    this.cervixPosition = CervixPosition.unset,
    this.cervixOpenness = CervixOpenness.unset,
    this.cervixFirmness = CervixFirmness.unset,
    this.isPeakDay = false,
    this.intercourse = false,
    this.notes,
  });

  /// copyWith that supports explicitly setting nullable fields to null.
  /// Pass the field normally to set a value, or use clearTemperature: true etc.
  DayEntry copyWith({
    int? id,
    int? cycleId,
    DateTime? date,
    int? cycleDay,
    Object? temperature = _sentinel,
    Object? temperatureTime = _sentinel,
    bool? temperatureExcluded,
    Object? temperatureExcludeReason = _sentinel,
    MucusType? mucusType,
    MucusAppearance? mucusAppearance,
    BleedingType? bleeding,
    CervixPosition? cervixPosition,
    CervixOpenness? cervixOpenness,
    CervixFirmness? cervixFirmness,
    bool? isPeakDay,
    bool? intercourse,
    Object? notes = _sentinel,
  }) {
    return DayEntry(
      id: id ?? this.id,
      cycleId: cycleId ?? this.cycleId,
      date: date ?? this.date,
      cycleDay: cycleDay ?? this.cycleDay,
      temperature: identical(temperature, _sentinel)
          ? this.temperature
          : temperature as double?,
      temperatureTime: identical(temperatureTime, _sentinel)
          ? this.temperatureTime
          : temperatureTime as String?,
      temperatureExcluded: temperatureExcluded ?? this.temperatureExcluded,
      temperatureExcludeReason: identical(temperatureExcludeReason, _sentinel)
          ? this.temperatureExcludeReason
          : temperatureExcludeReason as String?,
      mucusType: mucusType ?? this.mucusType,
      mucusAppearance: mucusAppearance ?? this.mucusAppearance,
      bleeding: bleeding ?? this.bleeding,
      cervixPosition: cervixPosition ?? this.cervixPosition,
      cervixOpenness: cervixOpenness ?? this.cervixOpenness,
      cervixFirmness: cervixFirmness ?? this.cervixFirmness,
      isPeakDay: isPeakDay ?? this.isPeakDay,
      intercourse: intercourse ?? this.intercourse,
      notes: identical(notes, _sentinel) ? this.notes : notes as String?,
    );
  }

  /// Mucus quality level for STM evaluation (0-4 scale)
  int get mucusQuality {
    if (mucusType == MucusType.eggWhite || mucusType == MucusType.slippery) {
      return 4;
    }
    if (mucusType == MucusType.wet) return 3;
    if (mucusType == MucusType.moist) return 2;
    if (mucusType == MucusType.nothing) return 1;
    return 0; // dry or unrecorded
  }

  /// Whether mucus has been explicitly recorded by the user
  bool get hasMucusRecorded => mucusType != MucusType.unrecorded;

  bool get hasFertileMucus => mucusQuality >= 3;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cycleId': cycleId,
      'date': date.toIso8601String(),
      'cycleDay': cycleDay,
      'temperature': temperature,
      'temperatureTime': temperatureTime,
      'temperatureExcluded': temperatureExcluded ? 1 : 0,
      'temperatureExcludeReason': temperatureExcludeReason,
      'mucusType': mucusType.index,
      'mucusAppearance': mucusAppearance.index,
      'bleeding': bleeding.index,
      'cervixPosition': cervixPosition.index,
      'cervixOpenness': cervixOpenness.index,
      'cervixFirmness': cervixFirmness.index,
      'isPeakDay': isPeakDay ? 1 : 0,
      'intercourse': intercourse ? 1 : 0,
      'notes': notes,
    };
  }

  factory DayEntry.fromMap(Map<String, dynamic> map) {
    return DayEntry(
      id: map['id'] as int?,
      cycleId: map['cycleId'] as int,
      date: DateTime.parse(map['date'] as String),
      cycleDay: map['cycleDay'] as int,
      temperature: map['temperature'] as double?,
      temperatureTime: map['temperatureTime'] as String?,
      temperatureExcluded: (map['temperatureExcluded'] as int?) == 1,
      temperatureExcludeReason: map['temperatureExcludeReason'] as String?,
      mucusType: MucusType.values[map['mucusType'] as int? ?? 0],
      mucusAppearance:
          MucusAppearance.values[map['mucusAppearance'] as int? ?? 0],
      bleeding: BleedingType.values[map['bleeding'] as int? ?? 0],
      cervixPosition:
          CervixPosition.values[map['cervixPosition'] as int? ?? 0],
      cervixOpenness:
          CervixOpenness.values[map['cervixOpenness'] as int? ?? 0],
      cervixFirmness:
          CervixFirmness.values[map['cervixFirmness'] as int? ?? 0],
      isPeakDay: (map['isPeakDay'] as int?) == 1,
      intercourse: (map['intercourse'] as int?) == 1,
      notes: map['notes'] as String?,
    );
  }
}
