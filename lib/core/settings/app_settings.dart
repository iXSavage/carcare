import 'package:shared_preferences/shared_preferences.dart';

enum DistanceUnit { miles, km }

enum FuelUnit { litres, gallons }

class AppSettings {
  final String currencySymbol;
  final String currencyCode;
  final DistanceUnit distanceUnit;
  final FuelUnit fuelUnit;

  const AppSettings({
    this.currencySymbol = '\$',
    this.currencyCode = 'USD',
    this.distanceUnit = DistanceUnit.miles,
    this.fuelUnit = FuelUnit.litres,
  });

  AppSettings copyWith({
    String? currencySymbol,
    String? currencyCode,
    DistanceUnit? distanceUnit,
    FuelUnit? fuelUnit,
  }) {
    return AppSettings(
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyCode: currencyCode ?? this.currencyCode,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      fuelUnit: fuelUnit ?? this.fuelUnit,
    );
  }

  // Keys
  static const _kCurrencySymbol = 'currency_symbol';
  static const _kCurrencyCode = 'currency_code';
  static const _kDistanceUnit = 'distance_unit';
  static const _kFuelUnit = 'fuel_unit';

  static Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    return AppSettings(
      currencySymbol: prefs.getString(_kCurrencySymbol) ?? '\$',
      currencyCode: prefs.getString(_kCurrencyCode) ?? 'USD',
      distanceUnit: DistanceUnit.values[prefs.getInt(_kDistanceUnit) ?? 0],
      fuelUnit: FuelUnit.values[prefs.getInt(_kFuelUnit) ?? 0],
    );
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kCurrencySymbol, currencySymbol);
    await prefs.setString(_kCurrencyCode, currencyCode);
    await prefs.setInt(_kDistanceUnit, distanceUnit.index);
    await prefs.setInt(_kFuelUnit, fuelUnit.index);
  }

  String get distanceLabel => distanceUnit == DistanceUnit.miles ? 'mi' : 'km';
  String get fuelLabel => fuelUnit == FuelUnit.litres ? 'L' : 'gal';

  /// Common currencies for the picker
  static const List<Map<String, String>> currencies = [
    {'symbol': '\$', 'code': 'USD', 'name': 'US Dollar'},
    {'symbol': '£', 'code': 'GBP', 'name': 'British Pound'},
    {'symbol': '€', 'code': 'EUR', 'name': 'Euro'},
    {'symbol': '₦', 'code': 'NGN', 'name': 'Nigerian Naira'},
    {'symbol': '₵', 'code': 'GHS', 'name': 'Ghanaian Cedi'},
    {'symbol': 'KES', 'code': 'KES', 'name': 'Kenyan Shilling'},
    {'symbol': 'ZAR', 'code': 'ZAR', 'name': 'South African Rand'},
    {'symbol': '฿', 'code': 'THB', 'name': 'Thai Baht'},
    {'symbol': '¥', 'code': 'JPY', 'name': 'Japanese Yen'},
    {'symbol': '₹', 'code': 'INR', 'name': 'Indian Rupee'},
    {'symbol': 'CA\$', 'code': 'CAD', 'name': 'Canadian Dollar'},
    {'symbol': 'A\$', 'code': 'AUD', 'name': 'Australian Dollar'},
  ];
}
