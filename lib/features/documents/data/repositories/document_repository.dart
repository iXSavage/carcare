import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_provider.dart';
import '../../../../core/providers/car_providers.dart';
import '../models/document_reminder.dart';

part 'document_repository.g.dart';

class DocumentRepository {
  final Isar isar;

  DocumentRepository(this.isar);

  Future<void> saveDocument(DocumentReminder doc) async {
    await isar.writeTxn(() async {
      await isar.documentReminders.put(doc);
    });
  }

  Future<void> deleteDocument(int id) async {
    await isar.writeTxn(() async {
      await isar.documentReminders.delete(id);
    });
  }

  Future<DocumentReminder?> getDocumentById(int id) async {
    return isar.documentReminders.get(id);
  }

  /// Watch all documents for a specific car.
  Stream<List<DocumentReminder>> watchDocumentsForCar(int carId) {
    return isar.documentReminders
        .filter()
        .carIdEqualTo(carId)
        .watch(fireImmediately: true);
  }
}

@riverpod
DocumentRepository documentRepository(DocumentRepositoryRef ref) {
  return DocumentRepository(ref.watch(isarProvider));
}

/// Streams documents for the currently active car.
@riverpod
Stream<List<DocumentReminder>> activeCarDocuments(ActiveCarDocumentsRef ref) {
  final carAsync = ref.watch(currentCarProvider);
  final repo = ref.watch(documentRepositoryProvider);
  final carId = carAsync.valueOrNull?.id ?? 0;
  return repo.watchDocumentsForCar(carId);
}
