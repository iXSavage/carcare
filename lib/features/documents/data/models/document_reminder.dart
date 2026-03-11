import 'package:isar/isar.dart';

import '../../../../core/constants/app_constants.dart';

part 'document_reminder.g.dart';

/// The current expiry status of a document, computed at read-time.
enum DocumentStatus {
  ok, // More than dueSoonDaysThreshold days remaining
  warning, // criticalDaysThreshold+1 – dueSoonDaysThreshold days remaining
  critical, // 0 – criticalDaysThreshold days remaining
  expired, // Past the expiry date
}

@collection
class DocumentReminder {
  Id id = Isar.autoIncrement;

  // --- Core Fields ---

  /// Foreign key linking this to a specific Car.
  late int carId;

  /// The type/category of the document. e.g., "Insurance", "Registration", "MOT"
  late String documentType;

  /// A human-readable label. e.g., "2026 State Registration"
  late String documentTitle;

  /// The exact date the document expires.
  late DateTime expiryDate;

  // --- Reminder Config ---

  /// A list of integer day offsets representing when to notify the user
  /// BEFORE expiry. e.g., [30, 7, 0] = notify 30 days before, 7 days before,
  /// and on the day of expiry.
  /// Default mirrors AppConstants.defaultReminderOffsets — kept inline because
  /// Isar requires a const-compatible default at the field declaration site.
  List<int> reminderOffsets = [
    30,
    7,
    0,
  ]; // == AppConstants.defaultReminderOffsets

  /// Whether this document reminder is active. Inactive reminders are muted
  /// without being deleted.
  bool isActive = true;

  // --- Notification Tracking ---

  /// The notification IDs scheduled for this document (one per offset).
  List<int> notificationIds = [];

  /// Tracks the last offset that was fired, to prevent duplicate notifications.
  int? lastNotifiedOffset;

  // --- Metadata ---

  DateTime? issueDate;
  String? issuingAuthority;
  String? notes;

  // --- Computed Helpers (NOT stored, computed at runtime) ---

  /// Fix #2 + #3: Status now uses AppConstants thresholds — no magic numbers.
  @ignore
  DocumentStatus get status {
    final daysLeft = daysUntilExpiry;
    if (daysLeft < 0) {
      return DocumentStatus.expired;
    }
    if (daysLeft <= AppConstants.criticalDaysThreshold) {
      return DocumentStatus.critical;
    }
    if (daysLeft <= AppConstants.dueSoonDaysThreshold) {
      return DocumentStatus.warning;
    }
    return DocumentStatus.ok;
  }

  /// Returns days remaining (negative if already expired).
  @ignore
  int get daysUntilExpiry => expiryDate.difference(DateTime.now()).inDays;
}
