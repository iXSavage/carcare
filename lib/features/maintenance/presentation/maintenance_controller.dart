import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/car_providers.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/providers/service_providers.dart';
import '../data/models/maintenance_task.dart';
import '../data/repositories/maintenance_repository.dart';

part 'maintenance_controller.g.dart';

@riverpod
class MaintenanceController extends _$MaintenanceController {
  @override
  FutureOr<void> build() {}

  Future<void> saveTask({
    required String taskName,
    required DateTime? lastServiceDate,
    required int? lastServiceMileage,
    required int? mileageInterval,
    required int? timeIntervalMonths,
    int? id,
  }) async {
    final carId = ref.read(currentCarProvider).valueOrNull?.id ?? 0;

    final task = MaintenanceTask()
      ..id = id ?? Isar.autoIncrement
      ..carId = carId
      ..taskName = taskName
      ..lastServiceDate = lastServiceDate
      ..lastServiceMileage = lastServiceMileage
      ..mileageInterval = mileageInterval
      ..timeIntervalMonths = timeIntervalMonths;

    await ref.read(maintenanceRepositoryProvider).saveTask(task);
  }

  Future<void> markAsDone(MaintenanceTask task, {String? notes}) async {
    final car = ref.read(currentCarProvider).valueOrNull;
    final currentMileage = car?.currentMileage;
    final carId = car?.id ?? 0;

    // Mutate in-place — only touch fields that change
    task.lastServiceDate = DateTime.now();
    task.lastServiceMileage = currentMileage;
    if (notes != null) task.notes = notes;

    await ref.read(maintenanceRepositoryProvider).saveTask(task);

    // Auto-log: create a ServiceLog entry so the history tab populates
    final log = ServiceLog()
      ..carId = carId
      ..serviceName = task.taskName
      ..serviceDate = DateTime.now()
      ..mileageAtService = currentMileage
      ..linkedTaskId = task.id
      ..notes = notes;
    await ref.read(serviceHistoryRepositoryProvider).saveLog(log);

    // Cancel the overdue notification now the task is resolved
    await ref
        .read(notificationServiceProvider)
        .cancelMaintenanceNotification(task);
  }

  Future<void> deleteTask(int id) async {
    await ref.read(maintenanceRepositoryProvider).deleteTask(id);
  }
}
