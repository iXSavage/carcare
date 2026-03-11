import 'package:flutter/material.dart';

/// Centralized styles for the CarCare app to ensure a consistent, premium
/// Light Mode aesthetic across all features without duplicating boilerplate.
class AppStyles {
  /// Defines the standard elevated "frosted white" card look used throughout
  /// the app (Garage, Maintenance, Fuel Log, Documents).
  ///
  /// This replaces the standard Material [Card] widget to provide exact
  /// control over the drop shadow, border, and background color.
  static BoxDecoration premiumCardDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
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
    );
  }

  /// Defines the styling for modal bottom sheets (e.g. Add Fuel, Add Task).
  static BoxDecoration bottomSheetDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, -5),
        ),
      ],
    );
  }

  /// Small status chips or pill badges.
  static BoxDecoration chipDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: theme.colorScheme.surfaceContainerHigh),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
