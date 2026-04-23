import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Thin wrapper around `flutter_local_notifications` that the rest of the
/// app uses to schedule a single daily check-in reminder.
///
/// The service is a singleton because the underlying plugin keeps global
/// state (channels, pending notifications) and we only ever want one of
/// them active at a time.
///
/// On unsupported platforms (web / desktop in debug), calls silently
/// no-op so the rest of the app can treat notifications as always-on.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static const int _dailyReminderId = 1001;
  static const String _channelId = 'stm_daily_reminder';
  static const String _channelName = 'Daily check-in';
  static const String _channelDesc =
      'Reminds you to log BBT and mucus each morning.';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Must be called once during app startup (before any schedule/cancel).
  Future<void> initialize() async {
    if (_initialized) return;
    if (kIsWeb) {
      _initialized = true;
      return;
    }
    try {
      tz.initializeTimeZones();
      const androidInit =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const initSettings = InitializationSettings(android: androidInit);
      await _plugin.initialize(initSettings);

      // Request runtime permissions on Android 13+.
      final androidImpl =
          _plugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidImpl?.requestNotificationsPermission();
    } catch (e) {
      debugPrint('NotificationService init failed: $e');
    }
    _initialized = true;
  }

  Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
  }) async {
    if (kIsWeb) return;
    await initialize();
    try {
      await cancelDailyReminder();
      final scheduled = _nextInstanceOf(hour, minute);
      await _plugin.zonedSchedule(
        _dailyReminderId,
        'Time to chart',
        'Log your temperature and mucus for today.',
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDesc,
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      debugPrint('scheduleDailyReminder failed: $e');
    }
  }

  Future<void> cancelDailyReminder() async {
    if (kIsWeb) return;
    try {
      await _plugin.cancel(_dailyReminderId);
    } catch (e) {
      debugPrint('cancelDailyReminder failed: $e');
    }
  }

  tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
