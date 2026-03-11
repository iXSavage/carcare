import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_provider.dart';
import '../models/fuel_entry.dart';

part 'fuel_repository.g.dart';

class FuelRepository {
  final Isar isar;
  FuelRepository(this.isar);

  // ── CRUD ──────────────────────────────────────────────────────────────

  Future<void> saveFuelEntry(FuelEntry entry) async {
    // Compute costPerLitre on save
    if (entry.litres > 0) {
      entry.costPerLitre = entry.costTotal / entry.litres;
    }
    await isar.writeTxn(() => isar.fuelEntrys.put(entry));
  }

  Future<void> deleteFuelEntry(int id) async {
    await isar.writeTxn(() => isar.fuelEntrys.delete(id));
  }

  // ── Queries ───────────────────────────────────────────────────────────

  Stream<List<FuelEntry>> watchEntriesForCar(int carId) {
    return isar.fuelEntrys
        .filter()
        .carIdEqualTo(carId)
        .sortByDateDesc()
        .watch(fireImmediately: true);
  }

  Future<List<FuelEntry>> getEntriesForCar(int carId) async {
    return isar.fuelEntrys
        .filter()
        .carIdEqualTo(carId)
        .sortByDateDesc()
        .findAll();
  }

  // ── Economy calculations ───────────────────────────────────────────────

  /// Returns (average L/100km, average cost/litre, total spent, total litres)
  Future<FuelStats> getStats(int carId) async {
    final entries = await getEntriesForCar(carId);
    if (entries.isEmpty) return const FuelStats();

    double totalCost = 0;
    double totalLitres = 0;

    for (final e in entries) {
      totalCost += e.costTotal;
      totalLitres += e.litres;
    }

    // Economy: needs at least two consecutive full fills
    double? avgL100km;
    final fullFills = entries.where((e) => e.isFull).toList();
    if (fullFills.length >= 2) {
      // Most recent is fullFills[0], oldest is fullFills[last]
      final distDriven = (fullFills.first.odometer - fullFills.last.odometer)
          .abs();
      final litresUsed = fullFills
          .sublist(0, fullFills.length - 1)
          .fold<double>(0, (s, e) => s + e.litres);
      if (distDriven > 0 && litresUsed > 0) {
        avgL100km = (litresUsed / distDriven) * 100;
      }
    }

    return FuelStats(
      totalCost: totalCost,
      totalLitres: totalLitres,
      avgCostPerLitre: totalLitres > 0 ? totalCost / totalLitres : null,
      avgL100km: avgL100km,
    );
  }
}

class FuelStats {
  final double totalCost;
  final double totalLitres;
  final double? avgCostPerLitre;
  final double? avgL100km;

  const FuelStats({
    this.totalCost = 0,
    this.totalLitres = 0,
    this.avgCostPerLitre,
    this.avgL100km,
  });

  double? get avgMpg {
    if (avgL100km == null || avgL100km == 0) return null;
    return 282.481 / avgL100km!; // convert L/100km → MPG (US)
  }
}

@riverpod
FuelRepository fuelRepository(FuelRepositoryRef ref) {
  return FuelRepository(ref.watch(isarProvider));
}
