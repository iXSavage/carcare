import 'package:isar/isar.dart';

part 'service_log.g.dart';

@collection
class ServiceLog {
  Id id = Isar.autoIncrement;

  // --- Core Fields ---

  /// Foreign key linking this to a specific Car.
  late int carId;

  /// The name of the service performed. e.g. "Oil Change", "Brake Pads"
  late String serviceName;

  /// The date the service was performed.
  late DateTime serviceDate;

  /// The odometer reading when the service was done.
  int? mileageAtService;

  // --- Provider & Cost ---

  /// Who performed the service. e.g. "Bob's Auto Shop", "DIY"
  String? provider;

  /// Total cost in the user's local currency.
  double? cost;

  // --- Links & Meta ---

  /// Optional link to the MaintenanceTask that triggered this service.
  /// Used to auto-populate history when "Mark as Done" is tapped.
  int? linkedTaskId;

  /// Freeform notes: parts changed, warranty info, next steps, etc.
  String? notes;
}
