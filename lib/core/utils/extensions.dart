/// Shared formatting extensions so date/currency formatting
/// is never duplicated across widgets.
extension DateFormatting on DateTime {
  /// Returns MM/DD/YYYY (e.g. "03/01/2026")
  String toShortDate() =>
      '${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}/$year';

  /// Returns "Month YYYY" (e.g. "March 2026")
  String toMonthYear() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[month - 1]} $year';
  }
}

extension CurrencyFormatting on double {
  /// Returns a formatted cost string using the provided [symbol].
  /// Defaults to '$' if no symbol is given.
  String toCurrency([String symbol = '\$']) => '$symbol${toStringAsFixed(2)}';
}

extension IntFormatting on int {
  /// Returns a mileage string (e.g. "5,000 mi")
  String toMileage() {
    if (this >= 1000) {
      final thousands = this ~/ 1000;
      final remainder = this % 1000;
      return remainder == 0
          ? '${thousands}k mi'
          : '$thousands,${remainder.toString().padLeft(3, '0')} mi';
    }
    return '$this mi';
  }
}
