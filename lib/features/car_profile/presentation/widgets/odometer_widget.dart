import 'package:flutter/material.dart';

/// Premium animated odometer digit drum widget.
/// Each character of the formatted mileage is rendered in its own
/// recessed slot, with a count-up animation driven by TweenAnimationBuilder.
class OdometerWidget extends StatelessWidget {
  final int mileage;

  const OdometerWidget({super.key, required this.mileage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: mileage),
      duration: const Duration(milliseconds: 1800),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, _) {
        // Format with commas, e.g. 45231 → "45,231"
        final formatted = _formatMileage(animatedValue);
        return Column(
          children: [
            // ── Odometer drum panel ───────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.surfaceContainerHigh,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Digit slots row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: formatted.characters
                        .map(
                          (ch) => _OdometerDigit(
                            character: ch,
                            theme: theme,
                            isSeparator: ch == ',',
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'mi',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary.withOpacity(0.6),
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String _formatMileage(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buffer.write(',');
      buffer.write(s[i]);
    }
    return buffer.toString();
  }
}

/// A single digit or separator slot in the odometer drum.
class _OdometerDigit extends StatelessWidget {
  final String character;
  final ThemeData theme;
  final bool isSeparator;

  const _OdometerDigit({
    required this.character,
    required this.theme,
    this.isSeparator = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isSeparator) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Text(
          ',',
          style: TextStyle(
            color: theme.colorScheme.primary.withOpacity(0.5),
            fontSize: 24,
            fontWeight: FontWeight.w300,
            height: 1,
          ),
        ),
      );
    }

    return Container(
      width: 36,
      height: 52,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 0.5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Top shadow overlay (drum illusion)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.15), Colors.transparent],
                ),
              ),
            ),
          ),
          // Bottom shadow overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(6),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.15), Colors.transparent],
                ),
              ),
            ),
          ),
          // The digit itself
          Text(
            character,
            style: TextStyle(
              fontFamily: 'monospace',
              color: theme.colorScheme.primary,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
