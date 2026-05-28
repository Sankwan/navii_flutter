import 'package:navii_dart/navii_dart.dart';

void main() {
  // Generate a deterministic SVG avatar from a seed string.
  final svg = createAvatar('user-123');
  print('SVG length: ${svg.length} chars');
  print('Starts with: ${svg.substring(0, 40)}...');

  // Same seed always produces the same output.
  assert(createAvatar('alice') == createAvatar('alice'));
  print('Determinism confirmed.');

  // With options.
  final customSvg = createAvatar('alice', AvatarOptions(paletteId: 'violet'));
  print('Custom palette SVG length: ${customSvg.length}');
}
