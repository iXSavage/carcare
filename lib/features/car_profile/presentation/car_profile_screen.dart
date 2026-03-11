import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../data/repositories/car_repository.dart';
import '../data/models/car.dart';
import '../../../core/providers/car_providers.dart';
import 'widgets/car_details_card.dart';
import 'widgets/cost_overview_card.dart';
import 'widgets/odometer_widget.dart';
import 'dialogs/car_profile_form_dialog.dart';
import 'car_profile_controller.dart';

class CarProfileScreen extends ConsumerStatefulWidget {
  const CarProfileScreen({super.key});

  @override
  ConsumerState<CarProfileScreen> createState() => _CarProfileScreenState();
}

class _CarProfileScreenState extends ConsumerState<CarProfileScreen> {
  bool _hasAttemptedLoad = false;
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted && !_hasAttemptedLoad) {
        _hasAttemptedLoad = true;
      }
    });
  }

  // ── Photo picking ────────────────────────────────────────────────────
  Future<void> _pickCarPhoto(Car car, ImageSource source) async {
    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
      );
      if (picked == null) return;

      // Copy to permanent app documents directory so the file survives cache clears
      final docsDir = await getApplicationDocumentsDirectory();
      final destPath = p.join(
        docsDir.path,
        'car_photos',
        'car_${car.id}_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await Directory(p.dirname(destPath)).create(recursive: true);
      await File(picked.path).copy(destPath);

      // Persist the path on the Car model
      // Use Controller to update instead of calling Repository directly
      await ref
          .read(carProfileControllerProvider.notifier)
          .updateCarPhoto(car, destPath);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not pick photo: $e')));
      }
    }
  }

  void _showPhotoPickerSheet(BuildContext context, Car car) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
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
              'Update Car Photo',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              title: const Text('Take Photo'),
              subtitle: const Text('Open camera'),
              onTap: () {
                Navigator.pop(context);
                _pickCarPhoto(car, ImageSource.camera);
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.photo_library_outlined,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              title: const Text('Choose from Library'),
              subtitle: const Text('Pick an existing photo'),
              onTap: () {
                Navigator.pop(context);
                _pickCarPhoto(car, ImageSource.gallery);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeCarAsync = ref.watch(currentCarProvider);

    return Scaffold(
      body: activeCarAsync.when(
        data: (car) {
          if (car == null) {
            return _buildEmptyState(context, ref);
          }
          return _buildProfile(context, ref, car, theme);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error loading car profile',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(err.toString(), style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ),
      floatingActionButton: activeCarAsync.value == null
          ? null
          : FloatingActionButton(
              onPressed: () =>
                  showCarProfileFormDialog(context, car: activeCarAsync.value),
              child: const Icon(Icons.edit),
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.directions_car_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text('No car selected or created.'),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => showCarProfileFormDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Car'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfile(
    BuildContext context,
    WidgetRef ref,
    Car car,
    ThemeData theme,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              [
                    Text(
                      'Details',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: CarDetailsCard(car: car)),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildMileageCard(
                                  car,
                                  theme,
                                  context,
                                  ref,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              CarDetailsCard(car: car),
                              const SizedBox(height: 16),
                              _buildMileageCard(car, theme, context, ref),
                            ],
                          ),
                    const SizedBox(height: 24),
                    Text(
                      'Cost Overview',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CostOverviewCard(carId: car.id),
                  ]
                  .animate(interval: 100.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(
                    begin: 0.1,
                    duration: 400.ms,
                    curve: Curves.easeOutQuad,
                  ),
        );

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 320,
              pinned: true,
              stretch: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                title: Text(
                  '${car.make} ${car.model}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: GestureDetector(
                  onTap: () => _showPhotoPickerSheet(context, car),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Hero image: user photo > asset fallback
                      Hero(
                        tag: 'car_hero_${car.id}',
                        child:
                            car.photoPath != null &&
                                File(car.photoPath!).existsSync()
                            ? Image.file(
                                File(car.photoPath!),
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              )
                            : Image.asset(
                                'assets/images/car_hero.png',
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                      ),
                      // Bottom gradient for readability of title
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black54,
                              Colors.black,
                            ],
                            stops: [0.5, 0.8, 1.0],
                          ),
                        ),
                      ),
                      // Camera icon badge — bottom-right
                      Positioned(
                        right: 16,
                        bottom: 56,
                        child: GestureDetector(
                          onTap: () => _showPhotoPickerSheet(context, car),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.55),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWide ? 800 : double.infinity,
                    ),
                    child: content,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMileageCard(
    Car car,
    ThemeData theme,
    BuildContext context,
    WidgetRef ref,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.surfaceContainerHigh,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.speed_outlined,
                  color: theme.colorScheme.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'ODOMETER',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            OdometerWidget(mileage: car.currentMileage),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                  foregroundColor: theme.colorScheme.primary,
                  side: BorderSide(
                    color: theme.colorScheme.primary.withOpacity(0.4),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () =>
                    _showUpdateMileageDialog(context, ref, car.currentMileage),
                icon: const Icon(Icons.update, size: 16),
                label: const Text('Update Mileage'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateMileageDialog(
    BuildContext context,
    WidgetRef ref,
    int currentMileage,
  ) {
    final controller = TextEditingController(text: currentMileage.toString());
    String? errorText;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Update Mileage'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'New Mileage',
              border: const OutlineInputBorder(),
              suffixText: 'mi',
              errorText: errorText,
            ),
            onChanged: (_) {
              if (errorText != null) setState(() => errorText = null);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final value = int.tryParse(controller.text);
                if (value == null) {
                  setState(() => errorText = 'Enter a valid number');
                  return;
                }
                if (value < currentMileage) {
                  setState(
                    () => errorText =
                        'New mileage must be >= current ($currentMileage mi)',
                  );
                  return;
                }

                ref
                    .read(carProfileControllerProvider.notifier)
                    .updateMileage(value)
                    .then((_) {
                      if (context.mounted) Navigator.pop(context);
                    })
                    .catchError((err) {
                      setState(() => errorText = err.toString());
                    });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
