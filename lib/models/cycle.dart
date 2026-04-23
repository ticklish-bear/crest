// Sentinel to distinguish "not provided" from "explicitly set to null"
const _cycleSentinel = Object();

class Cycle {
  final int? id;
  final DateTime startDate;
  final DateTime? endDate;
  final int? length;
  final double? coverlineTemp;
  final int? peakDayIndex; // cycle day of Peak Day (1-based)
  final int? temperatureShiftDay; // cycle day where temp shift confirmed
  final String? notes;

  Cycle({
    this.id,
    required this.startDate,
    this.endDate,
    this.length,
    this.coverlineTemp,
    this.peakDayIndex,
    this.temperatureShiftDay,
    this.notes,
  });

  Cycle copyWith({
    int? id,
    DateTime? startDate,
    Object? endDate = _cycleSentinel,
    Object? length = _cycleSentinel,
    Object? coverlineTemp = _cycleSentinel,
    Object? peakDayIndex = _cycleSentinel,
    Object? temperatureShiftDay = _cycleSentinel,
    Object? notes = _cycleSentinel,
  }) {
    return Cycle(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: identical(endDate, _cycleSentinel)
          ? this.endDate
          : endDate as DateTime?,
      length: identical(length, _cycleSentinel)
          ? this.length
          : length as int?,
      coverlineTemp: identical(coverlineTemp, _cycleSentinel)
          ? this.coverlineTemp
          : coverlineTemp as double?,
      peakDayIndex: identical(peakDayIndex, _cycleSentinel)
          ? this.peakDayIndex
          : peakDayIndex as int?,
      temperatureShiftDay: identical(temperatureShiftDay, _cycleSentinel)
          ? this.temperatureShiftDay
          : temperatureShiftDay as int?,
      notes: identical(notes, _cycleSentinel)
          ? this.notes
          : notes as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'length': length,
      'coverlineTemp': coverlineTemp,
      'peakDayIndex': peakDayIndex,
      'temperatureShiftDay': temperatureShiftDay,
      'notes': notes,
    };
  }

  factory Cycle.fromMap(Map<String, dynamic> map) {
    return Cycle(
      id: map['id'] as int?,
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: map['endDate'] != null
          ? DateTime.parse(map['endDate'] as String)
          : null,
      length: map['length'] as int?,
      coverlineTemp: map['coverlineTemp'] as double?,
      peakDayIndex: map['peakDayIndex'] as int?,
      temperatureShiftDay: map['temperatureShiftDay'] as int?,
      notes: map['notes'] as String?,
    );
  }

  int get currentDayCount {
    final end = endDate ?? DateTime.now();
    return end.difference(startDate).inDays + 1;
  }
}
