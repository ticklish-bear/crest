enum TemperatureUnit { celsius, fahrenheit }
enum StmRuleset { agNfp, tcoyf }
enum AppPurpose { anticonception, conception }
enum CalendarTapAction { longPress, doubleTap }

class AppSettings {
  final TemperatureUnit temperatureUnit;
  final StmRuleset ruleset;
  final AppPurpose purpose;
  final double defaultLutealPhaseLength;
  final bool showCervixTracking;
  final bool showIntercourseTracking;
  final bool autoDetectCoverline;
  final bool autoDetectPeakDay;
  final CalendarTapAction calendarTapAction;
  final bool dailyReminderEnabled;
  final int dailyReminderHour;
  final int dailyReminderMinute;

  const AppSettings({
    this.temperatureUnit = TemperatureUnit.celsius,
    this.ruleset = StmRuleset.agNfp,
    this.purpose = AppPurpose.anticonception,
    this.defaultLutealPhaseLength = 12,
    this.showCervixTracking = false,
    this.showIntercourseTracking = true,
    this.autoDetectCoverline = true,
    this.autoDetectPeakDay = true,
    this.calendarTapAction = CalendarTapAction.longPress,
    this.dailyReminderEnabled = false,
    this.dailyReminderHour = 7,
    this.dailyReminderMinute = 0,
  });

  AppSettings copyWith({
    TemperatureUnit? temperatureUnit,
    StmRuleset? ruleset,
    AppPurpose? purpose,
    double? defaultLutealPhaseLength,
    bool? showCervixTracking,
    bool? showIntercourseTracking,
    bool? autoDetectCoverline,
    bool? autoDetectPeakDay,
    CalendarTapAction? calendarTapAction,
    bool? dailyReminderEnabled,
    int? dailyReminderHour,
    int? dailyReminderMinute,
  }) {
    return AppSettings(
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      ruleset: ruleset ?? this.ruleset,
      purpose: purpose ?? this.purpose,
      defaultLutealPhaseLength:
          defaultLutealPhaseLength ?? this.defaultLutealPhaseLength,
      showCervixTracking: showCervixTracking ?? this.showCervixTracking,
      showIntercourseTracking:
          showIntercourseTracking ?? this.showIntercourseTracking,
      autoDetectCoverline: autoDetectCoverline ?? this.autoDetectCoverline,
      autoDetectPeakDay: autoDetectPeakDay ?? this.autoDetectPeakDay,
      calendarTapAction: calendarTapAction ?? this.calendarTapAction,
      dailyReminderEnabled:
          dailyReminderEnabled ?? this.dailyReminderEnabled,
      dailyReminderHour: dailyReminderHour ?? this.dailyReminderHour,
      dailyReminderMinute: dailyReminderMinute ?? this.dailyReminderMinute,
    );
  }

  String get reminderTimeLabel {
    final h = dailyReminderHour.toString().padLeft(2, '0');
    final m = dailyReminderMinute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  static double celsiusToFahrenheit(double c) => c * 9 / 5 + 32;
  static double fahrenheitToCelsius(double f) => (f - 32) * 5 / 9;

  double displayTemp(double celsius) {
    if (temperatureUnit == TemperatureUnit.fahrenheit) {
      return celsiusToFahrenheit(celsius);
    }
    return celsius;
  }

  double storageTemp(double displayed) {
    if (temperatureUnit == TemperatureUnit.fahrenheit) {
      return fahrenheitToCelsius(displayed);
    }
    return displayed;
  }

  String get tempUnitLabel =>
      temperatureUnit == TemperatureUnit.celsius ? '°C' : '°F';
}
