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
    default:
      return _faqSectionsEn;
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
