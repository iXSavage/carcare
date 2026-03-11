import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../data/models/fuel_entry.dart';
import '../data/repositories/fuel_repository.dart';
import '../../../core/providers/car_providers.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/settings/settings_provider.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/widgets/empty_state_view.dart';

class FuelLogScreen extends ConsumerWidget {
  const FuelLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carAsync = ref.watch(currentCarProvider);
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final theme = Theme.of(context);

    return carAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (car) {
        if (car == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Fuel Log')),
            body: const Center(child: Text('Add a car in your Garage first.')),
          );
        }

        final settings = settingsAsync.valueOrNull ?? const AppSettings();
        final entriesAsync = ref.watch(_fuelEntriesProvider(car.id));
        final statsAsync = ref.watch(_fuelStatsProvider(car.id));

        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // App bar
              SliverAppBar(
                pinned: true,
                expandedHeight: 60,
                backgroundColor: theme.scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                  title: Text(
                    'Fuel Log',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Stats strip
              SliverToBoxAdapter(
                child: statsAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (e, stack) => const SizedBox.shrink(),
                  data: (stats) => _StatsStrip(
                    stats: stats,
                  ).animate().fadeIn(duration: 400.ms),
                ),
              ),

              // Entries list
              entriesAsync.when(
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => SliverFillRemaining(
                  child: Center(child: Text('Error: $e')),
                ),
                data: (entries) {
                  if (entries.isEmpty) {
                    return SliverFillRemaining(
                      child: _buildEmptyState(context, ref, car.id, settings),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) =>
                            _FuelEntryCard(
                              entry: entries[i],
                              settings: settings,
                              onDelete: () async {
                                await ref
                                    .read(fuelRepositoryProvider)
                                    .deleteFuelEntry(entries[i].id);
                                ref.invalidate(_fuelStatsProvider(car.id));
                              },
                            ).animate().fadeIn(
                              delay: (i * 40).ms,
                              duration: 300.ms,
                            ),
                        childCount: entries.length,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddDialog(context, ref, car.id, settings),
            icon: const Icon(Icons.local_gas_station),
            label: const Text('Add Fill-Up'),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    WidgetRef ref,
    int carId,
    AppSettings settings,
  ) {
    return EmptyStateView(
      icon: Icons.local_gas_station_outlined,
      title: 'No fill-ups logged yet',
      message:
          'Tap + to log your first fill-up\nand start tracking fuel economy.',
    );
  }

  void _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    int carId,
    AppSettings settings,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddFuelEntrySheet(
        carId: carId,
        settings: settings,
        onSave: (entry) async {
          await ref.read(fuelRepositoryProvider).saveFuelEntry(entry);
          ref.invalidate(_fuelStatsProvider(carId));
        },
      ),
    );
  }
}

// ── Riverpod providers ─────────────────────────────────────────────────────────

final _fuelEntriesProvider = StreamProvider.autoDispose
    .family<List<FuelEntry>, int>(
      (ref, carId) =>
          ref.watch(fuelRepositoryProvider).watchEntriesForCar(carId),
    );

final _fuelStatsProvider = FutureProvider.autoDispose.family<FuelStats, int>(
  (ref, carId) => ref.watch(fuelRepositoryProvider).getStats(carId),
);

// ── Stats strip ────────────────────────────────────────────────────────────────

class _StatsStrip extends ConsumerWidget {
  final FuelStats stats;
  const _StatsStrip({required this.stats});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final fmt = NumberFormat('#,##0.0');
    final settings =
        ref.watch(settingsNotifierProvider).valueOrNull ?? const AppSettings();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          _StatChip(
            icon: Icons.water_drop_outlined,
            label: 'Total',
            value: '${fmt.format(stats.totalLitres)} ${settings.fuelLabel}',
            theme: theme,
          ),
          const SizedBox(width: 10),
          _StatChip(
            icon: Icons.payments_outlined,
            label: 'Spent',
            value:
                '${settings.currencySymbol}${NumberFormat('#,##0').format(stats.totalCost)}',
            theme: theme,
          ),
          const SizedBox(width: 10),
          if (stats.avgL100km != null)
            _StatChip(
              icon: Icons.speed_outlined,
              label: settings.distanceUnit == DistanceUnit.miles
                  ? 'MPG'
                  : 'L/100km',
              value: settings.distanceUnit == DistanceUnit.miles
                  ? fmt.format(stats.avgMpg ?? 0)
                  : fmt.format(stats.avgL100km!),
              theme: theme,
            ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final ThemeData theme;
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: AppStyles.premiumCardDecoration(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                value,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Fuel entry card ────────────────────────────────────────────────────────────

class _FuelEntryCard extends StatelessWidget {
  final FuelEntry entry;
  final AppSettings settings;
  final VoidCallback onDelete;
  const _FuelEntryCard({
    required this.entry,
    required this.settings,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFmt = DateFormat('d MMM yyyy');
    final numFmt = NumberFormat('#,##0.00');

    return Dismissible(
      key: Key('fuel_${entry.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.delete_outline, color: theme.colorScheme.error),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete entry?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: AppStyles.premiumCardDecoration(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Date column
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.local_gas_station,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dateFmt.format(entry.date),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${numFmt.format(entry.litres)} ${settings.fuelLabel} · ${NumberFormat('#,##0').format(entry.odometer)} ${settings.distanceLabel}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        if (entry.notes != null && entry.notes!.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            entry.notes!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Cost + receipt thumbnail column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${settings.currencySymbol}${NumberFormat('#,##0').format(entry.costTotal)}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (entry.costPerLitre != null)
                        Text(
                          '${settings.currencySymbol}${numFmt.format(entry.costPerLitre!)}/${settings.fuelLabel}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      // Receipt thumbnail
                      if (entry.receiptPhotoPath != null &&
                          File(entry.receiptPhotoPath!).existsSync()) ...[
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () => _showFullScreenPhoto(
                            context,
                            entry.receiptPhotoPath!,
                          ),
                          child: Hero(
                            tag: 'receipt_${entry.id}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(entry.receiptPhotoPath!),
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullScreenPhoto(BuildContext context, String path) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _ReceiptFullScreenViewer(
          photoPath: path,
          heroTag: 'receipt_${entry.id}',
        ),
      ),
    );
  }
} // end _FuelEntryCard

// ── Add fill-up bottom sheet ───────────────────────────────────────────────────

class _AddFuelEntrySheet extends StatefulWidget {
  final int carId;
  final AppSettings settings;
  final Future<void> Function(FuelEntry) onSave;
  const _AddFuelEntrySheet({
    required this.carId,
    required this.settings,
    required this.onSave,
  });

  @override
  State<_AddFuelEntrySheet> createState() => _AddFuelEntrySheetState();
}

class _AddFuelEntrySheetState extends State<_AddFuelEntrySheet> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  final _litresCtrl = TextEditingController();
  final _costCtrl = TextEditingController();
  final _odomCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  bool _isFull = false;
  bool _saving = false;
  File? _pickedPhoto;
  final _imagePicker = ImagePicker();

  @override
  void dispose() {
    _litresCtrl.dispose();
    _costCtrl.dispose();
    _odomCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    // Copy receipt photo to permanent storage if one was picked
    String? finalPhotoPath;
    if (_pickedPhoto != null) {
      final docsDir = await getApplicationDocumentsDirectory();
      final destPath = p.join(
        docsDir.path,
        'fuel_receipts',
        'receipt_${widget.carId}_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await Directory(p.dirname(destPath)).create(recursive: true);
      await _pickedPhoto!.copy(destPath);
      finalPhotoPath = destPath;
    }

    final entry = FuelEntry()
      ..carId = widget.carId
      ..date = _date
      ..litres = double.parse(_litresCtrl.text)
      ..costTotal = double.parse(_costCtrl.text)
      ..odometer = int.parse(_odomCtrl.text)
      ..isFull = _isFull
      ..notes = _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim()
      ..receiptPhotoPath = finalPhotoPath;

    await widget.onSave(entry);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final picked = await _imagePicker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1920,
    );
    if (picked != null) setState(() => _pickedPhoto = File(picked.path));
  }

  void _showPhotoPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        decoration: AppStyles.bottomSheetDecoration(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickPhoto(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickPhoto(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Add Fill-Up',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Date picker
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today_outlined),
                  title: Text(DateFormat('d MMMM yyyy').format(_date)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) setState(() => _date = picked);
                  },
                ),
                const Divider(),
                const SizedBox(height: 12),

                // Litres + cost row
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _litresCtrl,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Litres (${widget.settings.fuelLabel})',
                          prefixIcon: const Icon(Icons.water_drop_outlined),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        validator: (v) =>
                            (v == null || double.tryParse(v) == null)
                            ? 'Required'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _costCtrl,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText:
                              'Total Cost (${widget.settings.currencySymbol})',
                          prefixText: widget.settings.currencySymbol,
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        validator: (v) =>
                            (v == null || double.tryParse(v) == null)
                            ? 'Required'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Odometer
                TextFormField(
                  controller: _odomCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Odometer (${widget.settings.distanceLabel})',
                    prefixIcon: const Icon(Icons.speed_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) => (v == null || int.tryParse(v) == null)
                      ? 'Required'
                      : null,
                ),
                const SizedBox(height: 14),

                // Full tank toggle
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Full tank'),
                  subtitle: const Text(
                    'Needed for accurate economy calculation',
                  ),
                  value: _isFull,
                  onChanged: (v) => setState(() => _isFull = v),
                ),
                const SizedBox(height: 8),

                // Notes
                TextFormField(
                  controller: _notesCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Notes (optional)',
                    prefixIcon: Icon(Icons.notes_outlined),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 14),

                // Receipt photo picker
                _ReceiptPhotoPicker(
                  pickedPhoto: _pickedPhoto,
                  onPickTap: _showPhotoPicker,
                  onRemove: () => setState(() => _pickedPhoto = null),
                ),
                const SizedBox(height: 24),

                // Save button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _saving ? null : _save,
                    icon: _saving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.check),
                    label: Text(_saving ? 'Saving…' : 'Save Fill-Up'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Receipt photo picker row (used in _AddFuelEntrySheet) ─────────────────────

class _ReceiptPhotoPicker extends StatelessWidget {
  final File? pickedPhoto;
  final VoidCallback onPickTap;
  final VoidCallback onRemove;

  const _ReceiptPhotoPicker({
    required this.pickedPhoto,
    required this.onPickTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPhoto = pickedPhoto != null;

    return GestureDetector(
      onTap: hasPhoto ? null : onPickTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: hasPhoto ? 120 : 56,
        width: double.infinity,
        decoration: BoxDecoration(
          color: hasPhoto
              ? Colors.transparent
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasPhoto
                ? theme.colorScheme.primary.withOpacity(0.4)
                : theme.colorScheme.outlineVariant,
            width: hasPhoto ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: hasPhoto
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(pickedPhoto!, fit: BoxFit.cover),
                  // Remove button
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  // Change photo button at bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: onPickTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        color: Colors.black.withOpacity(0.45),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Change photo',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Attach receipt photo (optional)',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ── Full-screen receipt viewer ────────────────────────────────────────────────

class _ReceiptFullScreenViewer extends StatelessWidget {
  final String photoPath;
  final String heroTag;

  const _ReceiptFullScreenViewer({
    required this.photoPath,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Receipt', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Share the image
            },
          ),
        ],
      ),
      body: Center(
        child: Hero(
          tag: heroTag,
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: Image.file(File(photoPath), fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
