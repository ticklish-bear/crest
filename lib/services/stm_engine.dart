import '../models/day_entry.dart';
import '../models/cycle.dart';
import '../models/settings.dart';

/// Fertility status for a given day
enum FertilityStatus {
  infertilePreOvulation,
  fertile,
  /// Fertile, but one of the two checks (temp or mucus) has been met.
  /// Still considered FERTILE for safety — shown with an informational note.
  fertileWaitingForDoubleCheck,
  infertilePostOvulation,
  menstruation,
  unknown,
}

/// Which pre-ovulatory rule was applied to determine infertility
enum PreOvRule {
  /// Beginner default: first 5 days are infertile
  fiveDayRule,

  /// Rötzer: first 6 days infertile if all recorded cycles ≥26 days
  roetzerSixDayRule,

  /// Minus-20: shortest cycle length − 20 = last infertile day
  minus20Rule,

  /// Minus-8: earliest first higher temperature day − 8
  minus8Rule,

  /// Mucus override: fertile mucus appeared, ending infertile phase
  mucusOverride,

  /// No applicable rule (not enough data)
  none,
}

/// Result of the STM rule evaluation for a cycle
class StmEvaluation {
  final double? coverline;
  final int? firstHighTempDay; // cycle day of first high temp
  final int? temperatureShiftConfirmedDay; // day shift is confirmed (3rd high)
  final int? peakDay; // cycle day of Peak Day
  final int? postPeakInfertileFrom; // cycle day post-peak infertility begins
  final Map<int, FertilityStatus> dayStatuses; // cycleDay -> status

  /// Pre-ovulatory infertility details
  final int lastInfertilePreOvDay; // last cycle day considered infertile pre-ov
  final PreOvRule appliedPreOvRule; // which rule determined the boundary
  final int? minus20Value; // shortest cycle − 20 (if calculated)
  final int? minus8Value; // earliest temp rise − 8 (if calculated)
  final int? shortestCycleUsed; // shortest cycle used for minus-20
  final int? earliestTempRiseUsed; // earliest temp rise day used for minus-8
  final int completedCycleCount; // how many completed cycles are available

  const StmEvaluation({
    this.coverline,
    this.firstHighTempDay,
    this.temperatureShiftConfirmedDay,
    this.peakDay,
    this.postPeakInfertileFrom,
    this.dayStatuses = const {},
    this.lastInfertilePreOvDay = 5,
    this.appliedPreOvRule = PreOvRule.fiveDayRule,
    this.minus20Value,
    this.minus8Value,
    this.shortestCycleUsed,
    this.earliestTempRiseUsed,
    this.completedCycleCount = 0,
  });
}

class StmEngine {
  final StmRuleset ruleset;

  StmEngine({this.ruleset = StmRuleset.agNfp});

  /// Evaluate a full cycle and return the STM analysis.
  ///
  /// [previousCycles] provides completed cycle data for calculating
  /// pre-ovulatory rules (minus-20, minus-8, Rötzer).
  /// [previousTempShiftDays] provides the first higher temperature day
  /// from each of the previous cycles for the minus-8 rule.
  ///
  /// AG NFP / Sensiplan rules:
  /// - Temperature shift: 3 consecutive temps above the coverline (highest of
  ///   the previous 6 low temps). The 3rd temp must be at least 0.2°C above
  ///   the coverline.
  /// - Peak Day: last day of best-quality cervical mucus before it dries up.
  /// - Post-ovulatory infertility: confirmed on the evening of the 3rd day
  ///   after Peak Day AND after the temperature shift is confirmed, whichever
  ///   comes later.
  /// - Pre-ovulatory infertility: determined by the most conservative of:
  ///   1. 5-day rule (beginners, <12 completed cycles)
  ///   2. Rötzer 6-day rule (if all recorded cycles ≥26 days)
  ///   3. Minus-20 rule (shortest cycle − 20, after 12+ cycles)
  ///   4. Minus-8 rule (earliest temp rise − 8, after 12+ cycles)
  ///   The MOST CONSERVATIVE (smallest number) always wins.
  ///   Cervical mucus ALWAYS overrides: any fertile mucus = fertile.
  StmEvaluation evaluate(
    Cycle cycle,
    List<DayEntry> entries, {
    List<Cycle> previousCycles = const [],
    List<int?> previousTempShiftDays = const [],
  }) {
    if (entries.isEmpty) {
      return const StmEvaluation();
    }

    // Sort by cycle day
    final sorted = List<DayEntry>.from(entries)
      ..sort((a, b) => a.cycleDay.compareTo(b.cycleDay));

    final dayStatuses = <int, FertilityStatus>{};

    // Mark menstruation days
    for (final e in sorted) {
      if (e.bleeding != BleedingType.none) {
        dayStatuses[e.cycleDay] = FertilityStatus.menstruation;
      }
    }

    // Find valid temperatures (not excluded)
    final tempsWithDay = <int, double>{};
    for (final e in sorted) {
      if (e.temperature != null && !e.temperatureExcluded) {
        tempsWithDay[e.cycleDay] = e.temperature!;
      }
    }

    // Auto-detect Peak Day: last day of best mucus quality before it drops
    int? peakDay = _findPeakDay(sorted, cycle);

    // Temperature shift detection
    double? coverline;
    int? firstHighTempDay;
    int? shiftConfirmedDay;

    if (tempsWithDay.length >= 6) {
      final result = _detectTemperatureShift(tempsWithDay);
      coverline = result.$1;
      firstHighTempDay = result.$2;
      shiftConfirmedDay = result.$3;
    }

    // Use manual overrides from cycle if set
    coverline = cycle.coverlineTemp ?? coverline;
    peakDay = cycle.peakDayIndex ?? peakDay;

    // === DOUBLE-CHECK (Doppelte Kontrolle) ===
    // Post-ovulatory infertility requires BOTH:
    //   1. Temperature shift confirmed (3-over-6 rule)
    //   2. Peak Day + 3 (mucus drying confirms ovulation)
    // The LATER of these two markers starts the infertile phase.
    // Temperature alone is NEVER sufficient for confirming infertility.
    int? postPeakInfertileFrom;
    bool tempCheckMet = shiftConfirmedDay != null;
    bool mucusCheckMet = peakDay != null;
    bool doubleCheckComplete = tempCheckMet && mucusCheckMet;

    if (doubleCheckComplete) {
      final pd = peakDay;
      final sd = shiftConfirmedDay;
      final peakPlus3 = pd + 3;
      // Infertility begins on the evening of whichever comes later
      postPeakInfertileFrom = peakPlus3 > sd ? peakPlus3 : sd;
    }
    // If only one check is met, we track that for informational display
    // but do NOT confirm infertility — days remain fertile.

    // === PRE-OVULATORY INFERTILITY RULES ===
    final preOvResult = _calculatePreOvInfertileDay(
      previousCycles: previousCycles,
      previousTempShiftDays: previousTempShiftDays,
      currentEntries: sorted,
    );

    final lastInfertilePreOvDay = preOvResult.lastInfertileDay;

    // Determine the last cycle day to evaluate:
    // For an open cycle, go up to today; for a closed cycle, use the length.
    final today = DateTime.now();
    final int lastCycleDay;
    if (cycle.length != null) {
      lastCycleDay = cycle.length!;
    } else {
      lastCycleDay = today.difference(cycle.startDate).inDays + 1;
    }

    // Build a lookup of recorded entries by cycle day
    final entryByDay = <int, DayEntry>{};
    for (final e in sorted) {
      entryByDay[e.cycleDay] = e;
    }

    // Assign fertility status to ALL days in the cycle (not just recorded ones)
    for (int day = 1; day <= lastCycleDay; day++) {
      // Keep menstruation status if already set from bleeding data
      if (dayStatuses[day] == FertilityStatus.menstruation) continue;

      final entry = entryByDay[day];

      if (postPeakInfertileFrom != null &&
          day >= postPeakInfertileFrom) {
        // Post-ovulatory infertile — BOTH checks confirmed
        dayStatuses[day] = FertilityStatus.infertilePostOvulation;
      } else if (day <= lastInfertilePreOvDay &&
          (entry == null || entry.bleeding == BleedingType.none) &&
          !_hasFertileMucusOnOrBefore(sorted, day)) {
        // Pre-ov infertile: only if no fertile mucus observed up to this day
        dayStatuses[day] = FertilityStatus.infertilePreOvulation;
      } else if (!doubleCheckComplete &&
          (tempCheckMet || mucusCheckMet) &&
          _isAfterPartialCheck(day, shiftConfirmedDay, peakDay)) {
        // One check is met but not both — still FERTILE for safety,
        // but marked so the UI can show an informational note
        dayStatuses[day] = FertilityStatus.fertileWaitingForDoubleCheck;
      } else {
        dayStatuses[day] = FertilityStatus.fertile;
      }
    }

    return StmEvaluation(
      coverline: coverline,
      firstHighTempDay: firstHighTempDay,
      temperatureShiftConfirmedDay: shiftConfirmedDay,
      peakDay: peakDay,
      postPeakInfertileFrom: postPeakInfertileFrom,
      dayStatuses: dayStatuses,
      lastInfertilePreOvDay: lastInfertilePreOvDay,
      appliedPreOvRule: preOvResult.appliedRule,
      minus20Value: preOvResult.minus20Value,
      minus8Value: preOvResult.minus8Value,
      shortestCycleUsed: preOvResult.shortestCycleUsed,
      earliestTempRiseUsed: preOvResult.earliestTempRiseUsed,
      completedCycleCount: previousCycles.length,
    );
  }

  /// Check if a day falls after the point where a partial check was met.
  /// Used to assign the "waiting for double-check" status to the right days.
  bool _isAfterPartialCheck(
      int day, int? shiftConfirmedDay, int? peakDay) {
    if (shiftConfirmedDay != null && day >= shiftConfirmedDay) return true;
    if (peakDay != null && day >= peakDay + 3) return true;
    return false;
  }

  /// Check if any entry on or before the given cycle day has fertile mucus.
  /// This is the cervical mucus override: any fertile mucus = fertile,
  /// regardless of calendar calculations.
  bool _hasFertileMucusOnOrBefore(List<DayEntry> sorted, int cycleDay) {
    for (final e in sorted) {
      if (e.cycleDay > cycleDay) break;
      if (e.hasFertileMucus) return true;
    }
    return false;
  }

  /// Calculate the last pre-ovulatory infertile day using the STM rule
  /// hierarchy. Returns the most conservative (lowest) value.
  ///
  /// Rule hierarchy (AG NFP / Sensiplan):
  /// 1. Beginners (<12 completed cycles): 5-day rule (days 1–5 infertile)
  /// 2. Rötzer 6-day rule: days 1–6 infertile IF all recorded cycles ≥26 days
  /// 3. Minus-20 rule: shortest recorded cycle − 20 (after 12+ cycles)
  /// 4. Minus-8 rule: earliest first higher temperature day − 8 (after 12+)
  ///
  /// The MOST CONSERVATIVE (smallest number) always wins.
  /// Minimum is 1 (at least day 1 is infertile during menstruation).
  _PreOvResult _calculatePreOvInfertileDay({
    required List<Cycle> previousCycles,
    required List<int?> previousTempShiftDays,
    required List<DayEntry> currentEntries,
  }) {
    final completedCycles = previousCycles
        .where((c) => c.length != null && c.length! > 0)
        .toList();
    final cycleCount = completedCycles.length;

    // Collect all valid temp shift days (first higher temperature day)
    final validTempShiftDays = previousTempShiftDays
        .where((d) => d != null)
        .cast<int>()
        .toList();

    int? minus20Value;
    int? minus8Value;
    int? shortestCycleUsed;
    int? earliestTempRiseUsed;

    // Default: 5-day rule (beginners or fallback)
    int bestDay = 5;
    PreOvRule bestRule = PreOvRule.fiveDayRule;

    // === Rötzer 6-day rule ===
    // If we have cycle history and ALL recorded cycles are ≥26 days,
    // we can extend to 6 days infertile.
    if (cycleCount > 0) {
      final allCyclesLongEnough =
          completedCycles.every((c) => c.length! >= 26);
      if (allCyclesLongEnough) {
        // Rötzer allows 6 days — only if no stricter rule overrides
        bestDay = 6;
        bestRule = PreOvRule.roetzerSixDayRule;
      }
    }

    // === Minus-20 rule (after 12+ completed cycles) ===
    if (cycleCount >= 12) {
      final cycleLengths =
          completedCycles.map((c) => c.length!).toList();
      shortestCycleUsed = cycleLengths.reduce((a, b) => a < b ? a : b);
      minus20Value = shortestCycleUsed - 20;

      if (minus20Value >= 1 && minus20Value < bestDay) {
        bestDay = minus20Value;
        bestRule = PreOvRule.minus20Rule;
      }
    }

    // === Minus-8 rule (after 12+ cycles with temp data) ===
    if (validTempShiftDays.length >= 12) {
      earliestTempRiseUsed =
          validTempShiftDays.reduce((a, b) => a < b ? a : b);
      minus8Value = earliestTempRiseUsed - 8;

      if (minus8Value >= 1 && minus8Value < bestDay) {
        bestDay = minus8Value;
        bestRule = PreOvRule.minus8Rule;
      }
    }

    // Ensure minimum of 1
    if (bestDay < 1) bestDay = 1;

    return _PreOvResult(
      lastInfertileDay: bestDay,
      appliedRule: bestRule,
      minus20Value: minus20Value,
      minus8Value: minus8Value,
      shortestCycleUsed: shortestCycleUsed,
      earliestTempRiseUsed: earliestTempRiseUsed,
    );
  }

  /// Detect temperature shift using the "3 over 6" rule.
  ///
  /// Gap handling:
  /// - The 6 "low phase" temps do NOT need to be on consecutive days.
  ///   Missing recordings in the low phase are simply skipped — we use the
  ///   6 most recent temps before the candidate high phase.
  /// - The 3 "high phase" temps MUST be on consecutive calendar days.
  ///   If a day is missing in the high phase, the shift cannot be confirmed
  ///   at that point — we keep looking for a valid 3-consecutive-day window.
  ///   This is the conservative approach: a gap in the high phase means
  ///   the user cannot confirm ovulation has occurred.
  ///
  /// Returns (coverline, firstHighDay, confirmedDay) or nulls.
  (double?, int?, int?) _detectTemperatureShift(
      Map<int, double> tempsWithDay) {
    final sortedDays = tempsWithDay.keys.toList()..sort();

    // Need at least 9 recorded temps (6 low + 3 high minimum)
    if (sortedDays.length < 9) return (null, null, null);

    // Try each possible start of the "3 high" phase
    for (int i = 6; i <= sortedDays.length - 3; i++) {
      final highDays = sortedDays.sublist(i, i + 3);

      // The 3 high temps must be on CONSECUTIVE calendar days
      // (e.g. days 15, 16, 17 — not 15, 17, 18)
      if (highDays[1] != highDays[0] + 1 ||
          highDays[2] != highDays[1] + 1) {
        continue; // Gap in high phase — can't confirm shift here
      }

      // The 6 temps before this point (may span non-consecutive days)
      final lowDays = sortedDays.sublist(i - 6, i);
      final lowTemps = lowDays.map((d) => tempsWithDay[d]!).toList();
      final coverline = lowTemps.reduce((a, b) => a > b ? a : b);

      // Check if all 3 high temps are above the coverline
      final highTemps = highDays.map((d) => tempsWithDay[d]!).toList();
      final allAbove = highTemps.every((t) => t > coverline);
      final thirdAboveBy02 = highTemps[2] >= coverline + 0.2;

      if (allAbove && thirdAboveBy02) {
        return (coverline, highDays[0], highDays[2]);
      }
    }

    return (null, null, null);
  }

  /// Find Peak Day: the last day of best-quality mucus before a decline.
  int? _findPeakDay(List<DayEntry> sorted, Cycle cycle) {
    // Check for manual Peak Day first
    for (final e in sorted) {
      if (e.isPeakDay) return e.cycleDay;
    }

    // Auto-detect: find last day with fertile mucus (quality >= 3)
    // followed by at least one day of lower quality
    int? peak;
    for (int i = 0; i < sorted.length - 1; i++) {
      if (sorted[i].mucusQuality >= 3 && sorted[i + 1].mucusQuality < 3) {
        peak = sorted[i].cycleDay;
      }
    }
    return peak;
  }

  /// Get a display-friendly label for a fertility status.
  /// Labels adapt based on app purpose and which pre-ov rule was applied.
  static String statusLabel(FertilityStatus status,
      {AppPurpose purpose = AppPurpose.anticonception,
      int? cycleDay,
      StmEvaluation? evaluation}) {
    switch (status) {
      case FertilityStatus.infertilePreOvulation:
        return purpose == AppPurpose.anticonception
            ? 'Potentially fertile'
            : 'Infertile (pre-ov)';
      case FertilityStatus.fertile:
        return 'Fertile';
      case FertilityStatus.fertileWaitingForDoubleCheck:
        // Still fertile! But one check has passed.
        if (evaluation != null) {
          if (evaluation.temperatureShiftConfirmedDay != null &&
              evaluation.peakDay == null) {
            return 'Fertile (temp shift \u2713, awaiting mucus)';
          } else if (evaluation.peakDay != null &&
              evaluation.temperatureShiftConfirmedDay == null) {
            return 'Fertile (Peak Day \u2713, awaiting temp)';
          }
        }
        return 'Fertile (awaiting double-check)';
      case FertilityStatus.infertilePostOvulation:
        return purpose == AppPurpose.anticonception
            ? 'Infertile'
            : 'Infertile (post-ov)';
      case FertilityStatus.menstruation:
        if (purpose == AppPurpose.anticonception) {
          if (cycleDay != null && evaluation != null) {
            final limit = evaluation.lastInfertilePreOvDay;
            if (cycleDay <= limit) {
              return 'Infertile (day $cycleDay/$limit)';
            }
          } else if (cycleDay != null && cycleDay <= 5) {
            // Fallback when no evaluation available
            return 'Infertile (day $cycleDay/5)';
          }
          return 'Menstruation';
        }
        return 'Menstruation';
      case FertilityStatus.unknown:
        return 'Unknown';
    }
  }

  /// Get a short description of the applied pre-ov rule
  static String preOvRuleDescription(PreOvRule rule) {
    switch (rule) {
      case PreOvRule.fiveDayRule:
        return '5-day rule (beginner default)';
      case PreOvRule.roetzerSixDayRule:
        return 'Rötzer 6-day rule (all cycles ≥26 days)';
      case PreOvRule.minus20Rule:
        return 'Minus-20 rule (shortest cycle − 20)';
      case PreOvRule.minus8Rule:
        return 'Minus-8 rule (earliest temp rise − 8)';
      case PreOvRule.mucusOverride:
        return 'Mucus override (fertile signs detected)';
      case PreOvRule.none:
        return 'No rule applied';
    }
  }
}

/// Internal result of pre-ovulatory infertile day calculation
class _PreOvResult {
  final int lastInfertileDay;
  final PreOvRule appliedRule;
  final int? minus20Value;
  final int? minus8Value;
  final int? shortestCycleUsed;
  final int? earliestTempRiseUsed;

  const _PreOvResult({
    required this.lastInfertileDay,
    required this.appliedRule,
    this.minus20Value,
    this.minus8Value,
    this.shortestCycleUsed,
    this.earliestTempRiseUsed,
  });
}
