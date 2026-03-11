import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/settings/settings_provider.dart';

// Provider to load app info once
final _packageInfoProvider = FutureProvider<PackageInfo>(
  (_) => PackageInfo.fromPlatform(),
);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final pkgAsync = ref.watch(_packageInfoProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (settings) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Currency ───────────────────────────────────────────────────
            _SectionHeader(label: 'Currency', theme: theme),
            Card(
              child: ListTile(
                leading: const Icon(Icons.payments_outlined),
                title: const Text('Default Currency'),
                subtitle: Text(
                  '${settings.currencySymbol} · ${settings.currencyCode}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showCurrencyPicker(context, ref, settings),
              ),
            ),
            const SizedBox(height: 20),

            // ── Units ──────────────────────────────────────────────────────
            _SectionHeader(label: 'Units', theme: theme),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.speed_outlined),
                    title: const Text('Distance'),
                    trailing: SegmentedButton<DistanceUnit>(
                      segments: const [
                        ButtonSegment(
                          value: DistanceUnit.miles,
                          label: Text('mi'),
                        ),
                        ButtonSegment(
                          value: DistanceUnit.km,
                          label: Text('km'),
                        ),
                      ],
                      selected: {settings.distanceUnit},
                      onSelectionChanged: (v) => ref
                          .read(settingsNotifierProvider.notifier)
                          .setDistanceUnit(v.first),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.local_gas_station_outlined),
                    title: const Text('Fuel Volume'),
                    trailing: SegmentedButton<FuelUnit>(
                      segments: const [
                        ButtonSegment(value: FuelUnit.litres, label: Text('L')),
                        ButtonSegment(
                          value: FuelUnit.gallons,
                          label: Text('gal'),
                        ),
                      ],
                      selected: {settings.fuelUnit},
                      onSelectionChanged: (v) => ref
                          .read(settingsNotifierProvider.notifier)
                          .setFuelUnit(v.first),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── About ──────────────────────────────────────────────────────
            _SectionHeader(label: 'About', theme: theme),

            // Card 1 — App identity
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'assets/images/app_icon.png',
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'CarCare',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    pkgAsync.when(
                      loading: () => Text(
                        'Version —',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      error: (e, _) => const SizedBox.shrink(),
                      data: (pkg) => Text(
                        'Version ${pkg.version} (build ${pkg.buildNumber})',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your smart car companion',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Card 2 — Quick actions
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.star_outline_rounded,
                      color: theme.colorScheme.primary,
                    ),
                    title: const Text('Rate CarCare'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _launchUrl(
                      'https://apps.apple.com', // replace with real URL
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.share_outlined,
                      color: theme.colorScheme.primary,
                    ),
                    title: const Text('Share CarCare'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Share.share(
                      'Check out CarCare — the smart car companion app!\nhttps://apps.apple.com',
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.privacy_tip_outlined,
                      color: theme.colorScheme.primary,
                    ),
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _launchUrl(
                      'https://example.com/privacy', // replace with real URL
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline_rounded,
                      color: theme.colorScheme.primary,
                    ),
                    title: const Text('Open Source Licenses'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => pkgAsync.whenData(
                      (pkg) => showLicensePage(
                        context: context,
                        applicationName: 'CarCare',
                        applicationVersion: pkg.version,
                        applicationIcon: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.directions_car_rounded,
                            size: 48,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showCurrencyPicker(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select Currency',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: AppSettings.currencies.length,
                  itemBuilder: (_, i) {
                    final c = AppSettings.currencies[i];
                    final isSelected = c['code'] == settings.currencyCode;
                    return ListTile(
                      leading: Text(
                        c['symbol']!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      title: Text(c['name']!),
                      subtitle: Text(c['code']!),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : null,
                      onTap: () {
                        ref
                            .read(settingsNotifierProvider.notifier)
                            .setCurrency(c['symbol']!, c['code']!);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  final ThemeData theme;
  const _SectionHeader({required this.label, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
