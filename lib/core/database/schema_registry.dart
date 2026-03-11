import 'package:isar/isar.dart';

import '../../features/car_profile/data/models/car.dart';
import '../../features/maintenance/data/models/maintenance_task.dart';
import '../../features/documents/data/models/document_reminder.dart';
import '../../features/service_history/data/models/service_log.dart';
import '../../features/fuel_log/data/models/fuel_entry.dart';

/// Fix #6: Centralise Isar schema registration.
/// Adding a new feature's schema only requires editing this file,
/// not the core database initialisation directly.
const isarSchemas = <CollectionSchema<dynamic>>[
  CarSchema,
  MaintenanceTaskSchema,
  DocumentReminderSchema,
  ServiceLogSchema,
  FuelEntrySchema,
];
