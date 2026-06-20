// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Today';

  @override
  String get navChart => 'Chart';

  @override
  String get navInsights => 'Insights';

  @override
  String get navLearn => 'Learn';

  @override
  String get navSettings => 'Settings';

  @override
  String get supportTitle => 'Support Ember';

  @override
  String get supportHeadline => 'Ember is free — and stays that way';

  @override
  String get supportBody =>
      'No subscriptions, no ads, no tracking. Every feature is available to everyone. It’s built and maintained in my spare time.\n\nIf Ember is useful to you and you’d like to chip in toward its development, you can leave a small tip. It’s entirely optional and unlocks nothing — you already have the whole app.';

  @override
  String get supportButton => 'Buy me a coffee';

  @override
  String get supportFootnote =>
      'Opens in your browser. Ember never sees your payment details.';

  @override
  String get supportLinkError => 'Could not open the link';

  @override
  String get settingsGoal => 'Goal';

  @override
  String get settingsUseFor => 'I use STM for';

  @override
  String get purposeAvoiding => 'Avoiding';

  @override
  String get purposeAchieving => 'Achieving';

  @override
  String get purposeAvoidingDesc =>
      'Labels reflect a cautious approach — only confirmed phases are marked infertile.';

  @override
  String get purposeAchievingDesc =>
      'Labels use standard STM terminology for identifying the fertile window.';

  @override
  String get settingsTracking => 'Tracking';

  @override
  String get settingsTempUnit => 'Temperature Unit';

  @override
  String get settingsRuleset => 'STM Ruleset';

  @override
  String get settingsCervix => 'Cervix tracking';

  @override
  String get settingsCervixSub => 'Position, openness & firmness';

  @override
  String get settingsIntercourse => 'Intercourse tracking';

  @override
  String get settingsOpenEntryVia => 'Open day entry via';

  @override
  String get tapLongPress => 'Long press';

  @override
  String get tapDoubleTap => 'Double tap';

  @override
  String get settingsAutoDetection => 'Automatic Detection';

  @override
  String get settingsAutoCoverline => 'Auto-detect coverline';

  @override
  String get settingsAutoCoverlineSub => '3-over-6 rule';

  @override
  String get settingsAutoPeak => 'Auto-detect Peak Day';

  @override
  String get settingsAutoPeakSub => 'From mucus pattern';

  @override
  String get settingsReminders => 'Reminders';

  @override
  String get settingsDailyReminder => 'Daily check-in reminder';

  @override
  String get settingsDailyReminderSub =>
      'A single notification each day to log BBT and mucus.';

  @override
  String get settingsReminderTime => 'Reminder time';

  @override
  String get settingsData => 'Data';

  @override
  String get settingsExport => 'Export data (CSV)';

  @override
  String get settingsExportSub => 'Save all data as CSV';

  @override
  String get settingsImport => 'Import data (CSV)';

  @override
  String get settingsImportSub => 'Import Ember CSV format';

  @override
  String get settingsImportKindara => 'Import from Kindara';

  @override
  String get settingsImportKindaraSub => 'Import Kindara export file';

  @override
  String get settingsDeleteAll => 'Delete all data';

  @override
  String get settingsDeleteAllSub => 'This cannot be undone';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacySub =>
      'All data stored locally. No account required.';

  @override
  String get settingsAboutStm => 'About STM';

  @override
  String get settingsAboutStmSub =>
      'Compatible with the symptothermal method. Independent app, not affiliated with any organization.';

  @override
  String get settingsSupport => 'Support';

  @override
  String get settingsSupportDev => 'Support development';

  @override
  String get settingsSupportDevSub =>
      'Ember is free. Chip in a coffee if you like — optional.';

  @override
  String get exportCompleteTitle => 'Export Complete';

  @override
  String exportCompleteBody(String path) {
    return 'File saved to:\n$path\n\nWould you like to share it?';
  }

  @override
  String get close => 'Close';

  @override
  String get share => 'Share';

  @override
  String exportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String importedEntries(int count) {
    return 'Imported $count entries';
  }

  @override
  String importFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String importedKindara(int count) {
    return 'Imported $count Kindara entries';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Kindara import failed: $error';
  }

  @override
  String get deleteAllTitle => 'Delete All Data?';

  @override
  String get deleteAllBody =>
      'This will permanently delete all your cycles and entries. Consider exporting your data first.\n\nThis action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteEverything => 'Delete Everything';

  @override
  String get allDataDeleted => 'All data deleted';

  @override
  String cycleDayLabel(int day) {
    return 'Cycle Day $day';
  }

  @override
  String get deleteEntryTooltip => 'Delete entry';

  @override
  String get sectionTemperature => 'Temperature';

  @override
  String bbtLabel(String unit) {
    return 'BBT ($unit)';
  }

  @override
  String get fieldTime => 'Time';

  @override
  String get disturbanceFactorsLabel => 'Disturbance factors';

  @override
  String get disturbanceHelp =>
      'Did anything unusual affect your temperature? Tagged temps are shown on the chart but excluded from the coverline calculation.';

  @override
  String get distIllness => 'Illness';

  @override
  String get distPoorSleep => 'Poor sleep';

  @override
  String get distAlcohol => 'Alcohol';

  @override
  String get distLateMeasurement => 'Late measurement';

  @override
  String get distStress => 'Stress';

  @override
  String get distTravel => 'Travel';

  @override
  String get distMedication => 'Medication';

  @override
  String get additionalDetails => 'Additional details (optional)';

  @override
  String get additionalDetailsHint => 'e.g., woke up 2h late';

  @override
  String get sectionMucus => 'Cervical Mucus';

  @override
  String get mucusSensation => 'Sensation';

  @override
  String get mucusAppearanceLabel => 'Appearance';

  @override
  String get mucusDry => 'Dry';

  @override
  String get mucusNothing => 'Nothing';

  @override
  String get mucusMoist => 'Moist';

  @override
  String get mucusWet => 'Wet';

  @override
  String get mucusSlippery => 'Slippery';

  @override
  String get mucusEggWhite => 'Egg white';

  @override
  String get mucusNotRecorded => 'Not recorded';

  @override
  String get appNone => 'None';

  @override
  String get appCloudy => 'Cloudy';

  @override
  String get appYellowish => 'Yellowish';

  @override
  String get appSticky => 'Sticky';

  @override
  String get appCreamy => 'Creamy';

  @override
  String get appClear => 'Clear';

  @override
  String get appStretchy => 'Stretchy';

  @override
  String get appTransparent => 'Transparent';

  @override
  String get sectionBleeding => 'Bleeding';

  @override
  String get bleedNone => 'None';

  @override
  String get bleedSpotting => 'Spotting';

  @override
  String get bleedLight => 'Light';

  @override
  String get bleedMedium => 'Medium';

  @override
  String get bleedHeavy => 'Heavy';

  @override
  String get sectionCervix => 'Cervix';

  @override
  String get cervixPositionLabel => 'Position';

  @override
  String get cervixOpennessLabel => 'Openness';

  @override
  String get cervixFirmnessLabel => 'Firmness';

  @override
  String get posLow => 'Low';

  @override
  String get posMedium => 'Medium';

  @override
  String get posHigh => 'High';

  @override
  String get openClosed => 'Closed';

  @override
  String get openPartially => 'Partially open';

  @override
  String get openOpen => 'Open';

  @override
  String get firmFirm => 'Firm';

  @override
  String get firmMedium => 'Medium';

  @override
  String get firmSoft => 'Soft';

  @override
  String get sectionAdditional => 'Additional';

  @override
  String get fieldIntercourse => 'Intercourse';

  @override
  String get markPeakDay => 'Mark as Peak Day';

  @override
  String get markPeakDaySub => 'Last day of best-quality mucus before drying';

  @override
  String get sectionNotes => 'Notes';

  @override
  String get notesHint => 'Any additional observations...';

  @override
  String get saveEntry => 'Save Entry';

  @override
  String get couldNotLoad => 'Could not load entry';

  @override
  String get goBack => 'Go Back';

  @override
  String get unsavedTitle => 'Unsaved Changes';

  @override
  String get unsavedBody =>
      'You have unsaved changes. Do you want to discard them?';

  @override
  String get keepEditing => 'Keep Editing';

  @override
  String get discard => 'Discard';

  @override
  String get invalidNumber => 'Enter a valid number';

  @override
  String get rangeCelsius => 'Expected range: 35.00 - 39.00 °C';

  @override
  String get rangeFahrenheit => 'Expected range: 95.00 - 102.20 °F';

  @override
  String get deleteEntryTitle => 'Delete Entry?';

  @override
  String deleteEntryBody(String date, int day) {
    return 'Delete the entry for $date (Cycle Day $day)?\n\nThis cannot be undone.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get entryDeleted => 'Entry deleted';

  @override
  String get entrySaved => 'Entry saved';

  @override
  String get logTodayTitle => 'Log today\'s observations';

  @override
  String get logTodaySub => 'Temperature, mucus, bleeding';

  @override
  String get noActiveCycle => 'No active cycle';

  @override
  String get noActiveCycleSub => 'Start tracking to see fertility insights';

  @override
  String get start => 'Start';

  @override
  String cycleDayBadge(int day) {
    return 'Day $day';
  }

  @override
  String cycleStarted(String date) {
    return 'Started $date';
  }

  @override
  String get startNewCycleTooltip => 'Start new cycle';

  @override
  String get tapToAddEntry => 'Tap to add entry';

  @override
  String get mucusShort => 'Mucus';

  @override
  String get legendPeriodInfertile => 'Infertile (period)';

  @override
  String get legendPeriod => 'Period';

  @override
  String get legendPotFertile => 'Pot. fertile';

  @override
  String get legendPhase1 => 'Phase 1';

  @override
  String get legendInfertileConfirmed => 'Infertile (confirmed)';

  @override
  String get legendPostOv => 'Post-ov';

  @override
  String get periodStartHelp => 'When did your period start?';

  @override
  String get newCycleTitle => 'Start New Cycle';

  @override
  String newCycleStarting(String date) {
    return 'Starting on $date';
  }

  @override
  String get newCycleWillClose => 'The current cycle will be closed.';

  @override
  String get bleedingTodayQ => 'How is your bleeding today?';

  @override
  String bleedingOnDayQ(String date) {
    return 'How was your bleeding on $date?';
  }

  @override
  String get startCycle => 'Start Cycle';

  @override
  String get stmRuleTitle => 'STM Rule';

  @override
  String get gotIt => 'Got it';

  @override
  String get statusPotentiallyFertile => 'Potentially fertile';

  @override
  String get statusInfertilePreOv => 'Infertile (pre-ov)';

  @override
  String get statusFertile => 'Fertile';

  @override
  String get statusFertileAwaitingMucus =>
      'Fertile (temp shift ✓, awaiting mucus)';

  @override
  String get statusFertileAwaitingTemp => 'Fertile (Peak Day ✓, awaiting temp)';

  @override
  String get statusFertileAwaitingCheck => 'Fertile (awaiting double-check)';

  @override
  String get statusInfertile => 'Infertile';

  @override
  String get statusInfertilePostOv => 'Infertile (post-ov)';

  @override
  String get statusMenstruation => 'Menstruation';

  @override
  String statusInfertileDay(int day, int limit) {
    return 'Infertile (day $day/$limit)';
  }

  @override
  String get statusUnknown => 'Unknown';
}
