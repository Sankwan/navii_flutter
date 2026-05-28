import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navii_dart/navii_dart.dart';

/// Clip shape applied to the avatar.
enum NaviiShape {
  /// Circular clip (default). Matches the avatar's own circular background.
  circle,

  /// No clip — full square bounding box.
  square,

  /// Rounded-rectangle clip (corner radius = 20 % of [Navii.size]).
  rounded,
}

/// A deterministic mascot avatar widget.
///
/// Produces the same mascot every time for the same [seed].
/// Pass a stable unique identifier — user ID, email, UUID, etc.
///
/// ```dart
/// // Basic
/// Navii(seed: user.id)
///
/// // With size and shape
/// Navii(seed: user.id, size: 64, shape: NaviiShape.rounded)
///
/// // With online indicator
/// Navii(seed: user.id, size: 48, statusColor: Colors.green)
///
/// // Tappable with border ring
/// Navii(
///   seed: user.id,
///   size: 48,
///   borderColor: Colors.indigo,
///   onTap: () => openProfile(user),
/// )
/// ```
class Navii extends StatelessWidget {
  /// Stable unique identifier that determines the avatar.
  ///
  /// Must not change for the same user — if it changes, the avatar changes.
  /// Recommended: database user ID, UUID, or email address.
  final String seed;

  /// Width and height of the rendered avatar in logical pixels.
  final double size;

  /// Optional configuration to override palette or background.
  final AvatarOptions? options;

  /// Clip shape. Defaults to [NaviiShape.circle].
  final NaviiShape shape;

  /// Called when the avatar is tapped.
  final VoidCallback? onTap;

  /// Color of the border ring drawn around the avatar.
  /// No border is shown when null (default).
  final Color? borderColor;

  /// Width of the border ring in logical pixels. Defaults to 2.0.
  final double borderWidth;

  /// Color of the status dot (e.g. online indicator). No dot when null.
  final Color? statusColor;

  /// Diameter of the status dot in logical pixels. Defaults to 10.0.
  final double statusSize;

  /// Corner where the status dot is anchored. Defaults to [Alignment.bottomRight].
  final Alignment statusAlignment;

  const Navii({
    super.key,
    required this.seed,
    this.size = 48.0,
    this.options,
    this.shape = NaviiShape.circle,
    this.onTap,
    this.borderColor,
    this.borderWidth = 2.0,
    this.statusColor,
    this.statusSize = 10.0,
    this.statusAlignment = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    final opts = AvatarOptions(
      size: size,
      background: options?.background,
      paletteId: options?.paletteId,
      palette: options?.palette,
    );
    final svg = createAvatar(seed, opts);

    Widget avatar = SvgPicture.string(
      svg,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );

    // Shape clipping
    avatar = switch (shape) {
      NaviiShape.circle => ClipOval(child: avatar),
      NaviiShape.rounded => ClipRRect(
          borderRadius: BorderRadius.circular(size * 0.2),
          child: avatar,
        ),
      NaviiShape.square => avatar,
    };

    // Border ring
    if (borderColor != null) {
      avatar = Container(
        width: size + borderWidth * 2,
        height: size + borderWidth * 2,
        decoration: switch (shape) {
          NaviiShape.circle => BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: borderColor!, width: borderWidth),
            ),
          NaviiShape.rounded => BoxDecoration(
              borderRadius:
                  BorderRadius.circular(size * 0.2 + borderWidth),
              border: Border.all(color: borderColor!, width: borderWidth),
            ),
          NaviiShape.square => BoxDecoration(
              border: Border.all(color: borderColor!, width: borderWidth),
            ),
        },
        padding: EdgeInsets.all(borderWidth),
        child: avatar,
      );
    }

    // Status dot
    if (statusColor != null) {
      final surface = Theme.of(context).colorScheme.surface;
      avatar = SizedBox(
        width: borderColor != null ? size + borderWidth * 2 : size,
        height: borderColor != null ? size + borderWidth * 2 : size,
        child: Stack(
          children: [
            avatar,
            Align(
              alignment: statusAlignment,
              child: Container(
                width: statusSize,
                height: statusSize,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: surface, width: 1.5),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Tap handler
    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }
}
