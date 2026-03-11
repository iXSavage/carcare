// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serviceHistoryRepositoryHash() =>
    r'82ce46e0063976ccba279c8e5d8abbfb04e1a7f7';

/// See also [serviceHistoryRepository].
@ProviderFor(serviceHistoryRepository)
final serviceHistoryRepositoryProvider =
    AutoDisposeProvider<ServiceHistoryRepository>.internal(
  serviceHistoryRepository,
  name: r'serviceHistoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serviceHistoryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ServiceHistoryRepositoryRef
    = AutoDisposeProviderRef<ServiceHistoryRepository>;
String _$activeCarServiceLogsHash() =>
    r'b6f3b5f0f5fe7526626ac896aa8326b0fda0e309';

/// Streams service logs for the currently active car.
///
/// Copied from [activeCarServiceLogs].
@ProviderFor(activeCarServiceLogs)
final activeCarServiceLogsProvider =
    AutoDisposeStreamProvider<List<ServiceLog>>.internal(
  activeCarServiceLogs,
  name: r'activeCarServiceLogsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeCarServiceLogsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActiveCarServiceLogsRef
    = AutoDisposeStreamProviderRef<List<ServiceLog>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
