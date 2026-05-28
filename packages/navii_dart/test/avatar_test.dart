import 'package:test/test.dart';
import 'package:navii_dart/navii_dart.dart';

void main() {
  group('createAvatar — determinism contract', () {
    test('same seed → identical SVG', () {
      expect(createAvatar('alice'), equals(createAvatar('alice')));
      expect(createAvatar('user-123'), equals(createAvatar('user-123')));
      expect(createAvatar('test@example.com'),
          equals(createAvatar('test@example.com')));
    });

    test('different seeds → different SVGs', () {
      expect(createAvatar('alice'), isNot(equals(createAvatar('bob'))));
      expect(createAvatar('user-1'), isNot(equals(createAvatar('user-2'))));
    });

    test('produces valid SVG string', () {
      final svg = createAvatar('test-seed');
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
      expect(svg, contains('viewBox="0 0 100 100"'));
    });

    test('contains gradient defs', () {
      final svg = createAvatar('test-seed');
      expect(svg, contains('<defs>'));
      expect(svg, contains('radialGradient'));
    });

    test('respects size option', () {
      final svg = createAvatar('seed', AvatarOptions(size: 128));
      expect(svg, contains('width="128.0"'));
      expect(svg, contains('height="128.0"'));
    });

    test('respects paletteId option', () {
      final svgViolet =
          createAvatar('seed', AvatarOptions(paletteId: 'violet'));
      expect(svgViolet, contains('#C084FC')); // violet bodyFrom
    });

    test('empty string seed does not throw', () {
      expect(() => createAvatar(''), returnsNormally);
    });

    test('unicode seed does not throw', () {
      expect(() => createAvatar('こんにちは'), returnsNormally);
    });

    test('very long seed does not throw', () {
      final longSeed = 'a' * 10000;
      expect(() => createAvatar(longSeed), returnsNormally);
    });

    test('numeric string seed does not throw', () {
      expect(() => createAvatar('1234567890'), returnsNormally);
    });
  });

  group('selectAvatar', () {
    test('same seed → same spec fields', () {
      final s1 = selectAvatar('alice');
      final s2 = selectAvatar('alice');
      expect(s1.body, equals(s2.body));
      expect(s1.eyes, equals(s2.eyes));
      expect(s1.mouth, equals(s2.mouth));
      expect(s1.palette.id, equals(s2.palette.id));
      expect(s1.hueShift, equals(s2.hueShift));
      expect(s1.bodyScale, equals(s2.bodyScale));
    });

    test('spec seed field matches input', () {
      final spec = selectAvatar('my-user-id');
      expect(spec.seed, equals('my-user-id'));
    });

    test('background override is respected', () {
      final spec = selectAvatar('seed',
          AvatarOptions(background: BackgroundId.ring));
      expect(spec.background, equals(BackgroundId.ring));
    });
  });
}
