import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/cycle_provider.dart';
import '../models/day_entry.dart';
import '../models/settings.dart';
import '../services/stm_engine.dart';
import '../theme/app_theme.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Consumer<CycleProvider>(
      builder: (context, provider, _) {
        final entries = provider.currentEntries;
        final evaluation = provider.currentEvaluation;
        final cycle = provider.currentCycle;
        final settings = provider.settings;

        if (cycle == null || entries.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.ssid_chart,
                      size: 56,
                      color: colors.onSurfaceVariant.withAlpha(120)),
                  const SizedBox(height: 16),
                  Text('No chart data yet',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 8),
                  Text(
                    'Start a new cycle and log your daily temperature to see the chart.',
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

        final tempEntries =
            entries.where((e) => e.temperature != null).toList();
        if (tempEntries.isEmpty) {
          return Center(
            child: Text('No temperature data recorded yet.',
                style: TextStyle(color: colors.onSurfaceVariant)),
          );
        }

        final allTemps = tempEntries
            .map((e) => settings.displayTemp(e.temperature!))
            .toList();
        final minTemp =
            allTemps.reduce((a, b) => a < b ? a : b) - 0.3;
        final maxTemp =
            allTemps.reduce((a, b) => a > b ? a : b) + 0.3;
        final maxCycleDay = entries.last.cycleDay.toDouble();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Text('Temperature',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  const Spacer(),
                  TextButton.icon(
                    icon: const Icon(Icons.edit, size: 14),
                    label: const Text('Coverline'),
                    onPressed: () =>
                        _showCoverlineDialog(context, provider),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Temperature chart
              Container(
                height: 280,
                padding: const EdgeInsets.only(right: 8, top: 8),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: colors.outlineVariant.withAlpha(80)),
                ),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      horizontalInterval: 0.1,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: colors.outlineVariant.withAlpha(40),
                        strokeWidth: 0.5,
                      ),
                      getDrawingVerticalLine: (value) => FlLine(
                        color: colors.outlineVariant.withAlpha(40),
                        strokeWidth: 0.5,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        axisNameWidget: Text('Cycle Day',
                            style: TextStyle(
                                fontSize: 11,
                                color: colors.onSurfaceVariant)),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: 5,
                          getTitlesWidget: (value, meta) => Text(
                            '${value.toInt()}',
                            style: TextStyle(
                                fontSize: 10,
                                color: colors.onSurfaceVariant),
                          ),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        axisNameWidget: Text(settings.tempUnitLabel,
                            style: TextStyle(
                                fontSize: 11,
                                color: colors.onSurfaceVariant)),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 42,
                          interval: 0.2,
                          getTitlesWidget: (value, meta) => Text(
                            value.toStringAsFixed(1),
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
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                          color: colors.outlineVariant.withAlpha(60)),
                    ),
                    minX: 1,
                    maxX: maxCycleDay,
                    minY: minTemp,
                    maxY: maxTemp,
                    lineBarsData: [
                      LineChartBarData(
                        spots: tempEntries
                            .where((e) => !e.temperatureExcluded)
                            .map((e) => FlSpot(
                                  e.cycleDay.toDouble(),
                                  settings
                                      .displayTemp(e.temperature!),
                                ))
                            .toList(),
                        isCurved: false,
                        color: AppColors.temperatureLine,
                        barWidth: 2,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter:
                              (spot, pct, barData, idx) {
                            final entry = entries.firstWhere(
                                (e) =>
                                    e.cycleDay == spot.x.toInt());
                            final status = evaluation
                                ?.dayStatuses[entry.cycleDay];
                            return FlDotCirclePainter(
                              radius: 4,
                              color: status != null
                                  ? _dotColor(status)
                                  : AppColors.temperatureDot,
                              strokeWidth: 1.5,
                              strokeColor: Colors.white,
                            );
                          },
                        ),
                      ),
                      LineChartBarData(
                        spots: tempEntries
                            .where((e) => e.temperatureExcluded)
                            .map((e) => FlSpot(
                                  e.cycleDay.toDouble(),
                                  settings
                                      .displayTemp(e.temperature!),
                                ))
                            .toList(),
                        isCurved: false,
                        color: Colors.transparent,
                        barWidth: 0,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (_, __, a, b) =>
                              FlDotCirclePainter(
                            radius: 4,
                            color: AppColors.temperatureExcluded,
                            strokeWidth: 1.5,
                            strokeColor: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                    extraLinesData: ExtraLinesData(
                      horizontalLines: [
                        if (evaluation?.coverline != null)
                          HorizontalLine(
                            y: settings.displayTemp(
                                evaluation!.coverline!),
                            color: AppColors.coverline,
                            strokeWidth: 2,
                            dashArray: [8, 4],
                            label: HorizontalLineLabel(
                              show: true,
                              labelResolver: (_) => 'Coverline',
                              style: const TextStyle(
                                color: AppColors.coverline,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                      verticalLines: [
                        if (evaluation?.peakDay != null)
                          VerticalLine(
                            x: evaluation!.peakDay!.toDouble(),
                            color:
                                AppColors.fertile.withAlpha(100),
                            strokeWidth: 2,
                            dashArray: [4, 4],
                            label: VerticalLineLabel(
                              show: true,
                              labelResolver: (_) => 'Peak',
                              style: const TextStyle(
                                color: AppColors.fertile,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              'Day ${spot.x.toInt()}\n${spot.y.toStringAsFixed(2)}${settings.tempUnitLabel}',
                              const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Mucus chart
              _buildMucusChart(entries, evaluation, theme, colors),

              // Evaluation summary
              if (evaluation != null)
                _buildEvaluationSummary(
                    evaluation, settings, theme, colors),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMucusChart(List<DayEntry> entries,
      StmEvaluation? evaluation, ThemeData theme, ColorScheme colors) {
    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cervical Mucus',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 8),
        Container(
          height: 72,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: colors.outlineVariant.withAlpha(80)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: entries.map((e) {
              return Expanded(
                child: Tooltip(
                  message: 'Day ${e.cycleDay}: ${e.mucusType.name}',
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0.5),
                    height: (e.mucusQuality + 1) * 12.0,
                    decoration: BoxDecoration(
                      color: AppTheme.mucusColor(e.mucusQuality),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(3)),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        if (evaluation?.peakDay != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              'Peak Day: Cycle Day ${evaluation!.peakDay}',
              style: const TextStyle(
                color: AppColors.fertile,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildEvaluationSummary(StmEvaluation evaluation,
      AppSettings settings, ThemeData theme, ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: colors.outlineVariant.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('STM Evaluation',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 12),
          _evalRow(
              'Coverline',
              evaluation.coverline != null
                  ? '${settings.displayTemp(evaluation.coverline!).toStringAsFixed(2)} ${settings.tempUnitLabel}'
                  : 'Not yet determined',
              colors),
          _evalRow(
              'Temp Shift',
              evaluation.temperatureShiftConfirmedDay != null
                  ? 'Confirmed Day ${evaluation.temperatureShiftConfirmedDay}'
                  : 'Not yet confirmed',
              colors),
          _evalRow(
              'Peak Day',
              evaluation.peakDay != null
                  ? 'Day ${evaluation.peakDay}'
                  : 'Not yet identified',
              colors),
          _evalRow(
              settings.purpose == AppPurpose.anticonception
                  ? 'Infertile from'
                  : 'Post-ov',
              evaluation.postPeakInfertileFrom != null
                  ? 'Day ${evaluation.postPeakInfertileFrom}'
                  : 'Not yet confirmed',
              colors),
        ],
      ),
    );
  }

  Widget _evalRow(
      String label, String value, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(label,
                style: TextStyle(
                    color: colors.onSurfaceVariant, fontSize: 13)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Color _dotColor(FertilityStatus status) {
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

  void _showCoverlineDialog(
      BuildContext context, CycleProvider provider) {
    final controller = TextEditingController(
      text: provider.currentEvaluation?.coverline != null
          ? provider.settings
              .displayTemp(provider.currentEvaluation!.coverline!)
              .toStringAsFixed(2)
          : '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Coverline'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter the coverline temperature manually, or use automatic detection.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true),
              decoration: InputDecoration(
                labelText:
                    'Coverline (${provider.settings.tempUnitLabel})',
                hintText: provider.settings.temperatureUnit ==
                        TemperatureUnit.celsius
                    ? '36.40'
                    : '97.50',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.setCoverline(null);
              Navigator.pop(context);
            },
            child: const Text('Auto'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final value = double.tryParse(controller.text);
              if (value != null) {
                provider.setCoverline(
                    provider.settings.storageTemp(value));
              }
              Navigator.pop(context);
            },
            child: const Text('Set'),
          ),
        ],
      ),
    );
  }
}
