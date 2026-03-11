import 'package:isar/isar.dart';
part 'fuel_entry.g.dart';

@collection
class FuelEntry {
  Id id = Isar.autoIncrement;

  late int carId; // foreign key to Car.id
  late DateTime date;
  late double litres; // volume of fuel added
  late double costTotal; // total cost of fill-up
  late int odometer; // odometer reading at fill-up
  bool isFull = true; // full tank? affects economy calc accuracy
  String? notes;

  /// Optional path to a locally stored receipt photo for this fill-up.
  String? receiptPhotoPath;

  // Derived – stored on write so list is query-sortable
  double? costPerLitre;

  /// Fuel economy mpg for this fill-up segment (needs two consecutive full fills)
  double? milesPerGallon;
  double? litresPer100km;
}
