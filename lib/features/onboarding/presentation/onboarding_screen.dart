import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/car_providers.dart';
import '../../car_profile/presentation/dialogs/car_profile_form_dialog.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageCtrl = PageController();
  int _page = 0;
  bool _advanced = false; // guard: auto-advance only once

  void _next() {
    if (_page < 2) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/garage');
    }
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Watch at the top level so hasCar triggers a rebuild of the whole screen
    final hasCar = ref.watch(currentCarProvider).valueOrNull != null;

    // Auto-advance from page 1 → page 2 as soon as a car is saved
    if (hasCar && _page == 1 && !_advanced) {
      _advanced = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _next());
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageCtrl,
            onPageChanged: (p) => setState(() {
              _page = p;
              // Reset guard when navigating back to the add-car page
              if (p == 1) _advanced = false;
            }),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const _WelcomePage(),
              const _AddCarPage(),
              const _DonePage(),
            ],
          ),
          // Bottom navigation strip
          Positioned(
            left: 24,
            right: 24,
            bottom: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Progress dots
                Row(
                  children: List.generate(
                    3,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == _page ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: i == _page
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outlineVariant,
                      ),
                    ),
                  ),
                ),
                // Next / Get Started — disabled on page 1 until a car exists
                FilledButton(
                  onPressed: (_page == 1 && !hasCar) ? null : _next,
                  child: Text(_page >= 2 ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Page 1: Welcome ────────────────────────────────────────────────────────────

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 80, 32, 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.car_repair, size: 100, color: theme.colorScheme.primary),
          const SizedBox(height: 32),
          Text(
            'Welcome to CarCare',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Your all-in-one car maintenance tracker.\nNever miss a service, fuel log, or document again.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          _FeatureRow(
            icon: Icons.build_outlined,
            text: 'Track maintenance & reminders',
          ),
          const SizedBox(height: 12),
          _FeatureRow(
            icon: Icons.local_gas_station_outlined,
            text: 'Log fuel & calculate economy',
          ),
          const SizedBox(height: 12),
          _FeatureRow(
            icon: Icons.garage_outlined,
            text: 'Manage multiple cars',
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FeatureRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 14),
        Text(text, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}

// ── Page 2: Add Car ────────────────────────────────────────────────────────────
// Uses ConsumerWidget so it rebuilds when currentCarProvider emits

class _AddCarPage extends ConsumerWidget {
  const _AddCarPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hasCar = ref.watch(currentCarProvider).valueOrNull != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 80, 32, 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            hasCar ? Icons.check_circle : Icons.directions_car_outlined,
            size: 80,
            color: hasCar
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            hasCar ? 'Car added!' : 'Add your first car',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasCar
                ? "You're all set. Tap Next to continue."
                : 'Tell us about your car to get started.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          // Always show the Add button — even when a car exists, so user can
          // add another. The Next button at the bottom is what advances the page.
          FilledButton.icon(
            onPressed: () => showCarProfileFormDialog(context),
            icon: Icon(hasCar ? Icons.add : Icons.directions_car),
            label: Text(hasCar ? 'Add Another Car' : 'Add My Car'),
          ),
        ],
      ),
    );
  }
}

// ── Page 3: Done ───────────────────────────────────────────────────────────────

class _DonePage extends StatelessWidget {
  const _DonePage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 80, 32, 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.celebration, size: 100, color: theme.colorScheme.primary),
          const SizedBox(height: 32),
          Text(
            "You're all set!",
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "CarCare is ready to help you stay on top of your vehicle's health. Tap Get Started to begin.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
