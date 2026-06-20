// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Heute';

  @override
  String get navChart => 'Kurve';

  @override
  String get navInsights => 'Statistik';

  @override
  String get navLearn => 'Lernen';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get supportTitle => 'Ember unterstützen';

  @override
  String get supportHeadline => 'Ember ist kostenlos – und bleibt es';

  @override
  String get supportBody =>
      'Keine Abos, keine Werbung, kein Tracking. Alle Funktionen stehen allen offen. Ember wird in meiner Freizeit entwickelt und gepflegt.\n\nWenn Ember dir nützt und du die Entwicklung unterstützen möchtest, kannst du einen kleinen Betrag geben. Das ist völlig freiwillig und schaltet nichts frei – du hast bereits die komplette App.';

  @override
  String get supportButton => 'Spendier mir einen Kaffee';

  @override
  String get supportFootnote =>
      'Öffnet sich im Browser. Ember sieht deine Zahlungsdaten nie.';

  @override
  String get supportLinkError => 'Link konnte nicht geöffnet werden';

  @override
  String get settingsGoal => 'Ziel';

  @override
  String get settingsUseFor => 'Ich nutze STM zum';

  @override
  String get purposeAvoiding => 'Verhüten';

  @override
  String get purposeAchieving => 'Erfüllen';

  @override
  String get purposeAvoidingDesc =>
      'Die Bezeichnungen sind vorsichtig gewählt – nur bestätigte Phasen werden als unfruchtbar markiert.';

  @override
  String get purposeAchievingDesc =>
      'Die Bezeichnungen nutzen die übliche STM-Terminologie zur Bestimmung des fruchtbaren Fensters.';

  @override
  String get settingsTracking => 'Erfassung';

  @override
  String get settingsTempUnit => 'Temperatureinheit';

  @override
  String get settingsRuleset => 'STM-Regelwerk';

  @override
  String get settingsCervix => 'Muttermund erfassen';

  @override
  String get settingsCervixSub => 'Position, Öffnung & Festigkeit';

  @override
  String get settingsIntercourse => 'Geschlechtsverkehr erfassen';

  @override
  String get settingsOpenEntryVia => 'Tageseintrag öffnen mit';

  @override
  String get tapLongPress => 'Lang drücken';

  @override
  String get tapDoubleTap => 'Doppeltippen';

  @override
  String get settingsAutoDetection => 'Automatische Erkennung';

  @override
  String get settingsAutoCoverline => 'Hilfslinie automatisch';

  @override
  String get settingsAutoCoverlineSub => '3-über-6-Regel';

  @override
  String get settingsAutoPeak => 'Höhepunkt automatisch';

  @override
  String get settingsAutoPeakSub => 'Aus dem Schleimmuster';

  @override
  String get settingsReminders => 'Erinnerungen';

  @override
  String get settingsDailyReminder => 'Tägliche Erinnerung';

  @override
  String get settingsDailyReminderSub =>
      'Eine Benachrichtigung pro Tag, um Temperatur und Schleim einzutragen.';

  @override
  String get settingsReminderTime => 'Uhrzeit der Erinnerung';

  @override
  String get settingsData => 'Daten';

  @override
  String get settingsExport => 'Daten exportieren (CSV)';

  @override
  String get settingsExportSub => 'Alle Daten als CSV speichern';

  @override
  String get settingsImport => 'Daten importieren (CSV)';

  @override
  String get settingsImportSub => 'Ember-CSV-Format importieren';

  @override
  String get settingsImportKindara => 'Aus Kindara importieren';

  @override
  String get settingsImportKindaraSub => 'Kindara-Exportdatei importieren';

  @override
  String get settingsDeleteAll => 'Alle Daten löschen';

  @override
  String get settingsDeleteAllSub => 'Kann nicht rückgängig gemacht werden';

  @override
  String get settingsAbout => 'Über';

  @override
  String get settingsPrivacy => 'Datenschutz';

  @override
  String get settingsPrivacySub =>
      'Alle Daten lokal gespeichert. Kein Konto nötig.';

  @override
  String get settingsAboutStm => 'Über STM';

  @override
  String get settingsAboutStmSub =>
      'Kompatibel mit der symptothermalen Methode. Unabhängige App, nicht mit einer Organisation verbunden.';

  @override
  String get settingsSupport => 'Unterstützen';

  @override
  String get settingsSupportDev => 'Entwicklung unterstützen';

  @override
  String get settingsSupportDevSub =>
      'Ember ist kostenlos. Spendier einen Kaffee, wenn du magst – freiwillig.';

  @override
  String get exportCompleteTitle => 'Export abgeschlossen';

  @override
  String exportCompleteBody(String path) {
    return 'Datei gespeichert unter:\n$path\n\nMöchtest du sie teilen?';
  }

  @override
  String get close => 'Schließen';

  @override
  String get share => 'Teilen';

  @override
  String exportFailed(String error) {
    return 'Export fehlgeschlagen: $error';
  }

  @override
  String importedEntries(int count) {
    return '$count Einträge importiert';
  }

  @override
  String importFailed(String error) {
    return 'Import fehlgeschlagen: $error';
  }

  @override
  String importedKindara(int count) {
    return '$count Kindara-Einträge importiert';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Kindara-Import fehlgeschlagen: $error';
  }

  @override
  String get deleteAllTitle => 'Alle Daten löschen?';

  @override
  String get deleteAllBody =>
      'Damit werden alle deine Zyklen und Einträge dauerhaft gelöscht. Exportiere deine Daten vorher am besten.\n\nDiese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get deleteEverything => 'Alles löschen';

  @override
  String get allDataDeleted => 'Alle Daten gelöscht';

  @override
  String cycleDayLabel(int day) {
    return 'Zyklustag $day';
  }

  @override
  String get deleteEntryTooltip => 'Eintrag löschen';

  @override
  String get sectionTemperature => 'Temperatur';

  @override
  String bbtLabel(String unit) {
    return 'Basaltemp. ($unit)';
  }

  @override
  String get fieldTime => 'Uhrzeit';

  @override
  String get disturbanceFactorsLabel => 'Störfaktoren';

  @override
  String get disturbanceHelp =>
      'Hat etwas Ungewöhnliches deine Temperatur beeinflusst? Markierte Werte erscheinen in der Kurve, werden aber von der Hilfslinien-Berechnung ausgeschlossen.';

  @override
  String get distIllness => 'Krankheit';

  @override
  String get distPoorSleep => 'Schlecht geschlafen';

  @override
  String get distAlcohol => 'Alkohol';

  @override
  String get distLateMeasurement => 'Spät gemessen';

  @override
  String get distStress => 'Stress';

  @override
  String get distTravel => 'Reise';

  @override
  String get distMedication => 'Medikament';

  @override
  String get additionalDetails => 'Zusätzliche Angaben (optional)';

  @override
  String get additionalDetailsHint => 'z. B. 2 Std. später aufgewacht';

  @override
  String get sectionMucus => 'Zervixschleim';

  @override
  String get mucusSensation => 'Empfinden';

  @override
  String get mucusAppearanceLabel => 'Aussehen';

  @override
  String get mucusDry => 'Trocken';

  @override
  String get mucusNothing => 'Nichts';

  @override
  String get mucusMoist => 'Feucht';

  @override
  String get mucusWet => 'Nass';

  @override
  String get mucusSlippery => 'Glitschig';

  @override
  String get mucusEggWhite => 'Spinnbar';

  @override
  String get mucusNotRecorded => 'Nicht erfasst';

  @override
  String get appNone => 'Keins';

  @override
  String get appCloudy => 'Trüb';

  @override
  String get appYellowish => 'Gelblich';

  @override
  String get appSticky => 'Klebrig';

  @override
  String get appCreamy => 'Cremig';

  @override
  String get appClear => 'Klar';

  @override
  String get appStretchy => 'Dehnbar';

  @override
  String get appTransparent => 'Durchsichtig';

  @override
  String get sectionBleeding => 'Blutung';

  @override
  String get bleedNone => 'Keine';

  @override
  String get bleedSpotting => 'Schmierblutung';

  @override
  String get bleedLight => 'Leicht';

  @override
  String get bleedMedium => 'Mittel';

  @override
  String get bleedHeavy => 'Stark';

  @override
  String get sectionCervix => 'Muttermund';

  @override
  String get cervixPositionLabel => 'Position';

  @override
  String get cervixOpennessLabel => 'Öffnung';

  @override
  String get cervixFirmnessLabel => 'Festigkeit';

  @override
  String get posLow => 'Tief';

  @override
  String get posMedium => 'Mittel';

  @override
  String get posHigh => 'Hoch';

  @override
  String get openClosed => 'Geschlossen';

  @override
  String get openPartially => 'Leicht geöffnet';

  @override
  String get openOpen => 'Offen';

  @override
  String get firmFirm => 'Fest';

  @override
  String get firmMedium => 'Mittel';

  @override
  String get firmSoft => 'Weich';

  @override
  String get sectionAdditional => 'Weiteres';

  @override
  String get fieldIntercourse => 'Geschlechtsverkehr';

  @override
  String get markPeakDay => 'Als Höhepunkt markieren';

  @override
  String get markPeakDaySub =>
      'Letzter Tag mit bestem Schleim vor dem Abtrocknen';

  @override
  String get sectionNotes => 'Notizen';

  @override
  String get notesHint => 'Weitere Beobachtungen ...';

  @override
  String get saveEntry => 'Eintrag speichern';

  @override
  String get couldNotLoad => 'Eintrag konnte nicht geladen werden';

  @override
  String get goBack => 'Zurück';

  @override
  String get unsavedTitle => 'Ungespeicherte Änderungen';

  @override
  String get unsavedBody => 'Du hast ungespeicherte Änderungen. Verwerfen?';

  @override
  String get keepEditing => 'Weiter bearbeiten';

  @override
  String get discard => 'Verwerfen';

  @override
  String get invalidNumber => 'Gültige Zahl eingeben';

  @override
  String get rangeCelsius => 'Erwarteter Bereich: 35,00 – 39,00 °C';

  @override
  String get rangeFahrenheit => 'Erwarteter Bereich: 95,00 – 102,20 °F';

  @override
  String get deleteEntryTitle => 'Eintrag löschen?';

  @override
  String deleteEntryBody(String date, int day) {
    return 'Eintrag für $date (Zyklustag $day) löschen?\n\nKann nicht rückgängig gemacht werden.';
  }

  @override
  String get delete => 'Löschen';

  @override
  String get entryDeleted => 'Eintrag gelöscht';

  @override
  String get entrySaved => 'Eintrag gespeichert';

  @override
  String get logTodayTitle => 'Heute eintragen';

  @override
  String get logTodaySub => 'Temperatur, Schleim, Blutung';

  @override
  String get noActiveCycle => 'Kein aktiver Zyklus';

  @override
  String get noActiveCycleSub =>
      'Starte die Erfassung für Fruchtbarkeits-Einblicke';

  @override
  String get start => 'Start';

  @override
  String cycleDayBadge(int day) {
    return 'Tag $day';
  }

  @override
  String cycleStarted(String date) {
    return 'Begonnen am $date';
  }

  @override
  String get startNewCycleTooltip => 'Neuen Zyklus starten';

  @override
  String get tapToAddEntry => 'Tippen, um Eintrag hinzuzufügen';

  @override
  String get mucusShort => 'Schleim';

  @override
  String get legendPeriodInfertile => 'Unfruchtbar (Periode)';

  @override
  String get legendPeriod => 'Periode';

  @override
  String get legendPotFertile => 'Evtl. fruchtbar';

  @override
  String get legendPhase1 => 'Phase 1';

  @override
  String get legendInfertileConfirmed => 'Unfruchtbar (bestätigt)';

  @override
  String get legendPostOv => 'Nach Eisprung';

  @override
  String get periodStartHelp => 'Wann hat deine Periode begonnen?';

  @override
  String get newCycleTitle => 'Neuen Zyklus starten';

  @override
  String newCycleStarting(String date) {
    return 'Beginn am $date';
  }

  @override
  String get newCycleWillClose => 'Der aktuelle Zyklus wird abgeschlossen.';

  @override
  String get bleedingTodayQ => 'Wie ist deine Blutung heute?';

  @override
  String bleedingOnDayQ(String date) {
    return 'Wie war deine Blutung am $date?';
  }

  @override
  String get startCycle => 'Zyklus starten';

  @override
  String get stmRuleTitle => 'STM-Regel';

  @override
  String get gotIt => 'Verstanden';

  @override
  String get statusPotentiallyFertile => 'Evtl. fruchtbar';

  @override
  String get statusInfertilePreOv => 'Unfruchtbar (vor Eisprung)';

  @override
  String get statusFertile => 'Fruchtbar';

  @override
  String get statusFertileAwaitingMucus =>
      'Fruchtbar (Temp.-Anstieg ✓, Schleim fehlt)';

  @override
  String get statusFertileAwaitingTemp =>
      'Fruchtbar (Höhepunkt ✓, Temp. fehlt)';

  @override
  String get statusFertileAwaitingCheck =>
      'Fruchtbar (Doppelkontrolle ausstehend)';

  @override
  String get statusInfertile => 'Unfruchtbar';

  @override
  String get statusInfertilePostOv => 'Unfruchtbar (nach Eisprung)';

  @override
  String get statusMenstruation => 'Menstruation';

  @override
  String statusInfertileDay(int day, int limit) {
    return 'Unfruchtbar (Tag $day/$limit)';
  }

  @override
  String get statusUnknown => 'Unbekannt';
}
