import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../fuel_log/data/repositories/fuel_repository.dart';
import '../../service_history/data/repositories/service_history_repository.dart';
import '../../documents/data/repositories/document_repository.dart';
import '../../documents/data/models/document_reminder.dart';

// ── Period selector ────────────────────────────────────────────────────────────

enum CostPeriod {
  oneMonth,
  sixMonths,
  oneYear,
  allTime;

  String get label {
    return switch (this) {
      CostPeriod.oneMonth => '1M',
      CostPeriod.sixMonths => '6M',
      CostPeriod.oneYear => '1Y',
      CostPeriod.allTime => 'All',
    };
  }

  /// Returns the cutoff [DateTime] for filtering entries.
  /// Returns null for [allTime] (no filter).
  DateTime? get cutoff {
    final now = DateTime.now();
    return switch (this) {
      CostPeriod.oneMonth => DateTime(now.year, now.month - 1, now.day),
      CostPeriod.sixMonths => DateTime(now.year, now.month - 6, now.day),
      CostPeriod.oneYear => DateTime(now.year - 1, now.month, now.day),
      CostPeriod.allTime => null,
    };
  }
}

// ── Result model ───────────────────────────────────────────────────────────────

class CostSummary {
  final double fuelTotal;
  final double serviceTotal;
  final int documentAlertCount;
  final CostPeriod period;

  const CostSummary({
    required this.fuelTotal,
    required this.serviceTotal,
    required this.documentAlertCount,
    required this.period,
  });

  double get grand => fuelTotal + serviceTotal;
}

// ── Provider ───────────────────────────────────────────────────────────────────

typedef _CostParams = ({int carId, CostPeriod period});

final costSummaryProvider = FutureProvider.autoDispose
    .family<CostSummary, _CostParams>((ref, params) async {
      final cutoff = params.period.cutoff;

      // ── Fuel ────────────────────────────────────────────────────────────────
      final fuelRepo = ref.watch(fuelRepositoryProvider);
      final fuelEntries = await fuelRepo.getEntriesForCar(params.carId);
      final fuelTotal = fuelEntries
          .where((e) => cutoff == null || e.date.isAfter(cutoff))
          .fold<double>(0, (sum, e) => sum + e.costTotal);

      // ── Service / Maintenance ────────────────────────────────────────────────
      final serviceRepo = ref.watch(serviceHistoryRepositoryProvider);
      final serviceLogs = await serviceRepo.getAllLogsForCar(params.carId);
      final serviceTotal = serviceLogs
          .where(
            (e) =>
                (e.cost ?? 0) > 0 &&
                (cutoff == null || e.serviceDate.isAfter(cutoff)),
          )
          .fold<double>(0, (sum, e) => sum + (e.cost ?? 0));

      // ── Document Alerts (count only, not date-filtered) ───────────────────
      final docRepo = ref.watch(documentRepositoryProvider);
      final docs = await docRepo
          .watchDocumentsForCar(params.carId)
          .first; // snapshot
      final alertCount = docs
          .where(
            (d) =>
                d.status == DocumentStatus.warning ||
                d.status == DocumentStatus.critical ||
                d.status == DocumentStatus.expired,
          )
          .length;

      return CostSummary(
        fuelTotal: fuelTotal,
        serviceTotal: serviceTotal,
        documentAlertCount: alertCount,
        period: params.period,
      );
    });
