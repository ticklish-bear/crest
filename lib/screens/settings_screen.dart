import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import '../providers/cycle_provider.dart';
import '../models/settings.dart';
import '../database/database_helper.dart';
import '../services/export_import_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Consumer<CycleProvider>(
      builder: (context, provider, _) {
        final settings = provider.settings;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // App identity
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.favorite_rounded,
                        color: colors.onPrimaryContainer, size: 24),
                  ),
                  const SizedBox(height: 8),
                  Text('Crest',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  Text('v0.1.0',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Purpose
            _sectionTitle('Goal', colors),
            _settingsContainer(colors, [
              ListTile(
                leading: Icon(Icons.favorite_border,
                    color: colors.onSurfaceVariant),
                title: const Text('I use STM for'),
                trailing: SegmentedButton<AppPurpose>(
                  segments: const [
                    ButtonSegment(
                        value: AppPurpose.anticonception,
                        label: Text('Avoiding')),
                    ButtonSegment(
                        value: AppPurpose.conception,
                        label: Text('Achieving')),
                  ],
                  selected: {settings.purpose},
                  onSelectionChanged: (value) {
                    provider.updateSettings(settings.copyWith(
                        purpose: value.first));
                  },
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text(
                  settings.purpose == AppPurpose.anticonception
                      ? 'Labels reflect a cautious approach \u2014 only confirmed phases are marked infertile.'
                      : 'Labels use standard STM terminology for identifying the fertile window.',
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 20),

            // Tracking
            _sectionTitle('Tracking', colors),
            _settingsContainer(colors, [
              ListTile(
                leading: Icon(Icons.thermostat_outlined,
                    color: colors.onSurfaceVariant),
                title: const Text('Temperature Unit'),
                trailing: SegmentedButton<TemperatureUnit>(
                  segments: const [
                    ButtonSegment(
                        value: TemperatureUnit.celsius,
                        label: Text('\u00B0C')),
                    ButtonSegment(
                        value: TemperatureUnit.fahrenheit,
                        label: Text('\u00B0F')),
                  ],
                  selected: {settings.temperatureUnit},
                  onSelectionChanged: (value) {
                    provider.updateSettings(settings.copyWith(
                        temperatureUnit: value.first));
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.rule,
                    color: colors.onSurfaceVariant),
                title: const Text('STM Ruleset'),
                trailing: SegmentedButton<StmRuleset>(
                  segments: const [
                    ButtonSegment(
                        value: StmRuleset.agNfp,
                        label: Text('AG NFP')),
                    ButtonSegment(
                        value: StmRuleset.tcoyf,
                        label: Text('TCOYF')),
                  ],
                  selected: {settings.ruleset},
                  onSelectionChanged: (value) {
                    provider.updateSettings(
                        settings.copyWith(ruleset: value.first));
                  },
                ),
              ),
              const Divider(),
              SwitchListTile(
                secondary: Icon(Icons.adjust,
                    color: colors.onSurfaceVariant),
                title: const Text('Cervix tracking'),
                subtitle:
                    const Text('Position, openness & firmness'),
                value: settings.showCervixTracking,
                onChanged: (v) => provider.updateSettings(
                    settings.copyWith(showCervixTracking: v)),
              ),
              const Divider(),
              SwitchListTile(
                secondary: Icon(Icons.people_outline,
                    color: colors.onSurfaceVariant),
                title: const Text('Intercourse tracking'),
                value: settings.showIntercourseTracking,
                onChanged: (v) => provider.updateSettings(
                    settings.copyWith(
                        showIntercourseTracking: v)),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.touch_app_outlined,
                    color: colors.onSurfaceVariant),
                title: const Text('Open day entry via'),
                trailing: SegmentedButton<CalendarTapAction>(
                  segments: const [
                    ButtonSegment(
                        value: CalendarTapAction.longPress,
                        label: Text('Long press')),
                    ButtonSegment(
                        value: CalendarTapAction.doubleTap,
                        label: Text('Double tap')),
                  ],
                  selected: {settings.calendarTapAction},
                  onSelectionChanged: (value) {
                    provider.updateSettings(settings.copyWith(
                        calendarTapAction: value.first));
                  },
                ),
              ),
            ]),
            const SizedBox(height: 20),

            // Automatic Detection
            _sectionTitle('Automatic Detection', colors),
            _settingsContainer(colors, [
              SwitchListTile(
                secondary: Icon(Icons.auto_graph,
                    color: colors.onSurfaceVariant),
                title: const Text('Auto-detect coverline'),
                subtitle: const Text('3-over-6 rule'),
                value: settings.autoDetectCoverline,
                onChanged: (v) => provider.updateSettings(
                    settings.copyWith(autoDetectCoverline: v)),
              ),
              const Divider(),
              SwitchListTile(
                secondary: Icon(Icons.water_drop_outlined,
                    color: colors.onSurfaceVariant),
                title: const Text('Auto-detect Peak Day'),
                subtitle: const Text('From mucus pattern'),
                value: settings.autoDetectPeakDay,
                onChanged: (v) => provider.updateSettings(
                    settings.copyWith(autoDetectPeakDay: v)),
              ),
            ]),
            const SizedBox(height: 20),

            // Reminders
            _sectionTitle('Reminders', colors),
            _settingsContainer(colors, [
              SwitchListTile(
                secondary: Icon(Icons.notifications_active_outlined,
                    color: colors.onSurfaceVariant),
                title: const Text('Daily check-in reminder'),
                subtitle: const Text(
                    'A single notification each day to log BBT and mucus.'),
                value: settings.dailyReminderEnabled,
                onChanged: (v) => provider.updateSettings(
                    settings.copyWith(dailyReminderEnabled: v)),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.schedule,
                    color: colors.onSurfaceVariant),
                title: const Text('Reminder time'),
                subtitle: Text(settings.reminderTimeLabel),
                enabled: settings.dailyReminderEnabled,
                onTap: settings.dailyReminderEnabled
                    ? () => _pickReminderTime(context, provider, settings)
                    : null,
                trailing: const Icon(Icons.edit_outlined, size: 18),
              ),
            ]),
            const SizedBox(height: 20),

            // Data
            _sectionTitle('Data', colors),
            _settingsContainer(colors, [
              ListTile(
                leading: Icon(Icons.upload_file_outlined,
                    color: colors.primary),
                title: const Text('Export data (CSV)'),
                subtitle: const Text('Save all data as CSV'),
                onTap: () => _exportData(context),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.download_outlined,
                    color: colors.primary),
                title: const Text('Import data (CSV)'),
                subtitle:
                    const Text('Import Crest CSV format'),
                onTap: () => _importData(context),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.swap_horiz,
                    color: colors.primary),
                title: const Text('Import from Kindara'),
                subtitle:
                    const Text('Import Kindara export file'),
                onTap: () => _importKindara(context),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.delete_outline,
                    color: colors.error),
                title: Text('Delete all data',
                    style: TextStyle(color: colors.error)),
                subtitle: const Text('This cannot be undone'),
                onTap: () => _confirmDelete(context, provider),
              ),
            ]),
            const SizedBox(height: 20),

            // About
            _sectionTitle('About', colors),
            _settingsContainer(colors, [
              ListTile(
                leading: Icon(Icons.shield_outlined,
                    color: colors.onSurfaceVariant),
                title: const Text('Privacy'),
                subtitle: const Text(
                    'All data stored locally. No account required.'),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.info_outline,
                    color: colors.onSurfaceVariant),
                title: const Text('About STM'),
                subtitle: const Text(
                    'Compatible with the symptothermal method. Independent app, not affiliated with any organization.'),
              ),
            ]),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }

  Widget _sectionTitle(String title, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: colors.primary,
            letterSpacing: 0.3,
          )),
    );
  }

  Widget _settingsContainer(
      ColorScheme colors, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: colors.outlineVariant.withAlpha(100)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }

  Future<void> _pickReminderTime(BuildContext context,
      CycleProvider provider, AppSettings settings) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.dailyReminderHour,
        minute: settings.dailyReminderMinute,
      ),
    );
    if (picked == null) return;
    await provider.updateSettings(settings.copyWith(
      dailyReminderHour: picked.hour,
      dailyReminderMinute: picked.minute,
    ));
  }

  Future<void> _exportData(BuildContext context) async {
    try {
      final service = ExportImportService();
      final path = await service.exportToCsv();
      if (context.mounted) {
        final result = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Export Complete'),
            content: Text(
                'File saved to:\n$path\n\nWould you like to share it?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Close'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Share'),
              ),
            ],
          ),
        );
        if (result == true) {
          await Share.shareXFiles([XFile(path)]);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

  Future<void> _importData(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['csv'],
          withData: true);
      if (result == null) return;
      final bytes = result.files.single.bytes;
      if (bytes == null) return;
      final content = utf8.decode(bytes);
      final service = ExportImportService();
      final count = await service.importFromCsv(content);
      if (context.mounted) {
        final provider = context.read<CycleProvider>();
        await provider.loadCycles();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Imported $count entries')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Import failed: $e')));
      }
    }
  }

  Future<void> _importKindara(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['csv'],
          withData: true);
      if (result == null) return;
      final bytes = result.files.single.bytes;
      if (bytes == null) return;
      final content = utf8.decode(bytes);
      final service = ExportImportService();
      final count = await service.importFromKindara(content);
      if (context.mounted) {
        final provider = context.read<CycleProvider>();
        await provider.loadCycles();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Imported $count Kindara entries')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Kindara import failed: $e')));
      }
    }
  }

  Future<void> _confirmDelete(
      BuildContext context, CycleProvider provider) async {
    final colors = Theme.of(context).colorScheme;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete All Data?'),
        content: const Text(
          'This will permanently delete all your cycles and entries. '
          'Consider exporting your data first.\n\n'
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: colors.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete Everything'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final db = DatabaseHelper();
      await db.clearAllData();
      await provider.loadCycles();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All data deleted')));
      }
    }
  }
}
