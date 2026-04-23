# Daily Check-in Notifications

Crest can remind you once per day to log your basal body temperature
and cervical mucus. A single, quiet notification fires at a time you choose
— nothing else, no streaks, no guilt-trip copy.

## User setting

Settings → **Reminders**:

- **Daily check-in reminder** — master on/off switch.
- **Reminder time** — local time of day the notification fires
  (default 07:00). Only editable while the switch is on.

The time is stored in `SharedPreferences` as two ints
(`dailyReminderHour`, `dailyReminderMinute`) plus the boolean
`dailyReminderEnabled`. The app re-applies the schedule on startup
and whenever the setting changes.

## Technical implementation

- **Package:** `flutter_local_notifications` (+ `timezone` for zoned
  scheduling). All scheduling is local to the device — no push server,
  no network, no account.
- **Service:** `lib/services/notification_service.dart`, a singleton with
  `initialize()`, `scheduleDailyReminder(hour, minute)`, and
  `cancelDailyReminder()`.
- **Channel:** single Android channel `stm_daily_reminder`
  ("Daily check-in"), default importance.
- **Schedule mode:** `zonedSchedule` with
  `matchDateTimeComponents: DateTimeComponents.time`, so one entry
  repeats daily at the chosen wall-clock time across DST transitions.
  Uses `AndroidScheduleMode.inexactAllowWhileIdle` — we deliberately
  do *not* request the `SCHEDULE_EXACT_ALARM` permission, since a
  few minutes of slack is fine for a charting reminder and avoids
  the Android 12+ user-facing permission prompt.
- **ID:** a single constant (`1001`). Re-scheduling cancels the
  previous entry first so there is never more than one pending
  reminder.
- **Boot persistence:** `AndroidManifest.xml` declares
  `RECEIVE_BOOT_COMPLETED` plus the plugin's
  `ScheduledNotificationBootReceiver`, so the reminder survives
  reboots.
- **Android 13+ runtime permission:** requested via
  `AndroidFlutterLocalNotificationsPlugin.requestNotificationsPermission()`
  on first `initialize()`. If the user declines, scheduling calls
  silently no-op.
- **Desugaring:** enabled in `android/app/build.gradle.kts`
  (`isCoreLibraryDesugaringEnabled = true` + `desugar_jdk_libs`) —
  required by `flutter_local_notifications` 17 for `java.time`.
- **Web:** all methods no-op when `kIsWeb` is true.

## Privacy

- Reminders are scheduled and fired entirely on-device by the Android
  AlarmManager.
- No user data is included in the notification payload beyond a generic
  "Time to chart" title.
- Nothing leaves the device when the reminder fires.

## Known limitations

- Only one reminder time per day. A second "evening review" reminder
  would be straightforward to add (new ID, new setting) if users ask.
- iOS is not wired up yet — the plugin supports it, but we have no iOS
  build target in this repo.
- Delivery is inexact (±several minutes) by design; users who need an
  exact-time alarm can set their phone alarm separately.
