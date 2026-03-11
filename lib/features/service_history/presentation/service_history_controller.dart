import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/car_providers.dart';
import '../data/models/service_log.dart';
import '../data/repositories/service_history_repository.dart';

part 'service_history_controller.g.dart';

@riverpod
class ServiceHistoryController extends _$ServiceHistoryController {
  @override
  FutureOr<void> build() {}

  Future<void> saveLog({
    required String serviceName,
    required DateTime serviceDate,
    int? mileageAtService,
    String? provider,
    double? cost,
    String? notes,
    int? linkedTaskId,
    int? id,
  }) async {
    final carId = ref.read(currentCarProvider).valueOrNull?.id ?? 0;

    final log = ServiceLog()
      ..id = id ?? Isar.autoIncrement
      ..carId = carId
      ..serviceName = serviceName
      ..serviceDate = serviceDate
      ..mileageAtService = mileageAtService
      ..provider = provider
      ..cost = cost
      ..notes = notes
      ..linkedTaskId = linkedTaskId;

    await ref.read(serviceHistoryRepositoryProvider).saveLog(log);
  }

  Future<void> deleteLog(int id) async {
    await ref.read(serviceHistoryRepositoryProvider).deleteLog(id);
  }
}
