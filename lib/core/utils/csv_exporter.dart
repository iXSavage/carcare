import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../providers/car_providers.dart';
import '../settings/app_settings.dart';
import '../settings/settings_provider.dart';
import '../../features/service_history/data/repositories/service_history_repository.dart';
import '../../features/fuel_log/data/repositories/fuel_repository.dart';

/// Shows an export dialog letting the user pick what to include, then
/// generates and shares a CSV file.
Future<void> showExportDialog(BuildContext context, WidgetRef ref) async {
  bool includeServiceHistory = true;
  bool includeFuelLog = true;

  await showDialog<void>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => AlertDialog(
        title: const Text('Export Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose what to include in the export:'),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text('Service History'),
              value: includeServiceHistory,
              onChanged: (v) =>
                  setState(() => includeServiceHistory = v ?? true),
            ),
            CheckboxListTile(
              title: const Text('Fuel Log'),
              value: includeFuelLog,
              onChanged: (v) => setState(() => includeFuelLog = v ?? true),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            icon: const Icon(Icons.share),
            label: const Text('Export & Share'),
            onPressed: () async {
              Navigator.pop(ctx);
              await _doExport(
                context,
                ref,
                includeServiceHistory: includeServiceHistory,
                includeFuelLog: includeFuelLog,
              );
            },
          ),
        ],
      ),
    ),
  );
}

Future<void> _doExport(
  BuildContext context,
  WidgetRef ref, {
  required bool includeServiceHistory,
  required bool includeFuelLog,
}) async {
  final car = ref.read(currentCarProvider).valueOrNull;
  final settings =
      ref.read(settingsNotifierProvider).valueOrNull ?? const AppSettings();

  try {
    final buffer = StringBuffer();

    // ── Service history ──────────────────────────────────────────────
    if (includeServiceHistory) {
      final logs = await ref
          .read(serviceHistoryRepositoryProvider)
          .getAllLogsForCar(car?.id ?? 0);

      buffer.writeln('SERVICE HISTORY');
      buffer.writeln(
        'Date,Service,Cost (${settings.currencyCode}),Odometer (${settings.distanceLabel}),Notes',
      );
      for (final log in logs) {
        buffer.writeln(
          [
            _csv(log.serviceDate.toIso8601String().split('T').first),
            _csv(log.serviceName),
            _csv('${log.cost ?? ''}'),
            _csv('${log.mileageAtService ?? ''}'),
            _csv(log.notes ?? ''),
          ].join(','),
        );
      }
      buffer.writeln();
    }

    // ── Fuel log ─────────────────────────────────────────────────────
    if (includeFuelLog && car != null) {
      final entries = await ref
          .read(fuelRepositoryProvider)
          .getEntriesForCar(car.id);

      buffer.writeln('FUEL LOG');
      buffer.writeln(
        'Date,Litres,Total Cost (${settings.currencyCode}),Odometer (${settings.distanceLabel}),Full Tank,Notes',
      );
      for (final e in entries) {
        buffer.writeln(
          [
            _csv(e.date.toIso8601String().split('T').first),
            _csv('${e.litres}'),
            _csv('${e.costTotal}'),
            _csv('${e.odometer}'),
            _csv(e.isFull ? 'Yes' : 'No'),
            _csv(e.notes ?? ''),
          ].join(','),
        );
      }
    }

    // Write to temp file and share
    final tmpDir = await getTemporaryDirectory();
    final carName = car != null ? '${car.make}_${car.model}' : 'CarCare';
    final filename =
        '${carName}_export_${DateTime.now().millisecondsSinceEpoch}.csv';
    final file = File(p.join(tmpDir.path, filename));
    await file.writeAsString(buffer.toString());

    await Share.shareXFiles([
      XFile(file.path, mimeType: 'text/csv'),
    ], subject: 'CarCare Export — $carName');
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Export failed: $e')));
    }
  }
}

/// Wraps a value in double quotes and escapes any existing quotes.
String _csv(String value) => '"${value.replaceAll('"', '""')}"';
