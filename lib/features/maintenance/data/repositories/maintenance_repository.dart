import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_provider.dart';
import '../../../../core/providers/car_providers.dart';
import '../models/maintenance_task.dart';

part 'maintenance_repository.g.dart';

class MaintenanceRepository {
  final Isar isar;

  MaintenanceRepository(this.isar);

  Future<void> saveTask(MaintenanceTask task) async {
    // Computed fields updated in repository layer, not on the model.
    task.updateComputedFields();

    await isar.writeTxn(() async {
      await isar.maintenanceTasks.put(task);
    });
  }

  Future<void> deleteTask(int id) async {
    await isar.writeTxn(() async {
      await isar.maintenanceTasks.delete(id);
    });
  }

  /// Watch all tasks for a specific car.
  Stream<List<MaintenanceTask>> watchTasksForCar(int carId) {
    return isar.maintenanceTasks
        .filter()
        .carIdEqualTo(carId)
        .watch(fireImmediately: true);
  }
}

@riverpod
MaintenanceRepository maintenanceRepository(MaintenanceRepositoryRef ref) {
  return MaintenanceRepository(ref.watch(isarProvider));
}

/// Streams maintenance tasks for the currently active car.
@riverpod
Stream<List<MaintenanceTask>> activeCarMaintenanceTasks(
  ActiveCarMaintenanceTasksRef ref,
) {
  final carAsync = ref.watch(currentCarProvider);
  final repo = ref.watch(maintenanceRepositoryProvider);
  final carId = carAsync.valueOrNull?.id ?? 0;
  return repo.watchTasksForCar(carId);
}
