import 'package:isar/isar.dart';
part 'car.g.dart';

@collection
class Car {
  Id id = Isar.autoIncrement;
  late String make;
  late String model;
  late int year;
  String? licensePlate;
  String? vin;
  int currentMileage = 0;
  String? photoPath;
  bool isActive = false;
}
