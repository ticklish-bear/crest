import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pl'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Ember'**
  String get appTitle;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navChart.
  ///
  /// In en, this message translates to:
  /// **'Chart'**
  String get navChart;

  /// No description provided for @navInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// No description provided for @navLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get navLearn;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Ember'**
  String get supportTitle;

  /// No description provided for @supportHeadline.
  ///
  /// In en, this message translates to:
  /// **'Ember is free — and stays that way'**
  String get supportHeadline;

  /// No description provided for @supportBody.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions, no ads, no tracking. Every feature is available to everyone. It’s built and maintained in my spare time.\n\nIf Ember is useful to you and you’d like to chip in toward its development, you can leave a small tip. It’s entirely optional and unlocks nothing — you already have the whole app.'**
  String get supportBody;

  /// No description provided for @supportButton.
  ///
  /// In en, this message translates to:
  /// **'Buy me a coffee'**
  String get supportButton;

  /// No description provided for @supportFootnote.
  ///
  /// In en, this message translates to:
  /// **'Opens in your browser. Ember never sees your payment details.'**
  String get supportFootnote;

  /// No description provided for @supportLinkError.
  ///
  /// In en, this message translates to:
  /// **'Could not open the link'**
  String get supportLinkError;

  /// No description provided for @settingsGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get settingsGoal;

  /// No description provided for @settingsUseFor.
  ///
  /// In en, this message translates to:
  /// **'I use STM for'**
  String get settingsUseFor;

  /// No description provided for @purposeAvoiding.
  ///
  /// In en, this message translates to:
  /// **'Avoiding'**
  String get purposeAvoiding;

  /// No description provided for @purposeAchieving.
  ///
  /// In en, this message translates to:
  /// **'Achieving'**
  String get purposeAchieving;

  /// No description provided for @purposeAvoidingDesc.
  ///
  /// In en, this message translates to:
  /// **'Labels reflect a cautious approach — only confirmed phases are marked infertile.'**
  String get purposeAvoidingDesc;

  /// No description provided for @purposeAchievingDesc.
  ///
  /// In en, this message translates to:
  /// **'Labels use standard STM terminology for identifying the fertile window.'**
  String get purposeAchievingDesc;

  /// No description provided for @settingsTracking.
  ///
  /// In en, this message translates to:
  /// **'Tracking'**
  String get settingsTracking;

  /// No description provided for @settingsTempUnit.
  ///
  /// In en, this message translates to:
  /// **'Temperature Unit'**
  String get settingsTempUnit;

  /// No description provided for @settingsRuleset.
  ///
  /// In en, this message translates to:
  /// **'STM Ruleset'**
  String get settingsRuleset;

  /// No description provided for @settingsCervix.
  ///
  /// In en, this message translates to:
  /// **'Cervix tracking'**
  String get settingsCervix;

  /// No description provided for @settingsCervixSub.
  ///
  /// In en, this message translates to:
  /// **'Position, openness & firmness'**
  String get settingsCervixSub;

  /// No description provided for @settingsIntercourse.
  ///
  /// In en, this message translates to:
  /// **'Intercourse tracking'**
  String get settingsIntercourse;

  /// No description provided for @settingsOpenEntryVia.
  ///
  /// In en, this message translates to:
  /// **'Open day entry via'**
  String get settingsOpenEntryVia;

  /// No description provided for @tapLongPress.
  ///
  /// In en, this message translates to:
  /// **'Long press'**
  String get tapLongPress;

  /// No description provided for @tapDoubleTap.
  ///
  /// In en, this message translates to:
  /// **'Double tap'**
  String get tapDoubleTap;

  /// No description provided for @settingsAutoDetection.
  ///
  /// In en, this message translates to:
  /// **'Automatic Detection'**
  String get settingsAutoDetection;

  /// No description provided for @settingsAutoCoverline.
  ///
  /// In en, this message translates to:
  /// **'Auto-detect coverline'**
  String get settingsAutoCoverline;

  /// No description provided for @settingsAutoCoverlineSub.
  ///
  /// In en, this message translates to:
  /// **'3-over-6 rule'**
  String get settingsAutoCoverlineSub;

  /// No description provided for @settingsAutoPeak.
  ///
  /// In en, this message translates to:
  /// **'Auto-detect Peak Day'**
  String get settingsAutoPeak;

  /// No description provided for @settingsAutoPeakSub.
  ///
  /// In en, this message translates to:
  /// **'From mucus pattern'**
  String get settingsAutoPeakSub;

  /// No description provided for @settingsReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// No description provided for @settingsDailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in reminder'**
  String get settingsDailyReminder;

  /// No description provided for @settingsDailyReminderSub.
  ///
  /// In en, this message translates to:
  /// **'A single notification each day to log BBT and mucus.'**
  String get settingsDailyReminderSub;

  /// No description provided for @settingsReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get settingsReminderTime;

  /// No description provided for @settingsData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsData;

  /// No description provided for @settingsExport.
  ///
  /// In en, this message translates to:
  /// **'Export data (CSV)'**
  String get settingsExport;

  /// No description provided for @settingsExportSub.
  ///
  /// In en, this message translates to:
  /// **'Save all data as CSV'**
  String get settingsExportSub;

  /// No description provided for @settingsImport.
  ///
  /// In en, this message translates to:
  /// **'Import data (CSV)'**
  String get settingsImport;

  /// No description provided for @settingsImportSub.
  ///
  /// In en, this message translates to:
  /// **'Import Ember CSV format'**
  String get settingsImportSub;

  /// No description provided for @settingsImportKindara.
  ///
  /// In en, this message translates to:
  /// **'Import from Kindara'**
  String get settingsImportKindara;

  /// No description provided for @settingsImportKindaraSub.
  ///
  /// In en, this message translates to:
  /// **'Import Kindara export file'**
  String get settingsImportKindaraSub;

  /// No description provided for @settingsDeleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get settingsDeleteAll;

  /// No description provided for @settingsDeleteAllSub.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone'**
  String get settingsDeleteAllSub;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacySub.
  ///
  /// In en, this message translates to:
  /// **'All data stored locally. No account required.'**
  String get settingsPrivacySub;

  /// No description provided for @settingsAboutStm.
  ///
  /// In en, this message translates to:
  /// **'About STM'**
  String get settingsAboutStm;

  /// No description provided for @settingsAboutStmSub.
  ///
  /// In en, this message translates to:
  /// **'Compatible with the symptothermal method. Independent app, not affiliated with any organization.'**
  String get settingsAboutStmSub;

  /// No description provided for @settingsSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSupport;

  /// No description provided for @settingsSupportDev.
  ///
  /// In en, this message translates to:
  /// **'Support development'**
  String get settingsSupportDev;

  /// No description provided for @settingsSupportDevSub.
  ///
  /// In en, this message translates to:
  /// **'Ember is free. Chip in a coffee if you like — optional.'**
  String get settingsSupportDevSub;

  /// No description provided for @exportCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Complete'**
  String get exportCompleteTitle;

  /// No description provided for @exportCompleteBody.
  ///
  /// In en, this message translates to:
  /// **'File saved to:\n{path}\n\nWould you like to share it?'**
  String exportCompleteBody(String path);

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String exportFailed(String error);

  /// No description provided for @importedEntries.
  ///
  /// In en, this message translates to:
  /// **'Imported {count} entries'**
  String importedEntries(int count);

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String importFailed(String error);

  /// No description provided for @importedKindara.
  ///
  /// In en, this message translates to:
  /// **'Imported {count} Kindara entries'**
  String importedKindara(int count);

  /// No description provided for @kindaraImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Kindara import failed: {error}'**
  String kindaraImportFailed(String error);

  /// No description provided for @deleteAllTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete All Data?'**
  String get deleteAllTitle;

  /// No description provided for @deleteAllBody.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all your cycles and entries. Consider exporting your data first.\n\nThis action cannot be undone.'**
  String get deleteAllBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @deleteEverything.
  ///
  /// In en, this message translates to:
  /// **'Delete Everything'**
  String get deleteEverything;

  /// No description provided for @allDataDeleted.
  ///
  /// In en, this message translates to:
  /// **'All data deleted'**
  String get allDataDeleted;

  /// No description provided for @cycleDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Cycle Day {day}'**
  String cycleDayLabel(int day);

  /// No description provided for @deleteEntryTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete entry'**
  String get deleteEntryTooltip;

  /// No description provided for @sectionTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get sectionTemperature;

  /// No description provided for @bbtLabel.
  ///
  /// In en, this message translates to:
  /// **'BBT ({unit})'**
  String bbtLabel(String unit);

  /// No description provided for @fieldTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get fieldTime;

  /// No description provided for @disturbanceFactorsLabel.
  ///
  /// In en, this message translates to:
  /// **'Disturbance factors'**
  String get disturbanceFactorsLabel;

  /// No description provided for @disturbanceHelp.
  ///
  /// In en, this message translates to:
  /// **'Did anything unusual affect your temperature? Tagged temps are shown on the chart but excluded from the coverline calculation.'**
  String get disturbanceHelp;

  /// No description provided for @distIllness.
  ///
  /// In en, this message translates to:
  /// **'Illness'**
  String get distIllness;

  /// No description provided for @distPoorSleep.
  ///
  /// In en, this message translates to:
  /// **'Poor sleep'**
  String get distPoorSleep;

  /// No description provided for @distAlcohol.
  ///
  /// In en, this message translates to:
  /// **'Alcohol'**
  String get distAlcohol;

  /// No description provided for @distLateMeasurement.
  ///
  /// In en, this message translates to:
  /// **'Late measurement'**
  String get distLateMeasurement;

  /// No description provided for @distStress.
  ///
  /// In en, this message translates to:
  /// **'Stress'**
  String get distStress;

  /// No description provided for @distTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get distTravel;

  /// No description provided for @distMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get distMedication;

  /// No description provided for @additionalDetails.
  ///
  /// In en, this message translates to:
  /// **'Additional details (optional)'**
  String get additionalDetails;

  /// No description provided for @additionalDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., woke up 2h late'**
  String get additionalDetailsHint;

  /// No description provided for @sectionMucus.
  ///
  /// In en, this message translates to:
  /// **'Cervical Mucus'**
  String get sectionMucus;

  /// No description provided for @mucusSensation.
  ///
  /// In en, this message translates to:
  /// **'Sensation'**
  String get mucusSensation;

  /// No description provided for @mucusAppearanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get mucusAppearanceLabel;

  /// No description provided for @mucusDry.
  ///
  /// In en, this message translates to:
  /// **'Dry'**
  String get mucusDry;

  /// No description provided for @mucusNothing.
  ///
  /// In en, this message translates to:
  /// **'Nothing'**
  String get mucusNothing;

  /// No description provided for @mucusMoist.
  ///
  /// In en, this message translates to:
  /// **'Moist'**
  String get mucusMoist;

  /// No description provided for @mucusWet.
  ///
  /// In en, this message translates to:
  /// **'Wet'**
  String get mucusWet;

  /// No description provided for @mucusSlippery.
  ///
  /// In en, this message translates to:
  /// **'Slippery'**
  String get mucusSlippery;

  /// No description provided for @mucusEggWhite.
  ///
  /// In en, this message translates to:
  /// **'Egg white'**
  String get mucusEggWhite;

  /// No description provided for @mucusNotRecorded.
  ///
  /// In en, this message translates to:
  /// **'Not recorded'**
  String get mucusNotRecorded;

  /// No description provided for @appNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get appNone;

  /// No description provided for @appCloudy.
  ///
  /// In en, this message translates to:
  /// **'Cloudy'**
  String get appCloudy;

  /// No description provided for @appYellowish.
  ///
  /// In en, this message translates to:
  /// **'Yellowish'**
  String get appYellowish;

  /// No description provided for @appSticky.
  ///
  /// In en, this message translates to:
  /// **'Sticky'**
  String get appSticky;

  /// No description provided for @appCreamy.
  ///
  /// In en, this message translates to:
  /// **'Creamy'**
  String get appCreamy;

  /// No description provided for @appClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get appClear;

  /// No description provided for @appStretchy.
  ///
  /// In en, this message translates to:
  /// **'Stretchy'**
  String get appStretchy;

  /// No description provided for @appTransparent.
  ///
  /// In en, this message translates to:
  /// **'Transparent'**
  String get appTransparent;

  /// No description provided for @sectionBleeding.
  ///
  /// In en, this message translates to:
  /// **'Bleeding'**
  String get sectionBleeding;

  /// No description provided for @bleedNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get bleedNone;

  /// No description provided for @bleedSpotting.
  ///
  /// In en, this message translates to:
  /// **'Spotting'**
  String get bleedSpotting;

  /// No description provided for @bleedLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get bleedLight;

  /// No description provided for @bleedMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get bleedMedium;

  /// No description provided for @bleedHeavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get bleedHeavy;

  /// No description provided for @sectionCervix.
  ///
  /// In en, this message translates to:
  /// **'Cervix'**
  String get sectionCervix;

  /// No description provided for @cervixPositionLabel.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get cervixPositionLabel;

  /// No description provided for @cervixOpennessLabel.
  ///
  /// In en, this message translates to:
  /// **'Openness'**
  String get cervixOpennessLabel;

  /// No description provided for @cervixFirmnessLabel.
  ///
  /// In en, this message translates to:
  /// **'Firmness'**
  String get cervixFirmnessLabel;

  /// No description provided for @posLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get posLow;

  /// No description provided for @posMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get posMedium;

  /// No description provided for @posHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get posHigh;

  /// No description provided for @openClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get openClosed;

  /// No description provided for @openPartially.
  ///
  /// In en, this message translates to:
  /// **'Partially open'**
  String get openPartially;

  /// No description provided for @openOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openOpen;

  /// No description provided for @firmFirm.
  ///
  /// In en, this message translates to:
  /// **'Firm'**
  String get firmFirm;

  /// No description provided for @firmMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get firmMedium;

  /// No description provided for @firmSoft.
  ///
  /// In en, this message translates to:
  /// **'Soft'**
  String get firmSoft;

  /// No description provided for @sectionAdditional.
  ///
  /// In en, this message translates to:
  /// **'Additional'**
  String get sectionAdditional;

  /// No description provided for @fieldIntercourse.
  ///
  /// In en, this message translates to:
  /// **'Intercourse'**
  String get fieldIntercourse;

  /// No description provided for @markPeakDay.
  ///
  /// In en, this message translates to:
  /// **'Mark as Peak Day'**
  String get markPeakDay;

  /// No description provided for @markPeakDaySub.
  ///
  /// In en, this message translates to:
  /// **'Last day of best-quality mucus before drying'**
  String get markPeakDaySub;

  /// No description provided for @sectionNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get sectionNotes;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Any additional observations...'**
  String get notesHint;

  /// No description provided for @saveEntry.
  ///
  /// In en, this message translates to:
  /// **'Save Entry'**
  String get saveEntry;

  /// No description provided for @couldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load entry'**
  String get couldNotLoad;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @unsavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get unsavedTitle;

  /// No description provided for @unsavedBody.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Do you want to discard them?'**
  String get unsavedBody;

  /// No description provided for @keepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep Editing'**
  String get keepEditing;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get invalidNumber;

  /// No description provided for @rangeCelsius.
  ///
  /// In en, this message translates to:
  /// **'Expected range: 35.00 - 39.00 °C'**
  String get rangeCelsius;

  /// No description provided for @rangeFahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Expected range: 95.00 - 102.20 °F'**
  String get rangeFahrenheit;

  /// No description provided for @deleteEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Entry?'**
  String get deleteEntryTitle;

  /// No description provided for @deleteEntryBody.
  ///
  /// In en, this message translates to:
  /// **'Delete the entry for {date} (Cycle Day {day})?\n\nThis cannot be undone.'**
  String deleteEntryBody(String date, int day);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @entryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Entry deleted'**
  String get entryDeleted;

  /// No description provided for @entrySaved.
  ///
  /// In en, this message translates to:
  /// **'Entry saved'**
  String get entrySaved;

  /// No description provided for @logTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'Log today\'s observations'**
  String get logTodayTitle;

  /// No description provided for @logTodaySub.
  ///
  /// In en, this message translates to:
  /// **'Temperature, mucus, bleeding'**
  String get logTodaySub;

  /// No description provided for @noActiveCycle.
  ///
  /// In en, this message translates to:
  /// **'No active cycle'**
  String get noActiveCycle;

  /// No description provided for @noActiveCycleSub.
  ///
  /// In en, this message translates to:
  /// **'Start tracking to see fertility insights'**
  String get noActiveCycleSub;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @cycleDayBadge.
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String cycleDayBadge(int day);

  /// No description provided for @cycleStarted.
  ///
  /// In en, this message translates to:
  /// **'Started {date}'**
  String cycleStarted(String date);

  /// No description provided for @startNewCycleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Start new cycle'**
  String get startNewCycleTooltip;

  /// No description provided for @tapToAddEntry.
  ///
  /// In en, this message translates to:
  /// **'Tap to add entry'**
  String get tapToAddEntry;

  /// No description provided for @mucusShort.
  ///
  /// In en, this message translates to:
  /// **'Mucus'**
  String get mucusShort;

  /// No description provided for @legendPeriodInfertile.
  ///
  /// In en, this message translates to:
  /// **'Infertile (period)'**
  String get legendPeriodInfertile;

  /// No description provided for @legendPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get legendPeriod;

  /// No description provided for @legendPotFertile.
  ///
  /// In en, this message translates to:
  /// **'Pot. fertile'**
  String get legendPotFertile;

  /// No description provided for @legendPhase1.
  ///
  /// In en, this message translates to:
  /// **'Phase 1'**
  String get legendPhase1;

  /// No description provided for @legendInfertileConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Infertile (confirmed)'**
  String get legendInfertileConfirmed;

  /// No description provided for @legendPostOv.
  ///
  /// In en, this message translates to:
  /// **'Post-ov'**
  String get legendPostOv;

  /// No description provided for @periodStartHelp.
  ///
  /// In en, this message translates to:
  /// **'When did your period start?'**
  String get periodStartHelp;

  /// No description provided for @newCycleTitle.
  ///
  /// In en, this message translates to:
  /// **'Start New Cycle'**
  String get newCycleTitle;

  /// No description provided for @newCycleStarting.
  ///
  /// In en, this message translates to:
  /// **'Starting on {date}'**
  String newCycleStarting(String date);

  /// No description provided for @newCycleWillClose.
  ///
  /// In en, this message translates to:
  /// **'The current cycle will be closed.'**
  String get newCycleWillClose;

  /// No description provided for @bleedingTodayQ.
  ///
  /// In en, this message translates to:
  /// **'How is your bleeding today?'**
  String get bleedingTodayQ;

  /// No description provided for @bleedingOnDayQ.
  ///
  /// In en, this message translates to:
  /// **'How was your bleeding on {date}?'**
  String bleedingOnDayQ(String date);

  /// No description provided for @startCycle.
  ///
  /// In en, this message translates to:
  /// **'Start Cycle'**
  String get startCycle;

  /// No description provided for @stmRuleTitle.
  ///
  /// In en, this message translates to:
  /// **'STM Rule'**
  String get stmRuleTitle;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @statusPotentiallyFertile.
  ///
  /// In en, this message translates to:
  /// **'Potentially fertile'**
  String get statusPotentiallyFertile;

  /// No description provided for @statusInfertilePreOv.
  ///
  /// In en, this message translates to:
  /// **'Infertile (pre-ov)'**
  String get statusInfertilePreOv;

  /// No description provided for @statusFertile.
  ///
  /// In en, this message translates to:
  /// **'Fertile'**
  String get statusFertile;

  /// No description provided for @statusFertileAwaitingMucus.
  ///
  /// In en, this message translates to:
  /// **'Fertile (temp shift ✓, awaiting mucus)'**
  String get statusFertileAwaitingMucus;

  /// No description provided for @statusFertileAwaitingTemp.
  ///
  /// In en, this message translates to:
  /// **'Fertile (Peak Day ✓, awaiting temp)'**
  String get statusFertileAwaitingTemp;

  /// No description provided for @statusFertileAwaitingCheck.
  ///
  /// In en, this message translates to:
  /// **'Fertile (awaiting double-check)'**
  String get statusFertileAwaitingCheck;

  /// No description provided for @statusInfertile.
  ///
  /// In en, this message translates to:
  /// **'Infertile'**
  String get statusInfertile;

  /// No description provided for @statusInfertilePostOv.
  ///
  /// In en, this message translates to:
  /// **'Infertile (post-ov)'**
  String get statusInfertilePostOv;

  /// No description provided for @statusMenstruation.
  ///
  /// In en, this message translates to:
  /// **'Menstruation'**
  String get statusMenstruation;

  /// No description provided for @statusInfertileDay.
  ///
  /// In en, this message translates to:
  /// **'Infertile (day {day}/{limit})'**
  String statusInfertileDay(int day, int limit);

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'pl',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
