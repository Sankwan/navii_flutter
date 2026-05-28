/// Navii Flutter — deterministic mascot avatar widget.
///
/// ```dart
/// Navii(seed: user.id)
/// Navii(seed: user.email, size: 64)
/// Navii(seed: user.id, shape: NaviiShape.rounded, statusColor: Colors.green)
/// NaviiGroup(seeds: memberIds, size: 36, maxVisible: 3)
/// ```
library navii_flutter;

export 'package:navii_dart/navii_dart.dart'
    show AvatarOptions, AvatarSpec, BackgroundId, Palette;

export 'src/navii_widget.dart';
export 'src/navii_picker.dart';
export 'src/navii_group.dart';
