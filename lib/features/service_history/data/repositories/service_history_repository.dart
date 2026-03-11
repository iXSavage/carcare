import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_provider.dart';
import '../../../../core/providers/car_providers.dart';
import '../models/service_log.dart';

part 'service_history_repository.g.dart';

class ServiceHistoryRepository {
  final Isar isar;

  ServiceHistoryRepository(this.isar);

  Future<void> saveLog(ServiceLog log) async {
    await isar.writeTxn(() async {
      await isar.serviceLogs.put(log);
    });
  }

  Future<void> deleteLog(int id) async {
    await isar.writeTxn(() async {
      await isar.serviceLogs.delete(id);
    });
  }

  /// Watch all logs for a specific car, sorted newest first.
  Stream<List<ServiceLog>> watchLogsForCar(int carId) {
    return isar.serviceLogs
        .filter()
        .carIdEqualTo(carId)
        .sortByServiceDateDesc()
        .watch(fireImmediately: true);
  }

  Future<List<ServiceLog>> getAllLogsForCar(int carId) async {
    return isar.serviceLogs
        .filter()
        .carIdEqualTo(carId)
        .sortByServiceDateDesc()
        .findAll();
  }
}

@riverpod
ServiceHistoryRepository serviceHistoryRepository(
  ServiceHistoryRepositoryRef ref,
) {
  return ServiceHistoryRepository(ref.watch(isarProvider));
}

/// Streams service logs for the currently active car.
@riverpod
Stream<List<ServiceLog>> activeCarServiceLogs(ActiveCarServiceLogsRef ref) {
  final carAsync = ref.watch(currentCarProvider);
  final repo = ref.watch(serviceHistoryRepositoryProvider);
  final carId = carAsync.valueOrNull?.id ?? 0;
  return repo.watchLogsForCar(carId);
}
