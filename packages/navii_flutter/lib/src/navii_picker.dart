import 'package:flutter/material.dart';
import 'navii_widget.dart';

/// Generates [count] avatar variants from [baseSeed].
///
/// Each variant seed is stable: `"$baseSeed-navii-v$i"`.
/// Store the selected seed string in your database and render it
/// anytime with `Navii(seed: selectedSeed)`.
List<String> naviVariants(String baseSeed, {int count = 9}) =>
    List.generate(count, (i) => '$baseSeed-navii-v$i');

/// A grid picker that lets a user select from multiple avatar variants.
///
/// Variants are derived deterministically from [baseSeed], so the same
/// base seed always shows the same set of options.
///
/// ```dart
/// NaviiPicker(
///   baseSeed: user.id,
///   onSelected: (chosenSeed) {
///     // save chosenSeed to your database
///     // render anywhere: Navii(seed: chosenSeed)
///   },
/// )
/// ```
class NaviiPicker extends StatefulWidget {
  /// Base identifier used to generate all variants.
  final String baseSeed;

  /// Number of avatar options to show. Defaults to 9.
  final int count;

  /// Size of each avatar tile in logical pixels. Defaults to 64.
  final double avatarSize;

  /// Number of columns in the grid. Defaults to 3.
  final int crossAxisCount;

  /// Called when the user confirms a selection.
  /// Receives the full variant seed — store this in your database.
  final void Function(String selectedSeed)? onSelected;

  /// Pre-selected seed. Pass the user's existing seed to highlight it.
  final String? initialSeed;

  /// Label for the confirm button. Defaults to "Use this avatar".
  final String confirmLabel;

  const NaviiPicker({
    super.key,
    required this.baseSeed,
    this.count = 9,
    this.avatarSize = 64,
    this.crossAxisCount = 3,
    this.onSelected,
    this.initialSeed,
    this.confirmLabel = 'Use this avatar',
  });

  @override
  State<NaviiPicker> createState() => _NaviiPickerState();
}

class _NaviiPickerState extends State<NaviiPicker> {
  late String? _selected;
  late List<String> _seeds;

  @override
  void initState() {
    super.initState();
    _seeds = naviVariants(widget.baseSeed, count: widget.count);
    _selected = widget.initialSeed ??
        (_seeds.contains(widget.initialSeed) ? widget.initialSeed : null);
  }

  @override
  void didUpdateWidget(NaviiPicker old) {
    super.didUpdateWidget(old);
    if (old.baseSeed != widget.baseSeed || old.count != widget.count) {
      _seeds = naviVariants(widget.baseSeed, count: widget.count);
      _selected = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: _seeds.length,
          itemBuilder: (context, i) {
            final seed = _seeds[i];
            final isSelected = seed == _selected;
            return _AvatarTile(
              seed: seed,
              size: widget.avatarSize,
              isSelected: isSelected,
              selectionColor: colorScheme.primary,
              onTap: () => setState(() => _selected = seed),
            );
          },
        ),
        if (widget.onSelected != null) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _selected != null
                  ? () => widget.onSelected!(_selected!)
                  : null,
              child: Text(widget.confirmLabel),
            ),
          ),
        ],
      ],
    );
  }
}

class _AvatarTile extends StatelessWidget {
  final String seed;
  final double size;
  final bool isSelected;
  final Color selectionColor;
  final VoidCallback onTap;

  const _AvatarTile({
    required this.seed,
    required this.size,
    required this.isSelected,
    required this.selectionColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected
              ? selectionColor.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? selectionColor : Colors.transparent,
            width: 2.5,
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Navii(seed: seed, size: size),
              if (isSelected)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child:
                      Icon(Icons.check_circle, color: selectionColor, size: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A bottom sheet wrapper for [NaviiPicker].
///
/// ```dart
/// showNaviiPickerSheet(
///   context,
///   baseSeed: user.id,
///   onSelected: (seed) => setState(() => _profileSeed = seed),
/// );
/// ```
Future<String?> showNaviiPickerSheet(
  BuildContext context, {
  required String baseSeed,
  int count = 9,
  double avatarSize = 72,
  String? initialSeed,
  String title = 'Choose your avatar',
  String confirmLabel = 'Use this avatar',
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(ctx).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(title,
              style: Theme.of(ctx)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            'All options are unique to you. Pick one and it stays yours.',
            style:
                Theme.of(ctx).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          NaviiPicker(
            baseSeed: baseSeed,
            count: count,
            avatarSize: avatarSize,
            initialSeed: initialSeed,
            confirmLabel: confirmLabel,
            onSelected: (seed) => Navigator.of(ctx).pop(seed),
          ),
        ],
      ),
    ),
  );
}
