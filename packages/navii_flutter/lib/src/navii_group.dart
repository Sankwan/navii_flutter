import 'package:flutter/material.dart';
import 'navii_widget.dart';

/// A row of overlapping avatars, commonly used in group lists or
/// "participants" indicators.
///
/// ```dart
/// // Three visible, rest collapsed into a count badge
/// NaviiGroup(
///   seeds: memberIds,
///   size: 36,
///   overlap: 10,
///   maxVisible: 3,
/// )
/// ```
class NaviiGroup extends StatelessWidget {
  /// Seeds for each avatar, in left-to-right order.
  final List<String> seeds;

  /// Width and height of each avatar in logical pixels. Defaults to 36.
  final double size;

  /// How many logical pixels each avatar overlaps the previous one.
  /// Defaults to 10.
  final double overlap;

  /// Maximum number of avatars to render before showing a count badge.
  /// Set to -1 (default) to show all.
  final int maxVisible;

  /// Clip shape forwarded to each [Navii] in the group.
  final NaviiShape shape;

  /// Border color drawn around each avatar. Separates overlapping avatars
  /// visually. Defaults to [Colors.white].
  final Color borderColor;

  /// Width of the separator border in logical pixels. Defaults to 1.5.
  final double borderWidth;

  const NaviiGroup({
    super.key,
    required this.seeds,
    this.size = 36,
    this.overlap = 10,
    this.maxVisible = -1,
    this.shape = NaviiShape.circle,
    this.borderColor = Colors.white,
    this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    if (seeds.isEmpty) return const SizedBox.shrink();

    final visible =
        maxVisible > 0 ? seeds.take(maxVisible).toList() : seeds;
    final overflowCount = seeds.length - visible.length;

    final step = size - overlap;
    final totalWidth = size + (visible.length - 1) * step +
        (overflowCount > 0 ? step : 0);

    return SizedBox(
      width: totalWidth + borderWidth * 2,
      height: size + borderWidth * 2,
      child: Stack(
        children: [
          for (int i = 0; i < visible.length; i++)
            Positioned(
              left: i * step,
              top: 0,
              child: Navii(
                seed: visible[i],
                size: size,
                shape: shape,
                borderColor: borderColor,
                borderWidth: borderWidth,
              ),
            ),
          if (overflowCount > 0)
            Positioned(
              left: visible.length * step,
              top: 0,
              child: _OverflowBadge(
                count: overflowCount,
                size: size,
                shape: shape,
                borderColor: borderColor,
                borderWidth: borderWidth,
              ),
            ),
        ],
      ),
    );
  }
}

class _OverflowBadge extends StatelessWidget {
  final int count;
  final double size;
  final NaviiShape shape;
  final Color borderColor;
  final double borderWidth;

  const _OverflowBadge({
    required this.count,
    required this.size,
    required this.shape,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = theme.colorScheme.surfaceContainerHighest;
    final fg = theme.colorScheme.onSurfaceVariant;

    BoxDecoration decoration;
    switch (shape) {
      case NaviiShape.circle:
        decoration = BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: borderWidth),
        );
      case NaviiShape.rounded:
        decoration = BoxDecoration(
          color: bg,
          borderRadius:
              BorderRadius.circular(size * 0.2 + borderWidth),
          border: Border.all(color: borderColor, width: borderWidth),
        );
      case NaviiShape.square:
        decoration = BoxDecoration(
          color: bg,
          border: Border.all(color: borderColor, width: borderWidth),
        );
    }

    return Container(
      width: size + borderWidth * 2,
      height: size + borderWidth * 2,
      decoration: decoration,
      alignment: Alignment.center,
      child: Text(
        '+$count',
        style: TextStyle(
          fontSize: size * 0.28,
          fontWeight: FontWeight.bold,
          color: fg,
        ),
      ),
    );
  }
}
