// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$carRepositoryHash() => r'78f3bb027da3e26f5b0797aa9e485a97e879ea4f';

/// See also [carRepository].
@ProviderFor(carRepository)
final carRepositoryProvider = AutoDisposeProvider<CarRepository>.internal(
  carRepository,
  name: r'carRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$carRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CarRepositoryRef = AutoDisposeProviderRef<CarRepository>;
String _$currentCarHash() => r'5a1e673ae3897501fea5fe342ff5cc568f48d7e7';

/// See also [currentCar].
@ProviderFor(currentCar)
final currentCarProvider = AutoDisposeStreamProvider<Car?>.internal(
  currentCar,
  name: r'currentCarProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentCarHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentCarRef = AutoDisposeStreamProviderRef<Car?>;
String _$allCarsHash() => r'b24fc479abf75c5abae9fe22b28750c2adc5dd2d';

/// See also [allCars].
@ProviderFor(allCars)
final allCarsProvider = AutoDisposeStreamProvider<List<Car>>.internal(
  allCars,
  name: r'allCarsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allCarsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllCarsRef = AutoDisposeStreamProviderRef<List<Car>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
