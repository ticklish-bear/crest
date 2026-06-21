import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/cycle_provider.dart';
import '../models/cycle.dart';
import '../l10n/app_localizations.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    return Consumer<CycleProvider>(
      builder: (context, provider, _) {
        final cycles = provider.cycles;
        final lengths = provider.cycleLengths;

        if (cycles.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.insights,
                      size: 56,
                      color: colors.onSurfaceVariant.withAlpha(120)),
                  const SizedBox(height: 16),
                  Text(l.statsNoInsights,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 8),
                  Text(
                    l.statsNoInsightsSub,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildStatGrid(provider, colors, l),
            const SizedBox(height: 16),

            // Prediction card
            if (provider.predictedNextPeriod != null)
              _buildPredictionCard(provider, colors, theme, l, locale),
            if (provider.predictedNextPeriod != null)
              const SizedBox(height: 16),

            // Cross-cycle insights
            if (lengths.length >= 3)
              _buildInsightsCard(provider, colors, theme, l),
            if (lengths.length >= 3) const SizedBox(height: 16),

            if (lengths.length >= 2) ...[
              Text(l.cycleLengthHistory,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 12),
              _buildCycleLengthChart(lengths, colors, l),
              const SizedBox(height: 24),
            ],

            Text(l.allCycles,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 12),
            ...cycles.map((cycle) =>
                _buildCycleCard(context, cycle, provider, colors, l, locale)),
          ],
        );
      },
    );
  }

  Widget _buildPredictionCard(
      CycleProvider provider, ColorScheme colors, ThemeData theme,
      AppLocalizations l, String locale) {
    final predicted = provider.predictedNextPeriod!;
    final daysUntil = provider.daysUntilNextPeriod!;

    String statusText;
    Color statusColor;
    IconData statusIcon;

    if (daysUntil > 3) {
      statusText = l.daysUntilPeriod(daysUntil);
      statusColor = colors.primary;
      statusIcon = Icons.calendar_today_outlined;
    } else if (daysUntil > 0) {
      statusText = l.periodExpectedIn(daysUntil);
      statusColor = colors.tertiary;
      statusIcon = Icons.upcoming_outlined;
    } else if (daysUntil == 0) {
      statusText = l.periodExpectedToday;
      statusColor = colors.error;
      statusIcon = Icons.today;
    } else {
      statusText = l.daysPastExpected(-daysUntil);
      statusColor = colors.error;
      statusIcon = Icons.event_busy_outlined;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(statusIcon, color: statusColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(statusText,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: statusColor,
                    )),
                const SizedBox(height: 2),
                Text(
                  l.predictionEst(
                      DateFormat('MMM d', locale).format(predicted),
                      provider.averageCycleLength?.toStringAsFixed(0) ?? '—'),
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsCard(
      CycleProvider provider, ColorScheme colors, ThemeData theme,
      AppLocalizations l) {
    final stdDev = provider.cycleLengthStdDev;
    final avgShift = provider.averageTempShiftDay;
    final completed = provider.completedCycleCount;

    String regularity;
    Color regularityColor;
    if (stdDev != null) {
      if (stdDev <= 2.0) {
        regularity = l.regVeryRegular;
        regularityColor = Colors.green;
      } else if (stdDev <= 4.0) {
        regularity = l.regRegular;
        regularityColor = Colors.green.shade300;
      } else if (stdDev <= 7.0) {
        regularity = l.regSomewhat;
        regularityColor = Colors.orange;
      } else {
        regularity = l.regIrregular;
        regularityColor = colors.error;
      }
    } else {
      regularity = l.regNotEnough;
      regularityColor = colors.onSurfaceVariant;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics_outlined,
                  size: 18, color: colors.primary),
              const SizedBox(width: 8),
              Text(l.crossCycleInsights,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: colors.onSurface,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          _insightRow(l.insightRegularity, regularity, regularityColor, colors),
          if (stdDev != null)
            _insightRow(l.insightVariation,
                l.variationDays(stdDev.toStringAsFixed(1)),
                colors.onSurface, colors),
          if (avgShift != null)
            _insightRow(l.insightAvgShift, l.evalDayValue(avgShift.round()),
                colors.onSurface, colors),
          _insightRow(l.insightCyclesRecorded, l.cyclesCompleted(completed),
              colors.onSurface, colors),
          if (completed < 12) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: colors.tertiaryContainer.withAlpha(60),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 14, color: colors.tertiary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l.moreCyclesNeeded(12 - completed),
                      style: TextStyle(
                          fontSize: 12, color: colors.tertiary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _insightRow(
      String label, String value, Color valueColor, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 13, color: colors.onSurfaceVariant)),
          Text(value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor,
              )),
        ],
      ),
    );
  }

  Widget _buildStatGrid(
      CycleProvider provider, ColorScheme colors, AppLocalizations l) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: [
        _statCard(
            l.statTotalCycles, '${provider.cycles.length}', colors),
        _statCard(
            l.statAvgLength,
            provider.averageCycleLength != null
                ? l.daysUnit(
                    provider.averageCycleLength!.toStringAsFixed(1))
                : '\u2014',
            colors),
        _statCard(
            l.statShortest,
            provider.shortestCycle != null
                ? l.daysUnit('${provider.shortestCycle}')
                : '\u2014',
            colors),
        _statCard(
            l.statLongest,
            provider.longestCycle != null
                ? l.daysUnit('${provider.longestCycle}')
                : '\u2014',
            colors),
      ],
    );
  }

  Widget _statCard(
      String label, String value, ColorScheme colors) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colors.onSurface,
              )),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                fontSize: 12,
                color: colors.onSurfaceVariant,
              )),
        ],
      ),
    );
  }

  Widget _buildCycleLengthChart(
      List<int> lengths, ColorScheme colors, AppLocalizations l) {
    final avg =
        lengths.reduce((a, b) => a + b) / lengths.length;

    return Container(
      height: 200,
      padding: const EdgeInsets.only(right: 8, top: 8),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: colors.outlineVariant.withAlpha(80)),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: (lengths.reduce((a, b) => a > b ? a : b) + 5)
              .toDouble(),
          barGroups: lengths.asMap().entries.map((e) {
            final length = e.value;
            final isNormal = length >= 24 && length <= 35;
            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: length.toDouble(),
                  color:
                      isNormal ? colors.primary : colors.error,
                  width: 14,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4)),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  '#${value.toInt() + 1}',
                  style: TextStyle(
                      fontSize: 10,
                      color: colors.onSurfaceVariant),
                ),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 5,
                getTitlesWidget: (value, meta) => Text(
                  '${value.toInt()}',
                  style: TextStyle(
                      fontSize: 10,
                      color: colors.onSurfaceVariant),
                ),
              ),
            ),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: 5,
            getDrawingHorizontalLine: (value) => FlLine(
              color: colors.outlineVariant.withAlpha(40),
              strokeWidth: 0.5,
            ),
          ),
          borderData: FlBorderData(show: false),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: avg,
                color: colors.tertiary,
                strokeWidth: 1.5,
                dashArray: [4, 4],
                label: HorizontalLineLabel(
                  show: true,
                  labelResolver: (_) =>
                      l.chartAvg(avg.toStringAsFixed(1)),
                  style: TextStyle(
                      color: colors.tertiary, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCycleCard(
      BuildContext context, Cycle cycle, CycleProvider provider,
      ColorScheme colors, AppLocalizations l, String locale) {
    final isActive = cycle.endDate == null;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isActive
            ? colors.primaryContainer.withAlpha(50)
            : colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? colors.primary.withAlpha(60)
              : colors.outlineVariant.withAlpha(80),
        ),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: isActive
                ? colors.primary
                : colors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            cycle.length?.toString() ?? '?',
            style: TextStyle(
              color: isActive
                  ? colors.onPrimary
                  : colors.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        title: Text(
          '${DateFormat('MMM d, yyyy', locale).format(cycle.startDate)}'
          '${cycle.endDate != null ? ' \u2014 ${DateFormat('MMM d', locale).format(cycle.endDate!)}' : ''}',
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          isActive
              ? l.currentCycleDay(cycle.currentDayCount)
              : l.daysUnit('${cycle.length}'),
          style: TextStyle(
            fontSize: 13,
            color: colors.onSurfaceVariant,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isActive)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(l.active,
                    style: TextStyle(
                      color: colors.onPrimary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            if (!isActive)
              IconButton(
                icon: Icon(Icons.delete_outline,
                    size: 20, color: colors.error.withAlpha(160)),
                tooltip: l.deleteCycleTooltip,
                onPressed: () =>
                    _confirmDeleteCycle(context, cycle, provider, colors),
              ),
          ],
        ),
        onTap: () => provider.selectCycle(cycle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _confirmDeleteCycle(BuildContext context, Cycle cycle,
      CycleProvider provider, ColorScheme colors) async {
    final l = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.deleteCycleTitle),
        content: Text(l.deleteCycleBody(
            DateFormat('MMM d, yyyy', locale).format(cycle.startDate))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.cancel),
          ),
          FilledButton(
            style:
                FilledButton.styleFrom(backgroundColor: colors.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await provider.deleteCycle(cycle);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l.cycleDeleted),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
