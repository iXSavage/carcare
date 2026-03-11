import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/cost_summary_provider.dart';
import '../../../../core/settings/settings_provider.dart';
import '../../../../core/settings/app_settings.dart';
import '../../../../core/theme/app_styles.dart';

class CostOverviewCard extends ConsumerStatefulWidget {
  final int carId;
  const CostOverviewCard({super.key, required this.carId});

  @override
  ConsumerState<CostOverviewCard> createState() => _CostOverviewCardState();
}

class _CostOverviewCardState extends ConsumerState<CostOverviewCard> {
  CostPeriod _period = CostPeriod.oneYear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final settings = settingsAsync.valueOrNull ?? const AppSettings();

    final summaryAsync = ref.watch(
      costSummaryProvider((carId: widget.carId, period: _period)),
    );

    return Container(
      decoration: AppStyles.premiumCardDecoration(context),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  color: theme.colorScheme.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'COST OVERVIEW',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                // ── Period chips ─────────────────────────────────────────
                ...CostPeriod.values.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: GestureDetector(
                      onTap: () => setState(() => _period = p),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _period == p
                              ? theme.colorScheme.primary
                              : theme.colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          p.label,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _period == p
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Summary content ──────────────────────────────────────────
            summaryAsync.when(
              loading: () => const SizedBox(
                height: 120,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) =>
                  SizedBox(height: 80, child: Center(child: Text('Error: $e'))),
              data: (summary) => _CostContent(
                summary: summary,
                settings: settings,
                theme: theme,
              ).animate().fadeIn(duration: 300.ms),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Content shown once data loads ──────────────────────────────────────────────

class _CostContent extends StatelessWidget {
  final CostSummary summary;
  final AppSettings settings;
  final ThemeData theme;

  const _CostContent({
    required this.summary,
    required this.settings,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat('#,##0');
    final currSym = settings.currencySymbol;

    final hasData = summary.grand > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Stat chips row ─────────────────────────────────────────────
        Row(
          children: [
            _CostChip(
              icon: Icons.local_gas_station_outlined,
              label: 'Fuel',
              value: '$currSym${fmt.format(summary.fuelTotal)}',
              color: theme.colorScheme.primary,
              theme: theme,
            ),
            const SizedBox(width: 10),
            _CostChip(
              icon: Icons.build_outlined,
              label: 'Service',
              value: '$currSym${fmt.format(summary.serviceTotal)}',
              color: theme.colorScheme.secondary,
              theme: theme,
            ),
            const SizedBox(width: 10),
            _CostChip(
              icon: Icons.warning_amber_outlined,
              label: 'Alerts',
              value: summary.documentAlertCount.toString(),
              color: summary.documentAlertCount > 0
                  ? theme.colorScheme.error
                  : theme.colorScheme.onSurfaceVariant,
              theme: theme,
            ),
          ],
        ),

        const SizedBox(height: 20),

        // ── Grand total ────────────────────────────────────────────────
        if (hasData) ...[
          Text(
            'Total Spending',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$currSym${fmt.format(summary.grand)}',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),

          // ── Bar chart ────────────────────────────────────────────────
          _CostBarChart(summary: summary, theme: theme),
        ] else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'No spending data for this period.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}

// ── Stat chip ──────────────────────────────────────────────────────────────────

class _CostChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final ThemeData theme;

  const _CostChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Custom bar chart ───────────────────────────────────────────────────────────

class _CostBarChart extends StatelessWidget {
  final CostSummary summary;
  final ThemeData theme;

  const _CostBarChart({required this.summary, required this.theme});

  @override
  Widget build(BuildContext context) {
    final total = summary.grand;
    final fuelRatio = total > 0 ? summary.fuelTotal / total : 0.0;
    final serviceRatio = total > 0 ? summary.serviceTotal / total : 0.0;
    final fmt = NumberFormat('#,##0.0');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stacked bar
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LayoutBuilder(
            builder: (context, box) => SizedBox(
              height: 12,
              width: box.maxWidth,
              child: CustomPaint(
                painter: _StackedBarPainter(
                  fuelRatio: fuelRatio,
                  serviceRatio: serviceRatio,
                  fuelColor: theme.colorScheme.primary,
                  serviceColor: theme.colorScheme.secondary,
                  bgColor: theme.colorScheme.surfaceContainerHigh,
                ),
              ),
            ),
          ),
        ).animate().scaleX(
          begin: 0,
          end: 1,
          duration: 600.ms,
          curve: Curves.easeOutExpo,
          alignment: Alignment.centerLeft,
        ),

        const SizedBox(height: 10),

        // Legend
        Row(
          children: [
            _Legend(
              color: theme.colorScheme.primary,
              label: 'Fuel ${fmt.format(fuelRatio * 100)}%',
              theme: theme,
            ),
            const SizedBox(width: 16),
            _Legend(
              color: theme.colorScheme.secondary,
              label: 'Service ${fmt.format(serviceRatio * 100)}%',
              theme: theme,
            ),
          ],
        ),
      ],
    );
  }
}

class _StackedBarPainter extends CustomPainter {
  final double fuelRatio;
  final double serviceRatio;
  final Color fuelColor;
  final Color serviceColor;
  final Color bgColor;

  _StackedBarPainter({
    required this.fuelRatio,
    required this.serviceRatio,
    required this.fuelColor,
    required this.serviceColor,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final fuelWidth = size.width * math.max(0, fuelRatio);
    final serviceWidth = size.width * math.max(0, serviceRatio);

    if (fuelWidth > 0) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, fuelWidth, size.height),
        Paint()..color = fuelColor,
      );
    }
    if (serviceWidth > 0) {
      canvas.drawRect(
        Rect.fromLTWH(fuelWidth, 0, serviceWidth, size.height),
        Paint()..color = serviceColor,
      );
    }
  }

  @override
  bool shouldRepaint(_StackedBarPainter old) =>
      old.fuelRatio != fuelRatio || old.serviceRatio != serviceRatio;
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  final ThemeData theme;

  const _Legend({
    required this.color,
    required this.label,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
