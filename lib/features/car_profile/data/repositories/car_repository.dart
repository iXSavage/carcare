import 'dart:io';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_provider.dart';
import '../models/car.dart';
import '../../../maintenance/data/models/maintenance_task.dart';
import '../../../documents/data/models/document_reminder.dart';
import '../../../service_history/data/models/service_log.dart';
import '../../../fuel_log/data/models/fuel_entry.dart';

part 'car_repository.g.dart';

class CarRepository {
  final Isar isar;

  CarRepository(this.isar);

  // ── Single active car ──────────────────────────────────────────────────

  Future<Car?> getActiveCar() async {
    return isar.cars.filter().isActiveEqualTo(true).findFirst();
  }

  Stream<Car?> watchActiveCar() {
    return isar.cars
        .filter()
        .isActiveEqualTo(true)
        .watch(fireImmediately: true)
        .map((list) => list.firstOrNull);
  }

  // ── All cars ──────────────────────────────────────────────────────────

  Future<List<Car>> getAllCars() async {
    return isar.cars.where().findAll();
  }

  Stream<List<Car>> watchAllCars() {
    return isar.cars.where().watch(fireImmediately: true);
  }

  // ── Save / delete ─────────────────────────────────────────────────────

  Future<void> saveCar(Car car) async {
    await isar.writeTxn(() async {
      // If this is the first car, mark it active automatically
      final count = await isar.cars.count();
      if (count == 0) car.isActive = true;
      await isar.cars.put(car);
    });
  }

  Future<void> deleteCar(int id) async {
    await isar.writeTxn(() async {
      final car = await isar.cars.get(id);

      // 1. Delete associated physical photo file
      if (car?.photoPath != null) {
        final photoFile = File(car!.photoPath!);
        if (photoFile.existsSync()) {
          photoFile.deleteSync();
        }
      }

      // 2. Cascade delete all associated Isar records
      await isar.maintenanceTasks.filter().carIdEqualTo(id).deleteAll();
      await isar.documentReminders.filter().carIdEqualTo(id).deleteAll();
      await isar.serviceLogs.filter().carIdEqualTo(id).deleteAll();
      await isar.fuelEntrys.filter().carIdEqualTo(id).deleteAll();

      // 3. Delete the car itself
      await isar.cars.delete(id);

      // 4. If the deleted car was active, promote the first remaining car
      if (car?.isActive == true) {
        final remaining = await isar.cars.where().findFirst();
        if (remaining != null) {
          remaining.isActive = true;
          await isar.cars.put(remaining);
        }
      }
    });
  }

  // ── Active car switching ──────────────────────────────────────────────

  Future<void> setActiveCar(int id) async {
    await isar.writeTxn(() async {
      // Deactivate all
      final all = await isar.cars.where().findAll();
      for (final c in all) {
        c.isActive = c.id == id;
      }
      await isar.cars.putAll(all);
    });
  }

  // ── Mileage helper ────────────────────────────────────────────────────

  Future<void> updateMileage(int newMileage) async {
    final car = await getActiveCar();
    if (car != null) {
      car.currentMileage = newMileage;
      await saveCar(car);
    }
  }
}

@riverpod
CarRepository carRepository(CarRepositoryRef ref) {
  return CarRepository(ref.watch(isarProvider));
}

@riverpod
Stream<Car?> currentCar(CurrentCarRef ref) {
  return ref.watch(carRepositoryProvider).watchActiveCar();
}

@riverpod
Stream<List<Car>> allCars(AllCarsRef ref) {
  return ref.watch(carRepositoryProvider).watchAllCars();
}
