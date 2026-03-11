import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';

/// AppShell is the root scaffold providing adaptive M3 navigation.
///
/// Breakpoints (M3 spec):
///   < 600px   → NavigationBar (bottom)
///   600–840px → NavigationRail (collapsed, icons only)
///   > 840px   → NavigationRail (extended, icons + labels + logo)
class AppShell extends StatelessWidget {
  final Widget child;
  final String location;

  const AppShell({super.key, required this.child, required this.location});

  static const _routes = [
    '/garage',
    '/fuel-log',
    '/maintenance',
    '/documents',
    '/service-history',
  ];

  static const _destinations = [
    _NavDestination(
      label: 'Garage',
      icon: Icons.garage_outlined,
      selectedIcon: Icons.garage,
    ),
    _NavDestination(
      label: 'Fuel',
      icon: Icons.local_gas_station_outlined,
      selectedIcon: Icons.local_gas_station,
    ),
    _NavDestination(
      label: 'Maintenance',
      icon: Icons.build_outlined,
      selectedIcon: Icons.build,
    ),
    _NavDestination(
      label: 'Documents',
      icon: Icons.file_copy_outlined,
      selectedIcon: Icons.file_copy,
    ),
    _NavDestination(
      label: 'History',
      icon: Icons.history_outlined,
      selectedIcon: Icons.history,
    ),
  ];

  int get _selectedIndex {
    final idx = _routes.indexOf(location);
    return idx < 0 ? 0 : idx;
  }

  void _onSelect(BuildContext context, int index) {
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // ── Phone: standard NavigationBar (bottom) ───────────────────────────
        if (width < AppConstants.phoneBreakpoint) {
          return Scaffold(
            body: child,
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: NavigationBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                indicatorColor: Theme.of(
                  context,
                ).colorScheme.primary.withOpacity(0.15),
                selectedIndex: _selectedIndex,
                onDestinationSelected: (i) => _onSelect(context, i),
                destinations: _destinations.map((d) {
                  return NavigationDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(
                      d.selectedIcon,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: d.label,
                  );
                }).toList(),
              ),
            ),
          );
        }

        // ── Tablet (600–840px): collapsed rail ───────────────────────────
        // ── Wide (840px+): extended rail with app name ───────────────────
        final extended = width > AppConstants.desktopBreakpoint;
        final theme = Theme.of(context);

        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                extended: extended,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (i) => _onSelect(context, i),
                groupAlignment: -1.0, // pin destinations to top
                leading: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                  child: extended
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 8),
                            Icon(
                              Icons.car_repair,
                              color: theme.colorScheme.primary,
                              size: 26,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'CarCare',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        )
                      : Icon(
                          Icons.car_repair,
                          color: theme.colorScheme.primary,
                          size: 26,
                        ),
                ),
                destinations: _destinations
                    .map(
                      (d) => NavigationRailDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.selectedIcon),
                        label: Text(d.label),
                      ),
                    )
                    .toList(),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: theme.colorScheme.outlineVariant,
              ),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}

/// Immutable model for a single navigation destination.
class _NavDestination {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const _NavDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}
