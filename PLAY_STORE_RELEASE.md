# Crest — Google Play release guide

Everything needed to ship Crest to the Play Store. Items marked **[you]** must
be done by you (they need your Google account, your keystore password, or the
Play Console). Items marked **[done]** are already set up in this repo.

---

## 1. One-time account setup **[you]**

1. Create a Google Play Developer account: https://play.google.com/console
   — one-time **$25** fee, plus identity verification (can take a few days, so
   start this early).
2. Decide on an account type. For an indie release, a **personal** account is
   fine. (A registered organization is only needed for some donation models —
   not required for the Ko-fi link approach Crest uses.)

---

## 2. Signing key **[you]**

The Gradle build is already wired to use a release keystore if present, and to
fall back to debug keys otherwise (`android/app/build.gradle.kts`). **[done]**

You must generate the keystore once:

```bash
keytool -genkey -v -keystore crest-upload-keystore.jks \
        -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Then:

1. Move the `.jks` somewhere safe **outside the repo** (e.g. `C:/Users/Jakub/keys/`).
2. Copy `android/key.properties.example` to `android/key.properties` and fill in
   your real passwords + the absolute path to the `.jks`.
3. **Back up the keystore and passwords.** If you lose them you cannot update the
   app on Play without going through Google's key-reset process.

`key.properties`, `*.jks`, and `*.keystore` are git-ignored. **[done]**

> Tip: enroll in **Play App Signing** (the Console offers this on first upload).
> Google then manages the app signing key; your `.jks` becomes only the *upload*
> key, which Google can reset if lost. Recommended.

---

## 3. Build the release artifact **[done — re-run when shipping]**

Play requires an **Android App Bundle (.aab)**, not an APK:

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

(The APK in the GitHub release is for direct sideloading; Play needs the AAB.)

Release minification (R8) and resource shrinking are enabled, with ProGuard keep
rules for `flutter_local_notifications` so scheduled reminders survive R8. **[done]**

---

### Toolchain note — native symbol stripping **[you, one-time]**

`flutter build appbundle` strips debug symbols from the native libraries and
needs the **Android NDK + cmdline-tools** for that step. On a machine without
them you'll see:

> Release app bundle failed to strip debug symbols from native libraries.

The `.aab` is still produced and is valid/uploadable — only the (optional)
symbol stripping is skipped, making the native libs slightly larger. To get a
clean build (exit 0), install the missing pieces:

1. `flutter doctor` currently reports *"cmdline-tools component is missing"*.
   Install it via Android Studio → SDK Manager → SDK Tools → check
   **Android SDK Command-line Tools** and **NDK (Side by side)**, or:
   ```bash
   sdkmanager "cmdline-tools;latest" "ndk;<version>"
   flutter doctor --android-licenses   # accept all
   ```
2. Re-run `flutter build appbundle --release`.

The APK build (`flutter build apk --release`) does not strip and is unaffected.

## 4. Versioning **[you, each release]**

Bump in `pubspec.yaml` before each upload (`version: x.y.z+BUILD`). The build
number (after `+`) must increase on every upload. Current: `0.1.0+1`.

---

## 5. Store listing **[you — text drafted below]**

In the Console: Create app → fill out:

- **App name:** Crest
- **Short description (max 80 chars):**

  > Free, private symptothermal method (STM/NFP) charting. Offline, no account.

- **Full description (max 4000 chars):** see `assets/play/listing_full.txt`
- **App icon (512×512):** `assets/play/play_icon_512.png` **[done]**
- **Feature graphic (1024×500):** `assets/play/feature_graphic.png` **[done]**
- **Phone screenshots (min 2, max 8):** capture from the app **[you]** — at
  minimum: the chart screen, the calendar, a day-entry screen, and the learn
  section. Use a clean demo cycle.
- **Category:** Health & Fitness
- **Tags:** fertility, cycle tracking, health

---

## 6. Privacy policy **[done — host it [you]]**

`PRIVACY.md` is written. Play requires a public **URL**. Easiest options:

- Enable **GitHub Pages** for the repo (Settings → Pages → deploy from `main`),
  then link to the rendered file, **or**
- Use the GitHub-rendered URL directly:
  `https://github.com/ticklish-bear/crest/blob/main/PRIVACY.md`

Paste that URL into Console → Policy → App content → Privacy policy.

---

## 7. App content declarations **[you — answers below]**

Console → Policy → App content. Suggested answers based on how Crest actually
behaves:

- **Privacy policy:** URL from step 6.
- **Ads:** No, the app contains no ads.
- **Data safety:**
  - Does your app collect or share user data? **No.** Crest stores everything
    locally and makes no network calls. (Be ready to explain: the only data
    exists on-device; export is user-initiated to the system share sheet.)
  - Is data encrypted in transit? **N/A — no data is transmitted.**
  - Can users request deletion? **Yes — in-app: Settings → Delete all data.**
- **Content rating:** complete the questionnaire. Crest is a health/charting
  tool with no objectionable content → expect **Everyone / PEGI 3**. There is a
  reproductive-health context; answer honestly (no sexual content, it's a
  medical/health tracker).
- **Target audience:** adults (18+) — it's a fertility tool. Not designed for
  children; do not opt into the "Designed for Families" program.
- **Health apps declaration:** if prompted, Crest is a personal wellness/
  fertility tracker, **not** a medical device, and makes no diagnostic claims.
- **Government app / Financial features:** No.
- **Data collection from children:** No.

---

## 8. Permissions justification **[reference]**

The manifest declares:

- `POST_NOTIFICATIONS` — the optional daily check-in reminder.
- `RECEIVE_BOOT_COMPLETED` — re-schedule that reminder after a reboot.
- `WAKE_LOCK` — used by the notification scheduler.

All three are tied to the local reminder feature; none involve network or data
collection.

---

## 9. Donations / monetization **[done in-app — handle [you]]**

Crest uses a **voluntary, external** donation link (Ko-fi), surfaced under
Settings → Support. This is deliberate:

- Donations **unlock nothing** — every feature is free for everyone. That is
  what keeps an external payment link compliant with Google Play's payments
  policy (Play Billing is only required when you sell in-app digital content;
  no-benefit donations may use external processors).
- No ads, no subscription, no paywall.

**Before publishing:** set your real Ko-fi handle in
`lib/config/support_links.dart` (`SupportLinks.kofi`). Create the page at
https://ko-fi.com if you haven't. To hide the feature entirely, set
`SupportLinks.enabled = false`.

---

## 10. Pre-launch checklist

- [ ] Developer account created & identity verified **[you]**
- [ ] Keystore generated, `key.properties` filled, keystore backed up **[you]**
- [ ] Real Ko-fi handle set in `support_links.dart` **[you]**
- [ ] Version bumped in `pubspec.yaml` **[you]**
- [ ] `flutter build appbundle --release` produces a signed `.aab`
- [ ] Privacy policy URL live **[you]**
- [ ] Store listing text + graphics uploaded **[you]**
- [ ] Screenshots captured & uploaded **[you]**
- [ ] Data safety + content rating + target audience completed **[you]**
- [ ] Internal testing track release first, then production **[you]**

> Recommendation: push the first build to the **Internal testing** track,
> install it from the Play link on your own device, and confirm signing,
> notifications, and the donation link all work before promoting to production.
