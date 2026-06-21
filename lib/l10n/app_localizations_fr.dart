// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Aujourd’hui';

  @override
  String get navChart => 'Courbe';

  @override
  String get navInsights => 'Statistiques';

  @override
  String get navLearn => 'Apprendre';

  @override
  String get navSettings => 'Réglages';

  @override
  String get supportTitle => 'Soutenir Ember';

  @override
  String get supportHeadline => 'Ember est gratuit — et le reste';

  @override
  String get supportBody =>
      'Pas d’abonnement, pas de publicité, pas de suivi. Toutes les fonctions sont accessibles à tous. Je le développe et l’entretiens sur mon temps libre.\n\nSi Ember vous est utile et que vous souhaitez soutenir son développement, vous pouvez laisser un petit pourboire. C’est entièrement facultatif et ne débloque rien : vous avez déjà toute l’application.';

  @override
  String get supportButton => 'Offrez-moi un café';

  @override
  String get supportFootnote =>
      'S’ouvre dans votre navigateur. Ember ne voit jamais vos données de paiement.';

  @override
  String get supportLinkError => 'Impossible d’ouvrir le lien';

  @override
  String get settingsGoal => 'Objectif';

  @override
  String get settingsUseFor => 'J’utilise la méthode pour';

  @override
  String get purposeAvoiding => 'Éviter';

  @override
  String get purposeAchieving => 'Concevoir';

  @override
  String get purposeAvoidingDesc =>
      'Les libellés adoptent une approche prudente : seules les phases confirmées sont marquées comme infertiles.';

  @override
  String get purposeAchievingDesc =>
      'Les libellés utilisent la terminologie standard de la méthode pour identifier la fenêtre fertile.';

  @override
  String get settingsTracking => 'Saisie';

  @override
  String get settingsTempUnit => 'Unité de température';

  @override
  String get settingsRuleset => 'Règles de la méthode';

  @override
  String get settingsCervix => 'Suivi du col de l’utérus';

  @override
  String get settingsCervixSub => 'Position, ouverture et fermeté';

  @override
  String get settingsIntercourse => 'Suivi des rapports';

  @override
  String get settingsOpenEntryVia => 'Ouvrir la saisie du jour par';

  @override
  String get tapLongPress => 'Appui long';

  @override
  String get tapDoubleTap => 'Double tape';

  @override
  String get settingsAutoDetection => 'Détection automatique';

  @override
  String get settingsAutoCoverline => 'Ligne de base automatique';

  @override
  String get settingsAutoCoverlineSub => 'Règle des 3 au-dessus de 6';

  @override
  String get settingsAutoPeak => 'Jour sommet automatique';

  @override
  String get settingsAutoPeakSub => 'À partir du profil de la glaire';

  @override
  String get settingsReminders => 'Rappels';

  @override
  String get settingsDailyReminder => 'Rappel quotidien';

  @override
  String get settingsDailyReminderSub =>
      'Une notification par jour pour noter température et glaire.';

  @override
  String get settingsReminderTime => 'Heure du rappel';

  @override
  String get settingsData => 'Données';

  @override
  String get settingsExport => 'Exporter les données (CSV)';

  @override
  String get settingsExportSub => 'Enregistrer toutes les données en CSV';

  @override
  String get settingsImport => 'Importer des données (CSV)';

  @override
  String get settingsImportSub => 'Importer le format CSV d’Ember';

  @override
  String get settingsImportKindara => 'Importer depuis Kindara';

  @override
  String get settingsImportKindaraSub => 'Importer un fichier d’export Kindara';

  @override
  String get settingsDeleteAll => 'Supprimer toutes les données';

  @override
  String get settingsDeleteAllSub => 'Cette action est irréversible';

  @override
  String get settingsAbout => 'À propos';

  @override
  String get settingsPrivacy => 'Confidentialité';

  @override
  String get settingsPrivacySub =>
      'Toutes les données sont stockées localement. Aucun compte requis.';

  @override
  String get settingsAboutStm => 'À propos de la méthode';

  @override
  String get settingsAboutStmSub =>
      'Compatible avec la méthode symptothermique. Application indépendante, non affiliée à aucune organisation.';

  @override
  String get settingsSupport => 'Soutenir';

  @override
  String get settingsSupportDev => 'Soutenir le développement';

  @override
  String get settingsSupportDevSub =>
      'Ember est gratuit. Offrez un café si vous voulez — facultatif.';

  @override
  String get exportCompleteTitle => 'Export terminé';

  @override
  String exportCompleteBody(String path) {
    return 'Fichier enregistré dans :\n$path\n\nVoulez-vous le partager ?';
  }

  @override
  String get close => 'Fermer';

  @override
  String get share => 'Partager';

  @override
  String exportFailed(String error) {
    return 'Échec de l’export : $error';
  }

  @override
  String importedEntries(int count) {
    return '$count entrées importées';
  }

  @override
  String importFailed(String error) {
    return 'Échec de l’import : $error';
  }

  @override
  String importedKindara(int count) {
    return '$count entrées Kindara importées';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Échec de l’import Kindara : $error';
  }

  @override
  String get deleteAllTitle => 'Supprimer toutes les données ?';

  @override
  String get deleteAllBody =>
      'Cela supprimera définitivement tous vos cycles et saisies. Pensez à exporter vos données d’abord.\n\nCette action est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get deleteEverything => 'Tout supprimer';

  @override
  String get allDataDeleted => 'Toutes les données supprimées';

  @override
  String cycleDayLabel(int day) {
    return 'Jour du cycle $day';
  }

  @override
  String get deleteEntryTooltip => 'Supprimer la saisie';

  @override
  String get sectionTemperature => 'Température';

  @override
  String bbtLabel(String unit) {
    return 'TBC ($unit)';
  }

  @override
  String get fieldTime => 'Heure';

  @override
  String get disturbanceFactorsLabel => 'Facteurs perturbateurs';

  @override
  String get disturbanceHelp =>
      'Quelque chose d\'inhabituel a-t-il affecté votre température ? Les valeurs marquées apparaissent sur la courbe mais sont exclues du calcul de la ligne de base.';

  @override
  String get distIllness => 'Maladie';

  @override
  String get distPoorSleep => 'Mauvais sommeil';

  @override
  String get distAlcohol => 'Alcool';

  @override
  String get distLateMeasurement => 'Mesure tardive';

  @override
  String get distStress => 'Stress';

  @override
  String get distTravel => 'Voyage';

  @override
  String get distMedication => 'Médicament';

  @override
  String get additionalDetails => 'Détails supplémentaires (facultatif)';

  @override
  String get additionalDetailsHint => 'p. ex. réveil 2 h plus tard';

  @override
  String get sectionMucus => 'Glaire cervicale';

  @override
  String get mucusSensation => 'Sensation';

  @override
  String get mucusAppearanceLabel => 'Aspect';

  @override
  String get mucusDry => 'Sèche';

  @override
  String get mucusNothing => 'Rien';

  @override
  String get mucusMoist => 'Humide';

  @override
  String get mucusWet => 'Mouillée';

  @override
  String get mucusSlippery => 'Glissante';

  @override
  String get mucusEggWhite => 'Blanc d\'œuf';

  @override
  String get mucusNotRecorded => 'Non renseignée';

  @override
  String get appNone => 'Aucun';

  @override
  String get appCloudy => 'Trouble';

  @override
  String get appYellowish => 'Jaunâtre';

  @override
  String get appSticky => 'Collante';

  @override
  String get appCreamy => 'Crémeuse';

  @override
  String get appClear => 'Claire';

  @override
  String get appStretchy => 'Élastique';

  @override
  String get appTransparent => 'Transparente';

  @override
  String get sectionBleeding => 'Saignement';

  @override
  String get bleedNone => 'Aucun';

  @override
  String get bleedSpotting => 'Spotting';

  @override
  String get bleedLight => 'Léger';

  @override
  String get bleedMedium => 'Moyen';

  @override
  String get bleedHeavy => 'Abondant';

  @override
  String get sectionCervix => 'Col de l\'utérus';

  @override
  String get cervixPositionLabel => 'Position';

  @override
  String get cervixOpennessLabel => 'Ouverture';

  @override
  String get cervixFirmnessLabel => 'Fermeté';

  @override
  String get posLow => 'Bas';

  @override
  String get posMedium => 'Moyen';

  @override
  String get posHigh => 'Haut';

  @override
  String get openClosed => 'Fermé';

  @override
  String get openPartially => 'Entrouvert';

  @override
  String get openOpen => 'Ouvert';

  @override
  String get firmFirm => 'Ferme';

  @override
  String get firmMedium => 'Moyen';

  @override
  String get firmSoft => 'Souple';

  @override
  String get sectionAdditional => 'Autre';

  @override
  String get fieldIntercourse => 'Rapports';

  @override
  String get markPeakDay => 'Marquer comme jour sommet';

  @override
  String get markPeakDaySub =>
      'Dernier jour de la meilleure glaire avant l\'assèchement';

  @override
  String get sectionNotes => 'Notes';

  @override
  String get notesHint => 'Autres observations...';

  @override
  String get saveEntry => 'Enregistrer';

  @override
  String get couldNotLoad => 'Impossible de charger la saisie';

  @override
  String get goBack => 'Retour';

  @override
  String get unsavedTitle => 'Modifications non enregistrées';

  @override
  String get unsavedBody =>
      'Vous avez des modifications non enregistrées. Les abandonner ?';

  @override
  String get keepEditing => 'Continuer l\'édition';

  @override
  String get discard => 'Abandonner';

  @override
  String get invalidNumber => 'Saisissez un nombre valide';

  @override
  String get rangeCelsius => 'Plage attendue : 35,00 - 39,00 °C';

  @override
  String get rangeFahrenheit => 'Plage attendue : 95,00 - 102,20 °F';

  @override
  String get deleteEntryTitle => 'Supprimer la saisie ?';

  @override
  String deleteEntryBody(String date, int day) {
    return 'Supprimer la saisie du $date (jour du cycle $day) ?\n\nCette action est irréversible.';
  }

  @override
  String get delete => 'Supprimer';

  @override
  String get entryDeleted => 'Saisie supprimée';

  @override
  String get entrySaved => 'Saisie enregistrée';

  @override
  String get logTodayTitle => 'Noter aujourd\'hui';

  @override
  String get logTodaySub => 'Température, glaire, saignement';

  @override
  String get noActiveCycle => 'Aucun cycle actif';

  @override
  String get noActiveCycleSub => 'Commencez le suivi pour voir votre fertilité';

  @override
  String get start => 'Démarrer';

  @override
  String cycleDayBadge(int day) {
    return 'Jour $day';
  }

  @override
  String cycleStarted(String date) {
    return 'Commencé le $date';
  }

  @override
  String get startNewCycleTooltip => 'Démarrer un nouveau cycle';

  @override
  String get tapToAddEntry => 'Appuyez pour ajouter une saisie';

  @override
  String get mucusShort => 'Glaire';

  @override
  String get legendPeriodInfertile => 'Infertile (règles)';

  @override
  String get legendPeriod => 'Règles';

  @override
  String get legendPotFertile => 'Pot. fertile';

  @override
  String get legendPhase1 => 'Phase 1';

  @override
  String get legendInfertileConfirmed => 'Infertile (confirmé)';

  @override
  String get legendPostOv => 'Post-ovulation';

  @override
  String get periodStartHelp => 'Quand vos règles ont-elles commencé ?';

  @override
  String get newCycleTitle => 'Démarrer un nouveau cycle';

  @override
  String newCycleStarting(String date) {
    return 'Début le $date';
  }

  @override
  String get newCycleWillClose => 'Le cycle actuel sera clôturé.';

  @override
  String get bleedingTodayQ => 'Comment sont vos règles aujourd\'hui ?';

  @override
  String bleedingOnDayQ(String date) {
    return 'Comment étaient vos règles le $date ?';
  }

  @override
  String get startCycle => 'Démarrer le cycle';

  @override
  String get stmRuleTitle => 'Règle de la méthode';

  @override
  String get gotIt => 'Compris';

  @override
  String get statusPotentiallyFertile => 'Pot. fertile';

  @override
  String get statusInfertilePreOv => 'Infertile (pré-ovulation)';

  @override
  String get statusFertile => 'Fertile';

  @override
  String get statusFertileAwaitingMucus =>
      'Fertile (hausse temp. ✓, glaire manquante)';

  @override
  String get statusFertileAwaitingTemp =>
      'Fertile (jour sommet ✓, temp. manquante)';

  @override
  String get statusFertileAwaitingCheck =>
      'Fertile (double contrôle en attente)';

  @override
  String get statusInfertile => 'Infertile';

  @override
  String get statusInfertilePostOv => 'Infertile (post-ovulation)';

  @override
  String get statusMenstruation => 'Menstruation';

  @override
  String statusInfertileDay(int day, int limit) {
    return 'Infertile (jour $day/$limit)';
  }

  @override
  String get statusUnknown => 'Inconnu';

  @override
  String get chartNoData => 'Pas encore de données de courbe';

  @override
  String get chartNoDataSub =>
      'Démarrez un nouveau cycle et notez votre température quotidienne pour voir la courbe.';

  @override
  String get chartNoTempData => 'Aucune donnée de température enregistrée.';

  @override
  String get coverlineLabel => 'Ligne de base';

  @override
  String get chartCycleDayAxis => 'Jour du cycle';

  @override
  String get peakShort => 'Sommet';

  @override
  String peakDayLine(int day) {
    return 'Jour sommet : jour du cycle $day';
  }

  @override
  String mucusDayTooltip(int day, String mucus) {
    return 'Jour $day : $mucus';
  }

  @override
  String chartTempTooltip(int day, String temp, String unit) {
    return 'Jour $day\n$temp$unit';
  }

  @override
  String get stmEvaluation => 'Évaluation de la méthode';

  @override
  String get evalNotDetermined => 'Pas encore déterminée';

  @override
  String get evalTempShift => 'Hausse temp.';

  @override
  String evalConfirmedDay(int day) {
    return 'Confirmé jour $day';
  }

  @override
  String get evalNotConfirmed => 'Pas encore confirmé';

  @override
  String get evalPeakDay => 'Jour sommet';

  @override
  String evalDayValue(int day) {
    return 'Jour $day';
  }

  @override
  String get evalNotIdentified => 'Pas encore identifié';

  @override
  String get evalInfertileFrom => 'Infertile à partir de';

  @override
  String get coverlineDialogTitle => 'Définir la ligne de base';

  @override
  String get coverlineDialogBody =>
      'Saisissez la température de la ligne de base manuellement ou utilisez la détection automatique.';

  @override
  String coverlineFieldLabel(String unit) {
    return 'Ligne de base ($unit)';
  }

  @override
  String get auto => 'Auto';

  @override
  String get set => 'Définir';

  @override
  String get statsNoInsights => 'Pas encore de statistiques';

  @override
  String get statsNoInsightsSub =>
      'Terminez au moins un cycle pour voir vos statistiques.';

  @override
  String get cycleLengthHistory => 'Historique de la durée des cycles';

  @override
  String get allCycles => 'Tous les cycles';

  @override
  String daysUntilPeriod(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours avant les règles prévues',
      one: '1 jour avant les règles prévues',
    );
    return '$_temp0';
  }

  @override
  String periodExpectedIn(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Règles prévues dans $days jours',
      one: 'Règles prévues dans 1 jour',
    );
    return '$_temp0';
  }

  @override
  String get periodExpectedToday => 'Règles prévues aujourd\'hui';

  @override
  String daysPastExpected(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours de retard sur la date prévue',
      one: '1 jour de retard sur la date prévue',
    );
    return '$_temp0';
  }

  @override
  String predictionEst(String date, String avg) {
    return 'Env. $date (sur la base d\'un cycle moyen de $avg jours)';
  }

  @override
  String get regVeryRegular => 'Très régulier';

  @override
  String get regRegular => 'Régulier';

  @override
  String get regSomewhat => 'Un peu irrégulier';

  @override
  String get regIrregular => 'Irrégulier';

  @override
  String get regNotEnough => 'Pas assez de données';

  @override
  String get crossCycleInsights => 'Analyse multi-cycles';

  @override
  String get insightRegularity => 'Régularité';

  @override
  String get insightVariation => 'Variation';

  @override
  String variationDays(String value) {
    return '±$value jours';
  }

  @override
  String get insightAvgShift => 'Hausse temp. moy.';

  @override
  String get insightCyclesRecorded => 'Cycles enregistrés';

  @override
  String cyclesCompleted(int count) {
    return '$count terminés';
  }

  @override
  String moreCyclesNeeded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Encore $count cycles requis pour les règles avancées (moins-20, moins-8)',
      one: 'Encore 1 cycle requis pour les règles avancées (moins-20, moins-8)',
    );
    return '$_temp0';
  }

  @override
  String get statTotalCycles => 'Cycles au total';

  @override
  String get statAvgLength => 'Durée moy.';

  @override
  String get statShortest => 'Le plus court';

  @override
  String get statLongest => 'Le plus long';

  @override
  String daysUnit(String value) {
    return '$value jours';
  }

  @override
  String chartAvg(String value) {
    return 'Moy. : $value';
  }

  @override
  String currentCycleDay(int day) {
    return 'Cycle actuel · jour $day';
  }

  @override
  String get active => 'Actif';

  @override
  String get deleteCycleTooltip => 'Supprimer le cycle';

  @override
  String get deleteCycleTitle => 'Supprimer le cycle ?';

  @override
  String deleteCycleBody(String date) {
    return 'Supprimer le cycle commençant le $date ?\n\nToutes les saisies de ce cycle seront aussi supprimées. Cette action est irréversible.';
  }

  @override
  String get cycleDeleted => 'Cycle supprimé';
}
