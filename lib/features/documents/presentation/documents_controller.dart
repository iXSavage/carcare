import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/providers/car_providers.dart';
import '../data/models/document_reminder.dart';
import '../data/repositories/document_repository.dart';

part 'documents_controller.g.dart';

@riverpod
class DocumentsController extends _$DocumentsController {
  @override
  FutureOr<void> build() {}

  // ── Convenience accessors ─────────────────────────────────────────────────

  DocumentRepository get _repo => ref.read(documentRepositoryProvider);

  NotificationService get _notifications =>
      ref.read(notificationServiceProvider);

  // ── Save ──────────────────────────────────────────────────────────────────

  Future<void> saveDocument({
    required String documentType,
    required String documentTitle,
    required DateTime expiryDate,
    DateTime? issueDate,
    String? issuingAuthority,
    String? notes,
    List<int> reminderOffsets = AppConstants.defaultReminderOffsets,
    int? id,
  }) async {
    final carId = ref.read(currentCarProvider).valueOrNull?.id ?? 0;

    // On edit: fetch existing doc first to preserve isActive
    final existingDoc = id != null ? await _repo.getDocumentById(id) : null;

    final doc = DocumentReminder()
      ..id = id ?? Isar.autoIncrement
      ..carId = carId
      ..documentType = documentType
      ..documentTitle = documentTitle
      ..expiryDate = expiryDate
      ..issueDate = issueDate
      ..issuingAuthority = issuingAuthority
      ..notes = notes
      ..reminderOffsets = reminderOffsets
      // Preserve mute state — never silently reactivate a muted doc
      ..isActive = existingDoc?.isActive ?? true;

    // Cancel existing notifications before re-scheduling
    if (existingDoc != null) {
      await _notifications.cancelDocumentReminders(existingDoc);
    }

    // Only schedule if the document is active
    if (doc.isActive) {
      await _notifications.scheduleDocumentReminders(doc);
    }
    await _repo.saveDocument(doc);
  }

  // ── Toggle active (mute / unmute) ─────────────────────────────────────────

  Future<void> toggleActive(DocumentReminder doc) async {
    doc.isActive = !doc.isActive;

    if (doc.isActive) {
      await _notifications.scheduleDocumentReminders(doc);
    } else {
      await _notifications.cancelDocumentReminders(doc);
    }

    await _repo.saveDocument(doc);
  }

  // ── Delete ────────────────────────────────────────────────────────────────

  Future<void> deleteDocument(int id) async {
    // Cancel notifications BEFORE deleting so we still have the stored IDs
    final doc = await _repo.getDocumentById(id);
    if (doc != null) {
      await _notifications.cancelDocumentReminders(doc);
    }
    await _repo.deleteDocument(id);
  }
}
