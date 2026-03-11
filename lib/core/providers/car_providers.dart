// Core providers barrel — the single import point for providers
// that span multiple features.
//
// RULE: Feature presentation layers must import cross-feature providers
// from here, never directly from another feature's data layer.
//
// Example:
//   ✅  import 'package:carcare/core/providers/car_providers.dart';
//   ❌  import '../../car_profile/data/repositories/car_repository.dart';

export '../../features/car_profile/data/repositories/car_repository.dart'
    show currentCarProvider, carRepositoryProvider, allCarsProvider;
