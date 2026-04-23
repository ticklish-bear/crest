import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/cycle_provider.dart';
import '../models/day_entry.dart';
import '../models/settings.dart';
import '../theme/app_theme.dart';

class DayEntryScreen extends StatefulWidget {
  final DateTime date;

  const DayEntryScreen({super.key, required this.date});

  @override
  State<DayEntryScreen> createState() => _DayEntryScreenState();
}

class _DayEntryScreenState extends State<DayEntryScreen> {
  DayEntry? _entry;
  DayEntry? _originalEntry; // For unsaved changes detection
  bool _isLoading = true;
  bool _hasUnsavedChanges = false;
  final _tempController = TextEditingController();
  final _timeController = TextEditingController();
  final _notesController = TextEditingController();
  final _excludeReasonController = TextEditingController();
  String? _tempError;

  // Common disturbance factors for temperature
  static const _disturbanceFactors = [
    'Illness',
    'Poor sleep',
    'Alcohol',
    'Late measurement',
    'Stress',
    'Travel',
    'Medication',
  ];
  final Set<String> _selectedDisturbances = {};

  @override
  void initState() {
    super.initState();
    _loadEntry();
    // Listen for text changes to track unsaved state
    _tempController.addListener(_markDirty);
    _timeController.addListener(_markDirty);
    _notesController.addListener(_markDirty);
    _excludeReasonController.addListener(_markDirty);
  }

  void _markDirty() {
    if (!_hasUnsavedChanges && !_isLoading) {
      setState(() => _hasUnsavedChanges = true);
    }
  }

  /// Parse the stored reason string back into selected chips + free text.
  /// Format: "Illness, Poor sleep | woke up 2h late"
  void _parseDisturbancesFromReason(String? reason) {
    _selectedDisturbances.clear();
    _excludeReasonController.text = '';
    if (reason == null || reason.isEmpty) return;

    // Split on pipe separator between chips and free text
    final parts = reason.split(' | ');
    final chipsPart = parts[0];
    final freeText = parts.length > 1 ? parts.sublist(1).join(' | ') : '';

    // Match known factors
    for (final factor in _disturbanceFactors) {
      if (chipsPart.contains(factor)) {
        _selectedDisturbances.add(factor);
      }
    }

    // If there were unknown parts in chips section, or free text
    _excludeReasonController.text = freeText;

    // If nothing matched any known factor, put it all in free text
    if (_selectedDisturbances.isEmpty && freeText.isEmpty) {
      _excludeReasonController.text = reason;
    }
  }

  /// Sync selected disturbance chips to the controller for storage.
  void _syncDisturbancesToController() {
    // We don't store in the controller — we build the string at save time
  }

  /// Build the combined reason string from chips + free text.
  String? _buildReasonString() {
    if (_selectedDisturbances.isEmpty &&
        _excludeReasonController.text.isEmpty) {
      return null;
    }
    final chips = _selectedDisturbances.toList()..sort();
    final freeText = _excludeReasonController.text.trim();
    if (chips.isEmpty) return freeText.isNotEmpty ? freeText : null;
    if (freeText.isEmpty) return chips.join(', ');
    return '${chips.join(', ')} | $freeText';
  }

  Future<void> _loadEntry() async {
    try {
      final provider = context.read<CycleProvider>();
      final entry = await provider.getOrCreateEntry(widget.date);
      if (!mounted) return;
      setState(() {
        _entry = entry;
        _originalEntry = entry;
        _isLoading = false;
        if (entry.temperature != null) {
          _tempController.text = provider.settings
              .displayTemp(entry.temperature!)
              .toStringAsFixed(2);
        }
        _timeController.text = entry.temperatureTime ?? '';
        _notesController.text = entry.notes ?? '';
        // Parse stored disturbance factors from reason string
        _parseDisturbancesFromReason(entry.temperatureExcludeReason);
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _entry = DayEntry(
            cycleId: 0,
            date: DateTime(widget.date.year, widget.date.month, widget.date.day),
            cycleDay: 1,
          );
          _originalEntry = _entry;
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _tempController.dispose();
    _timeController.dispose();
    _notesController.dispose();
    _excludeReasonController.dispose();
    super.dispose();
  }

  /// Check if the entry has been modified
  bool get _isDirty {
    if (_entry == null || _originalEntry == null) return false;
    final e = _entry!;
    final o = _originalEntry!;
    return _hasUnsavedChanges ||
        e.mucusType != o.mucusType ||
        e.mucusAppearance != o.mucusAppearance ||
        e.bleeding != o.bleeding ||
        e.temperatureExcluded != o.temperatureExcluded ||
        e.cervixPosition != o.cervixPosition ||
        e.cervixOpenness != o.cervixOpenness ||
        e.cervixFirmness != o.cervixFirmness ||
        e.isPeakDay != o.isPeakDay ||
        e.intercourse != o.intercourse;
  }

  Future<bool> _onWillPop() async {
    if (!_isDirty) return true;
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Unsaved Changes'),
        content: const Text(
            'You have unsaved changes. Do you want to discard them?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep Editing'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(DateFormat('EEE, MMM d').format(widget.date)),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final entry = _entry;
    if (entry == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(DateFormat('EEE, MMM d').format(widget.date)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: colors.error),
              const SizedBox(height: 16),
              const Text('Could not load entry'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final provider = context.watch<CycleProvider>();
    final settings = provider.settings;

    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat('EEE, MMM d').format(widget.date)),
              Text(
                'Cycle Day ${entry.cycleDay}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          actions: [
            // Delete button — only for existing (saved) entries
            if (entry.id != null)
              IconButton(
                icon: Icon(Icons.delete_outline, color: colors.error),
                tooltip: 'Delete entry',
                onPressed: () => _confirmDelete(context, provider, entry),
              ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [
            // Temperature
            _buildSection(
              title: 'Temperature',
              icon: Icons.thermostat_outlined,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _tempController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText: 'BBT (${settings.tempUnitLabel})',
                          hintText:
                              settings.temperatureUnit == TemperatureUnit.celsius
                                  ? '36.50'
                                  : '97.70',
                          errorText: _tempError,
                          suffixIcon: _tempController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    _tempController.clear();
                                    setState(() => _tempError = null);
                                  },
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _tempError = _validateTemperature(value, settings);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _timeController,
                        decoration: const InputDecoration(
                          labelText: 'Time',
                          hintText: '06:30',
                        ),
                        onTap: _pickTime,
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Disturbance factors
                _subLabel('Disturbance factors', colors),
                const SizedBox(height: 4),
                Text(
                  'Did anything unusual affect your temperature? '
                  'Tagged temps are shown on the chart but excluded '
                  'from the coverline calculation.',
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _disturbanceFactors.map((factor) {
                    final isSelected =
                        _selectedDisturbances.contains(factor);
                    return FilterChip(
                      label: Text(factor),
                      selected: isSelected,
                      selectedColor: colors.errorContainer,
                      checkmarkColor: colors.onErrorContainer,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedDisturbances.add(factor);
                          } else {
                            _selectedDisturbances.remove(factor);
                          }
                          // Auto-exclude temp when any disturbance is tagged
                          _entry = entry.copyWith(
                            temperatureExcluded:
                                _selectedDisturbances.isNotEmpty,
                          );
                          _hasUnsavedChanges = true;
                          _syncDisturbancesToController();
                        });
                      },
                    );
                  }).toList(),
                ),
                // Custom reason field (always visible, for "Other" or details)
                if (_selectedDisturbances.isNotEmpty ||
                    _excludeReasonController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextField(
                      controller: _excludeReasonController,
                      decoration: const InputDecoration(
                        labelText: 'Additional details (optional)',
                        hintText: 'e.g., woke up 2h late',
                      ),
                    ),
                  ),
              ],
            ),

            // Cervical mucus
            _buildSection(
              title: 'Cervical Mucus',
              icon: Icons.water_drop_outlined,
              children: [
                _subLabel('Sensation', colors),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: MucusType.values
                      .where((t) => t != MucusType.unrecorded)
                      .map((type) {
                    return ChoiceChip(
                      label: Text(_mucusTypeLabel(type)),
                      selected: entry.mucusType == type,
                      selectedColor: AppTheme.mucusColor(
                          MucusType.values.indexOf(type)),
                      onSelected: (selected) {
                        setState(() {
                          _entry = entry.copyWith(
                            mucusType: selected
                                ? type
                                : MucusType.unrecorded,
                          );
                          _hasUnsavedChanges = true;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                _subLabel('Appearance', colors),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: MucusAppearance.values.map((app) {
                    return ChoiceChip(
                      label: Text(_mucusAppLabel(app)),
                      selected: entry.mucusAppearance == app,
                      onSelected: (selected) {
                        setState(() {
                          _entry = entry.copyWith(
                            mucusAppearance: selected
                                ? app
                                : MucusAppearance.none,
                          );
                          _hasUnsavedChanges = true;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),

            // Bleeding
            _buildSection(
              title: 'Bleeding',
              icon: Icons.circle,
              iconColor: AppColors.menstruation,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: BleedingType.values.map((type) {
                    return ChoiceChip(
                      label: Text(_bleedingLabel(type)),
                      selected: entry.bleeding == type,
                      selectedColor: type != BleedingType.none
                          ? AppColors.menstruation.withAlpha(60)
                          : null,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _entry = entry.copyWith(bleeding: type);
                            _hasUnsavedChanges = true;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
              ],
            ),

            // Cervix (optional)
            if (settings.showCervixTracking)
              _buildSection(
                title: 'Cervix',
                icon: Icons.adjust,
                children: [
                  _subLabel('Position', colors),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: CervixPosition.values
                        .where((p) => p != CervixPosition.unset)
                        .map((pos) => ChoiceChip(
                              label: Text(pos.name),
                              selected: entry.cervixPosition == pos,
                              onSelected: (s) {
                                setState(() {
                                  _entry = entry.copyWith(
                                      cervixPosition: s
                                          ? pos
                                          : CervixPosition.unset);
                                  _hasUnsavedChanges = true;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  _subLabel('Openness', colors),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: CervixOpenness.values
                        .where((o) => o != CervixOpenness.unset)
                        .map((op) => ChoiceChip(
                              label: Text(_cervixOpennessLabel(op)),
                              selected: entry.cervixOpenness == op,
                              onSelected: (s) {
                                setState(() {
                                  _entry = entry.copyWith(
                                      cervixOpenness: s
                                          ? op
                                          : CervixOpenness.unset);
                                  _hasUnsavedChanges = true;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  _subLabel('Firmness', colors),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: CervixFirmness.values
                        .where((f) => f != CervixFirmness.unset)
                        .map((firm) => ChoiceChip(
                              label: Text(firm.name),
                              selected: entry.cervixFirmness == firm,
                              onSelected: (s) {
                                setState(() {
                                  _entry = entry.copyWith(
                                      cervixFirmness: s
                                          ? firm
                                          : CervixFirmness.unset);
                                  _hasUnsavedChanges = true;
                                });
                              },
                            ))
                        .toList(),
                  ),
                ],
              ),

            // Additional
            _buildSection(
              title: 'Additional',
              icon: Icons.more_horiz,
              children: [
                if (settings.showIntercourseTracking)
                  SwitchListTile(
                    title: const Text('Intercourse'),
                    value: entry.intercourse,
                    onChanged: (v) {
                      setState(() {
                        _entry = entry.copyWith(intercourse: v);
                        _hasUnsavedChanges = true;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                SwitchListTile(
                  title: const Text('Mark as Peak Day'),
                  subtitle: const Text(
                      'Last day of best-quality mucus before drying'),
                  value: entry.isPeakDay,
                  onChanged: (v) {
                    setState(() {
                      _entry = entry.copyWith(isPeakDay: v);
                      _hasUnsavedChanges = true;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),

            // Notes
            _buildSection(
              title: 'Notes',
              icon: Icons.edit_note,
              children: [
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Any additional observations...',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(
              top: BorderSide(
                  color: colors.outlineVariant.withAlpha(80)),
            ),
          ),
          child: SafeArea(
            child: FilledButton(
              onPressed: _tempError != null ? null : _save,
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Save Entry'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _subLabel(String text, ColorScheme colors) {
    return Text(text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: colors.onSurfaceVariant,
        ));
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    Color? iconColor,
    required List<Widget> children,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: colors.outlineVariant.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon,
                  size: 18, color: iconColor ?? colors.primary),
              const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  /// Normalize decimal separator: accept both comma and dot
  String _normalizeDecimal(String value) => value.replaceAll(',', '.');

  /// Validate temperature is within reasonable BBT range
  String? _validateTemperature(String value, AppSettings settings) {
    if (value.isEmpty) return null;
    final normalized = _normalizeDecimal(value);
    final parsed = double.tryParse(normalized);
    if (parsed == null) return 'Enter a valid number';

    if (settings.temperatureUnit == TemperatureUnit.celsius) {
      if (parsed < 35.0 || parsed > 39.0) {
        return 'Expected range: 35.00 - 39.00 \u00B0C';
      }
    } else {
      if (parsed < 95.0 || parsed > 102.2) {
        return 'Expected range: 95.00 - 102.20 \u00B0F';
      }
    }
    return null;
  }

  Future<void> _pickTime() async {
    // Default to existing time, or 6:30 AM (common BBT measurement time)
    TimeOfDay initialTime;
    if (_timeController.text.isNotEmpty) {
      final parts = _timeController.text.split(':');
      initialTime = TimeOfDay(
        hour: int.tryParse(parts[0]) ?? 6,
        minute: int.tryParse(parts.length > 1 ? parts[1] : '30') ?? 30,
      );
    } else {
      initialTime = const TimeOfDay(hour: 6, minute: 30);
    }

    final time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (time != null) {
      _timeController.text =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _confirmDelete(
      BuildContext context, CycleProvider provider, DayEntry entry) async {
    final colors = Theme.of(context).colorScheme;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Entry?'),
        content: Text(
          'Delete the entry for ${DateFormat('MMM d').format(entry.date)} '
          '(Cycle Day ${entry.cycleDay})?\n\n'
          'This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: colors.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await provider.deleteDayEntry(entry);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Entry deleted'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _save() async {
    final entry = _entry;
    if (entry == null) return;

    final provider = context.read<CycleProvider>();
    final settings = provider.settings;

    // Parse temperature — empty means clear it (set to null)
    double? temperature;
    if (_tempController.text.isNotEmpty) {
      final normalized = _normalizeDecimal(_tempController.text);
      final parsed = double.tryParse(normalized);
      if (parsed != null) {
        // Validate range before saving
        final error = _validateTemperature(_tempController.text, settings);
        if (error != null) {
          setState(() => _tempError = error);
          return;
        }
        temperature = settings.storageTemp(parsed);
      }
    }

    // Use the sentinel-aware copyWith to properly handle nulls
    final reasonString = _buildReasonString();
    final updated = entry.copyWith(
      temperature: temperature, // null if cleared
      temperatureTime:
          _timeController.text.isNotEmpty ? _timeController.text : null,
      temperatureExcluded: _selectedDisturbances.isNotEmpty,
      temperatureExcludeReason: reasonString,
      notes:
          _notesController.text.isNotEmpty ? _notesController.text : null,
    );

    await provider.saveDayEntry(updated);

    if (mounted) {
      setState(() => _hasUnsavedChanges = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Entry saved'),
          duration: Duration(seconds: 1),
        ),
      );
      Navigator.pop(context);
    }
  }

  String _mucusTypeLabel(MucusType type) {
    switch (type) {
      case MucusType.dry:
        return 'Dry';
      case MucusType.nothing:
        return 'Nothing';
      case MucusType.moist:
        return 'Moist';
      case MucusType.wet:
        return 'Wet';
      case MucusType.slippery:
        return 'Slippery';
      case MucusType.eggWhite:
        return 'Egg white';
      case MucusType.unrecorded:
        return 'Not recorded';
    }
  }

  String _mucusAppLabel(MucusAppearance app) {
    switch (app) {
      case MucusAppearance.none:
        return 'None';
      case MucusAppearance.cloudy:
        return 'Cloudy';
      case MucusAppearance.yellowish:
        return 'Yellowish';
      case MucusAppearance.sticky:
        return 'Sticky';
      case MucusAppearance.creamy:
        return 'Creamy';
      case MucusAppearance.clear:
        return 'Clear';
      case MucusAppearance.stretchy:
        return 'Stretchy';
      case MucusAppearance.transparent:
        return 'Transparent';
    }
  }

  String _bleedingLabel(BleedingType type) {
    switch (type) {
      case BleedingType.none:
        return 'None';
      case BleedingType.spotting:
        return 'Spotting';
      case BleedingType.light:
        return 'Light';
      case BleedingType.medium:
        return 'Medium';
      case BleedingType.heavy:
        return 'Heavy';
    }
  }

  String _cervixOpennessLabel(CervixOpenness op) {
    switch (op) {
      case CervixOpenness.unset:
        return 'Unset';
      case CervixOpenness.closed:
        return 'Closed';
      case CervixOpenness.partiallyOpen:
        return 'Partially open';
      case CervixOpenness.open:
        return 'Open';
    }
  }
}
