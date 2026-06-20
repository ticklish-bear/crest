// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Hoje';

  @override
  String get navChart => 'Gráfico';

  @override
  String get navInsights => 'Estatísticas';

  @override
  String get navLearn => 'Aprender';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get supportTitle => 'Apoiar o Ember';

  @override
  String get supportHeadline => 'O Ember é grátis — e continua assim';

  @override
  String get supportBody =>
      'Sem assinaturas, sem anúncios, sem rastreamento. Todos os recursos estão disponíveis para todos. É desenvolvido e mantido no meu tempo livre.\n\nSe o Ember é útil para você e quiser apoiar o desenvolvimento, pode deixar uma pequena contribuição. É totalmente opcional e não desbloqueia nada — você já tem o app completo.';

  @override
  String get supportButton => 'Pague-me um café';

  @override
  String get supportFootnote =>
      'Abre no seu navegador. O Ember nunca vê os seus dados de pagamento.';

  @override
  String get supportLinkError => 'Não foi possível abrir o link';

  @override
  String get settingsGoal => 'Objetivo';

  @override
  String get settingsUseFor => 'Uso o método para';

  @override
  String get purposeAvoiding => 'Evitar';

  @override
  String get purposeAchieving => 'Buscar';

  @override
  String get purposeAvoidingDesc =>
      'Os rótulos refletem uma abordagem cautelosa: apenas as fases confirmadas são marcadas como inférteis.';

  @override
  String get purposeAchievingDesc =>
      'Os rótulos usam a terminologia padrão do método para identificar a janela fértil.';

  @override
  String get settingsTracking => 'Registro';

  @override
  String get settingsTempUnit => 'Unidade de temperatura';

  @override
  String get settingsRuleset => 'Regras do método';

  @override
  String get settingsCervix => 'Registrar colo do útero';

  @override
  String get settingsCervixSub => 'Posição, abertura e firmeza';

  @override
  String get settingsIntercourse => 'Registrar relações';

  @override
  String get settingsOpenEntryVia => 'Abrir o registro do dia com';

  @override
  String get tapLongPress => 'Pressionar e segurar';

  @override
  String get tapDoubleTap => 'Toque duplo';

  @override
  String get settingsAutoDetection => 'Detecção automática';

  @override
  String get settingsAutoCoverline => 'Linha de base automática';

  @override
  String get settingsAutoCoverlineSub => 'Regra 3 sobre 6';

  @override
  String get settingsAutoPeak => 'Dia ápice automático';

  @override
  String get settingsAutoPeakSub => 'A partir do padrão do muco';

  @override
  String get settingsReminders => 'Lembretes';

  @override
  String get settingsDailyReminder => 'Lembrete diário';

  @override
  String get settingsDailyReminderSub =>
      'Uma notificação por dia para registrar temperatura e muco.';

  @override
  String get settingsReminderTime => 'Horário do lembrete';

  @override
  String get settingsData => 'Dados';

  @override
  String get settingsExport => 'Exportar dados (CSV)';

  @override
  String get settingsExportSub => 'Salvar todos os dados como CSV';

  @override
  String get settingsImport => 'Importar dados (CSV)';

  @override
  String get settingsImportSub => 'Importar formato CSV do Ember';

  @override
  String get settingsImportKindara => 'Importar do Kindara';

  @override
  String get settingsImportKindaraSub =>
      'Importar arquivo de exportação do Kindara';

  @override
  String get settingsDeleteAll => 'Excluir todos os dados';

  @override
  String get settingsDeleteAllSub => 'Isto não pode ser desfeito';

  @override
  String get settingsAbout => 'Sobre';

  @override
  String get settingsPrivacy => 'Privacidade';

  @override
  String get settingsPrivacySub =>
      'Todos os dados são salvos localmente. Não é necessária conta.';

  @override
  String get settingsAboutStm => 'Sobre o método';

  @override
  String get settingsAboutStmSub =>
      'Compatível com o método sintotérmico. App independente, não afiliado a nenhuma organização.';

  @override
  String get settingsSupport => 'Apoiar';

  @override
  String get settingsSupportDev => 'Apoiar o desenvolvimento';

  @override
  String get settingsSupportDevSub =>
      'O Ember é grátis. Pague um café se quiser — opcional.';

  @override
  String get exportCompleteTitle => 'Exportação concluída';

  @override
  String exportCompleteBody(String path) {
    return 'Arquivo salvo em:\n$path\n\nDeseja compartilhá-lo?';
  }

  @override
  String get close => 'Fechar';

  @override
  String get share => 'Compartilhar';

  @override
  String exportFailed(String error) {
    return 'Falha na exportação: $error';
  }

  @override
  String importedEntries(int count) {
    return '$count registros importados';
  }

  @override
  String importFailed(String error) {
    return 'Falha na importação: $error';
  }

  @override
  String importedKindara(int count) {
    return '$count registros do Kindara importados';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Falha ao importar do Kindara: $error';
  }

  @override
  String get deleteAllTitle => 'Excluir todos os dados?';

  @override
  String get deleteAllBody =>
      'Isto excluirá permanentemente todos os seus ciclos e registros. Considere exportar seus dados primeiro.\n\nEsta ação não pode ser desfeita.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteEverything => 'Excluir tudo';

  @override
  String get allDataDeleted => 'Todos os dados excluídos';

  @override
  String cycleDayLabel(int day) {
    return 'Dia do ciclo $day';
  }

  @override
  String get deleteEntryTooltip => 'Excluir registro';

  @override
  String get sectionTemperature => 'Temperatura';

  @override
  String bbtLabel(String unit) {
    return 'TBC ($unit)';
  }

  @override
  String get fieldTime => 'Hora';

  @override
  String get disturbanceFactorsLabel => 'Fatores de perturbação';

  @override
  String get disturbanceHelp =>
      'Algo incomum afetou sua temperatura? Os valores marcados aparecem no gráfico, mas são excluídos do cálculo da linha de base.';

  @override
  String get distIllness => 'Doença';

  @override
  String get distPoorSleep => 'Sono ruim';

  @override
  String get distAlcohol => 'Álcool';

  @override
  String get distLateMeasurement => 'Medição tardia';

  @override
  String get distStress => 'Estresse';

  @override
  String get distTravel => 'Viagem';

  @override
  String get distMedication => 'Medicação';

  @override
  String get additionalDetails => 'Detalhes adicionais (opcional)';

  @override
  String get additionalDetailsHint => 'ex.: acordei 2 h mais tarde';

  @override
  String get sectionMucus => 'Muco cervical';

  @override
  String get mucusSensation => 'Sensação';

  @override
  String get mucusAppearanceLabel => 'Aparência';

  @override
  String get mucusDry => 'Seco';

  @override
  String get mucusNothing => 'Nada';

  @override
  String get mucusMoist => 'Úmido';

  @override
  String get mucusWet => 'Molhado';

  @override
  String get mucusSlippery => 'Escorregadio';

  @override
  String get mucusEggWhite => 'Clara de ovo';

  @override
  String get mucusNotRecorded => 'Não registrado';

  @override
  String get appNone => 'Nenhuma';

  @override
  String get appCloudy => 'Turvo';

  @override
  String get appYellowish => 'Amarelado';

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
  String get sectionBleeding => 'Sangramento';

  @override
  String get bleedNone => 'Nenhum';

  @override
  String get bleedSpotting => 'Escape';

  @override
  String get bleedLight => 'Leve';

  @override
  String get bleedMedium => 'Médio';

  @override
  String get bleedHeavy => 'Intenso';

  @override
  String get sectionCervix => 'Colo do útero';

  @override
  String get cervixPositionLabel => 'Posição';

  @override
  String get cervixOpennessLabel => 'Abertura';

  @override
  String get cervixFirmnessLabel => 'Firmeza';

  @override
  String get posLow => 'Baixo';

  @override
  String get posMedium => 'Médio';

  @override
  String get posHigh => 'Alto';

  @override
  String get openClosed => 'Fechado';

  @override
  String get openPartially => 'Parcialmente aberto';

  @override
  String get openOpen => 'Aberto';

  @override
  String get firmFirm => 'Firme';

  @override
  String get firmMedium => 'Médio';

  @override
  String get firmSoft => 'Macio';

  @override
  String get sectionAdditional => 'Adicional';

  @override
  String get fieldIntercourse => 'Relações';

  @override
  String get markPeakDay => 'Marcar como dia ápice';

  @override
  String get markPeakDaySub => 'Último dia do melhor muco antes de secar';

  @override
  String get sectionNotes => 'Notas';

  @override
  String get notesHint => 'Outras observações...';

  @override
  String get saveEntry => 'Salvar registro';

  @override
  String get couldNotLoad => 'Não foi possível carregar o registro';

  @override
  String get goBack => 'Voltar';

  @override
  String get unsavedTitle => 'Alterações não salvas';

  @override
  String get unsavedBody =>
      'Você tem alterações não salvas. Deseja descartá-las?';

  @override
  String get keepEditing => 'Continuar editando';

  @override
  String get discard => 'Descartar';

  @override
  String get invalidNumber => 'Digite um número válido';

  @override
  String get rangeCelsius => 'Faixa esperada: 35,00 - 39,00 °C';

  @override
  String get rangeFahrenheit => 'Faixa esperada: 95,00 - 102,20 °F';

  @override
  String get deleteEntryTitle => 'Excluir registro?';

  @override
  String deleteEntryBody(String date, int day) {
    return 'Excluir o registro de $date (dia do ciclo $day)?\n\nIsto não pode ser desfeito.';
  }

  @override
  String get delete => 'Excluir';

  @override
  String get entryDeleted => 'Registro excluído';

  @override
  String get entrySaved => 'Registro salvo';

  @override
  String get logTodayTitle => 'Registrar hoje';

  @override
  String get logTodaySub => 'Temperatura, muco, sangramento';

  @override
  String get noActiveCycle => 'Nenhum ciclo ativo';

  @override
  String get noActiveCycleSub => 'Comece a registrar para ver sua fertilidade';

  @override
  String get start => 'Iniciar';

  @override
  String cycleDayBadge(int day) {
    return 'Dia $day';
  }

  @override
  String cycleStarted(String date) {
    return 'Iniciado em $date';
  }

  @override
  String get startNewCycleTooltip => 'Iniciar novo ciclo';

  @override
  String get tapToAddEntry => 'Toque para adicionar registro';

  @override
  String get mucusShort => 'Muco';

  @override
  String get legendPeriodInfertile => 'Infértil (menstruação)';

  @override
  String get legendPeriod => 'Menstruação';

  @override
  String get legendPotFertile => 'Pot. fértil';

  @override
  String get legendPhase1 => 'Fase 1';

  @override
  String get legendInfertileConfirmed => 'Infértil (confirmado)';

  @override
  String get legendPostOv => 'Pós-ovulação';

  @override
  String get periodStartHelp => 'Quando sua menstruação começou?';

  @override
  String get newCycleTitle => 'Iniciar novo ciclo';

  @override
  String newCycleStarting(String date) {
    return 'Início em $date';
  }

  @override
  String get newCycleWillClose => 'O ciclo atual será encerrado.';

  @override
  String get bleedingTodayQ => 'Como está seu sangramento hoje?';

  @override
  String bleedingOnDayQ(String date) {
    return 'Como foi seu sangramento em $date?';
  }

  @override
  String get startCycle => 'Iniciar ciclo';

  @override
  String get stmRuleTitle => 'Regra do método';

  @override
  String get gotIt => 'Entendi';

  @override
  String get statusPotentiallyFertile => 'Pot. fértil';

  @override
  String get statusInfertilePreOv => 'Infértil (pré-ovulação)';

  @override
  String get statusFertile => 'Fértil';

  @override
  String get statusFertileAwaitingMucus =>
      'Fértil (mudança térmica ✓, falta muco)';

  @override
  String get statusFertileAwaitingTemp => 'Fértil (dia ápice ✓, falta temp.)';

  @override
  String get statusFertileAwaitingCheck =>
      'Fértil (dupla confirmação pendente)';

  @override
  String get statusInfertile => 'Infértil';

  @override
  String get statusInfertilePostOv => 'Infértil (pós-ovulação)';

  @override
  String get statusMenstruation => 'Menstruação';

  @override
  String statusInfertileDay(int day, int limit) {
    return 'Infértil (dia $day/$limit)';
  }

  @override
  String get statusUnknown => 'Desconhecido';
}
