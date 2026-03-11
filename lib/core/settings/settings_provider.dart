import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_settings.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<AppSettings> build() async {
    return AppSettings.load();
  }

  Future<void> saveSettings(AppSettings updated) async {
    await updated.save();
    state = AsyncData(updated);
  }

  Future<void> setCurrency(String symbol, String code) async {
    final current = state.valueOrNull ?? const AppSettings();
    await saveSettings(
      current.copyWith(currencySymbol: symbol, currencyCode: code),
    );
  }

  Future<void> setDistanceUnit(DistanceUnit unit) async {
    final current = state.valueOrNull ?? const AppSettings();
    await saveSettings(current.copyWith(distanceUnit: unit));
  }

  Future<void> setFuelUnit(FuelUnit unit) async {
    final current = state.valueOrNull ?? const AppSettings();
    await saveSettings(current.copyWith(fuelUnit: unit));
  }
}
