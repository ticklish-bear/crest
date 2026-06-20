// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Dziś';

  @override
  String get navChart => 'Wykres';

  @override
  String get navInsights => 'Statystyki';

  @override
  String get navLearn => 'Naucz się';

  @override
  String get navSettings => 'Ustawienia';

  @override
  String get supportTitle => 'Wesprzyj Ember';

  @override
  String get supportHeadline => 'Ember jest darmowy — i taki zostanie';

  @override
  String get supportBody =>
      'Bez subskrypcji, bez reklam, bez śledzenia. Wszystkie funkcje są dostępne dla każdego. Tworzę i utrzymuję aplikację w wolnym czasie.\n\nJeśli Ember jest dla Ciebie przydatny i chcesz wesprzeć jego rozwój, możesz zostawić mały napiwek. Jest całkowicie dobrowolny i niczego nie odblokowuje — masz już całą aplikację.';

  @override
  String get supportButton => 'Postaw mi kawę';

  @override
  String get supportFootnote =>
      'Otwiera się w przeglądarce. Ember nigdy nie widzi Twoich danych płatności.';

  @override
  String get supportLinkError => 'Nie udało się otworzyć linku';

  @override
  String get settingsGoal => 'Cel';

  @override
  String get settingsUseFor => 'Używam metody, aby';

  @override
  String get purposeAvoiding => 'Unikać';

  @override
  String get purposeAchieving => 'Starać się';

  @override
  String get purposeAvoidingDesc =>
      'Etykiety odzwierciedlają ostrożne podejście — tylko potwierdzone fazy są oznaczane jako niepłodne.';

  @override
  String get purposeAchievingDesc =>
      'Etykiety używają standardowej terminologii metody do określenia okna płodności.';

  @override
  String get settingsTracking => 'Zapis';

  @override
  String get settingsTempUnit => 'Jednostka temperatury';

  @override
  String get settingsRuleset => 'Reguły metody';

  @override
  String get settingsCervix => 'Zapis szyjki macicy';

  @override
  String get settingsCervixSub => 'Pozycja, rozwarcie i twardość';

  @override
  String get settingsIntercourse => 'Zapis współżycia';

  @override
  String get settingsOpenEntryVia => 'Otwórz wpis dnia przez';

  @override
  String get tapLongPress => 'Długie naciśnięcie';

  @override
  String get tapDoubleTap => 'Podwójne dotknięcie';

  @override
  String get settingsAutoDetection => 'Automatyczne wykrywanie';

  @override
  String get settingsAutoCoverline => 'Automatyczna linia bazowa';

  @override
  String get settingsAutoCoverlineSub => 'Reguła 3 ponad 6';

  @override
  String get settingsAutoPeak => 'Automatyczny dzień szczytu';

  @override
  String get settingsAutoPeakSub => 'Na podstawie wzorca śluzu';

  @override
  String get settingsReminders => 'Przypomnienia';

  @override
  String get settingsDailyReminder => 'Codzienne przypomnienie';

  @override
  String get settingsDailyReminderSub =>
      'Jedno powiadomienie dziennie, aby zapisać temperaturę i śluz.';

  @override
  String get settingsReminderTime => 'Godzina przypomnienia';

  @override
  String get settingsData => 'Dane';

  @override
  String get settingsExport => 'Eksportuj dane (CSV)';

  @override
  String get settingsExportSub => 'Zapisz wszystkie dane jako CSV';

  @override
  String get settingsImport => 'Importuj dane (CSV)';

  @override
  String get settingsImportSub => 'Importuj format CSV aplikacji Ember';

  @override
  String get settingsImportKindara => 'Importuj z Kindara';

  @override
  String get settingsImportKindaraSub => 'Importuj plik eksportu Kindara';

  @override
  String get settingsDeleteAll => 'Usuń wszystkie dane';

  @override
  String get settingsDeleteAllSub => 'Tego nie można cofnąć';

  @override
  String get settingsAbout => 'O aplikacji';

  @override
  String get settingsPrivacy => 'Prywatność';

  @override
  String get settingsPrivacySub =>
      'Wszystkie dane przechowywane lokalnie. Konto nie jest wymagane.';

  @override
  String get settingsAboutStm => 'O metodzie';

  @override
  String get settingsAboutStmSub =>
      'Zgodna z metodą objawowo-termiczną. Niezależna aplikacja, niepowiązana z żadną organizacją.';

  @override
  String get settingsSupport => 'Wsparcie';

  @override
  String get settingsSupportDev => 'Wesprzyj rozwój';

  @override
  String get settingsSupportDevSub =>
      'Ember jest darmowy. Postaw kawę, jeśli chcesz — dobrowolnie.';

  @override
  String get exportCompleteTitle => 'Eksport zakończony';

  @override
  String exportCompleteBody(String path) {
    return 'Plik zapisany w:\n$path\n\nCzy chcesz go udostępnić?';
  }

  @override
  String get close => 'Zamknij';

  @override
  String get share => 'Udostępnij';

  @override
  String exportFailed(String error) {
    return 'Eksport nie powiódł się: $error';
  }

  @override
  String importedEntries(int count) {
    return 'Zaimportowano $count wpisów';
  }

  @override
  String importFailed(String error) {
    return 'Import nie powiódł się: $error';
  }

  @override
  String importedKindara(int count) {
    return 'Zaimportowano $count wpisów z Kindara';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Import z Kindara nie powiódł się: $error';
  }

  @override
  String get deleteAllTitle => 'Usunąć wszystkie dane?';

  @override
  String get deleteAllBody =>
      'Spowoduje to trwałe usunięcie wszystkich cykli i wpisów. Rozważ najpierw wyeksportowanie danych.\n\nTej operacji nie można cofnąć.';

  @override
  String get cancel => 'Anuluj';

  @override
  String get deleteEverything => 'Usuń wszystko';

  @override
  String get allDataDeleted => 'Usunięto wszystkie dane';

  @override
  String cycleDayLabel(int day) {
    return 'Dzień cyklu $day';
  }

  @override
  String get deleteEntryTooltip => 'Usuń wpis';

  @override
  String get sectionTemperature => 'Temperatura';

  @override
  String bbtLabel(String unit) {
    return 'PTC ($unit)';
  }

  @override
  String get fieldTime => 'Godzina';

  @override
  String get disturbanceFactorsLabel => 'Czynniki zakłócające';

  @override
  String get disturbanceHelp =>
      'Czy coś nietypowego wpłynęło na temperaturę? Oznaczone wartości są widoczne na wykresie, ale wyłączone z obliczania linii bazowej.';

  @override
  String get distIllness => 'Choroba';

  @override
  String get distPoorSleep => 'Słaby sen';

  @override
  String get distAlcohol => 'Alkohol';

  @override
  String get distLateMeasurement => 'Późny pomiar';

  @override
  String get distStress => 'Stres';

  @override
  String get distTravel => 'Podróż';

  @override
  String get distMedication => 'Leki';

  @override
  String get additionalDetails => 'Dodatkowe szczegóły (opcjonalnie)';

  @override
  String get additionalDetailsHint => 'np. obudziłam się 2 h później';

  @override
  String get sectionMucus => 'Śluz szyjkowy';

  @override
  String get mucusSensation => 'Odczucie';

  @override
  String get mucusAppearanceLabel => 'Wygląd';

  @override
  String get mucusDry => 'Sucho';

  @override
  String get mucusNothing => 'Nic';

  @override
  String get mucusMoist => 'Wilgotno';

  @override
  String get mucusWet => 'Mokro';

  @override
  String get mucusSlippery => 'Śliski';

  @override
  String get mucusEggWhite => 'Jak białko jaja';

  @override
  String get mucusNotRecorded => 'Nie zapisano';

  @override
  String get appNone => 'Brak';

  @override
  String get appCloudy => 'Mętny';

  @override
  String get appYellowish => 'Żółtawy';

  @override
  String get appSticky => 'Lepki';

  @override
  String get appCreamy => 'Kremowy';

  @override
  String get appClear => 'Przejrzysty';

  @override
  String get appStretchy => 'Rozciągliwy';

  @override
  String get appTransparent => 'Przezroczysty';

  @override
  String get sectionBleeding => 'Krwawienie';

  @override
  String get bleedNone => 'Brak';

  @override
  String get bleedSpotting => 'Plamienie';

  @override
  String get bleedLight => 'Lekkie';

  @override
  String get bleedMedium => 'Średnie';

  @override
  String get bleedHeavy => 'Obfite';

  @override
  String get sectionCervix => 'Szyjka macicy';

  @override
  String get cervixPositionLabel => 'Pozycja';

  @override
  String get cervixOpennessLabel => 'Rozwarcie';

  @override
  String get cervixFirmnessLabel => 'Twardość';

  @override
  String get posLow => 'Nisko';

  @override
  String get posMedium => 'Średnio';

  @override
  String get posHigh => 'Wysoko';

  @override
  String get openClosed => 'Zamknięta';

  @override
  String get openPartially => 'Lekko otwarta';

  @override
  String get openOpen => 'Otwarta';

  @override
  String get firmFirm => 'Twarda';

  @override
  String get firmMedium => 'Średnia';

  @override
  String get firmSoft => 'Miękka';

  @override
  String get sectionAdditional => 'Dodatkowe';

  @override
  String get fieldIntercourse => 'Współżycie';

  @override
  String get markPeakDay => 'Oznacz jako dzień szczytu';

  @override
  String get markPeakDaySub =>
      'Ostatni dzień najlepszego śluzu przed wyschnięciem';

  @override
  String get sectionNotes => 'Notatki';

  @override
  String get notesHint => 'Inne obserwacje...';

  @override
  String get saveEntry => 'Zapisz wpis';

  @override
  String get couldNotLoad => 'Nie udało się wczytać wpisu';

  @override
  String get goBack => 'Wstecz';

  @override
  String get unsavedTitle => 'Niezapisane zmiany';

  @override
  String get unsavedBody => 'Masz niezapisane zmiany. Czy chcesz je odrzucić?';

  @override
  String get keepEditing => 'Kontynuuj edycję';

  @override
  String get discard => 'Odrzuć';

  @override
  String get invalidNumber => 'Wpisz prawidłową liczbę';

  @override
  String get rangeCelsius => 'Oczekiwany zakres: 35,00–39,00 °C';

  @override
  String get rangeFahrenheit => 'Oczekiwany zakres: 95,00–102,20 °F';

  @override
  String get deleteEntryTitle => 'Usunąć wpis?';

  @override
  String deleteEntryBody(String date, int day) {
    return 'Usunąć wpis z $date (dzień cyklu $day)?\n\nTej operacji nie można cofnąć.';
  }

  @override
  String get delete => 'Usuń';

  @override
  String get entryDeleted => 'Wpis usunięty';

  @override
  String get entrySaved => 'Wpis zapisany';

  @override
  String get logTodayTitle => 'Zapisz dzisiaj';

  @override
  String get logTodaySub => 'Temperatura, śluz, krwawienie';

  @override
  String get noActiveCycle => 'Brak aktywnego cyklu';

  @override
  String get noActiveCycleSub => 'Zacznij zapisywać, aby zobaczyć płodność';

  @override
  String get start => 'Rozpocznij';

  @override
  String cycleDayBadge(int day) {
    return 'Dzień $day';
  }

  @override
  String cycleStarted(String date) {
    return 'Rozpoczęto $date';
  }

  @override
  String get startNewCycleTooltip => 'Rozpocznij nowy cykl';

  @override
  String get tapToAddEntry => 'Dotknij, aby dodać wpis';

  @override
  String get mucusShort => 'Śluz';

  @override
  String get legendPeriodInfertile => 'Niepłodne (okres)';

  @override
  String get legendPeriod => 'Okres';

  @override
  String get legendPotFertile => 'Możl. płodne';

  @override
  String get legendPhase1 => 'Faza 1';

  @override
  String get legendInfertileConfirmed => 'Niepłodne (potwierdzone)';

  @override
  String get legendPostOv => 'Po owulacji';

  @override
  String get periodStartHelp => 'Kiedy zaczął się Twój okres?';

  @override
  String get newCycleTitle => 'Rozpocznij nowy cykl';

  @override
  String newCycleStarting(String date) {
    return 'Początek $date';
  }

  @override
  String get newCycleWillClose => 'Bieżący cykl zostanie zamknięty.';

  @override
  String get bleedingTodayQ => 'Jakie jest dziś Twoje krwawienie?';

  @override
  String bleedingOnDayQ(String date) {
    return 'Jakie było Twoje krwawienie w dniu $date?';
  }

  @override
  String get startCycle => 'Rozpocznij cykl';

  @override
  String get stmRuleTitle => 'Reguła metody';

  @override
  String get gotIt => 'Rozumiem';

  @override
  String get statusPotentiallyFertile => 'Możl. płodne';

  @override
  String get statusInfertilePreOv => 'Niepłodne (przed owulacją)';

  @override
  String get statusFertile => 'Płodne';

  @override
  String get statusFertileAwaitingMucus => 'Płodne (skok temp. ✓, brak śluzu)';

  @override
  String get statusFertileAwaitingTemp =>
      'Płodne (dzień szczytu ✓, brak temp.)';

  @override
  String get statusFertileAwaitingCheck =>
      'Płodne (oczekuje podwójnej kontroli)';

  @override
  String get statusInfertile => 'Niepłodne';

  @override
  String get statusInfertilePostOv => 'Niepłodne (po owulacji)';

  @override
  String get statusMenstruation => 'Miesiączka';

  @override
  String statusInfertileDay(int day, int limit) {
    return 'Niepłodne (dzień $day/$limit)';
  }

  @override
  String get statusUnknown => 'Nieznane';
}
