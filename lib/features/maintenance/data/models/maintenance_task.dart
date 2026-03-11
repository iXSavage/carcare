import 'package:isar/isar.dart';

part 'maintenance_task.g.dart';

@collection
class MaintenanceTask {
  Id id = Isar.autoIncrement;

  /// Foreign key linking this to a specific Car.
  late int carId;

  /// The name of the maintenance task. e.g. "Oil Change", "Tire Rotation"
  late String taskName;

  // User inputs — when the service was last performed
  DateTime? lastServiceDate;
  int? lastServiceMileage;

  // User inputs — how often it recurs
  int? mileageInterval; // e.g. every 5,000 miles
  int? timeIntervalMonths; // e.g. every 6 months

  // Computed and persisted for efficient Isar querying / sorting.
  // Updated by MaintenanceRepository before every save via updateComputedFields().
  DateTime? nextDueDate;
  int? nextDueMileage;

  String? notes;
  bool isCompleted = false;
}

/// Fix #3: Side effects removed from the model.
/// The computation logic now lives in an extension so the
/// Isar schema class remains a pure data holder.
extension MaintenanceTaskComputed on MaintenanceTask {
  /// Recalculates [nextDueDate] and [nextDueMileage] from the stored
  /// user inputs. Called by [MaintenanceRepository.saveTask] before persisting.
  void updateComputedFields() {
    if (lastServiceDate != null && timeIntervalMonths != null) {
      nextDueDate = DateTime(
        lastServiceDate!.year,
        lastServiceDate!.month + timeIntervalMonths!,
        lastServiceDate!.day,
      );
    } else {
      nextDueDate = null;
    }

    if (lastServiceMileage != null && mileageInterval != null) {
      nextDueMileage = lastServiceMileage! + mileageInterval!;
    } else {
      nextDueMileage = null;
    }
  }
}
