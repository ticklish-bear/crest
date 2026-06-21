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
