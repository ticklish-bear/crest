import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'The Method'),
              Tab(text: 'FAQ'),
              Tab(text: 'Mucus Atlas'),
            ],
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _MethodTab(),
                _FaqTab(),
                _MucusAtlasTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 1: THE METHOD
// Progressive disclosure: short summaries expand into detail
// ─────────────────────────────────────────────────────────────────────────────

class _MethodTab extends StatelessWidget {
  const _MethodTab();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        // Friendly intro
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Learn at your own pace. Tap any topic to expand it.',
            style: TextStyle(
              fontSize: 14,
              color: colors.onSurfaceVariant,
            ),
          ),
        ),

        _TopicCard(
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

        _TopicCard(
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

        _TopicCard(
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

        _TopicCard(
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

        _TopicCard(
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

        _TopicCard(
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

        _TopicCard(
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

        const SizedBox(height: 8),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 2: FAQ — expandable Q&A
// ─────────────────────────────────────────────────────────────────────────────

class _FaqTab extends StatelessWidget {
  const _FaqTab();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Tap a question to see the answer.',
            style: TextStyle(fontSize: 14, color: colors.onSurfaceVariant),
          ),
        ),

        _sectionLabel('Getting Started', colors),

        const _FaqItem(
          question: 'How do I start using the method?',
          answer: 'Record your basal body temperature every morning '
              'before getting up, and observe your cervical mucus '
              'throughout the day. Log both daily. For the first few '
              'cycles, focus on learning your pattern.\n\n'
              'Reading "Taking Charge of Your Fertility" (Weschler) '
              'or taking a certified course is strongly recommended '
              'before relying on the method.',
        ),
        const _FaqItem(
          question: 'When and how do I measure temperature?',
          answer: 'Measure immediately after waking, before getting '
              'up or talking. Use a basal thermometer with 0.01°C '
              'precision. Same time each day (±30 min).\n\n'
              'You can measure orally (5 min under tongue), vaginally '
              '(5 min), or rectally (3 min). Pick one method and '
              'stick with it within a cycle.',
        ),
        const _FaqItem(
          question: 'What if I slept badly or drank alcohol?',
          answer: 'Mark the temperature as "excluded." Disturbed '
              'values shouldn\'t be used for evaluation. Common '
              'disturbances: alcohol, illness, poor sleep (<5 hrs), '
              'late/early waking, travel, stress.\n\n'
              'Better to exclude a questionable value than to get '
              'a false evaluation.',
        ),

        _sectionLabel('Observing & Recording', colors),

        const _FaqItem(
          question: 'How do I observe cervical mucus?',
          answer: 'Check each time you use the bathroom:\n\n'
              '1. Sensation — does it feel dry, moist, wet, or '
              'slippery?\n'
              '2. Appearance — check toilet paper for nothing, '
              'something cloudy, or something clear/stretchy.\n\n'
              'Record the highest quality you observed that day. '
              'See the "Mucus Atlas" tab for a visual guide.',
        ),
        const _FaqItem(
          question: 'What is the "Peak Day"?',
          answer: 'The last day of best-quality mucus before it '
              'drops to a lower quality. You identify it '
              'retrospectively — when today is less fertile than '
              'yesterday, then yesterday was the Peak Day.\n\n'
              'It closely correlates with ovulation (±1–2 days).',
        ),
        const _FaqItem(
          question: 'What does the 3-over-6 rule mean?',
          answer: '1. Find 6 low temps before the suspected shift\n'
              '2. Coverline = highest of those 6\n'
              '3. 3 consecutive temps must be above the coverline\n'
              '4. The 3rd must be ≥0.2°C above the coverline\n\n'
              'If condition 4 isn\'t met, wait for a 4th high temp.',
        ),

        _sectionLabel('Safety & Rules', colors),

        const _FaqItem(
          question: 'Are the first days really infertile?',
          answer: 'For beginners (<12 cycles), the first 5 days are '
              'infertile — provided there is no fertile mucus. After '
              '12+ cycles, the app uses your history for a personalized '
              'calculation.\n\n'
              'Any fertile mucus observation immediately overrides '
              'the calendar rule — even on day 3.',
        ),
        const _FaqItem(
          question: 'Can I use STM with irregular cycles?',
          answer: 'Yes. STM observes real signals rather than '
              'predicting, so it works well with irregular cycles. '
              'The pre-ovulatory safe days may be fewer, but the '
              'post-ovulatory phase remains reliable.\n\n'
              'Very irregular cycles may warrant medical investigation.',
        ),
        const _FaqItem(
          question: 'What about breastfeeding or postpartum?',
          answer: 'STM can be adapted, but the rules are more '
              'complex. Work with a trained counselor during this '
              'time. Standard app calculations assume established '
              'cycling.',
        ),
        const _FaqItem(
          question: 'How is STM different from the calendar method?',
          answer: 'The calendar method predicts from past averages '
              '(Pearl Index ~15–25). STM observes actual biological '
              'signals in the current cycle (Pearl Index 0.4).\n\n'
              'This app uses calendar calculations only as a '
              'secondary tool — mucus always takes priority.',
        ),

        _sectionLabel('Using the App', colors),

        const _FaqItem(
          question: 'What does "avoiding" vs "achieving" mode mean?',
          answer: 'It changes how labels appear:\n\n'
              '• Avoiding: Conservative labels. Pre-ovulatory days '
              'say "potentially fertile" since ovulation isn\'t '
              'confirmed yet.\n\n'
              '• Achieving: Standard STM labels. The fertile window '
              'is highlighted for timing.\n\n'
              'The underlying evaluation is identical.',
        ),
        const _FaqItem(
          question: 'Should I trust the app blindly?',
          answer: 'No. This is a charting tool, not a medical device. '
              'You should learn the rules and verify the evaluation '
              'makes sense. Use manual overrides (coverline, Peak Day) '
              'if needed.\n\n'
              'Tap the ℹ icon next to any label to see which rule '
              'was applied and why.',
        ),

        const SizedBox(height: 8),
      ],
    );
  }

  Widget _sectionLabel(String label, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8, left: 4),
      child: Text(label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: colors.primary,
            letterSpacing: 0.3,
          )),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 3: MUCUS ATLAS
// ─────────────────────────────────────────────────────────────────────────────

class _MucusAtlasTab extends StatelessWidget {
  const _MucusAtlasTab();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        // How to collect a sample
        _SamplingGuide(colors: colors),
        const SizedBox(height: 20),

        // Category cards with illustrations and photos
        const _MucusCategoryCard(
          category: 'Dry',
          quality: 0,
          icon: Icons.wb_sunny_outlined,
          mucusType: _MucusIllustration.dry,
          // No photo for dry — nothing visible to photograph
          sensation: 'Dry, rough, possibly itchy or slightly '
              'uncomfortable. The vaginal opening may feel '
              'sandpapery when you wipe.',
          appearance: 'Nothing visible on toilet paper or underwear. '
              'The tissue stays completely clean and dry when you '
              'wipe. There is no sheen or residue at all.',
          fingerTest: 'Nothing to test — your fingers remain '
              'completely dry with no residue.',
          fertility: 'Not fertile',
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
        const _MucusCategoryCard(
          category: 'Nothing felt, nothing seen',
          quality: 1,
          icon: Icons.remove_circle_outline,
          mucusType: _MucusIllustration.nothing,
          // No photo — nothing visible
          sensation: 'Neither dry nor moist — a neutral feeling. '
              'You don\'t particularly notice anything, no '
              'discomfort, no wetness.',
          appearance: 'No visible mucus on toilet paper. No stains '
              'on underwear. The tissue may have a very slight '
              'sheen but nothing you can pick up or examine.',
          fingerTest: 'Nothing to pick up or test between your '
              'fingers. The area feels neutral to touch.',
          fertility: 'Not fertile',
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
        const _MucusCategoryCard(
          category: 'Moist / Sticky',
          quality: 2,
          icon: Icons.grain,
          mucusType: _MucusIllustration.sticky,
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
          fertility: 'Possibly fertile',
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
        const _MucusCategoryCard(
          category: 'Wet / Creamy',
          quality: 3,
          icon: Icons.water_outlined,
          mucusType: _MucusIllustration.creamy,
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
          fertility: 'Fertile',
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
        const _MucusCategoryCard(
          category: 'Egg white / Slippery',
          quality: 4,
          icon: Icons.opacity,
          mucusType: _MucusIllustration.eggWhite,
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
          fertility: 'Highly fertile',
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

        const SizedBox(height: 16),

        // Progression
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.outlineVariant.withAlpha(100)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.trending_up,
                      size: 18, color: colors.primary),
                  const SizedBox(width: 8),
                  const Text('Typical Progression',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
              const SizedBox(height: 14),
              _ProgressionRow(
                  'After period', 'Dry', AppColors.mucusDry),
              _ProgressionRow('Early follicular',
                  'Sticky/cloudy', AppColors.mucusMoist),
              _ProgressionRow('Near ovulation',
                  'Wet/creamy', AppColors.mucusWet),
              _ProgressionRow('Peak fertility',
                  'Egg white', AppColors.mucusEggWhite),
              _ProgressionRow('After ovulation',
                  'Back to dry', AppColors.mucusDry),
              const SizedBox(height: 10),
              Text(
                'The abrupt change from egg white back to dry/sticky '
                'marks the Peak Day (identified the next day).',
                style: TextStyle(
                  fontSize: 12.5,
                  color: colors.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Notes
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest.withAlpha(80),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: colors.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Text('Good to know',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurfaceVariant,
                      )),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '• Focus on the change in pattern, not matching a '
                'textbook description exactly.\n'
                '• Arousal fluid is different — watery, disappears '
                'quickly, doesn\'t stretch.\n'
                '• Semen can mask observations for 12–24 hours.\n'
                '• Some medications may reduce mucus production.',
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.5,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable widgets
// ─────────────────────────────────────────────────────────────────────────────

/// A topic card that shows a brief summary and expands on tap
class _TopicCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String summary;
  final String body;
  final String? reference;

  const _TopicCard({
    required this.icon,
    required this.title,
    required this.summary,
    required this.body,
    this.reference,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withAlpha(100)),
      ),
      child: ExpansionTile(
        leading: Icon(icon, size: 20, color: colors.primary),
        title: Text(title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.3,
            )),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(summary,
              style: TextStyle(
                fontSize: 12.5,
                color: colors.onSurfaceVariant,
              )),
        ),
        tilePadding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: const Border(),
        collapsedShape: const Border(),
        children: [
          const Divider(height: 1),
          const SizedBox(height: 14),
          Text(body,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.55,
                color: colors.onSurface.withAlpha(210),
              )),
          if (reference != null) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest.withAlpha(80),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.menu_book_outlined,
                      size: 13, color: colors.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(reference!,
                        style: TextStyle(
                          fontSize: 11,
                          color: colors.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                          height: 1.3,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// FAQ item — question as title, answer expands
class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant.withAlpha(80)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        shape: const Border(),
        collapsedShape: const Border(),
        leading: Icon(Icons.help_outline,
            size: 18, color: colors.primary),
        title: Text(question,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              height: 1.3,
            )),
        children: [
          Text(answer,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: colors.onSurface.withAlpha(200),
              )),
        ],
      ),
    );
  }
}

/// Mucus category card with finger-test illustration and optional photo
class _MucusCategoryCard extends StatelessWidget {
  final String category;
  final int quality;
  final IconData icon;
  final _MucusIllustration mucusType;
  final String sensation;
  final String appearance;
  final String fingerTest;
  final String fertility;
  final String details;

  const _MucusCategoryCard({
    required this.category,
    required this.quality,
    required this.icon,
    required this.mucusType,
    required this.sensation,
    required this.appearance,
    required this.fingerTest,
    required this.fertility,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final mucusColor = AppTheme.mucusColor(quality);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: mucusColor.withAlpha(25),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(13)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: mucusColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: mucusColor, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(category,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: quality >= 3
                        ? AppColors.fertile.withAlpha(25)
                        : colors.surfaceContainerHighest.withAlpha(80),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(fertility,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: quality >= 3
                            ? AppColors.fertile
                            : colors.onSurfaceVariant,
                      )),
                ),
              ],
            ),
          ),

          // Illustration
          Container(
            height: 140,
            width: double.infinity,
            color: colors.surfaceContainerLowest,
            child: CustomPaint(
              painter: _FingerTestPainter(
                mucusType: mucusType,
                mucusColor: mucusColor,
                skinColor: const Color(0xFFF0D5B8),
              ),
            ),
          ),

          // Details (expandable for long content)
          ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 14),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
            shape: const Border(),
            collapsedShape: const Border(),
            initiallyExpanded: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                _detailRow(Icons.touch_app_outlined,
                    'Sensation', sensation, colors),
                const SizedBox(height: 6),
                _detailRow(Icons.visibility_outlined,
                    'Appearance', appearance, colors),
                const SizedBox(height: 6),
                _detailRow(Icons.pinch_outlined,
                    'Finger test', fingerTest, colors),
                const SizedBox(height: 4),
              ],
            ),
            children: [
              Text(details,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: colors.onSurface.withAlpha(190),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String text,
      ColorScheme colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: colors.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.5,
                height: 1.35,
                color: colors.onSurface.withAlpha(200),
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Finger-test illustration painter
// ─────────────────────────────────────────────────────────────────────────────

enum _MucusIllustration {
  dry,
  nothing,
  sticky,
  creamy,
  eggWhite,
}

class _FingerTestPainter extends CustomPainter {
  final _MucusIllustration mucusType;
  final Color mucusColor;
  final Color skinColor;

  _FingerTestPainter({
    required this.mucusType,
    required this.mucusColor,
    required this.skinColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Finger spacing depends on stretch
    final double gap;
    switch (mucusType) {
      case _MucusIllustration.dry:
      case _MucusIllustration.nothing:
        gap = 20;
        break;
      case _MucusIllustration.sticky:
        gap = 28;
        break;
      case _MucusIllustration.creamy:
        gap = 40;
        break;
      case _MucusIllustration.eggWhite:
        gap = 56;
        break;
    }

    _drawFinger(canvas, cx - gap, cy, size, isLeft: true);
    _drawFinger(canvas, cx + gap, cy, size, isLeft: false);

    // Draw mucus between fingers
    switch (mucusType) {
      case _MucusIllustration.dry:
        _drawDryIndicator(canvas, cx, cy, size);
        break;
      case _MucusIllustration.nothing:
        _drawNothingIndicator(canvas, cx, cy, size);
        break;
      case _MucusIllustration.sticky:
        _drawStickyMucus(canvas, cx, cy, gap, size);
        break;
      case _MucusIllustration.creamy:
        _drawCreamyMucus(canvas, cx, cy, gap, size);
        break;
      case _MucusIllustration.eggWhite:
        _drawEggWhiteMucus(canvas, cx, cy, gap, size);
        break;
    }

    // Label under illustration
    final labelText = _labelForType(mucusType);
    final textPainter = TextPainter(
      text: TextSpan(
        text: labelText,
        style: TextStyle(
          fontSize: 11,
          color: mucusColor.withAlpha(180),
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(cx - textPainter.width / 2, size.height - 22),
    );
  }

  void _drawFinger(Canvas canvas, double x, double cy, Size size,
      {required bool isLeft}) {
    final paint = Paint()..color = skinColor;
    final outline = Paint()
      ..color = skinColor.withAlpha(120)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final nailPaint = Paint()
      ..color = const Color(0xFFF8E8D8);

    // Finger tip (rounded rectangle going down from center)
    final fingerWidth = 26.0;
    final fingerLength = 46.0;
    final tipRadius = fingerWidth / 2;

    final path = Path();
    if (isLeft) {
      // Left finger - tip points right
      final left = x - fingerWidth / 2;
      final top = cy - fingerLength / 2;
      path.addRRect(RRect.fromLTRBR(
        left, top,
        left + fingerWidth, top + fingerLength,
        Radius.circular(tipRadius),
      ));
    } else {
      // Right finger - tip points left
      final left = x - fingerWidth / 2;
      final top = cy - fingerLength / 2;
      path.addRRect(RRect.fromLTRBR(
        left, top,
        left + fingerWidth, top + fingerLength,
        Radius.circular(tipRadius),
      ));
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(path, outline);

    // Fingernail
    final nailRect = RRect.fromLTRBR(
      x - 8, cy - fingerLength / 2 + 4,
      x + 8, cy - fingerLength / 2 + 18,
      const Radius.circular(8),
    );
    canvas.drawRRect(nailRect, nailPaint);
    canvas.drawRRect(nailRect, Paint()
      ..color = skinColor.withAlpha(80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8);

    // Finger crease lines
    final creasePaint = Paint()
      ..color = skinColor.withAlpha(80)
      ..strokeWidth = 0.8;
    canvas.drawLine(
      Offset(x - 8, cy + 4),
      Offset(x + 8, cy + 4),
      creasePaint,
    );
    canvas.drawLine(
      Offset(x - 6, cy + 10),
      Offset(x + 6, cy + 10),
      creasePaint,
    );
  }

  void _drawDryIndicator(Canvas canvas, double cx, double cy, Size size) {
    // Small "nothing here" indicator — dashed arc
    final paint = Paint()
      ..color = mucusColor.withAlpha(100)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i < 5; i++) {
      final angle = -math.pi / 4 + (i * math.pi / 10);
      final x1 = cx + 8 * math.cos(angle);
      final y1 = cy + 8 * math.sin(angle);
      final x2 = cx + 12 * math.cos(angle);
      final y2 = cy + 12 * math.sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  void _drawNothingIndicator(Canvas canvas, double cx, double cy,
      Size size) {
    // Very faint circle — "nothing"
    final paint = Paint()
      ..color = mucusColor.withAlpha(50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(Offset(cx, cy), 10, paint);

    // Question mark
    final textPainter = TextPainter(
      text: TextSpan(
        text: '—',
        style: TextStyle(
          fontSize: 14,
          color: mucusColor.withAlpha(80),
          fontWeight: FontWeight.w300,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas,
        Offset(cx - textPainter.width / 2, cy - textPainter.height / 2));
  }

  void _drawStickyMucus(Canvas canvas, double cx, double cy,
      double gap, Size size) {
    final paint = Paint()
      ..color = mucusColor.withAlpha(160)
      ..style = PaintingStyle.fill;

    // Small blobs on each fingertip, broken strand in the middle
    // Left blob
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx - gap + 14, cy),
          width: 12, height: 8),
      paint,
    );
    // Right blob
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx + gap - 14, cy),
          width: 12, height: 8),
      paint,
    );

    // Broken strand fragments
    final strandPaint = Paint()
      ..color = mucusColor.withAlpha(120)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(cx - gap + 20, cy),
      Offset(cx - 6, cy - 1),
      strandPaint,
    );
    canvas.drawLine(
      Offset(cx + gap - 20, cy),
      Offset(cx + 6, cy + 1),
      strandPaint,
    );
    // Gap in middle = broken
  }

  void _drawCreamyMucus(Canvas canvas, double cx, double cy,
      double gap, Size size) {
    final paint = Paint()
      ..color = mucusColor.withAlpha(130);

    // Thicker strand that stretches but is opaque/creamy
    final path = Path();
    final leftEdge = cx - gap + 14;
    final rightEdge = cx + gap - 14;

    path.moveTo(leftEdge, cy - 5);
    path.cubicTo(
      cx - 10, cy - 8,
      cx + 10, cy - 3,
      rightEdge, cy - 4,
    );
    path.lineTo(rightEdge, cy + 4);
    path.cubicTo(
      cx + 10, cy + 3,
      cx - 10, cy + 8,
      leftEdge, cy + 5,
    );
    path.close();
    canvas.drawPath(path, paint);

    // Slight sheen highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withAlpha(50)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(leftEdge + 4, cy - 3),
      Offset(rightEdge - 4, cy - 2),
      highlightPaint,
    );
  }

  void _drawEggWhiteMucus(Canvas canvas, double cx, double cy,
      double gap, Size size) {
    // Long, thin, transparent stretchy strand
    final leftEdge = cx - gap + 14;
    final rightEdge = cx + gap - 14;

    // Main strand — slight sag
    final path = Path();
    path.moveTo(leftEdge, cy);
    path.quadraticBezierTo(cx, cy + 10, rightEdge, cy);
    canvas.drawPath(path, Paint()
      ..color = mucusColor.withAlpha(60)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round);

    // Thinner parallel strand
    final path2 = Path();
    path2.moveTo(leftEdge, cy - 2);
    path2.quadraticBezierTo(cx, cy + 6, rightEdge, cy - 2);
    canvas.drawPath(path2, Paint()
      ..color = mucusColor.withAlpha(40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5);

    // Sheen highlights
    canvas.drawLine(
      Offset(cx - 20, cy + 3),
      Offset(cx + 15, cy + 5),
      Paint()
        ..color = Colors.white.withAlpha(70)
        ..strokeWidth = 1
        ..strokeCap = StrokeCap.round,
    );

    // Blobs on fingertips
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(leftEdge, cy),
          width: 10, height: 10),
      Paint()..color = mucusColor.withAlpha(70),
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(rightEdge, cy),
          width: 10, height: 10),
      Paint()..color = mucusColor.withAlpha(70),
    );

    // Stretch distance label
    final distPainter = TextPainter(
      text: TextSpan(
        text: '↔ 3–10+ cm',
        style: TextStyle(
          fontSize: 10,
          color: mucusColor.withAlpha(140),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    distPainter.paint(canvas,
        Offset(cx - distPainter.width / 2, cy + 16));
  }

  String _labelForType(_MucusIllustration type) {
    switch (type) {
      case _MucusIllustration.dry:
        return 'No mucus between fingers';
      case _MucusIllustration.nothing:
        return 'Nothing to pick up';
      case _MucusIllustration.sticky:
        return 'Breaks apart immediately';
      case _MucusIllustration.creamy:
        return 'Stretches 1–2 cm, creamy';
      case _MucusIllustration.eggWhite:
        return 'Long elastic threads';
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Guide on how to collect a mucus sample
class _SamplingGuide extends StatelessWidget {
  final ColorScheme colors;

  const _SamplingGuide({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant.withAlpha(100)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: const Border(),
        collapsedShape: const Border(),
        initiallyExpanded: true,
        leading: Icon(Icons.lightbulb_outline,
            size: 20, color: colors.primary),
        title: Text('How to observe & collect a sample',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: colors.primary,
            )),
        children: [
          Text(
            'There are three ways to check your cervical mucus. '
            'Use whichever feels most comfortable — what matters '
            'is that you do it consistently.',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: colors.onSurface.withAlpha(200),
            ),
          ),
          const SizedBox(height: 14),

          _samplingMethod(
            '1',
            'Toilet paper method',
            'Before urinating, wipe the vaginal opening from '
            'front to back with white, unscented toilet paper. '
            'Look at the tissue: is there anything on it? '
            'Note the color, consistency, and how it feels '
            'while wiping (dry, smooth, slippery?).',
          ),
          _samplingMethod(
            '2',
            'Finger method',
            'With clean hands, insert your index or middle '
            'finger into the vagina (about 2–3 cm is enough). '
            'Gently sweep around the cervical opening. Remove '
            'your finger and examine what\'s on it. Then do '
            'the finger test: press the mucus between your '
            'thumb and forefinger and slowly pull apart. '
            'Note how far it stretches before breaking.',
          ),
          _samplingMethod(
            '3',
            'Underwear check',
            'Look at your underwear throughout the day. '
            'Cervical mucus often leaves visible marks — '
            'note whether the spot is dry, creamy, wet, '
            'or shows clear stretchy residue.',
          ),

          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.tertiaryContainer.withAlpha(50),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.tips_and_updates_outlined,
                    size: 16, color: colors.tertiary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Always record the HIGHEST quality you observed '
                    'during the day. If you saw sticky mucus in the '
                    'morning but egg white in the afternoon, record '
                    'egg white.\n\n'
                    'Check several times per day — mucus can change '
                    'throughout the day. Pay extra attention to the '
                    'sensation: the slippery/lubricative feeling is '
                    'often the most reliable indicator, even when '
                    'you can\'t see much.',
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.45,
                      color: colors.onSurface.withAlpha(190),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _samplingMethod(String number, String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Text(number,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: colors.primary,
                )),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    )),
                const SizedBox(height: 3),
                Text(text,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.45,
                      color: colors.onSurface.withAlpha(190),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressionRow extends StatelessWidget {
  final String phase;
  final String mucus;
  final Color color;

  const _ProgressionRow(this.phase, this.mucus, this.color);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: Text(phase,
                style: TextStyle(
                  fontSize: 12.5,
                  color: colors.onSurface,
                )),
          ),
          Expanded(
            child: Text(mucus,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurfaceVariant,
                )),
          ),
        ],
      ),
    );
  }
}
