/// Central place for all magic numbers and app-wide constants.
/// Any threshold used in business logic lives here — never hardcoded inline.
abstract class AppConstants {
  // Maintenance reminder thresholds
  static const int dueSoonDaysThreshold = 30;
  static const int criticalDaysThreshold = 7;
  static const double dueSoonMileagePercent = 0.10;

  // Document reminder defaults
  static const List<int> defaultReminderOffsets = [30, 7, 0];

  // Navigation breakpoints (matching M3 spec)
  static const double phoneBreakpoint = 600;
  static const double desktopBreakpoint = 840;
}
