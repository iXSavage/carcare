import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../data/models/document_reminder.dart';
import '../data/repositories/document_repository.dart';
import '../../../core/theme/app_styles.dart';
import 'add_document_dialog.dart';
import 'documents_controller.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docsAsync = ref.watch(activeCarDocumentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add document',
            onPressed: () => _showAddDialog(context),
          ),
        ],
      ),
      body: docsAsync.when(
        data: (docs) {
          if (docs.isEmpty) return _buildEmpty(context);

          // Sort: expired first, then by days remaining ascending
          final sorted = [...docs]
            ..sort((a, b) => a.daysUntilExpiry.compareTo(b.daysUntilExpiry));

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 600;

              if (isWide) {
                // Tablet / wide: two-column grid
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth >= 900 ? 3 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: sorted.length,
                  itemBuilder: (ctx, i) =>
                      _DocumentCard(doc: sorted[i], wide: true)
                          .animate(delay: (i * 50).ms)
                          .fadeIn(duration: 300.ms)
                          .slideY(
                            begin: 0.1,
                            duration: 300.ms,
                            curve: Curves.easeOutQuad,
                          ),
                );
              }

              // Phone: vertical list
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
                itemCount: sorted.length,
                itemBuilder: (ctx, i) =>
                    _DocumentCard(doc: sorted[i], wide: false)
                        .animate(delay: (i * 50).ms)
                        .fadeIn(duration: 300.ms)
                        .slideY(
                          begin: 0.1,
                          duration: 300.ms,
                          curve: Curves.easeOutQuad,
                        ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AppErrorWidget(
          onRetry: () => ref.invalidate(activeCarDocumentsProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        icon: const Icon(Icons.upload_file_outlined),
        label: const Text('Add Document'),
      ),
    );
  }

  void _showAddDialog(BuildContext context, [DocumentReminder? existing]) {
    showDialog(
      context: context,
      builder: (_) => AddDocumentDialog(existing: existing),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.file_copy_outlined,
            size: 72,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text('No documents yet', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Add your Insurance, Registration, MOT\nor any expiry-tracked document.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Document Card
// ---------------------------------------------------------------------------
class _DocumentCard extends ConsumerWidget {
  final DocumentReminder doc;
  final bool wide;

  const _DocumentCard({required this.doc, required this.wide});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final status = doc.status;
    final daysLeft = doc.daysUntilExpiry;

    final (statusColor, statusBg, statusIcon, statusLabel) = _statusStyle(
      theme,
      status,
    );

    return Container(
      margin: wide ? EdgeInsets.zero : const EdgeInsets.only(bottom: 12),
      decoration: AppStyles.premiumCardDecoration(context),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showEditDialog(context, doc),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // — Coloured status banner
              Container(
                color: statusBg,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Icon(statusIcon, size: 16, color: statusColor),
                    const SizedBox(width: 6),
                    Text(
                      statusLabel,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // Mute toggle
                    Tooltip(
                      message: doc.isActive
                          ? 'Mute reminders'
                          : 'Unmute reminders',
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => ref
                            .read(documentsControllerProvider.notifier)
                            .toggleActive(doc),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            doc.isActive
                                ? Icons.notifications_active_outlined
                                : Icons.notifications_off_outlined,
                            size: 18,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // — Main content
              _ExpandedIfWide(
                wide: wide,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          doc.documentType,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Title
                      Text(
                        doc.documentTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (wide) const Spacer() else const SizedBox(height: 16),
                      // Expiry info
                      Row(
                        children: [
                          Icon(
                            Icons.event_outlined,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            doc.expiryDate.toShortDate(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _daysText(daysLeft),
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // — Action bar
              const Divider(height: 1),
              Row(
                children: [
                  _CardAction(
                    icon: Icons.edit_outlined,
                    label: 'Edit',
                    onTap: () => _showEditDialog(context, doc),
                  ),
                  const VerticalDivider(width: 1),
                  _CardAction(
                    icon: Icons.delete_outline,
                    label: 'Delete',
                    color: theme.colorScheme.error,
                    onTap: () => _confirmDelete(context, ref, doc),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Status colours
  (Color, Color, IconData, String) _statusStyle(ThemeData t, DocumentStatus s) {
    switch (s) {
      case DocumentStatus.expired:
        return (
          t.colorScheme.error,
          t.colorScheme.errorContainer.withValues(alpha: 0.5),
          Icons.warning_rounded,
          'EXPIRED',
        );
      case DocumentStatus.critical:
        return (
          Colors.deepOrange,
          Colors.deepOrange.withValues(alpha: 0.12),
          Icons.access_alarm,
          'CRITICAL',
        );
      case DocumentStatus.warning:
        return (
          Colors.amber.shade700,
          Colors.amber.withValues(alpha: 0.12),
          Icons.schedule,
          'DUE SOON',
        );
      case DocumentStatus.ok:
        return (
          Colors.green.shade700,
          Colors.green.withValues(alpha: 0.10),
          Icons.verified_outlined,
          'VALID',
        );
    }
  }

  // Uses DateFormatting extension from core/utils/extensions.dart

  String _daysText(int days) {
    if (days < 0) return '${days.abs()}d overdue';
    if (days == 0) return 'Today!';
    return 'In ${days}d';
  }

  void _showEditDialog(BuildContext context, DocumentReminder doc) {
    showDialog(
      context: context,
      builder: (_) => AddDocumentDialog(existing: doc),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    DocumentReminder doc,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.delete_outline),
        title: const Text('Delete Document'),
        content: Text(
          'Remove "${doc.documentTitle}"? All scheduled reminders will be cancelled.',
        ),
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
                  .read(documentsControllerProvider.notifier)
                  .deleteDocument(doc.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _CardAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _CardAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = color ?? theme.colorScheme.primary;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: c),
              const SizedBox(width: 4),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(color: c),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandedIfWide extends StatelessWidget {
  final bool wide;
  final Widget child;

  const _ExpandedIfWide({required this.wide, required this.child});

  @override
  Widget build(BuildContext context) {
    if (wide) {
      return Expanded(child: child);
    }
    return child;
  }
}
