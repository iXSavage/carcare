import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/models/car.dart';
import '../data/repositories/car_repository.dart';
import '../../../core/providers/car_providers.dart';
import '../../../core/theme/app_styles.dart';
import 'dialogs/car_profile_form_dialog.dart';

class GarageScreen extends ConsumerWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsAsync = ref.watch(allCarsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: carsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (cars) => CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 100,
              backgroundColor: theme.scaffoldBackgroundColor,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  tooltip: 'Settings',
                  onPressed: () => context.push('/settings'),
                ),
                const SizedBox(width: 8),
              ],
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                title: Text(
                  'My Garage',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (cars.isEmpty)
              SliverFillRemaining(child: _buildEmptyGarage(context, ref))
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    mainAxisExtent: 240,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _CarCard(
                      car: cars[i],
                      onTap: () async {
                        await ref
                            .read(carRepositoryProvider)
                            .setActiveCar(cars[i].id);
                        if (context.mounted) context.go('/car');
                      },
                      onDelete: () => _confirmDelete(context, ref, cars[i]),
                    ).animate().fadeIn(delay: (i * 60).ms, duration: 350.ms),
                    childCount: cars.length,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCarDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Car'),
      ),
    );
  }

  Widget _buildEmptyGarage(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.garage_outlined,
            size: 80,
            color: theme.colorScheme.primary.withOpacity(0.4),
          ),
          const SizedBox(height: 20),
          Text(
            'Your garage is empty',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first car to get started',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: () => _showAddCarDialog(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Add Car'),
          ),
        ],
      ),
    );
  }

  void _showAddCarDialog(BuildContext context, WidgetRef ref) {
    showCarProfileFormDialog(context);
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Car car) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Car?'),
        content: Text(
          'This will permanently delete ${car.make} ${car.model} and all associated data.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(carRepositoryProvider).deleteCar(car.id);
              ref.invalidate(allCarsProvider);
              ref.invalidate(currentCarProvider);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _CarCard extends StatelessWidget {
  final Car car;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _CarCard({
    required this.car,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPhoto = car.photoPath != null && File(car.photoPath!).existsSync();

    return GestureDetector(
      onTap: onTap,
      onLongPress: onDelete,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: AppStyles.premiumCardDecoration(context).copyWith(
          border: Border.all(
            color: car.isActive
                ? theme.colorScheme.primary
                : theme.colorScheme.surfaceContainerHigh,
            width: car.isActive ? 2 : 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image area
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'car_hero_${car.id}',
                      child: hasPhoto
                          ? Image.file(File(car.photoPath!), fit: BoxFit.cover)
                          : Image.asset(
                              'assets/images/car_hero.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                    // Active badge
                    if (car.isActive)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Active',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Info area
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${car.make} ${car.model}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${car.year}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
