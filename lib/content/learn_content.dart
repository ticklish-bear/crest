import 'package:flutter/material.dart';

/// Locale-specific educational content for the Learn screen.
///
/// The long-form method prose lives here as data (not in ARB), keyed by
/// language, so each locale can be translated and reviewed as a coherent body
/// of text. Widgets render whichever language matches the device locale,
/// falling back to English.
class TopicContent {
  final IconData icon;
  final String title;
  final String summary;
  final String body;
  final String? reference;

  const TopicContent({
    required this.icon,
    required this.title,
    required this.summary,
    required this.body,
    this.reference,
  });
}

/// Method-tab topics for the given language code (falls back to English).
List<TopicContent> methodTopics(String lang) {
  switch (lang) {
    case 'de':
      return _methodTopicsDe;
    case 'es':
      return _methodTopicsEs;
    default:
      return _methodTopicsEn;
  }
}

/// A single FAQ question/answer pair.
class FaqEntry {
  final String question;
  final String answer;
  const FaqEntry({required this.question, required this.answer});
}

/// A labelled group of FAQ entries.
class FaqSection {
  final String label;
  final List<FaqEntry> items;
  const FaqSection({required this.label, required this.items});
}

/// FAQ-tab sections for the given language code (falls back to English).
List<FaqSection> faqSections(String lang) {
  switch (lang) {
    case 'de':
      return _faqSectionsDe;
    case 'es':
      return _faqSectionsEs;
    default:
      return _faqSectionsEn;
  }
}

/// Translatable text for one mucus category (visual attributes — icon,
/// illustration, quality — are fixed in the widget and paired by order).
class MucusCategoryText {
  final String category;
  final String fertility;
  final String sensation;
  final String appearance;
  final String fingerTest;
  final String details;
  const MucusCategoryText({
    required this.category,
    required this.fertility,
    required this.sensation,
    required this.appearance,
    required this.fingerTest,
    required this.details,
  });
}

class SamplingMethodText {
  final String title;
  final String text;
  const SamplingMethodText({required this.title, required this.text});
}

class ProgressionRowText {
  final String phase;
  final String mucus;
  const ProgressionRowText({required this.phase, required this.mucus});
}

/// All translatable content of the Mucus Atlas tab.
class AtlasContent {
  final List<MucusCategoryText> categories; // 5, fixed order
  final String progressionTitle;
  final List<ProgressionRowText> progression; // 5
  final String progressionCaption;
  final String goodToKnowTitle;
  final String goodToKnowBody;
  final String samplingTitle;
  final String samplingIntro;
  final List<SamplingMethodText> samplingMethods; // 3
  final String samplingTip;
  const AtlasContent({
    required this.categories,
    required this.progressionTitle,
    required this.progression,
    required this.progressionCaption,
    required this.goodToKnowTitle,
    required this.goodToKnowBody,
    required this.samplingTitle,
    required this.samplingIntro,
    required this.samplingMethods,
    required this.samplingTip,
  });
}

/// Mucus Atlas content for the given language code (falls back to English).
AtlasContent atlasContent(String lang) {
  switch (lang) {
    case 'de':
      return _atlasDe;
    case 'es':
      return _atlasEs;
    default:
      return _atlasEn;
  }
}

const _methodTopicsEn = <TopicContent>[
  TopicContent(
    icon: Icons.auto_stories_outlined,
    title: 'What is the Symptothermal Method?',
    summary: 'A scientifically validated way to identify '
        'fertile and infertile days using two body signs.',
    body: 'The symptothermal method (STM) uses two independent '
        'biological markers — basal body temperature and cervical '
        'mucus — to identify the fertile and infertile phases '
        'of each menstrual cycle.\n\n'
        'Unlike calendar-based methods that predict from averages, '
        'STM observes your body\'s actual signals each cycle. '
        'A large study (Frank-Herrmann et al., 2007) found fewer '
        'than 1 in 200 women per year became pregnant when '
        'following the rules correctly.',
    reference: 'Frank-Herrmann P et al. (2007). '
        'Human Reproduction, 22(5), 1310–1319.',
  ),
  TopicContent(
    icon: Icons.loop,
    title: 'Your Menstrual Cycle',
    summary: 'How hormones drive the four phases of your cycle.',
    body: 'Your cycle is controlled by a feedback loop between '
        'your brain and ovaries. A typical cycle lasts 24–35 days, '
        'but variation is normal.\n\n'
        'The four phases:\n\n'
        '1. Menstruation (~days 1–5)\n'
        'The uterine lining sheds. Hormones are at their lowest.\n\n'
        '2. Follicular phase (variable length)\n'
        'Follicles mature in the ovaries. Rising estrogen '
        'stimulates fertile mucus and thickens the uterine '
        'lining. This phase varies in length — it\'s why '
        'cycles aren\'t always the same.\n\n'
        '3. Ovulation (~24 hours)\n'
        'An LH surge triggers the release of a mature egg. '
        'The egg survives 12–24 hours, but sperm can live up '
        'to 5 days in fertile mucus.\n\n'
        '4. Luteal phase (~10–16 days)\n'
        'Progesterone rises, raising your temperature by 0.2–0.5°C '
        'and causing mucus to dry up. This phase is quite '
        'consistent from cycle to cycle.',
    reference: 'Reed BG, Carr BR (2018). '
        '"The Normal Menstrual Cycle and the Control of Ovulation." '
        'In: Endotext. PMID: 25905282.',
  ),
  TopicContent(
    icon: Icons.thermostat_outlined,
    title: 'Sign 1: Temperature',
    summary: 'How the "3-over-6" rule confirms ovulation.',
    body: 'Your basal body temperature (BBT) is your resting '
        'temperature, measured right after waking. After ovulation, '
        'progesterone causes it to rise by at least 0.2°C.\n\n'
        'The 3-over-6 rule:\n'
        '① Identify the 6 low temps before the suspected shift\n'
        '② The coverline = highest of those 6\n'
        '③ 3 consecutive temps must be above the coverline\n'
        '④ The 3rd must be ≥0.2°C above the coverline\n\n'
        'If ④ isn\'t met, wait for a 4th high temp (which '
        'doesn\'t need the 0.2°C margin).\n\n'
        'Tip: Measure at the same time each day (±30 min). '
        'Alcohol, illness, or poor sleep can disturb readings — '
        'mark those as "excluded."',
    reference: 'Colombo B, Masarotto G (2000). '
        'Demographic Research, 3(5).',
  ),
  TopicContent(
    icon: Icons.water_drop_outlined,
    title: 'Sign 2: Cervical Mucus',
    summary: 'How mucus changes reveal your fertile window.',
    body: 'Cervical mucus changes throughout the cycle in '
        'response to hormone levels. It\'s the primary sign '
        'that opens the fertile window.\n\n'
        'Observe both sensation (what you feel) and appearance '
        '(what you see). Record the highest quality of the day.\n\n'
        'Typical progression:\n'
        'Dry → Sticky/cloudy → Wet/creamy → Egg white/slippery '
        '→ Back to dry after ovulation\n\n'
        'The "Peak Day" is the last day of best-quality mucus '
        'before it drops. You identify it retrospectively.\n\n'
        'See the "Mucus Atlas" tab for a visual guide to each '
        'category.',
    reference: 'Bigelow JL et al. (2004). '
        'Human Reproduction, 19(4), 889–892.',
  ),
  TopicContent(
    icon: Icons.rule_outlined,
    title: 'The Rules: Pre-Ovulatory Phase',
    summary: 'Which days at the start of the cycle are infertile.',
    body: 'Calendar-based rules determine how many early days '
        'can be considered infertile. The most conservative '
        '(lowest) always applies:\n\n'
        '• 5-day rule (beginners, <12 cycles): '
        'Days 1–5 are infertile.\n\n'
        '• Rötzer 6-day rule: Days 1–6, but only if ALL '
        'recorded cycles were ≥26 days.\n\n'
        '• Minus-20 rule (12+ cycles): Shortest cycle ever '
        'minus 20 = last infertile day.\n\n'
        '• Minus-8 rule (12+ cycles): Earliest temperature '
        'rise day minus 8.\n\n'
        'Critical: Any fertile cervical mucus immediately '
        'overrides these calculations. Mucus always takes '
        'priority over calendar rules.',
  ),
  TopicContent(
    icon: Icons.check_circle_outline,
    title: 'The Rules: Post-Ovulatory Phase',
    summary: 'How the "double-check" confirms infertility.',
    body: 'Post-ovulatory infertility begins on the LATER of:\n\n'
        '• Evening of the 3rd day after Peak Day\n'
        '• Evening of the 3rd consecutive high temperature\n\n'
        'Both conditions must be met — this is the "double-check" '
        'principle that makes STM so reliable. If temperature '
        'confirms on day 17 but Peak Day + 3 is day 19, the '
        'infertile phase begins on day 19.\n\n'
        'This is the most reliable phase in the entire cycle.',
  ),
  TopicContent(
    icon: Icons.verified_outlined,
    title: 'How Reliable Is STM?',
    summary: '99.6% effective with correct use.',
    body: 'Method-use effectiveness: 99.6%\n'
        'Typical-use effectiveness: 98.2%\n'
        'Pearl Index (correct use): 0.4\n\n'
        'For comparison, the pill has a typical-use Pearl Index '
        'of 7–9, and condoms about 13–18.\n\n'
        'The key is correct observation and honest recording. '
        'This app supports you, but YOU interpret and apply '
        'the rules. Consider taking a certified course, '
        'especially when starting out.',
    reference: 'Frank-Herrmann P et al. (2007). Human Reproduction. '
        '\nManhart MD et al. (2013). Osteopathic Family Physician, 5(1).',
  ),
];

const _faqSectionsEn = <FaqSection>[
  FaqSection(label: 'Getting Started', items: [
    FaqEntry(
      question: 'How do I start using the method?',
      answer: 'Record your basal body temperature every morning '
          'before getting up, and observe your cervical mucus '
          'throughout the day. Log both daily. For the first few '
          'cycles, focus on learning your pattern.\n\n'
          'Reading "Taking Charge of Your Fertility" (Weschler) '
          'or taking a certified course is strongly recommended '
          'before relying on the method.',
    ),
    FaqEntry(
      question: 'When and how do I measure temperature?',
      answer: 'Measure immediately after waking, before getting '
          'up or talking. Use a basal thermometer with 0.01°C '
          'precision. Same time each day (±30 min).\n\n'
          'You can measure orally (5 min under tongue), vaginally '
          '(5 min), or rectally (3 min). Pick one method and '
          'stick with it within a cycle.',
    ),
    FaqEntry(
      question: 'What if I slept badly or drank alcohol?',
      answer: 'Mark the temperature as "excluded." Disturbed '
          'values shouldn\'t be used for evaluation. Common '
          'disturbances: alcohol, illness, poor sleep (<5 hrs), '
          'late/early waking, travel, stress.\n\n'
          'Better to exclude a questionable value than to get '
          'a false evaluation.',
    ),
  ]),
  FaqSection(label: 'Observing & Recording', items: [
    FaqEntry(
      question: 'How do I observe cervical mucus?',
      answer: 'Check each time you use the bathroom:\n\n'
          '1. Sensation — does it feel dry, moist, wet, or '
          'slippery?\n'
          '2. Appearance — check toilet paper for nothing, '
          'something cloudy, or something clear/stretchy.\n\n'
          'Record the highest quality you observed that day. '
          'See the "Mucus Atlas" tab for a visual guide.',
    ),
    FaqEntry(
      question: 'What is the "Peak Day"?',
      answer: 'The last day of best-quality mucus before it '
          'drops to a lower quality. You identify it '
          'retrospectively — when today is less fertile than '
          'yesterday, then yesterday was the Peak Day.\n\n'
          'It closely correlates with ovulation (±1–2 days).',
    ),
    FaqEntry(
      question: 'What does the 3-over-6 rule mean?',
      answer: '1. Find 6 low temps before the suspected shift\n'
          '2. Coverline = highest of those 6\n'
          '3. 3 consecutive temps must be above the coverline\n'
          '4. The 3rd must be ≥0.2°C above the coverline\n\n'
          'If condition 4 isn\'t met, wait for a 4th high temp.',
    ),
  ]),
  FaqSection(label: 'Safety & Rules', items: [
    FaqEntry(
      question: 'Are the first days really infertile?',
      answer: 'For beginners (<12 cycles), the first 5 days are '
          'infertile — provided there is no fertile mucus. After '
          '12+ cycles, the app uses your history for a personalized '
          'calculation.\n\n'
          'Any fertile mucus observation immediately overrides '
          'the calendar rule — even on day 3.',
    ),
    FaqEntry(
      question: 'Can I use STM with irregular cycles?',
      answer: 'Yes. STM observes real signals rather than '
          'predicting, so it works well with irregular cycles. '
          'The pre-ovulatory safe days may be fewer, but the '
          'post-ovulatory phase remains reliable.\n\n'
          'Very irregular cycles may warrant medical investigation.',
    ),
    FaqEntry(
      question: 'What about breastfeeding or postpartum?',
      answer: 'STM can be adapted, but the rules are more '
          'complex. Work with a trained counselor during this '
          'time. Standard app calculations assume established '
          'cycling.',
    ),
    FaqEntry(
      question: 'How is STM different from the calendar method?',
      answer: 'The calendar method predicts from past averages '
          '(Pearl Index ~15–25). STM observes actual biological '
          'signals in the current cycle (Pearl Index 0.4).\n\n'
          'This app uses calendar calculations only as a '
          'secondary tool — mucus always takes priority.',
    ),
  ]),
  FaqSection(label: 'Using the App', items: [
    FaqEntry(
      question: 'What does "avoiding" vs "achieving" mode mean?',
      answer: 'It changes how labels appear:\n\n'
          '• Avoiding: Conservative labels. Pre-ovulatory days '
          'say "potentially fertile" since ovulation isn\'t '
          'confirmed yet.\n\n'
          '• Achieving: Standard STM labels. The fertile window '
          'is highlighted for timing.\n\n'
          'The underlying evaluation is identical.',
    ),
    FaqEntry(
      question: 'Should I trust the app blindly?',
      answer: 'No. This is a charting tool, not a medical device. '
          'You should learn the rules and verify the evaluation '
          'makes sense. Use manual overrides (coverline, Peak Day) '
          'if needed.\n\n'
          'Tap the ℹ icon next to any label to see which rule '
          'was applied and why.',
    ),
  ]),
];

const _faqSectionsDe = <FaqSection>[
  FaqSection(label: 'Erste Schritte', items: [
    FaqEntry(
      question: 'Wie fange ich mit der Methode an?',
      answer: 'Miss jeden Morgen vor dem Aufstehen deine '
          'Basaltemperatur und beobachte tagsüber deinen '
          'Zervixschleim. Trage beides täglich ein. Konzentriere '
          'dich in den ersten Zyklen darauf, dein Muster '
          'kennenzulernen.\n\n'
          'Es wird dringend empfohlen, „Natürlich und sicher" '
          '(AG NFP) oder „Taking Charge of Your Fertility" '
          '(Weschler) zu lesen oder einen zertifizierten Kurs zu '
          'besuchen, bevor du dich auf die Methode verlässt.',
    ),
    FaqEntry(
      question: 'Wann und wie messe ich die Temperatur?',
      answer: 'Miss direkt nach dem Aufwachen, bevor du aufstehst '
          'oder sprichst. Verwende ein Basalthermometer mit '
          '0,01 °C Genauigkeit. Jeden Tag zur selben Zeit '
          '(±30 Min.).\n\n'
          'Du kannst oral (5 Min. unter der Zunge), vaginal '
          '(5 Min.) oder rektal (3 Min.) messen. Wähle eine '
          'Methode und bleibe innerhalb eines Zyklus dabei.',
    ),
    FaqEntry(
      question: 'Was, wenn ich schlecht geschlafen oder Alkohol '
          'getrunken habe?',
      answer: 'Markiere die Temperatur als „ausgeschlossen". '
          'Gestörte Werte sollten nicht zur Auswertung verwendet '
          'werden. Häufige Störungen: Alkohol, Krankheit, '
          'schlechter Schlaf (< 5 Std.), spätes/frühes Aufwachen, '
          'Reisen, Stress.\n\n'
          'Besser einen fraglichen Wert ausschließen als eine '
          'falsche Auswertung erhalten.',
    ),
  ]),
  FaqSection(label: 'Beobachten & Aufzeichnen', items: [
    FaqEntry(
      question: 'Wie beobachte ich den Zervixschleim?',
      answer: 'Prüfe jedes Mal, wenn du auf der Toilette bist:\n\n'
          '1. Empfinden – fühlt es sich trocken, feucht, nass '
          'oder glitschig an?\n'
          '2. Aussehen – prüfe das Toilettenpapier auf nichts, '
          'etwas Trübes oder etwas Klares/Spinnbares.\n\n'
          'Notiere die höchste Qualität, die du an dem Tag '
          'beobachtet hast. Im Tab „Schleim-Atlas" findest du '
          'einen visuellen Leitfaden.',
    ),
    FaqEntry(
      question: 'Was ist der „Höhepunkt"?',
      answer: 'Der letzte Tag mit bester Schleimqualität, bevor '
          'sie auf eine geringere Qualität abfällt. Du bestimmst '
          'ihn rückblickend – wenn heute weniger fruchtbar ist '
          'als gestern, dann war gestern der Höhepunkt.\n\n'
          'Er korreliert eng mit dem Eisprung (±1–2 Tage).',
    ),
    FaqEntry(
      question: 'Was bedeutet die 3-über-6-Regel?',
      answer: '1. Finde die 6 niedrigen Werte vor dem vermuteten '
          'Anstieg\n'
          '2. Hilfslinie = höchster dieser 6 Werte\n'
          '3. 3 aufeinanderfolgende Werte müssen über der '
          'Hilfslinie liegen\n'
          '4. Der 3. Wert muss ≥ 0,2 °C über der Hilfslinie '
          'liegen\n\n'
          'Wird Bedingung 4 nicht erfüllt, warte auf einen '
          '4. hohen Wert.',
    ),
  ]),
  FaqSection(label: 'Sicherheit & Regeln', items: [
    FaqEntry(
      question: 'Sind die ersten Tage wirklich unfruchtbar?',
      answer: 'Für Anfängerinnen (< 12 Zyklen) sind die ersten '
          '5 Tage unfruchtbar – vorausgesetzt, es zeigt sich kein '
          'fruchtbarer Schleim. Nach 12+ Zyklen nutzt die App '
          'deinen Verlauf für eine personalisierte Berechnung.\n\n'
          'Jede Beobachtung von fruchtbarem Schleim hebt die '
          'Kalenderregel sofort auf – auch an Tag 3.',
    ),
    FaqEntry(
      question: 'Kann ich die STM bei unregelmäßigen Zyklen nutzen?',
      answer: 'Ja. Die STM beobachtet echte Signale, statt '
          'vorherzusagen, daher funktioniert sie auch bei '
          'unregelmäßigen Zyklen gut. Die unfruchtbaren Tage vor '
          'dem Eisprung können weniger sein, aber die Phase nach '
          'dem Eisprung bleibt zuverlässig.\n\n'
          'Sehr unregelmäßige Zyklen können eine ärztliche '
          'Abklärung rechtfertigen.',
    ),
    FaqEntry(
      question: 'Was ist mit Stillzeit oder Wochenbett?',
      answer: 'Die STM lässt sich anpassen, aber die Regeln sind '
          'komplexer. Arbeite in dieser Zeit mit einer geschulten '
          'Beraterin. Die Standard-Berechnungen der App setzen '
          'einen eingependelten Zyklus voraus.',
    ),
    FaqEntry(
      question: 'Wie unterscheidet sich die STM von der '
          'Kalendermethode?',
      answer: 'Die Kalendermethode sagt aus vergangenen '
          'Durchschnittswerten vorher (Pearl-Index ~15–25). Die '
          'STM beobachtet die tatsächlichen biologischen Signale '
          'im aktuellen Zyklus (Pearl-Index 0,4).\n\n'
          'Diese App nutzt Kalenderberechnungen nur als '
          'sekundäres Hilfsmittel – Schleim hat immer Vorrang.',
    ),
  ]),
  FaqSection(label: 'Die App nutzen', items: [
    FaqEntry(
      question: 'Was bedeutet der Modus „Verhüten" vs. „Erfüllen"?',
      answer: 'Er ändert, wie die Bezeichnungen erscheinen:\n\n'
          '• Verhüten: Vorsichtige Bezeichnungen. Tage vor dem '
          'Eisprung heißen „evtl. fruchtbar", da der Eisprung '
          'noch nicht bestätigt ist.\n\n'
          '• Erfüllen: Übliche STM-Bezeichnungen. Das fruchtbare '
          'Fenster wird zur zeitlichen Planung hervorgehoben.\n\n'
          'Die zugrundeliegende Auswertung ist identisch.',
    ),
    FaqEntry(
      question: 'Sollte ich der App blind vertrauen?',
      answer: 'Nein. Dies ist ein Charting-Werkzeug, kein '
          'Medizinprodukt. Du solltest die Regeln lernen und '
          'prüfen, ob die Auswertung sinnvoll ist. Nutze bei '
          'Bedarf die manuellen Überschreibungen (Hilfslinie, '
          'Höhepunkt).\n\n'
          'Tippe auf das ℹ-Symbol neben einer Bezeichnung, um zu '
          'sehen, welche Regel angewendet wurde und warum.',
    ),
  ]),
];

const _methodTopicsDe = <TopicContent>[
  TopicContent(
    icon: Icons.auto_stories_outlined,
    title: 'Was ist die symptothermale Methode?',
    summary: 'Eine wissenschaftlich validierte Methode, fruchtbare und '
        'unfruchtbare Tage anhand zweier Körperzeichen zu bestimmen.',
    body: 'Die symptothermale Methode (STM) nutzt zwei unabhängige '
        'biologische Marker – die Basaltemperatur und den Zervixschleim –, '
        'um die fruchtbaren und unfruchtbaren Phasen jedes '
        'Menstruationszyklus zu bestimmen.\n\n'
        'Anders als kalenderbasierte Methoden, die aus Durchschnittswerten '
        'vorhersagen, beobachtet die STM die tatsächlichen Signale deines '
        'Körpers in jedem Zyklus. Eine große Studie (Frank-Herrmann et al., '
        '2007) fand, dass weniger als 1 von 200 Frauen pro Jahr schwanger '
        'wurde, wenn die Regeln korrekt angewendet wurden.',
    reference: 'Frank-Herrmann P et al. (2007). '
        'Human Reproduction, 22(5), 1310–1319.',
  ),
  TopicContent(
    icon: Icons.loop,
    title: 'Dein Menstruationszyklus',
    summary: 'Wie Hormone die vier Phasen deines Zyklus steuern.',
    body: 'Dein Zyklus wird durch einen Regelkreis zwischen Gehirn und '
        'Eierstöcken gesteuert. Ein typischer Zyklus dauert 24–35 Tage, '
        'aber Schwankungen sind normal.\n\n'
        'Die vier Phasen:\n\n'
        '1. Menstruation (~Tag 1–5)\n'
        'Die Gebärmutterschleimhaut wird abgestoßen. Die Hormone sind '
        'auf ihrem niedrigsten Stand.\n\n'
        '2. Follikelphase (variable Länge)\n'
        'In den Eierstöcken reifen Follikel heran. Steigendes Östrogen '
        'regt fruchtbaren Schleim an und baut die Gebärmutterschleimhaut '
        'auf. Diese Phase ist unterschiedlich lang – deshalb sind Zyklen '
        'nicht immer gleich.\n\n'
        '3. Eisprung (~24 Stunden)\n'
        'Ein LH-Anstieg löst die Freisetzung einer reifen Eizelle aus. '
        'Die Eizelle überlebt 12–24 Stunden, Spermien können in '
        'fruchtbarem Schleim aber bis zu 5 Tage überleben.\n\n'
        '4. Lutealphase (~10–16 Tage)\n'
        'Progesteron steigt, erhöht deine Temperatur um 0,2–0,5 °C und '
        'lässt den Schleim abtrocknen. Diese Phase ist von Zyklus zu '
        'Zyklus recht konstant.',
    reference: 'Reed BG, Carr BR (2018). '
        '"The Normal Menstrual Cycle and the Control of Ovulation." '
        'In: Endotext. PMID: 25905282.',
  ),
  TopicContent(
    icon: Icons.thermostat_outlined,
    title: 'Zeichen 1: Temperatur',
    summary: 'Wie die „3-über-6"-Regel den Eisprung bestätigt.',
    body: 'Deine Basaltemperatur (BBT) ist deine Ruhetemperatur, direkt '
        'nach dem Aufwachen gemessen. Nach dem Eisprung lässt Progesteron '
        'sie um mindestens 0,2 °C ansteigen.\n\n'
        'Die 3-über-6-Regel:\n'
        '① Bestimme die 6 niedrigen Werte vor dem vermuteten Anstieg\n'
        '② Die Hilfslinie = höchster dieser 6 Werte\n'
        '③ 3 aufeinanderfolgende Werte müssen über der Hilfslinie liegen\n'
        '④ Der 3. Wert muss ≥ 0,2 °C über der Hilfslinie liegen\n\n'
        'Wird ④ nicht erfüllt, warte auf einen 4. hohen Wert (der die '
        '0,2-°C-Marge nicht braucht).\n\n'
        'Tipp: Miss jeden Tag zur selben Zeit (±30 Min.). Alkohol, '
        'Krankheit oder schlechter Schlaf können Werte stören – '
        'markiere diese als „ausgeschlossen".',
    reference: 'Colombo B, Masarotto G (2000). '
        'Demographic Research, 3(5).',
  ),
  TopicContent(
    icon: Icons.water_drop_outlined,
    title: 'Zeichen 2: Zervixschleim',
    summary: 'Wie Schleimveränderungen dein fruchtbares Fenster zeigen.',
    body: 'Der Zervixschleim verändert sich im Lauf des Zyklus als '
        'Reaktion auf die Hormonspiegel. Er ist das wichtigste Zeichen, '
        'das das fruchtbare Fenster eröffnet.\n\n'
        'Beobachte sowohl das Empfinden (was du fühlst) als auch das '
        'Aussehen (was du siehst). Notiere die höchste Qualität des '
        'Tages.\n\n'
        'Typischer Verlauf:\n'
        'Trocken → klebrig/trüb → nass/cremig → spinnbar/glitschig '
        '→ nach dem Eisprung wieder trocken\n\n'
        'Der „Höhepunkt" ist der letzte Tag mit bester Schleimqualität, '
        'bevor sie nachlässt. Du bestimmst ihn rückblickend.\n\n'
        'Im Tab „Schleim-Atlas" findest du einen visuellen Leitfaden '
        'zu jeder Kategorie.',
    reference: 'Bigelow JL et al. (2004). '
        'Human Reproduction, 19(4), 889–892.',
  ),
  TopicContent(
    icon: Icons.rule_outlined,
    title: 'Die Regeln: Phase vor dem Eisprung',
    summary: 'Welche Tage am Zyklusbeginn unfruchtbar sind.',
    body: 'Kalenderbasierte Regeln bestimmen, wie viele frühe Tage als '
        'unfruchtbar gelten können. Die konservativste (niedrigste) gilt '
        'immer:\n\n'
        '• 5-Tage-Regel (Anfängerinnen, < 12 Zyklen): '
        'Tag 1–5 sind unfruchtbar.\n\n'
        '• Rötzer 6-Tage-Regel: Tag 1–6, aber nur wenn ALLE '
        'aufgezeichneten Zyklen ≥ 26 Tage lang waren.\n\n'
        '• Minus-20-Regel (12+ Zyklen): Kürzester je gemessener Zyklus '
        'minus 20 = letzter unfruchtbarer Tag.\n\n'
        '• Minus-8-Regel (12+ Zyklen): Frühester Tag des '
        'Temperaturanstiegs minus 8.\n\n'
        'Wichtig: Jeder fruchtbare Zervixschleim hebt diese Berechnungen '
        'sofort auf. Schleim hat immer Vorrang vor Kalenderregeln.',
  ),
  TopicContent(
    icon: Icons.check_circle_outline,
    title: 'Die Regeln: Phase nach dem Eisprung',
    summary: 'Wie die „Doppelte Kontrolle" Unfruchtbarkeit bestätigt.',
    body: 'Die Unfruchtbarkeit nach dem Eisprung beginnt am SPÄTEREN '
        'dieser beiden Zeitpunkte:\n\n'
        '• Abend des 3. Tages nach dem Höhepunkt\n'
        '• Abend der 3. aufeinanderfolgenden hohen Temperatur\n\n'
        'Beide Bedingungen müssen erfüllt sein – das ist das Prinzip der '
        '„Doppelten Kontrolle", das die STM so zuverlässig macht. '
        'Bestätigt die Temperatur an Tag 17, der Höhepunkt + 3 aber '
        'Tag 19, beginnt die unfruchtbare Phase an Tag 19.\n\n'
        'Dies ist die zuverlässigste Phase im ganzen Zyklus.',
  ),
  TopicContent(
    icon: Icons.verified_outlined,
    title: 'Wie zuverlässig ist die STM?',
    summary: '99,6 % wirksam bei korrekter Anwendung.',
    body: 'Methodensicherheit: 99,6 %\n'
        'Gebrauchssicherheit: 98,2 %\n'
        'Pearl-Index (korrekte Anwendung): 0,4\n\n'
        'Zum Vergleich: Die Pille hat einen Gebrauchs-Pearl-Index von '
        '7–9, Kondome etwa 13–18.\n\n'
        'Entscheidend sind korrekte Beobachtung und ehrliche Aufzeichnung. '
        'Diese App unterstützt dich, aber DU deutest und wendest die '
        'Regeln an. Erwäge einen zertifizierten Kurs, besonders am '
        'Anfang.',
    reference: 'Frank-Herrmann P et al. (2007). Human Reproduction. '
        '\nManhart MD et al. (2013). Osteopathic Family Physician, 5(1).',
  ),
];

const _atlasEn = AtlasContent(
  categories: [
    MucusCategoryText(
      category: 'Dry',
      fertility: 'Not fertile',
      sensation: 'Dry, rough, possibly itchy or slightly '
          'uncomfortable. The vaginal opening may feel '
          'sandpapery when you wipe.',
      appearance: 'Nothing visible on toilet paper or underwear. '
          'The tissue stays completely clean and dry when you '
          'wipe. There is no sheen or residue at all.',
      fingerTest: 'Nothing to test — your fingers remain '
          'completely dry with no residue.',
      details: 'This is typically observed in the days right after '
          'menstruation ends and again after ovulation throughout '
          'the luteal phase. Estrogen levels are at their lowest, '
          'so the cervix produces little to no secretion. In the '
          'STM classification, dry days during the pre-ovulatory '
          'phase (before any mucus has appeared) may still be '
          'considered infertile according to the calendar rules.\n\n'
          'Note: Some women rarely feel completely "dry" — if your '
          'baseline is more neutral, that\'s your personal pattern. '
          'What matters is recognizing when it CHANGES.',
    ),
    MucusCategoryText(
      category: 'Nothing felt, nothing seen',
      fertility: 'Not fertile',
      sensation: 'Neither dry nor moist — a neutral feeling. '
          'You don\'t particularly notice anything, no '
          'discomfort, no wetness.',
      appearance: 'No visible mucus on toilet paper. No stains '
          'on underwear. The tissue may have a very slight '
          'sheen but nothing you can pick up or examine.',
      fingerTest: 'Nothing to pick up or test between your '
          'fingers. The area feels neutral to touch.',
      details: 'This is a transitional category that sits between '
          '"dry" and "moist." Some women experience this as their '
          'baseline rather than complete dryness — especially '
          'women who naturally have slightly more moisture. '
          'This is perfectly normal.\n\n'
          'The key with this category is to pay close attention '
          'to whether it transitions to "moist" or "wet" — that '
          'shift, even if subtle, signals rising estrogen and '
          'the potential opening of the fertile window.',
    ),
    MucusCategoryText(
      category: 'Moist / Sticky',
      fertility: 'Possibly fertile',
      sensation: 'Slightly moist or damp feeling at the vaginal '
          'opening. You notice something is there, but it '
          'doesn\'t feel slick or lubricative.',
      appearance: 'Thick, white, cloudy, or yellowish. May look '
          'pasty, crumbly, or gummy. Stays in a blob or lump. '
          'Can resemble white school glue or thick hand cream '
          'that has started to dry.',
      fingerTest: 'Breaks immediately when pulled apart, or '
          'stretches less than 1 cm before snapping. '
          'Feels tacky, sticky, or crumbly between your '
          'thumb and forefinger — like dried paste.',
      details: 'The cervix is beginning to respond to rising '
          'estrogen levels. This mucus provides limited sperm '
          'survival (hours rather than days), but it signals '
          'that the body is transitioning toward fertility.\n\n'
          'In the STM classification, this is the boundary zone. '
          'If you are using the method to avoid pregnancy, the '
          'first appearance of this mucus after dry days should '
          'be treated as the start of the fertile window — even '
          'if the calendar calculation says you\'re still in the '
          'infertile phase. Mucus always takes priority over '
          'calendar rules.\n\n'
          'This type of mucus forms a mesh-like structure under '
          'the microscope that partially blocks sperm passage.',
    ),
    MucusCategoryText(
      category: 'Wet / Creamy',
      fertility: 'Fertile',
      sensation: 'Wet, smooth, or slick feeling. You may '
          'notice moisture when you walk or sit down. '
          'There\'s a clear sense of lubrication, though '
          'not as intense as the egg white phase.',
      appearance: 'White to slightly cloudy, with a creamy, '
          'lotion-like consistency. More fluid than the sticky '
          'phase. May leave noticeable wet spots on underwear. '
          'Can look like body lotion, yogurt, or thin '
          'hand cream.',
      fingerTest: 'Stretches 1–2 cm before breaking. Feels '
          'smooth and creamy between your fingers — like '
          'hand lotion or moisturizer. Not yet forming '
          'the elastic threads of egg white mucus.',
      details: 'Estrogen levels are now significantly elevated, '
          'signaling that ovulation is approaching (usually '
          'within a few days). The mucus is becoming hospitable '
          'to sperm — providing nutrients, alkaline pH to '
          'counteract the vagina\'s acidity, and channels '
          'that facilitate sperm transport toward the egg.\n\n'
          'Sperm can survive 3–5 days in this type of mucus, '
          'which is why the fertile window extends well before '
          'ovulation itself. This marks the clearly fertile '
          'phase of the cycle.\n\n'
          'Under a microscope, this mucus shows a more open, '
          'channel-like structure compared to the mesh of '
          'sticky mucus, actively guiding sperm upward.',
    ),
    MucusCategoryText(
      category: 'Egg white / Slippery',
      fertility: 'Highly fertile',
      sensation: 'Very slippery, lubricative — like soap, oil, '
          'or sliding on a wet surface. You may notice it '
          'when walking, sitting, or even without wiping. '
          'Some describe it as a "gushing" sensation.',
      appearance: 'Clear, transparent, or slightly streaked '
          'with white. Highly fluid, glassy, and stretchy. '
          'Resembles raw egg white — you can often see '
          'long, thin strings on the toilet paper. May be '
          'watery-clear with no cloudiness at all.',
      fingerTest: 'Stretches 3–10+ cm without breaking, forming '
          'thin, elastic, glistening threads between thumb and '
          'forefinger. The longer and thinner the thread, the '
          'more fertile. Feels extremely slippery — your '
          'fingers almost glide past each other.',
      details: 'This is the most fertile mucus, indicating peak '
          'estrogen levels and that ovulation is imminent or '
          'happening right now. Sperm can survive up to 5 days '
          'in this mucus, and it actively facilitates their '
          'transport to the egg.\n\n'
          'The LAST day you observe this peak-quality mucus is '
          'your "Peak Day" — one of the two key markers in STM. '
          'You can only identify the Peak Day retrospectively: '
          'when you notice that today\'s mucus is drier or less '
          'stretchy than yesterday, then yesterday was the Peak '
          'Day.\n\n'
          'Not everyone produces large amounts — some women '
          'only see a small amount of stretchy mucus. The '
          'quality (stretchiness, clarity, slipperiness) matters '
          'more than the quantity. Even a small amount of true '
          'egg-white mucus is a strong fertility sign.\n\n'
          'Under a microscope, this mucus shows wide-open, '
          'parallel channels — essentially a highway system '
          'for sperm. It also shows a characteristic "ferning" '
          'pattern when dried on a glass slide.',
    ),
  ],
  progressionTitle: 'Typical Progression',
  progression: [
    ProgressionRowText(phase: 'After period', mucus: 'Dry'),
    ProgressionRowText(phase: 'Early follicular', mucus: 'Sticky/cloudy'),
    ProgressionRowText(phase: 'Near ovulation', mucus: 'Wet/creamy'),
    ProgressionRowText(phase: 'Peak fertility', mucus: 'Egg white'),
    ProgressionRowText(phase: 'After ovulation', mucus: 'Back to dry'),
  ],
  progressionCaption: 'The abrupt change from egg white back to '
      'dry/sticky marks the Peak Day (identified the next day).',
  goodToKnowTitle: 'Good to know',
  goodToKnowBody: '• Focus on the change in pattern, not matching a '
      'textbook description exactly.\n'
      '• Arousal fluid is different — watery, disappears '
      'quickly, doesn\'t stretch.\n'
      '• Semen can mask observations for 12–24 hours.\n'
      '• Some medications may reduce mucus production.',
  samplingTitle: 'How to observe & collect a sample',
  samplingIntro: 'There are three ways to check your cervical mucus. '
      'Use whichever feels most comfortable — what matters '
      'is that you do it consistently.',
  samplingMethods: [
    SamplingMethodText(
      title: 'Toilet paper method',
      text: 'Before urinating, wipe the vaginal opening from '
          'front to back with white, unscented toilet paper. '
          'Look at the tissue: is there anything on it? '
          'Note the color, consistency, and how it feels '
          'while wiping (dry, smooth, slippery?).',
    ),
    SamplingMethodText(
      title: 'Finger method',
      text: 'With clean hands, insert your index or middle '
          'finger into the vagina (about 2–3 cm is enough). '
          'Gently sweep around the cervical opening. Remove '
          'your finger and examine what\'s on it. Then do '
          'the finger test: press the mucus between your '
          'thumb and forefinger and slowly pull apart. '
          'Note how far it stretches before breaking.',
    ),
    SamplingMethodText(
      title: 'Underwear check',
      text: 'Look at your underwear throughout the day. '
          'Cervical mucus often leaves visible marks — '
          'note whether the spot is dry, creamy, wet, '
          'or shows clear stretchy residue.',
    ),
  ],
  samplingTip: 'Always record the HIGHEST quality you observed '
      'during the day. If you saw sticky mucus in the '
      'morning but egg white in the afternoon, record '
      'egg white.\n\n'
      'Check several times per day — mucus can change '
      'throughout the day. Pay extra attention to the '
      'sensation: the slippery/lubricative feeling is '
      'often the most reliable indicator, even when '
      'you can\'t see much.',
);

const _atlasDe = AtlasContent(
  categories: [
    MucusCategoryText(
      category: 'Trocken',
      fertility: 'Nicht fruchtbar',
      sensation: 'Trocken, rau, evtl. juckend oder leicht '
          'unangenehm. Der Scheideneingang kann sich beim '
          'Abwischen wie Schmirgelpapier anfühlen.',
      appearance: 'Nichts auf Toilettenpapier oder Unterwäsche '
          'sichtbar. Das Papier bleibt beim Abwischen völlig '
          'sauber und trocken. Kein Glanz, kein Rückstand.',
      fingerTest: 'Nichts zu testen – deine Finger bleiben '
          'völlig trocken, ohne Rückstand.',
      details: 'Dies wird typischerweise in den Tagen direkt nach '
          'dem Ende der Menstruation und erneut nach dem Eisprung '
          'während der gesamten Lutealphase beobachtet. Der '
          'Östrogenspiegel ist am niedrigsten, daher produziert '
          'der Gebärmutterhals kaum bis kein Sekret. In der '
          'STM-Klassifikation können trockene Tage in der Phase '
          'vor dem Eisprung (bevor Schleim aufgetreten ist) nach '
          'den Kalenderregeln noch als unfruchtbar gelten.\n\n'
          'Hinweis: Manche Frauen fühlen sich selten völlig '
          '„trocken" – wenn dein Normalzustand neutraler ist, '
          'ist das dein persönliches Muster. Entscheidend ist, '
          'zu erkennen, wann es sich ÄNDERT.',
    ),
    MucusCategoryText(
      category: 'Nichts gefühlt, nichts gesehen',
      fertility: 'Nicht fruchtbar',
      sensation: 'Weder trocken noch feucht – ein neutrales '
          'Gefühl. Du nimmst nichts Besonderes wahr, kein '
          'Unbehagen, keine Nässe.',
      appearance: 'Kein sichtbarer Schleim auf Toilettenpapier. '
          'Keine Flecken auf der Unterwäsche. Das Papier kann '
          'einen ganz leichten Glanz haben, aber nichts, das du '
          'aufnehmen oder untersuchen kannst.',
      fingerTest: 'Nichts zum Aufnehmen oder Testen zwischen den '
          'Fingern. Der Bereich fühlt sich neutral an.',
      details: 'Dies ist eine Übergangskategorie zwischen „trocken" '
          'und „feucht". Manche Frauen erleben dies als '
          'Normalzustand statt völliger Trockenheit – besonders '
          'Frauen mit von Natur aus etwas mehr Feuchtigkeit. '
          'Das ist völlig normal.\n\n'
          'Wichtig bei dieser Kategorie ist, genau darauf zu '
          'achten, ob sie zu „feucht" oder „nass" übergeht – '
          'dieser Wechsel, auch wenn er subtil ist, signalisiert '
          'steigendes Östrogen und das mögliche Öffnen des '
          'fruchtbaren Fensters.',
    ),
    MucusCategoryText(
      category: 'Feucht / Klebrig',
      fertility: 'Evtl. fruchtbar',
      sensation: 'Leicht feuchtes oder klammes Gefühl am '
          'Scheideneingang. Du merkst, dass etwas da ist, aber '
          'es fühlt sich nicht glatt oder gleitfähig an.',
      appearance: 'Dick, weiß, trüb oder gelblich. Kann pastös, '
          'krümelig oder gummiartig aussehen. Bleibt als Klumpen. '
          'Kann an weißen Bastelkleber oder dicke Handcreme '
          'erinnern, die anzutrocknen beginnt.',
      fingerTest: 'Reißt sofort beim Auseinanderziehen oder dehnt '
          'sich weniger als 1 cm, bevor es reißt. Fühlt sich '
          'klebrig oder krümelig zwischen Daumen und Zeigefinger '
          'an – wie angetrocknete Paste.',
      details: 'Der Gebärmutterhals beginnt, auf steigendes '
          'Östrogen zu reagieren. Dieser Schleim ermöglicht ein '
          'begrenztes Spermienüberleben (Stunden statt Tage), '
          'signalisiert aber, dass der Körper in Richtung '
          'Fruchtbarkeit übergeht.\n\n'
          'In der STM-Klassifikation ist dies die Grenzzone. '
          'Wenn du die Methode zur Verhütung nutzt, sollte das '
          'erste Auftreten dieses Schleims nach trockenen Tagen '
          'als Beginn des fruchtbaren Fensters behandelt werden – '
          'auch wenn die Kalenderberechnung sagt, du seist noch '
          'in der unfruchtbaren Phase. Schleim hat immer Vorrang '
          'vor Kalenderregeln.\n\n'
          'Diese Schleimart bildet unter dem Mikroskop eine '
          'netzartige Struktur, die den Spermiendurchgang teilweise '
          'blockiert.',
    ),
    MucusCategoryText(
      category: 'Nass / Cremig',
      fertility: 'Fruchtbar',
      sensation: 'Nasses, glattes oder gleitfähiges Gefühl. Du '
          'bemerkst evtl. Feuchtigkeit beim Gehen oder Sitzen. '
          'Es gibt ein klares Gefühl von Gleitfähigkeit, wenn '
          'auch nicht so intensiv wie in der Eiweiß-Phase.',
      appearance: 'Weiß bis leicht trüb, mit cremiger, '
          'lotionartiger Konsistenz. Flüssiger als die klebrige '
          'Phase. Kann deutliche nasse Flecken auf der Unterwäsche '
          'hinterlassen. Kann wie Körperlotion, Joghurt oder '
          'dünne Handcreme aussehen.',
      fingerTest: 'Dehnt sich 1–2 cm, bevor es reißt. Fühlt sich '
          'glatt und cremig zwischen den Fingern an – wie '
          'Handlotion oder Feuchtigkeitscreme. Bildet noch nicht '
          'die elastischen Fäden des Eiweißschleims.',
      details: 'Der Östrogenspiegel ist nun deutlich erhöht und '
          'signalisiert, dass der Eisprung naht (meist innerhalb '
          'weniger Tage). Der Schleim wird spermienfreundlich – '
          'er liefert Nährstoffe, einen alkalischen pH-Wert, der '
          'die Säure der Scheide ausgleicht, und Kanäle, die den '
          'Spermientransport zur Eizelle erleichtern.\n\n'
          'Spermien können in dieser Schleimart 3–5 Tage '
          'überleben, weshalb sich das fruchtbare Fenster weit '
          'vor den Eisprung selbst erstreckt. Dies markiert die '
          'klar fruchtbare Phase des Zyklus.\n\n'
          'Unter dem Mikroskop zeigt dieser Schleim eine offenere, '
          'kanalartige Struktur als das Netz des klebrigen '
          'Schleims und leitet Spermien aktiv nach oben.',
    ),
    MucusCategoryText(
      category: 'Eiweiß / Spinnbar',
      fertility: 'Hoch fruchtbar',
      sensation: 'Sehr glitschig, gleitfähig – wie Seife, Öl '
          'oder das Gleiten auf einer nassen Oberfläche. Du '
          'bemerkst es evtl. beim Gehen, Sitzen oder sogar ohne '
          'Abwischen. Manche beschreiben es als „strömendes" '
          'Gefühl.',
      appearance: 'Klar, durchsichtig oder leicht weißlich '
          'durchzogen. Sehr flüssig, glasig und dehnbar. Ähnelt '
          'rohem Eiweiß – oft sieht man lange, dünne Fäden auf '
          'dem Toilettenpapier. Kann wässrig-klar und völlig '
          'ungetrübt sein.',
      fingerTest: 'Dehnt sich 3–10+ cm, ohne zu reißen, und '
          'bildet dünne, elastische, glänzende Fäden zwischen '
          'Daumen und Zeigefinger. Je länger und dünner der '
          'Faden, desto fruchtbarer. Fühlt sich extrem glitschig '
          'an – die Finger gleiten fast aneinander vorbei.',
      details: 'Dies ist der fruchtbarste Schleim und zeigt einen '
          'Östrogen-Höchststand sowie an, dass der Eisprung '
          'unmittelbar bevorsteht oder gerade stattfindet. '
          'Spermien können in diesem Schleim bis zu 5 Tage '
          'überleben, und er erleichtert aktiv ihren Transport '
          'zur Eizelle.\n\n'
          'Der LETZTE Tag, an dem du diesen Schleim bester '
          'Qualität beobachtest, ist dein „Höhepunkt" – einer der '
          'beiden Schlüsselmarker der STM. Du kannst den '
          'Höhepunkt nur rückblickend bestimmen: Wenn du '
          'bemerkst, dass der Schleim heute trockener oder weniger '
          'dehnbar ist als gestern, dann war gestern der '
          'Höhepunkt.\n\n'
          'Nicht jede produziert große Mengen – manche Frauen '
          'sehen nur eine kleine Menge dehnbaren Schleim. Die '
          'Qualität (Dehnbarkeit, Klarheit, Glitschigkeit) zählt '
          'mehr als die Menge. Schon eine kleine Menge echten '
          'Eiweißschleims ist ein starkes Fruchtbarkeitszeichen.\n\n'
          'Unter dem Mikroskop zeigt dieser Schleim weit offene, '
          'parallele Kanäle – im Grunde ein Autobahnsystem für '
          'Spermien. Getrocknet auf einem Glasträger zeigt er '
          'zudem ein charakteristisches „Farnkraut"-Muster.',
    ),
  ],
  progressionTitle: 'Typischer Verlauf',
  progression: [
    ProgressionRowText(phase: 'Nach der Periode', mucus: 'Trocken'),
    ProgressionRowText(phase: 'Frühe Follikelphase', mucus: 'Klebrig/trüb'),
    ProgressionRowText(phase: 'Nahe Eisprung', mucus: 'Nass/cremig'),
    ProgressionRowText(phase: 'Höchste Fruchtbarkeit', mucus: 'Eiweiß'),
    ProgressionRowText(phase: 'Nach dem Eisprung', mucus: 'Wieder trocken'),
  ],
  progressionCaption: 'Der abrupte Wechsel von Eiweiß zurück zu '
      'trocken/klebrig markiert den Höhepunkt (am nächsten Tag '
      'erkennbar).',
  goodToKnowTitle: 'Gut zu wissen',
  goodToKnowBody: '• Achte auf die Veränderung des Musters, nicht '
      'auf das exakte Übereinstimmen mit einer Lehrbuchbeschreibung.\n'
      '• Erregungsflüssigkeit ist anders – wässrig, verschwindet '
      'schnell, dehnt sich nicht.\n'
      '• Sperma kann Beobachtungen 12–24 Stunden überdecken.\n'
      '• Manche Medikamente können die Schleimbildung verringern.',
  samplingTitle: 'Beobachten & Probe gewinnen',
  samplingIntro: 'Es gibt drei Wege, deinen Zervixschleim zu prüfen. '
      'Nutze den, der sich am angenehmsten anfühlt – wichtig ist, '
      'dass du es regelmäßig tust.',
  samplingMethods: [
    SamplingMethodText(
      title: 'Toilettenpapier-Methode',
      text: 'Wische vor dem Wasserlassen den Scheideneingang von '
          'vorne nach hinten mit weißem, unparfümiertem '
          'Toilettenpapier ab. Schau auf das Papier: Ist etwas '
          'darauf? Notiere Farbe, Konsistenz und wie es sich beim '
          'Abwischen anfühlt (trocken, glatt, glitschig?).',
    ),
    SamplingMethodText(
      title: 'Finger-Methode',
      text: 'Führe mit sauberen Händen den Zeige- oder Mittelfinger '
          'in die Scheide ein (etwa 2–3 cm reichen). Streiche '
          'sanft um den Muttermund. Zieh den Finger heraus und '
          'untersuche, was daran ist. Mach dann den Fingertest: '
          'Drücke den Schleim zwischen Daumen und Zeigefinger und '
          'zieh langsam auseinander. Notiere, wie weit er sich '
          'dehnt, bevor er reißt.',
    ),
    SamplingMethodText(
      title: 'Unterwäsche-Kontrolle',
      text: 'Schau über den Tag verteilt auf deine Unterwäsche. '
          'Zervixschleim hinterlässt oft sichtbare Spuren – '
          'notiere, ob der Fleck trocken, cremig, nass ist oder '
          'klare, dehnbare Rückstände zeigt.',
    ),
  ],
  samplingTip: 'Notiere immer die HÖCHSTE Qualität, die du an dem '
      'Tag beobachtet hast. Wenn du morgens klebrigen Schleim '
      'gesehen hast, nachmittags aber Eiweißschleim, trage '
      'Eiweißschleim ein.\n\n'
      'Prüfe mehrmals täglich – Schleim kann sich im Lauf des '
      'Tages ändern. Achte besonders auf das Empfinden: das '
      'glitschige/gleitfähige Gefühl ist oft der zuverlässigste '
      'Indikator, auch wenn du wenig sehen kannst.',
);

const _methodTopicsEs = <TopicContent>[
  TopicContent(
    icon: Icons.auto_stories_outlined,
    title: '¿Qué es el método sintotérmico?',
    summary: 'Una forma científicamente validada de identificar los días '
        'fértiles e infértiles usando dos signos corporales.',
    body: 'El método sintotérmico usa dos marcadores biológicos '
        'independientes —la temperatura basal corporal y el moco '
        'cervical— para identificar las fases fértil e infértil de cada '
        'ciclo menstrual.\n\n'
        'A diferencia de los métodos basados en el calendario, que '
        'predicen a partir de promedios, el método observa las señales '
        'reales de tu cuerpo en cada ciclo. Un amplio estudio '
        '(Frank-Herrmann et al., 2007) halló que menos de 1 de cada 200 '
        'mujeres al año quedaba embarazada si seguía las reglas '
        'correctamente.',
    reference: 'Frank-Herrmann P et al. (2007). '
        'Human Reproduction, 22(5), 1310–1319.',
  ),
  TopicContent(
    icon: Icons.loop,
    title: 'Tu ciclo menstrual',
    summary: 'Cómo las hormonas impulsan las cuatro fases de tu ciclo.',
    body: 'Tu ciclo está controlado por un circuito de retroalimentación '
        'entre el cerebro y los ovarios. Un ciclo típico dura 24–35 días, '
        'pero la variación es normal.\n\n'
        'Las cuatro fases:\n\n'
        '1. Menstruación (~días 1–5)\n'
        'El revestimiento uterino se desprende. Las hormonas están en su '
        'nivel más bajo.\n\n'
        '2. Fase folicular (duración variable)\n'
        'Los folículos maduran en los ovarios. El aumento de estrógeno '
        'estimula el moco fértil y engrosa el revestimiento uterino. Esta '
        'fase varía en duración: por eso los ciclos no siempre son '
        'iguales.\n\n'
        '3. Ovulación (~24 horas)\n'
        'Un pico de LH desencadena la liberación de un óvulo maduro. El '
        'óvulo sobrevive 12–24 horas, pero los espermatozoides pueden '
        'vivir hasta 5 días en el moco fértil.\n\n'
        '4. Fase lútea (~10–16 días)\n'
        'La progesterona aumenta, elevando tu temperatura entre 0,2 y '
        '0,5 °C y secando el moco. Esta fase es bastante constante de un '
        'ciclo a otro.',
    reference: 'Reed BG, Carr BR (2018). '
        '"The Normal Menstrual Cycle and the Control of Ovulation." '
        'In: Endotext. PMID: 25905282.',
  ),
  TopicContent(
    icon: Icons.thermostat_outlined,
    title: 'Signo 1: Temperatura',
    summary: 'Cómo la regla «3 sobre 6» confirma la ovulación.',
    body: 'Tu temperatura basal corporal (TBC) es tu temperatura en '
        'reposo, medida justo al despertar. Tras la ovulación, la '
        'progesterona la eleva al menos 0,2 °C.\n\n'
        'La regla 3 sobre 6:\n'
        '① Identifica las 6 temperaturas bajas antes del posible cambio\n'
        '② La línea base = la más alta de esas 6\n'
        '③ 3 temperaturas consecutivas deben estar por encima de la '
        'línea base\n'
        '④ La 3.ª debe estar ≥ 0,2 °C por encima de la línea base\n\n'
        'Si no se cumple ④, espera una 4.ª temperatura alta (que no '
        'necesita el margen de 0,2 °C).\n\n'
        'Consejo: Mide a la misma hora cada día (±30 min). El alcohol, la '
        'enfermedad o dormir mal pueden alterar las lecturas; márcalas '
        'como «excluidas».',
    reference: 'Colombo B, Masarotto G (2000). '
        'Demographic Research, 3(5).',
  ),
  TopicContent(
    icon: Icons.water_drop_outlined,
    title: 'Signo 2: Moco cervical',
    summary: 'Cómo los cambios del moco revelan tu ventana fértil.',
    body: 'El moco cervical cambia a lo largo del ciclo en respuesta a '
        'los niveles hormonales. Es el signo principal que abre la '
        'ventana fértil.\n\n'
        'Observa tanto la sensación (lo que sientes) como el aspecto (lo '
        'que ves). Registra la mejor calidad del día.\n\n'
        'Progresión típica:\n'
        'Seco → pegajoso/turbio → húmedo/cremoso → clara de huevo/'
        'resbaladizo → de nuevo seco tras la ovulación\n\n'
        'El «día cúspide» es el último día con el moco de mejor calidad '
        'antes de que disminuya. Se identifica de forma retrospectiva.\n\n'
        'Consulta la pestaña «Atlas del moco» para una guía visual de '
        'cada categoría.',
    reference: 'Bigelow JL et al. (2004). '
        'Human Reproduction, 19(4), 889–892.',
  ),
  TopicContent(
    icon: Icons.rule_outlined,
    title: 'Las reglas: fase preovulatoria',
    summary: 'Qué días al inicio del ciclo son infértiles.',
    body: 'Las reglas basadas en el calendario determinan cuántos días '
        'iniciales pueden considerarse infértiles. Siempre se aplica la '
        'más conservadora (la más baja):\n\n'
        '• Regla de los 5 días (principiantes, <12 ciclos): los días 1–5 '
        'son infértiles.\n\n'
        '• Regla de los 6 días de Rötzer: días 1–6, pero solo si TODOS '
        'los ciclos registrados fueron ≥ 26 días.\n\n'
        '• Regla menos-20 (12+ ciclos): ciclo más corto registrado menos '
        '20 = último día infértil.\n\n'
        '• Regla menos-8 (12+ ciclos): día más temprano de subida de '
        'temperatura menos 8.\n\n'
        'Clave: cualquier moco cervical fértil anula de inmediato estos '
        'cálculos. El moco siempre tiene prioridad sobre las reglas del '
        'calendario.',
  ),
  TopicContent(
    icon: Icons.check_circle_outline,
    title: 'Las reglas: fase posovulatoria',
    summary: 'Cómo la «doble comprobación» confirma la infertilidad.',
    body: 'La infertilidad posovulatoria comienza en el MÁS TARDÍO de:\n\n'
        '• La tarde del 3.er día tras el día cúspide\n'
        '• La tarde de la 3.ª temperatura alta consecutiva\n\n'
        'Deben cumplirse ambas condiciones: este es el principio de '
        '«doble comprobación» que hace tan fiable al método. Si la '
        'temperatura se confirma el día 17 pero el día cúspide + 3 es el '
        'día 19, la fase infértil empieza el día 19.\n\n'
        'Esta es la fase más fiable de todo el ciclo.',
  ),
  TopicContent(
    icon: Icons.verified_outlined,
    title: '¿Qué fiabilidad tiene el método?',
    summary: '99,6 % de eficacia con uso correcto.',
    body: 'Eficacia con uso del método: 99,6 %\n'
        'Eficacia con uso típico: 98,2 %\n'
        'Índice de Pearl (uso correcto): 0,4\n\n'
        'Para comparar, la píldora tiene un índice de Pearl de uso típico '
        'de 7–9, y los condones de unos 13–18.\n\n'
        'La clave es una observación correcta y un registro honesto. Esta '
        'app te ayuda, pero ERES TÚ quien interpreta y aplica las reglas. '
        'Considera hacer un curso certificado, sobre todo al empezar.',
    reference: 'Frank-Herrmann P et al. (2007). Human Reproduction. '
        '\nManhart MD et al. (2013). Osteopathic Family Physician, 5(1).',
  ),
];

const _faqSectionsEs = <FaqSection>[
  FaqSection(label: 'Primeros pasos', items: [
    FaqEntry(
      question: '¿Cómo empiezo a usar el método?',
      answer: 'Registra tu temperatura basal cada mañana antes de '
          'levantarte y observa tu moco cervical a lo largo del día. '
          'Anota ambos a diario. En los primeros ciclos, céntrate en '
          'aprender tu patrón.\n\n'
          'Se recomienda mucho leer «Taking Charge of Your Fertility» '
          '(Weschler) o hacer un curso certificado antes de confiar en '
          'el método.',
    ),
    FaqEntry(
      question: '¿Cuándo y cómo mido la temperatura?',
      answer: 'Mide nada más despertar, antes de levantarte o hablar. '
          'Usa un termómetro basal con precisión de 0,01 °C. A la misma '
          'hora cada día (±30 min).\n\n'
          'Puedes medir por vía oral (5 min bajo la lengua), vaginal '
          '(5 min) o rectal (3 min). Elige un método y mantenlo durante '
          'el ciclo.',
    ),
    FaqEntry(
      question: '¿Y si dormí mal o bebí alcohol?',
      answer: 'Marca la temperatura como «excluida». Los valores '
          'alterados no deben usarse para la evaluación. Alteraciones '
          'comunes: alcohol, enfermedad, dormir mal (<5 h), despertar '
          'tarde/temprano, viajes, estrés.\n\n'
          'Mejor excluir un valor dudoso que obtener una evaluación '
          'falsa.',
    ),
  ]),
  FaqSection(label: 'Observar y registrar', items: [
    FaqEntry(
      question: '¿Cómo observo el moco cervical?',
      answer: 'Comprueba cada vez que vayas al baño:\n\n'
          '1. Sensación: ¿se siente seco, húmedo, mojado o '
          'resbaladizo?\n'
          '2. Aspecto: revisa el papel higiénico en busca de nada, algo '
          'turbio o algo claro/elástico.\n\n'
          'Registra la mejor calidad que observaste ese día. Consulta la '
          'pestaña «Atlas del moco» para una guía visual.',
    ),
    FaqEntry(
      question: '¿Qué es el «día cúspide»?',
      answer: 'El último día con el moco de mejor calidad antes de que '
          'baje a una calidad menor. Se identifica de forma '
          'retrospectiva: cuando hoy es menos fértil que ayer, entonces '
          'ayer fue el día cúspide.\n\n'
          'Se correlaciona estrechamente con la ovulación (±1–2 días).',
    ),
    FaqEntry(
      question: '¿Qué significa la regla 3 sobre 6?',
      answer: '1. Encuentra 6 temperaturas bajas antes del posible '
          'cambio\n'
          '2. Línea base = la más alta de esas 6\n'
          '3. 3 temperaturas consecutivas deben superar la línea base\n'
          '4. La 3.ª debe estar ≥ 0,2 °C por encima\n\n'
          'Si no se cumple la condición 4, espera una 4.ª temperatura '
          'alta.',
    ),
  ]),
  FaqSection(label: 'Seguridad y reglas', items: [
    FaqEntry(
      question: '¿De verdad son infértiles los primeros días?',
      answer: 'Para principiantes (<12 ciclos), los primeros 5 días son '
          'infértiles, siempre que no haya moco fértil. Tras 12+ ciclos, '
          'la app usa tu historial para un cálculo personalizado.\n\n'
          'Cualquier observación de moco fértil anula de inmediato la '
          'regla del calendario, incluso el día 3.',
    ),
    FaqEntry(
      question: '¿Puedo usar el método con ciclos irregulares?',
      answer: 'Sí. El método observa señales reales en lugar de predecir, '
          'así que funciona bien con ciclos irregulares. Los días seguros '
          'preovulatorios pueden ser menos, pero la fase posovulatoria '
          'sigue siendo fiable.\n\n'
          'Los ciclos muy irregulares pueden requerir una evaluación '
          'médica.',
    ),
    FaqEntry(
      question: '¿Y durante la lactancia o el posparto?',
      answer: 'El método puede adaptarse, pero las reglas son más '
          'complejas. Trabaja con una instructora formada durante esta '
          'etapa. Los cálculos estándar de la app suponen ciclos ya '
          'establecidos.',
    ),
    FaqEntry(
      question: '¿En qué se diferencia del método del calendario?',
      answer: 'El método del calendario predice a partir de promedios '
          'pasados (índice de Pearl ~15–25). El método sintotérmico '
          'observa señales biológicas reales del ciclo actual (índice de '
          'Pearl 0,4).\n\n'
          'Esta app usa los cálculos de calendario solo como herramienta '
          'secundaria: el moco siempre tiene prioridad.',
    ),
  ]),
  FaqSection(label: 'Usar la app', items: [
    FaqEntry(
      question: '¿Qué significan los modos «evitar» y «buscar»?',
      answer: 'Cambia cómo aparecen las etiquetas:\n\n'
          '• Evitar: etiquetas conservadoras. Los días preovulatorios '
          'dicen «potencialmente fértil», ya que la ovulación aún no está '
          'confirmada.\n\n'
          '• Buscar: etiquetas estándar del método. Se resalta la ventana '
          'fértil para planificar.\n\n'
          'La evaluación subyacente es idéntica.',
    ),
    FaqEntry(
      question: '¿Debo confiar ciegamente en la app?',
      answer: 'No. Es una herramienta de registro, no un dispositivo '
          'médico. Deberías aprender las reglas y verificar que la '
          'evaluación tenga sentido. Usa los ajustes manuales (línea '
          'base, día cúspide) si hace falta.\n\n'
          'Toca el icono ℹ junto a cualquier etiqueta para ver qué regla '
          'se aplicó y por qué.',
    ),
  ]),
];

const _atlasEs = AtlasContent(
  categories: [
    MucusCategoryText(
      category: 'Seco',
      fertility: 'No fértil',
      sensation: 'Seco, áspero, posiblemente con picor o ligera molestia. '
          'La entrada vaginal puede sentirse como papel de lija al '
          'limpiarte.',
      appearance: 'Nada visible en el papel higiénico ni en la ropa '
          'interior. El papel queda completamente limpio y seco al '
          'limpiarte. No hay brillo ni residuo alguno.',
      fingerTest: 'Nada que probar: tus dedos quedan completamente secos, '
          'sin residuo.',
      details: 'Esto se observa normalmente en los días justo después de '
          'que termina la menstruación y de nuevo tras la ovulación, '
          'durante toda la fase lútea. Los niveles de estrógeno están en '
          'su punto más bajo, así que el cuello uterino produce poca o '
          'ninguna secreción. En la clasificación del método, los días '
          'secos de la fase preovulatoria (antes de que aparezca moco) '
          'aún pueden considerarse infértiles según las reglas del '
          'calendario.\n\n'
          'Nota: Algunas mujeres rara vez se sienten completamente '
          '«secas»; si tu estado base es más neutro, ese es tu patrón '
          'personal. Lo importante es reconocer cuándo CAMBIA.',
    ),
    MucusCategoryText(
      category: 'Nada sentido, nada visto',
      fertility: 'No fértil',
      sensation: 'Ni seco ni húmedo: una sensación neutra. No notas nada '
          'en particular, sin molestia, sin humedad.',
      appearance: 'Sin moco visible en el papel higiénico. Sin manchas en '
          'la ropa interior. El papel puede tener un brillo muy leve, '
          'pero nada que puedas recoger o examinar.',
      fingerTest: 'Nada que recoger o probar entre los dedos. La zona se '
          'siente neutra al tacto.',
      details: 'Es una categoría de transición entre «seco» y «húmedo». '
          'Algunas mujeres la experimentan como su estado base en lugar '
          'de la sequedad total, sobre todo quienes tienen de forma '
          'natural algo más de humedad. Esto es perfectamente normal.\n\n'
          'La clave en esta categoría es prestar mucha atención a si pasa '
          'a «húmedo» o «mojado»: ese cambio, aunque sea sutil, indica un '
          'aumento de estrógeno y la posible apertura de la ventana '
          'fértil.',
    ),
    MucusCategoryText(
      category: 'Húmedo / Pegajoso',
      fertility: 'Posiblemente fértil',
      sensation: 'Sensación ligeramente húmeda en la entrada vaginal. '
          'Notas que hay algo, pero no se siente resbaladizo ni '
          'lubricante.',
      appearance: 'Espeso, blanco, turbio o amarillento. Puede verse '
          'pastoso, grumoso o gomoso. Se mantiene en un grumo. Puede '
          'parecerse a cola blanca escolar o a crema de manos espesa que '
          'ha empezado a secarse.',
      fingerTest: 'Se rompe enseguida al estirarlo, o se estira menos de '
          '1 cm antes de romperse. Se siente pegajoso o grumoso entre el '
          'pulgar y el índice, como pasta seca.',
      details: 'El cuello uterino empieza a responder al aumento de '
          'estrógeno. Este moco permite una supervivencia limitada de los '
          'espermatozoides (horas, no días), pero indica que el cuerpo '
          'está pasando hacia la fertilidad.\n\n'
          'En la clasificación del método, esta es la zona límite. Si '
          'usas el método para evitar el embarazo, la primera aparición '
          'de este moco tras días secos debe tratarse como el inicio de '
          'la ventana fértil, aunque el cálculo del calendario diga que '
          'aún estás en la fase infértil. El moco siempre tiene prioridad '
          'sobre las reglas del calendario.\n\n'
          'Bajo el microscopio, este tipo de moco forma una estructura en '
          'malla que bloquea parcialmente el paso de los espermatozoides.',
    ),
    MucusCategoryText(
      category: 'Mojado / Cremoso',
      fertility: 'Fértil',
      sensation: 'Sensación mojada, suave o resbaladiza. Puedes notar '
          'humedad al caminar o sentarte. Hay una clara sensación de '
          'lubricación, aunque no tan intensa como en la fase de clara de '
          'huevo.',
      appearance: 'De blanco a ligeramente turbio, con una consistencia '
          'cremosa, tipo loción. Más fluido que la fase pegajosa. Puede '
          'dejar manchas húmedas notables en la ropa interior. Puede '
          'parecerse a loción corporal, yogur o crema de manos ligera.',
      fingerTest: 'Se estira 1–2 cm antes de romperse. Se siente suave y '
          'cremoso entre los dedos, como loción de manos o hidratante. '
          'Aún no forma los hilos elásticos del moco de clara de huevo.',
      details: 'Los niveles de estrógeno están ahora bastante elevados, '
          'lo que indica que la ovulación se acerca (normalmente en pocos '
          'días). El moco se vuelve hospitalario para los espermatozoides: '
          'aporta nutrientes, un pH alcalino que contrarresta la acidez '
          'vaginal y canales que facilitan su transporte hacia el '
          'óvulo.\n\n'
          'Los espermatozoides pueden sobrevivir 3–5 días en este tipo de '
          'moco, por lo que la ventana fértil se extiende bastante antes '
          'de la propia ovulación. Esto marca la fase claramente fértil '
          'del ciclo.\n\n'
          'Bajo el microscopio, este moco muestra una estructura más '
          'abierta, con canales, en comparación con la malla del moco '
          'pegajoso, guiando activamente a los espermatozoides hacia '
          'arriba.',
    ),
    MucusCategoryText(
      category: 'Clara de huevo / Resbaladizo',
      fertility: 'Muy fértil',
      sensation: 'Muy resbaladizo, lubricante, como jabón, aceite o '
          'deslizarse sobre una superficie mojada. Puedes notarlo al '
          'caminar, al sentarte o incluso sin limpiarte. Algunas lo '
          'describen como una sensación de «chorro».',
      appearance: 'Claro, transparente o con leves vetas blancas. Muy '
          'fluido, vidrioso y elástico. Se parece a la clara de huevo '
          'cruda: a menudo se ven hilos largos y finos en el papel '
          'higiénico. Puede ser acuoso-claro, sin turbidez alguna.',
      fingerTest: 'Se estira 3–10+ cm sin romperse, formando hilos finos, '
          'elásticos y brillantes entre el pulgar y el índice. Cuanto más '
          'largo y fino el hilo, más fértil. Se siente extremadamente '
          'resbaladizo: los dedos casi se deslizan uno sobre otro.',
      details: 'Este es el moco más fértil, e indica niveles máximos de '
          'estrógeno y que la ovulación es inminente o está ocurriendo '
          'ahora mismo. Los espermatozoides pueden sobrevivir hasta 5 '
          'días en este moco, y este facilita activamente su transporte '
          'hacia el óvulo.\n\n'
          'El ÚLTIMO día en que observas este moco de máxima calidad es '
          'tu «día cúspide», uno de los dos marcadores clave del método. '
          'Solo puedes identificar el día cúspide de forma retrospectiva: '
          'cuando notas que el moco de hoy es más seco o menos elástico '
          'que el de ayer, entonces ayer fue el día cúspide.\n\n'
          'No todas producen grandes cantidades; algunas mujeres solo ven '
          'una pequeña cantidad de moco elástico. La calidad (elasticidad, '
          'claridad, resbaladicidad) importa más que la cantidad. Incluso '
          'una pequeña cantidad de auténtico moco de clara de huevo es un '
          'fuerte signo de fertilidad.\n\n'
          'Bajo el microscopio, este moco muestra canales paralelos muy '
          'abiertos, esencialmente una autopista para los espermatozoides. '
          'Al secarse en un portaobjetos, también muestra un patrón '
          'característico de «helecho».',
    ),
  ],
  progressionTitle: 'Progresión típica',
  progression: [
    ProgressionRowText(phase: 'Tras la regla', mucus: 'Seco'),
    ProgressionRowText(phase: 'Folicular temprana', mucus: 'Pegajoso/turbio'),
    ProgressionRowText(phase: 'Cerca de la ovulación', mucus: 'Húmedo/cremoso'),
    ProgressionRowText(phase: 'Máxima fertilidad', mucus: 'Clara de huevo'),
    ProgressionRowText(phase: 'Tras la ovulación', mucus: 'De nuevo seco'),
  ],
  progressionCaption: 'El cambio brusco de clara de huevo a seco/pegajoso '
      'marca el día cúspide (identificado al día siguiente).',
  goodToKnowTitle: 'Bueno saber',
  goodToKnowBody: '• Céntrate en el cambio de patrón, no en coincidir '
      'exactamente con una descripción de manual.\n'
      '• El fluido de excitación es distinto: acuoso, desaparece rápido, '
      'no se estira.\n'
      '• El semen puede enmascarar las observaciones durante 12–24 '
      'horas.\n'
      '• Algunos medicamentos pueden reducir la producción de moco.',
  samplingTitle: 'Cómo observar y tomar una muestra',
  samplingIntro: 'Hay tres formas de comprobar tu moco cervical. Usa la '
      'que te resulte más cómoda; lo importante es que lo hagas de forma '
      'constante.',
  samplingMethods: [
    SamplingMethodText(
      title: 'Método del papel higiénico',
      text: 'Antes de orinar, límpiate la entrada vaginal de delante '
          'hacia atrás con papel higiénico blanco y sin perfume. Mira el '
          'papel: ¿hay algo en él? Anota el color, la consistencia y cómo '
          'se siente al limpiarte (¿seco, suave, resbaladizo?).',
    ),
    SamplingMethodText(
      title: 'Método del dedo',
      text: 'Con las manos limpias, introduce el dedo índice o medio en '
          'la vagina (basta con unos 2–3 cm). Recorre suavemente '
          'alrededor del cuello uterino. Saca el dedo y examina lo que '
          'hay en él. Luego haz la prueba con los dedos: presiona el moco '
          'entre el pulgar y el índice y sepáralos despacio. Anota cuánto '
          'se estira antes de romperse.',
    ),
    SamplingMethodText(
      title: 'Revisión de la ropa interior',
      text: 'Mira tu ropa interior a lo largo del día. El moco cervical '
          'suele dejar marcas visibles; anota si la mancha está seca, '
          'cremosa, mojada o muestra un residuo claro y elástico.',
    ),
  ],
  samplingTip: 'Registra siempre la calidad MÁS ALTA que observaste '
      'durante el día. Si viste moco pegajoso por la mañana pero clara de '
      'huevo por la tarde, registra clara de huevo.\n\n'
      'Comprueba varias veces al día: el moco puede cambiar a lo largo '
      'del día. Presta especial atención a la sensación: el tacto '
      'resbaladizo/lubricante suele ser el indicador más fiable, aun '
      'cuando no veas mucho.',
);
