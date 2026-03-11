import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../features/documents/data/models/document_reminder.dart';
import '../../features/maintenance/data/models/maintenance_task.dart';

part 'notification_service.g.dart';

// ── Channel constants ─────────────────────────────────────────────────────────
const _channelId = 'carcare_reminders';
const _channelName = 'CarCare Reminders';
const _channelDesc = 'Document expiry and maintenance reminders';

// ── Notification ID strategy (all must be unique ints) ────────────────────────
//
//   Document offset notification : doc.id * 100 + offsetIndex
//     e.g. doc(id=5), offset[0]=30d → notif id 500
//          doc(id=5), offset[1]=7d  → notif id 501
//
//   Maintenance overdue alert    : task.id * 10000
//     (large enough to never collide with doc IDs)
int _docNotifId(int docId, int offsetIndex) => docId * 100 + offsetIndex;
int _taskNotifId(int taskId) => taskId * 10000;

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ── Init ───────────────────────────────────────────────────────────────────

  Future<void> init() async {
    tz.initializeTimeZones();

    // Resolve the device local timezone. Dart's DateTime gives us the name
    // (e.g. "CET" or "Europe/Amsterdam"); look it up in the tz database.
    // Fall back to UTC on any error so scheduling still silently works.
    try {
      final String timezoneName = DateTime.now().timeZoneName;
      tz.setLocalLocation(tz.getLocation(timezoneName));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@drawable/notification_icon'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    await _plugin.initialize(settings: initSettings);

    // Request Android 13+ runtime notification permission
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  // ── Shared notification details ────────────────────────────────────────────

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@drawable/notification_icon',
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  // ── Document reminders ─────────────────────────────────────────────────────

  /// Schedules future notifications for each active reminder offset on [doc].
  /// Silently skips any offset whose fire time is already in the past.
  Future<void> scheduleDocumentReminders(DocumentReminder doc) async {
    if (!doc.isActive) return;

    // Guard: if timezone isn't initialised yet, skip scheduling silently
    late final tz.TZDateTime now;
    try {
      now = tz.TZDateTime.now(tz.local);
    } catch (_) {
      return;
    }

    final scheduledIds = <int>[];

    for (var i = 0; i < doc.reminderOffsets.length; i++) {
      final offsetDays = doc.reminderOffsets[i];
      try {
        final fireAt = tz.TZDateTime.from(
          doc.expiryDate.subtract(Duration(days: offsetDays)),
          tz.local,
        );

        if (fireAt.isBefore(now)) continue; // already past — skip

        final notifId = _docNotifId(doc.id, i);

        final title = offsetDays == 0
            ? '⚠️ ${doc.documentTitle} expires today!'
            : '📄 ${doc.documentTitle} expires in $offsetDays days';

        final body = offsetDays == 0
            ? 'Your ${doc.documentType} expires today. Renew it now.'
            : 'Your ${doc.documentType} expires on '
                  '${doc.expiryDate.day}/${doc.expiryDate.month}/${doc.expiryDate.year}.';

        // v21 API: all named parameters
        await _plugin.zonedSchedule(
          id: notifId,
          scheduledDate: fireAt,
          notificationDetails: _details,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          title: title,
          body: body,
          payload: 'doc:${doc.id}',
        );

        scheduledIds.add(notifId);
      } catch (_) {
        // Notification scheduling should never break the save flow
        continue;
      }
    }

    // Persist the scheduled IDs so they can be cancelled later
    doc.notificationIds = scheduledIds;
  }

  /// Cancels all pending notifications for [doc] using its stored IDs.
  Future<void> cancelDocumentReminders(DocumentReminder doc) async {
    for (final id in doc.notificationIds) {
      await _plugin.cancel(id: id);
    }
    doc.notificationIds = [];
  }

  // ── Maintenance alerts ─────────────────────────────────────────────────────

  /// Fires an immediate notification when [task] becomes overdue.
  Future<void> notifyMaintenanceOverdue(MaintenanceTask task) async {
    await _plugin.show(
      id: _taskNotifId(task.id),
      title: '🔧 ${task.taskName} is overdue',
      body:
          'Your ${task.taskName} service is past due. '
          'Tap to open the Maintenance tab.',
      notificationDetails: _details,
      payload: 'task:${task.id}',
    );
  }

  /// Cancels the overdue notification for [task] (e.g. after marking done).
  Future<void> cancelMaintenanceNotification(MaintenanceTask task) async {
    await _plugin.cancel(id: _taskNotifId(task.id));
  }
}

@Riverpod(keepAlive: true)
NotificationService notificationService(NotificationServiceRef ref) {
  throw UnimplementedError(
    'NotificationService must be initialized before use',
  );
}
