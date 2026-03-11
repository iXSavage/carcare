import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/providers/car_providers.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../data/models/maintenance_task.dart';
import '../data/repositories/maintenance_repository.dart';
import '../utils/reminder_calculator.dart';
import '../../../core/theme/app_styles.dart';
import 'add_maintenance_dialog.dart';
import 'maintenance_controller.dart';

class MaintenanceScreen extends ConsumerWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(activeCarMaintenanceTasksProvider);
    final currentCarAsync = ref.watch(currentCarProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Maintenance Reminders')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showTaskDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
      body: currentCarAsync.when(
        // Fix #3: AppErrorWidget with retry
        error: (e, _) =>
            AppErrorWidget(onRetry: () => ref.invalidate(currentCarProvider)),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (car) {
          if (car == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.directions_car_outlined,
                      size: 64,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No vehicle added yet',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add your car in the Car tab first.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return tasksAsync.when(
            // Fix #3: AppErrorWidget with retry
            error: (e, _) => AppErrorWidget(
              onRetry: () => ref.invalidate(activeCarMaintenanceTasksProvider),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (tasks) {
              if (tasks.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.build_circle_outlined,
                        size: 64,
                        color: theme.colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No maintenance tasks yet.',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap + to add your first reminder.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Fix #4: Pre-compute status for every task once.
              // Avoids O(n log n) redundant calls during sort + O(n) during render.
              final statusMap = {
                for (final t in tasks)
                  t.id: ReminderCalculator.calculateStatus(
                    t,
                    car.currentMileage,
                  ),
              };

              // Sort using the pre-computed map — no more double-calculation
              final sorted = [...tasks]
                ..sort(
                  (a, b) => _statusPriority(
                    statusMap[b.id]!,
                  ).compareTo(_statusPriority(statusMap[a.id]!)),
                );

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
                itemCount: sorted.length,
                itemBuilder: (context, index) {
                  final task = sorted[index];
                  return _TaskCard(
                        task: task,
                        status: statusMap[task.id]!,
                        currentMileage: car.currentMileage,
                      )
                      .animate(delay: (index * 50).ms)
                      .fadeIn(duration: 300.ms)
                      .slideY(
                        begin: 0.1,
                        duration: 300.ms,
                        curve: Curves.easeOutQuad,
                      );
                },
              );
            },
          );
        },
      ),
    );
  }

  int _statusPriority(MaintenanceStatus status) {
    switch (status) {
      case MaintenanceStatus.overdue:
        return 3;
      case MaintenanceStatus.dueSoon:
        return 2;
      case MaintenanceStatus.good:
        return 1;
      case MaintenanceStatus.unknown:
        return 0;
    }
  }

  void _showTaskDialog(BuildContext context, [MaintenanceTask? existing]) {
    showDialog(
      context: context,
      builder: (_) => AddMaintenanceDialog(existing: existing),
    );
  }
}

// ---------------------------------------------------------------------------
// Task Card — extracted to its own ConsumerWidget so it can read ref cleanly
// ---------------------------------------------------------------------------
class _TaskCard extends ConsumerWidget {
  final MaintenanceTask task;
  final MaintenanceStatus status;
  final int currentMileage;

  const _TaskCard({
    required this.task,
    required this.status,
    required this.currentMileage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final (statusColor, statusIcon) = switch (status) {
      MaintenanceStatus.overdue => (
        theme.colorScheme.error,
        Icons.warning_rounded,
      ),
      MaintenanceStatus.dueSoon => (Colors.orange, Icons.access_time_filled),
      MaintenanceStatus.good => (Colors.green, Icons.check_circle),
      MaintenanceStatus.unknown => (theme.dividerColor, Icons.help_outline),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppStyles.premiumCardDecoration(context),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // Fix #6: onTap now opens the edit dialog
          onTap: () => showDialog(
            context: context,
            builder: (_) => AddMaintenanceDialog(existing: task),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(statusIcon, color: statusColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        task.taskName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 20),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'done',
                          child: Row(
                            children: [
                              Icon(Icons.check, size: 20),
                              SizedBox(width: 8),
                              Text('Mark as Done'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 20, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'edit') {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                AddMaintenanceDialog(existing: task),
                          );
                        } else if (value == 'done') {
                          // Fix #5: Confirmation dialog before destructive action
                          _confirmMarkAsDone(context, ref);
                        } else if (value == 'delete') {
                          _confirmDelete(context, ref);
                        }
                      },
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    if (task.mileageInterval != null)
                      Expanded(
                        child: _InfoRow(
                          icon: Icons.speed,
                          text: ReminderCalculator.getMileageRemainingText(
                            task,
                            currentMileage,
                          ),
                          statusColor: statusColor,
                        ),
                      ),
                    if (task.timeIntervalMonths != null)
                      Expanded(
                        child: _InfoRow(
                          icon: Icons.calendar_today,
                          text: ReminderCalculator.getDaysRemainingText(task),
                          statusColor: statusColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fix #5: Confirmation dialog before marking as done
  void _confirmMarkAsDone(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle_outline),
        title: const Text('Mark as Done?'),
        content: Text(
          'This will reset "${task.taskName}" and set today as the last service date '
          'at your current mileage. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ref.read(maintenanceControllerProvider.notifier).markAsDone(task);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.delete_outline),
        title: const Text('Delete Task'),
        content: Text('Remove "${task.taskName}"? This cannot be undone.'),
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
                  .read(maintenanceControllerProvider.notifier)
                  .deleteTask(task.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Info Row chip
// ---------------------------------------------------------------------------
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color statusColor;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOverdue = text.contains('overdue');
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
              color: isOverdue ? statusColor : null,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
