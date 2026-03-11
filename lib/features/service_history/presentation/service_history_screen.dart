import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/utils/csv_exporter.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../data/models/service_log.dart';
import '../data/repositories/service_history_repository.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/settings/settings_provider.dart';
import 'add_service_log_dialog.dart';
import 'service_history_controller.dart';

class ServiceHistoryScreen extends ConsumerWidget {
  const ServiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(activeCarServiceLogsProvider);
    final settings =
        ref.watch(settingsNotifierProvider).valueOrNull ?? const AppSettings();
    final currencySymbol = settings.currencySymbol;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Service History'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share_outlined),
            tooltip: 'Export CSV',
            onPressed: () => showExportDialog(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Log service',
            onPressed: () => _showAddDialog(context),
          ),
        ],
      ),
      body: logsAsync.when(
        data: (logs) {
          if (logs.isEmpty) return _buildEmpty(context);

          // Compute summary stats
          final totalSpend = logs.fold<double>(
            0,
            (sum, l) => sum + (l.cost ?? 0),
          );
          final lastService = logs.first.serviceDate; // already sorted desc

          return Column(
            children: [
              _SummaryBanner(
                    totalSpend: totalSpend,
                    lastServiceDate: lastService,
                    totalRecords: logs.length,
                  )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(
                    begin: -0.1,
                    duration: 400.ms,
                    curve: Curves.easeOutQuad,
                  ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 600) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints.maxWidth >= 900 ? 3 : 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.6,
                        ),
                        itemCount: logs.length,
                        itemBuilder: (ctx, i) =>
                            _ServiceLogCard(
                                  log: logs[i],
                                  currencySymbol: currencySymbol,
                                )
                                .animate(delay: (i * 50).ms)
                                .fadeIn(duration: 300.ms)
                                .slideY(
                                  begin: 0.1,
                                  duration: 300.ms,
                                  curve: Curves.easeOutQuad,
                                ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                      itemCount: logs.length,
                      itemBuilder: (ctx, i) =>
                          _ServiceLogCard(
                                log: logs[i],
                                currencySymbol: currencySymbol,
                              )
                              .animate(delay: (i * 50).ms)
                              .fadeIn(duration: 300.ms)
                              .slideY(
                                begin: 0.1,
                                duration: 300.ms,
                                curve: Curves.easeOutQuad,
                              ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AppErrorWidget(
          onRetry: () => ref.invalidate(activeCarServiceLogsProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        icon: const Icon(Icons.add_circle_outline),
        label: const Text('Log Service'),
      ),
    );
  }

  void _showAddDialog(BuildContext context, [ServiceLog? existing]) {
    showDialog(
      context: context,
      builder: (_) => AddServiceLogDialog(existing: existing),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return EmptyStateView(
      icon: Icons.history_outlined,
      title: 'No service records yet',
      message:
          'Log your first oil change, tyre rotation,\nor any other service.',
    );
  }
}

// ---------------------------------------------------------------------------
// Summary Banner
// ---------------------------------------------------------------------------
class _SummaryBanner extends ConsumerWidget {
  final double totalSpend;
  final DateTime lastServiceDate;
  final int totalRecords;

  const _SummaryBanner({
    required this.totalSpend,
    required this.lastServiceDate,
    required this.totalRecords,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currencySymbol =
        ref.watch(settingsNotifierProvider).valueOrNull?.currencySymbol ?? '\$';
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            label: 'Records',
            value: '$totalRecords',
            icon: Icons.receipt_long_outlined,
          ),
          _VerticalDivider(),
          _StatItem(
            label: 'Last Service',
            value: lastServiceDate.toShortDate(),
            icon: Icons.event_outlined,
          ),
          _VerticalDivider(),
          _StatItem(
            label: 'Total Spend',
            value: totalSpend.toCurrency(currencySymbol),
            icon: Icons.payments_outlined,
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    height: 36,
    color: Theme.of(
      context,
    ).colorScheme.onPrimaryContainer.withValues(alpha: 0.2),
  );
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onContainer = theme.colorScheme.onPrimaryContainer;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: onContainer),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: onContainer,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: onContainer.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Service Log Card
// ---------------------------------------------------------------------------
class _ServiceLogCard extends ConsumerWidget {
  final ServiceLog log;
  final String currencySymbol;

  const _ServiceLogCard({required this.log, required this.currencySymbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: AppStyles.premiumCardDecoration(context),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (_) => AddServiceLogDialog(existing: log),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: service name + date
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.build_outlined,
                      size: 20,
                      color: theme.colorScheme.surface,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          log.serviceName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          log.serviceDate.toShortDate(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Delete button
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: theme.colorScheme.error,
                    ),
                    tooltip: 'Delete',
                    visualDensity: VisualDensity.compact,
                    onPressed: () => _confirmDelete(context, ref),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Info chips row
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  if (log.provider != null)
                    _InfoChip(icon: Icons.store_outlined, label: log.provider!),
                  if (log.mileageAtService != null)
                    _InfoChip(
                      icon: Icons.speed_outlined,
                      label: '${log.mileageAtService} mi',
                    ),
                  if (log.cost != null)
                    _InfoChip(label: log.cost!.toCurrency(currencySymbol)),
                ],
              ),
              if (log.notes != null) ...[
                const SizedBox(height: 10),
                Text(
                  log.notes!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.delete_outline),
        title: const Text('Delete Record'),
        content: Text('Remove "${log.serviceName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ref
                  .read(serviceHistoryControllerProvider.notifier)
                  .deleteLog(log.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData? icon;
  final String label;

  const _InfoChip({this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = theme.colorScheme.surfaceContainerHighest;
    final fg = theme.colorScheme.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon!, size: 13, color: fg),
            const SizedBox(width: 4),
          ],
          Text(label, style: theme.textTheme.labelSmall?.copyWith(color: fg)),
        ],
      ),
    );
  }
}
