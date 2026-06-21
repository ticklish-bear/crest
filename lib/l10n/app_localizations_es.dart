// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Hoy';

  @override
  String get navChart => 'Gráfica';

  @override
  String get navInsights => 'Estadísticas';

  @override
  String get navLearn => 'Aprender';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get supportTitle => 'Apoyar Ember';

  @override
  String get supportHeadline => 'Ember es gratis, y seguirá siéndolo';

  @override
  String get supportBody =>
      'Sin suscripciones, sin anuncios, sin rastreo. Todas las funciones están disponibles para todo el mundo. La desarrollo y mantengo en mi tiempo libre.\n\nSi Ember te resulta útil y quieres apoyar su desarrollo, puedes dejar una pequeña propina. Es totalmente opcional y no desbloquea nada: ya tienes la app completa.';

  @override
  String get supportButton => 'Invítame a un café';

  @override
  String get supportFootnote =>
      'Se abre en tu navegador. Ember nunca ve tus datos de pago.';

  @override
  String get supportLinkError => 'No se pudo abrir el enlace';

  @override
  String get settingsGoal => 'Objetivo';

  @override
  String get settingsUseFor => 'Uso el método para';

  @override
  String get purposeAvoiding => 'Evitar';

  @override
  String get purposeAchieving => 'Buscar';

  @override
  String get purposeAvoidingDesc =>
      'Las etiquetas reflejan un enfoque cauteloso: solo las fases confirmadas se marcan como infértiles.';

  @override
  String get purposeAchievingDesc =>
      'Las etiquetas usan la terminología estándar del método para identificar la ventana fértil.';

  @override
  String get settingsTracking => 'Registro';

  @override
  String get settingsTempUnit => 'Unidad de temperatura';

  @override
  String get settingsRuleset => 'Reglas del método';

  @override
  String get settingsCervix => 'Registrar cuello uterino';

  @override
  String get settingsCervixSub => 'Posición, apertura y firmeza';

  @override
  String get settingsIntercourse => 'Registrar relaciones';

  @override
  String get settingsOpenEntryVia => 'Abrir el registro del día con';

  @override
  String get tapLongPress => 'Mantener pulsado';

  @override
  String get tapDoubleTap => 'Doble toque';

  @override
  String get settingsAutoDetection => 'Detección automática';

  @override
  String get settingsAutoCoverline => 'Línea base automática';

  @override
  String get settingsAutoCoverlineSub => 'Regla 3 sobre 6';

  @override
  String get settingsAutoPeak => 'Día cúspide automático';

  @override
  String get settingsAutoPeakSub => 'A partir del patrón del moco';

  @override
  String get settingsReminders => 'Recordatorios';

  @override
  String get settingsDailyReminder => 'Recordatorio diario';

  @override
  String get settingsDailyReminderSub =>
      'Una notificación al día para registrar temperatura y moco.';

  @override
  String get settingsReminderTime => 'Hora del recordatorio';

  @override
  String get settingsData => 'Datos';

  @override
  String get settingsExport => 'Exportar datos (CSV)';

  @override
  String get settingsExportSub => 'Guardar todos los datos como CSV';

  @override
  String get settingsImport => 'Importar datos (CSV)';

  @override
  String get settingsImportSub => 'Importar formato CSV de Ember';

  @override
  String get settingsImportKindara => 'Importar desde Kindara';

  @override
  String get settingsImportKindaraSub =>
      'Importar archivo de exportación de Kindara';

  @override
  String get settingsDeleteAll => 'Eliminar todos los datos';

  @override
  String get settingsDeleteAllSub => 'Esto no se puede deshacer';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String get settingsPrivacy => 'Privacidad';

  @override
  String get settingsPrivacySub =>
      'Todos los datos se guardan localmente. No se requiere cuenta.';

  @override
  String get settingsAboutStm => 'Sobre el método';

  @override
  String get settingsAboutStmSub =>
      'Compatible con el método sintotérmico. App independiente, no afiliada a ninguna organización.';

  @override
  String get settingsSupport => 'Apoyar';

  @override
  String get settingsSupportDev => 'Apoyar el desarrollo';

  @override
  String get settingsSupportDevSub =>
      'Ember es gratis. Invita a un café si quieres: opcional.';

  @override
  String get exportCompleteTitle => 'Exportación completa';

  @override
  String exportCompleteBody(String path) {
    return 'Archivo guardado en:\n$path\n\n¿Quieres compartirlo?';
  }

  @override
  String get close => 'Cerrar';

  @override
  String get share => 'Compartir';

  @override
  String exportFailed(String error) {
    return 'Error al exportar: $error';
  }

  @override
  String importedEntries(int count) {
    return '$count registros importados';
  }

  @override
  String importFailed(String error) {
    return 'Error al importar: $error';
  }

  @override
  String importedKindara(int count) {
    return '$count registros de Kindara importados';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Error al importar de Kindara: $error';
  }

  @override
  String get deleteAllTitle => '¿Eliminar todos los datos?';

  @override
  String get deleteAllBody =>
      'Esto eliminará permanentemente todos tus ciclos y registros. Considera exportar tus datos primero.\n\nEsta acción no se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteEverything => 'Eliminar todo';

  @override
  String get allDataDeleted => 'Todos los datos eliminados';

  @override
  String cycleDayLabel(int day) {
    return 'Día del ciclo $day';
  }

  @override
  String get deleteEntryTooltip => 'Eliminar registro';

  @override
  String get sectionTemperature => 'Temperatura';

  @override
  String bbtLabel(String unit) {
    return 'TBC ($unit)';
  }

  @override
  String get fieldTime => 'Hora';

  @override
  String get disturbanceFactorsLabel => 'Factores de alteración';

  @override
  String get disturbanceHelp =>
      '¿Algo inusual afectó tu temperatura? Los valores marcados se muestran en la gráfica pero se excluyen del cálculo de la línea base.';

  @override
  String get distIllness => 'Enfermedad';

  @override
  String get distPoorSleep => 'Dormir mal';

  @override
  String get distAlcohol => 'Alcohol';

  @override
  String get distLateMeasurement => 'Medición tardía';

  @override
  String get distStress => 'Estrés';

  @override
  String get distTravel => 'Viaje';

  @override
  String get distMedication => 'Medicación';

  @override
  String get additionalDetails => 'Detalles adicionales (opcional)';

  @override
  String get additionalDetailsHint => 'p. ej., desperté 2 h tarde';

  @override
  String get sectionMucus => 'Moco cervical';

  @override
  String get mucusSensation => 'Sensación';

  @override
  String get mucusAppearanceLabel => 'Aspecto';

  @override
  String get mucusDry => 'Seco';

  @override
  String get mucusNothing => 'Nada';

  @override
  String get mucusMoist => 'Húmedo';

  @override
  String get mucusWet => 'Mojado';

  @override
  String get mucusSlippery => 'Resbaladizo';

  @override
  String get mucusEggWhite => 'Clara de huevo';

  @override
  String get mucusNotRecorded => 'Sin registrar';

  @override
  String get appNone => 'Ninguno';

  @override
  String get appCloudy => 'Turbio';

  @override
  String get appYellowish => 'Amarillento';

  @override
  String get appSticky => 'Pegajoso';

  @override
  String get appCreamy => 'Cremoso';

  @override
  String get appClear => 'Claro';

  @override
  String get appStretchy => 'Elástico';

  @override
  String get appTransparent => 'Transparente';

  @override
  String get sectionBleeding => 'Sangrado';

  @override
  String get bleedNone => 'Ninguno';

  @override
  String get bleedSpotting => 'Manchado';

  @override
  String get bleedLight => 'Ligero';

  @override
  String get bleedMedium => 'Medio';

  @override
  String get bleedHeavy => 'Abundante';

  @override
  String get sectionCervix => 'Cuello uterino';

  @override
  String get cervixPositionLabel => 'Posición';

  @override
  String get cervixOpennessLabel => 'Apertura';

  @override
  String get cervixFirmnessLabel => 'Firmeza';

  @override
  String get posLow => 'Bajo';

  @override
  String get posMedium => 'Medio';

  @override
  String get posHigh => 'Alto';

  @override
  String get openClosed => 'Cerrado';

  @override
  String get openPartially => 'Parcialmente abierto';

  @override
  String get openOpen => 'Abierto';

  @override
  String get firmFirm => 'Firme';

  @override
  String get firmMedium => 'Medio';

  @override
  String get firmSoft => 'Blando';

  @override
  String get sectionAdditional => 'Adicional';

  @override
  String get fieldIntercourse => 'Relaciones';

  @override
  String get markPeakDay => 'Marcar como día cúspide';

  @override
  String get markPeakDaySub => 'Último día del mejor moco antes de secarse';

  @override
  String get sectionNotes => 'Notas';

  @override
  String get notesHint => 'Otras observaciones...';

  @override
  String get saveEntry => 'Guardar registro';

  @override
  String get couldNotLoad => 'No se pudo cargar el registro';

  @override
  String get goBack => 'Volver';

  @override
  String get unsavedTitle => 'Cambios sin guardar';

  @override
  String get unsavedBody =>
      'Tienes cambios sin guardar. ¿Quieres descartarlos?';

  @override
  String get keepEditing => 'Seguir editando';

  @override
  String get discard => 'Descartar';

  @override
  String get invalidNumber => 'Introduce un número válido';

  @override
  String get rangeCelsius => 'Rango esperado: 35,00 - 39,00 °C';

  @override
  String get rangeFahrenheit => 'Rango esperado: 95,00 - 102,20 °F';

  @override
  String get deleteEntryTitle => '¿Eliminar registro?';

  @override
  String deleteEntryBody(String date, int day) {
    return '¿Eliminar el registro del $date (día del ciclo $day)?\n\nEsto no se puede deshacer.';
  }

  @override
  String get delete => 'Eliminar';

  @override
  String get entryDeleted => 'Registro eliminado';

  @override
  String get entrySaved => 'Registro guardado';

  @override
  String get logTodayTitle => 'Registrar hoy';

  @override
  String get logTodaySub => 'Temperatura, moco, sangrado';

  @override
  String get noActiveCycle => 'Sin ciclo activo';

  @override
  String get noActiveCycleSub => 'Empieza a registrar para ver tu fertilidad';

  @override
  String get start => 'Iniciar';

  @override
  String cycleDayBadge(int day) {
    return 'Día $day';
  }

  @override
  String cycleStarted(String date) {
    return 'Inició el $date';
  }

  @override
  String get startNewCycleTooltip => 'Iniciar nuevo ciclo';

  @override
  String get tapToAddEntry => 'Toca para añadir registro';

  @override
  String get mucusShort => 'Moco';

  @override
  String get legendPeriodInfertile => 'Infértil (regla)';

  @override
  String get legendPeriod => 'Regla';

  @override
  String get legendPotFertile => 'Pot. fértil';

  @override
  String get legendPhase1 => 'Fase 1';

  @override
  String get legendInfertileConfirmed => 'Infértil (confirmado)';

  @override
  String get legendPostOv => 'Posovulación';

  @override
  String get periodStartHelp => '¿Cuándo empezó tu regla?';

  @override
  String get newCycleTitle => 'Iniciar nuevo ciclo';

  @override
  String newCycleStarting(String date) {
    return 'Empieza el $date';
  }

  @override
  String get newCycleWillClose => 'El ciclo actual se cerrará.';

  @override
  String get bleedingTodayQ => '¿Cómo es tu sangrado hoy?';

  @override
  String bleedingOnDayQ(String date) {
    return '¿Cómo fue tu sangrado el $date?';
  }

  @override
  String get startCycle => 'Iniciar ciclo';

  @override
  String get stmRuleTitle => 'Regla del método';

  @override
  String get gotIt => 'Entendido';

  @override
  String get statusPotentiallyFertile => 'Pot. fértil';

  @override
  String get statusInfertilePreOv => 'Infértil (preovulación)';

  @override
  String get statusFertile => 'Fértil';

  @override
  String get statusFertileAwaitingMucus =>
      'Fértil (cambio térmico ✓, falta moco)';

  @override
  String get statusFertileAwaitingTemp => 'Fértil (día cúspide ✓, falta temp.)';

  @override
  String get statusFertileAwaitingCheck => 'Fértil (falta doble confirmación)';

  @override
  String get statusInfertile => 'Infértil';

  @override
  String get statusInfertilePostOv => 'Infértil (posovulación)';

  @override
  String get statusMenstruation => 'Menstruación';

  @override
  String statusInfertileDay(int day, int limit) {
    return 'Infértil (día $day/$limit)';
  }

  @override
  String get statusUnknown => 'Desconocido';

  @override
  String get chartNoData => 'Aún no hay datos de la gráfica';

  @override
  String get chartNoDataSub =>
      'Inicia un nuevo ciclo y registra tu temperatura diaria para ver la gráfica.';

  @override
  String get chartNoTempData => 'Aún no hay datos de temperatura.';

  @override
  String get coverlineLabel => 'Línea base';

  @override
  String get chartCycleDayAxis => 'Día del ciclo';

  @override
  String get peakShort => 'Cúspide';

  @override
  String peakDayLine(int day) {
    return 'Día cúspide: día del ciclo $day';
  }

  @override
  String mucusDayTooltip(int day, String mucus) {
    return 'Día $day: $mucus';
  }

  @override
  String chartTempTooltip(int day, String temp, String unit) {
    return 'Día $day\n$temp$unit';
  }

  @override
  String get stmEvaluation => 'Evaluación del método';

  @override
  String get evalNotDetermined => 'Aún no determinada';

  @override
  String get evalTempShift => 'Cambio térmico';

  @override
  String evalConfirmedDay(int day) {
    return 'Confirmado día $day';
  }

  @override
  String get evalNotConfirmed => 'Aún no confirmado';

  @override
  String get evalPeakDay => 'Día cúspide';

  @override
  String evalDayValue(int day) {
    return 'Día $day';
  }

  @override
  String get evalNotIdentified => 'Aún no identificado';

  @override
  String get evalInfertileFrom => 'Infértil desde';

  @override
  String get coverlineDialogTitle => 'Establecer línea base';

  @override
  String get coverlineDialogBody =>
      'Introduce la temperatura de la línea base manualmente o usa la detección automática.';

  @override
  String coverlineFieldLabel(String unit) {
    return 'Línea base ($unit)';
  }

  @override
  String get auto => 'Auto';

  @override
  String get set => 'Establecer';

  @override
  String get statsNoInsights => 'Aún no hay estadísticas';

  @override
  String get statsNoInsightsSub =>
      'Completa al menos un ciclo para ver tus estadísticas.';

  @override
  String get cycleLengthHistory => 'Historial de duración del ciclo';

  @override
  String get allCycles => 'Todos los ciclos';

  @override
  String daysUntilPeriod(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days días hasta la regla prevista',
      one: '1 día hasta la regla prevista',
    );
    return '$_temp0';
  }

  @override
  String periodExpectedIn(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Regla prevista en $days días',
      one: 'Regla prevista en 1 día',
    );
    return '$_temp0';
  }

  @override
  String get periodExpectedToday => 'Regla prevista para hoy';

  @override
  String daysPastExpected(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days días de retraso sobre lo previsto',
      one: '1 día de retraso sobre lo previsto',
    );
    return '$_temp0';
  }

  @override
  String predictionEst(String date, String avg) {
    return 'Aprox. $date (según ciclo medio de $avg días)';
  }

  @override
  String get regVeryRegular => 'Muy regular';

  @override
  String get regRegular => 'Regular';

  @override
  String get regSomewhat => 'Algo irregular';

  @override
  String get regIrregular => 'Irregular';

  @override
  String get regNotEnough => 'Datos insuficientes';

  @override
  String get crossCycleInsights => 'Análisis entre ciclos';

  @override
  String get insightRegularity => 'Regularidad';

  @override
  String get insightVariation => 'Variación';

  @override
  String variationDays(String value) {
    return '±$value días';
  }

  @override
  String get insightAvgShift => 'Cambio térmico medio';

  @override
  String get insightCyclesRecorded => 'Ciclos registrados';

  @override
  String cyclesCompleted(int count) {
    return '$count completados';
  }

  @override
  String moreCyclesNeeded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Faltan $count ciclos para las reglas avanzadas (menos-20, menos-8)',
      one: 'Falta 1 ciclo para las reglas avanzadas (menos-20, menos-8)',
    );
    return '$_temp0';
  }

  @override
  String get statTotalCycles => 'Ciclos totales';

  @override
  String get statAvgLength => 'Duración media';

  @override
  String get statShortest => 'Más corto';

  @override
  String get statLongest => 'Más largo';

  @override
  String daysUnit(String value) {
    return '$value días';
  }

  @override
  String chartAvg(String value) {
    return 'Media: $value';
  }

  @override
  String currentCycleDay(int day) {
    return 'Ciclo actual · día $day';
  }

  @override
  String get active => 'Activo';

  @override
  String get deleteCycleTooltip => 'Eliminar ciclo';

  @override
  String get deleteCycleTitle => '¿Eliminar ciclo?';

  @override
  String deleteCycleBody(String date) {
    return '¿Eliminar el ciclo que empieza el $date?\n\nTodos los registros de este ciclo también se eliminarán. Esto no se puede deshacer.';
  }

  @override
  String get cycleDeleted => 'Ciclo eliminado';
}
