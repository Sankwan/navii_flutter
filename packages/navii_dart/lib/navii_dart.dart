/// Navii — deterministic mascot avatar generation for Dart.
///
/// Same seed → same SVG, every time, on every platform.
///
/// ```dart
/// final svg = createAvatar('user-123');
/// ```
library navii_dart;

export 'src/types.dart';
export 'src/select.dart' show selectAvatar;
export 'src/render.dart' show renderAvatar;
export 'src/prng.dart' show cyrb53, NaviiRng;

import 'src/select.dart';
import 'src/render.dart';
import 'src/types.dart';

/// Generate a deterministic SVG avatar string from [seed].
///
/// The same seed always produces byte-identical SVG output.
/// Pass a stable unique identifier — user ID, email, etc.
String createAvatar(String seed, [AvatarOptions? options]) {
  final spec = selectAvatar(seed, options);
  return renderAvatar(spec, options);
}
