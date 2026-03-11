// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$maintenanceRepositoryHash() =>
    r'8b1acbf55b7c42b4875e68fca70b9797785da6c6';

/// See also [maintenanceRepository].
@ProviderFor(maintenanceRepository)
final maintenanceRepositoryProvider =
    AutoDisposeProvider<MaintenanceRepository>.internal(
  maintenanceRepository,
  name: r'maintenanceRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$maintenanceRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MaintenanceRepositoryRef
    = AutoDisposeProviderRef<MaintenanceRepository>;
String _$activeCarMaintenanceTasksHash() =>
    r'63eabcc911dbe0257b6db1fff4ef6ceb224bb0da';

/// Streams maintenance tasks for the currently active car.
///
/// Copied from [activeCarMaintenanceTasks].
@ProviderFor(activeCarMaintenanceTasks)
final activeCarMaintenanceTasksProvider =
    AutoDisposeStreamProvider<List<MaintenanceTask>>.internal(
  activeCarMaintenanceTasks,
  name: r'activeCarMaintenanceTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeCarMaintenanceTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActiveCarMaintenanceTasksRef
    = AutoDisposeStreamProviderRef<List<MaintenanceTask>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
