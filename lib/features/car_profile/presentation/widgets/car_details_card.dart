import 'package:flutter/material.dart';
import '../../../../core/theme/app_styles.dart';
import '../../data/models/car.dart';

/// A premium light-aesthetic card displaying key car details like License Plate and VIN.
class CarDetailsCard extends StatelessWidget {
  final Car car;

  const CarDetailsCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: AppStyles.premiumCardDecoration(context),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              'License Plate',
              car.licensePlate ?? 'Not specified',
              theme,
            ),
            const Divider(height: 32),
            _buildDetailRow('VIN', car.vin ?? 'Not specified', theme),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}
