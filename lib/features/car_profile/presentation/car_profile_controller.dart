import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/notifications/notification_service.dart';
import '../../../core/providers/car_providers.dart';
import '../../../core/providers/maintenance_providers.dart';
import '../data/models/car.dart';
import '../data/repositories/car_repository.dart';

part 'car_profile_controller.g.dart';

@riverpod
class CarProfileController extends _$CarProfileController {
  @override
  FutureOr<Car?> build() async {
    return await ref.watch(currentCarProvider.future);
  }

  Future<void> saveCarProfile({
    required String make,
    required String model,
    required int year,
    required int mileage,
    String? licensePlate,
    String? vin,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(carRepositoryProvider);
      final current = await repo.getActiveCar() ?? Car();

      current.make = make;
      current.model = model;
      current.year = year;
      current.currentMileage = mileage;
      current.licensePlate = licensePlate;
      current.vin = vin;

      await repo.saveCar(current);
      return current;
    });
  }

  Future<void> updateMileage(int newMileage) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(carRepositoryProvider);
      final car = await repo.getActiveCar();
      if (car == null) return null;

      car.currentMileage = newMileage;
      await repo.saveCar(car);

      // After mileage update, check all tasks for newly-overdue status
      // and fire immediate notifications for any that crossed the threshold.
      await _checkMaintenanceAndNotify(newMileage);

      // Invalidate the current provider to update UI
      ref.invalidate(currentCarProvider);
      return car;
    });
  }

  Future<void> updateCarPhoto(Car car, String photoPath) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(carRepositoryProvider);
      car.photoPath = photoPath;
      await repo.saveCar(car);
      ref.invalidate(currentCarProvider);
      return car;
    });
  }

  /// Reads all maintenance tasks, evaluates each against [currentMileage],
  /// and fires an immediate overdue notification for any that are now overdue.
  /// Cancels notifications for tasks that are no longer overdue.
  Future<void> _checkMaintenanceAndNotify(int currentMileage) async {
    try {
      final carId = ref.read(currentCarProvider).valueOrNull?.id ?? 0;
      final tasks = await ref
          .read(maintenanceRepositoryProvider)
          .watchTasksForCar(carId)
          .first;

      final notifications = ref.read(notificationServiceProvider);

      for (final task in tasks) {
        final status = ReminderCalculator.calculateStatus(task, currentMileage);

        if (status == MaintenanceStatus.overdue) {
          await notifications.notifyMaintenanceOverdue(task);
        } else {
          // Task is no longer overdue (e.g., was marked done) — cancel alert
          await notifications.cancelMaintenanceNotification(task);
        }
      }
    } catch (_) {
      // Notification failure should never break the mileage update UX
    }
  }
}
