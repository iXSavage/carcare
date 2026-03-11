import '../data/models/maintenance_task.dart';
import '../../../core/constants/app_constants.dart';

enum MaintenanceStatus { good, dueSoon, overdue, unknown }

class ReminderCalculator {
  /// Determines if a [MaintenanceTask] is due based on the current date
  /// and the car's current mileage.
  ///
  /// Logic:
  /// - OVERDUE: If current mileage >= nextDueMileage OR currentDate >= nextDueDate
  /// - DUE SOON: If within [AppConstants.dueSoonMileagePercent] of interval
  ///             OR within [AppConstants.dueSoonDaysThreshold] days of due date
  /// - GOOD: Safely under both thresholds
  static MaintenanceStatus calculateStatus(
    MaintenanceTask task,
    int currentMileage,
  ) {
    if (task.nextDueDate == null && task.nextDueMileage == null) {
      return MaintenanceStatus.unknown;
    }

    final now = DateTime.now();
    bool isOverdue = false;
    bool isDueSoon = false;

    // 1. Check Mileage Threshold
    if (task.nextDueMileage != null && task.mileageInterval != null) {
      final int milesRemaining = task.nextDueMileage! - currentMileage;

      if (milesRemaining <= 0) {
        isOverdue = true;
      } else {
        final double threshold =
            task.mileageInterval! * AppConstants.dueSoonMileagePercent;
        if (milesRemaining <= threshold) {
          isDueSoon = true;
        }
      }
    }

    // 2. Check Time Threshold
    if (task.nextDueDate != null) {
      final int daysRemaining = task.nextDueDate!.difference(now).inDays;

      if (daysRemaining <= 0) {
        isOverdue = true;
      } else if (daysRemaining <= AppConstants.dueSoonDaysThreshold) {
        isDueSoon = true;
      }
    }

    // 3. Return Final Status (overdue takes priority)
    if (isOverdue) return MaintenanceStatus.overdue;
    if (isDueSoon) return MaintenanceStatus.dueSoon;
    return MaintenanceStatus.good;
  }

  /// Human-readable miles remaining text.
  static String getMileageRemainingText(
    MaintenanceTask task,
    int currentMileage,
  ) {
    if (task.nextDueMileage == null) return 'N/A';
    final diff = task.nextDueMileage! - currentMileage;
    if (diff <= 0) return '${diff.abs()} mi overdue';
    return 'In $diff mi';
  }

  /// Human-readable days remaining text.
  static String getDaysRemainingText(MaintenanceTask task) {
    if (task.nextDueDate == null) return 'N/A';
    final diff = task.nextDueDate!.difference(DateTime.now()).inDays;
    if (diff == 0) return 'Due today';
    if (diff < 0) return '${diff.abs()} days overdue';
    return 'In $diff days';
  }
}
