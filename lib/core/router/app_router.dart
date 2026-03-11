import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/car_profile/presentation/garage_screen.dart';
import '../../features/car_profile/presentation/car_profile_screen.dart';
import '../../features/fuel_log/presentation/fuel_log_screen.dart';
import '../../features/maintenance/presentation/maintenance_screen.dart';
import '../../features/documents/presentation/documents_screen.dart';
import '../../features/service_history/presentation/service_history_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../shell/app_shell.dart';

part 'app_router.g.dart';

const _onboardingDoneKey = 'onboarding_done';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/garage',
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final done = prefs.getBool(_onboardingDoneKey) ?? false;
      if (!done && state.matchedLocation != '/onboarding') {
        return '/onboarding';
      }
      return null; // no redirect
    },
    routes: [
      // Onboarding — outside the shell so there's no bottom nav
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
        redirect: (context, state) async {
          // Mark onboarding done when this route is visited
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool(_onboardingDoneKey, true);
          return null;
        },
      ),

      ShellRoute(
        builder: (context, state, child) =>
            AppShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(
            path: '/garage',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: GarageScreen()),
          ),
          GoRoute(
            path: '/car',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CarProfileScreen()),
          ),
          GoRoute(
            path: '/fuel-log',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: FuelLogScreen()),
          ),
          GoRoute(
            path: '/maintenance',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MaintenanceScreen()),
          ),
          GoRoute(
            path: '/documents',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DocumentsScreen()),
          ),
          GoRoute(
            path: '/service-history',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ServiceHistoryScreen()),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SettingsScreen()),
          ),
        ],
      ),
    ],
  );
}
