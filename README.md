# Crest

A free, offline charting app for the symptothermal method (STM / NFP / FAM).
Android. No account. No ads. No predictions dressed up as science.

---

## Why this exists

I'm a med student. STM came up during my gynecology module, and I'd vaguely
heard of it before but always assumed it was the rhythm method with extra
steps. Turns out it's a genuinely well-researched method with clearly defined
rules — the rotation made me actually read into it properly.

Not long after, my partner told me she wanted to come off the pill. So we
figured we'd try STM together. She read through the method literature, I had
the background from uni, and we started charting.

Then came the app question. I spent a weekend going through what's out there
and got progressively more confused. A lot of apps advertise STM but when you
look at how they actually determine the fertile window, it's based on your
past cycle lengths — which is the calendar method with a temperature graph
on top. The ones that do implement STM correctly are either behind a
subscription, German-only, or feel abandoned.

I didn't want to pay a monthly fee for what's essentially a digital version
of a paper chart. And I wasn't comfortable using something where I couldn't
tell what logic was running underneath.

So I spent a few weekends building one. It turned out okay, so I figured I'd
put it out there.

---

## What it is

A charting tool. BBT, cervical mucus, cervix, the usual. The evaluation
follows the published STM rules and the AG NFP guidelines — nothing else.

- No algorithm that learns from your data.
- No predictions from past cycles.
- No proprietary logic.

If a day gets marked fertile, you can trace exactly which rule caused it.

## The educational side

There's an extensive section on the biology behind the method — the hormonal
cycle, why the biomarkers work, how the rules were derived from the
underlying physiology. Every claim in there is backed by primary sources.

For me that's as important as the charting itself. Ideally you learn STM
from a qualified instructor, but I wanted people to have the option to
understand the method properly rather than just following rules on faith.

## Privacy

- Everything stored locally on your phone.
- No account, no sign-in, no cloud.
- No analytics, no tracking, no ads.
- Nothing leaves the device.

---

## Download

Grab the latest APK from the [Releases page](../../releases).

Android only for now. iOS is on the maybe-list.

---

## Feedback

This is a first release. The charting logic works and has been checked
against the guidelines, but the UX has rough edges and I'd rather hear about
them than pretend they aren't there.

Useful places to tell me:

- **Open an [issue](../../issues)** for anything concrete — bugs, rule
  interpretations that look off, UX friction, missing inputs.
- **[Discussions](../../discussions)** for open-ended questions or ideas.

If you've been charting a while and something in the evaluation doesn't
match the guidelines as you understand them, please say so. That's the
kind of feedback I want most.

---

## Disclaimer

Crest is a charting tool, not a medical device. It does not provide
medical advice, diagnosis, or treatment, and it is not a substitute for a
qualified instructor.

The symptothermal method is effective when applied correctly by someone
trained in it. If you are using STM to avoid pregnancy, learn the method
properly before relying on it.

This app is an independent project. It is compatible with the symptothermal
method as taught by the AG NFP / Malteser, but it is not affiliated with,
endorsed by, or certified by any organization. "Sensiplan" is a registered
trademark of the Malteser AG NFP and is not used to describe this app.

---

## For developers

Built with Flutter. Local SQLite, no backend.

```bash
flutter pub get
flutter run
```

The STM evaluation engine lives in [`lib/services/stm_engine.dart`](lib/services/stm_engine.dart).
If you spot a rule that's implemented incorrectly, that's where to look —
and a PR with a failing test case is the fastest way to get it fixed.

## License

MIT. Do what you want with the code.

The method itself belongs to nobody. The trademarks belong to their owners.
