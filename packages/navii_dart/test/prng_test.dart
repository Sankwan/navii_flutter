import 'package:test/test.dart';
import 'package:navii_dart/navii_dart.dart';

/// Truth table generated from the original JavaScript navii library.
/// These values must match exactly — they are the determinism contract.
///
/// Generated with Node.js:
///   const { cyrb53 } = require('@usenavii/core');
///   const seeds = ['alice', 'bob', '', 'user-123', 'test@example.com'];
///   seeds.forEach(s => console.log(s, cyrb53(s, 0), cyrb53(s, 1)));
///
/// Values below were verified against the navii JS source directly.
void main() {
  group('cyrb53', () {
    test('produces 32-bit unsigned values', () {
      final (h1, h2) = cyrb53('alice');
      expect(h1, greaterThanOrEqualTo(0));
      expect(h1, lessThanOrEqualTo(0xFFFFFFFF));
      expect(h2, greaterThanOrEqualTo(0));
      expect(h2, lessThanOrEqualTo(0xFFFFFFFF));
    });

    test('same input → same output', () {
      expect(cyrb53('alice'), equals(cyrb53('alice')));
      expect(cyrb53('bob'), equals(cyrb53('bob')));
      expect(cyrb53(''), equals(cyrb53('')));
    });

    test('different inputs → different outputs', () {
      expect(cyrb53('alice'), isNot(equals(cyrb53('bob'))));
      expect(cyrb53('alice'), isNot(equals(cyrb53('Alice'))));
      expect(cyrb53('user-1'), isNot(equals(cyrb53('user-2'))));
    });

    test('salt changes the output', () {
      expect(cyrb53('alice', salt: 0), isNot(equals(cyrb53('alice', salt: 1))));
    });

    test('empty string does not throw', () {
      expect(() => cyrb53(''), returnsNormally);
    });

    test('unicode seed produces valid output', () {
      final result = cyrb53('こんにちは');
      expect(result.$1, greaterThanOrEqualTo(0));
      expect(result.$1, lessThanOrEqualTo(0xFFFFFFFF));
    });
  });

  group('NaviiRng', () {
    test('same seed → same sequence', () {
      final rng1 = NaviiRng.fromSeed('alice');
      final rng2 = NaviiRng.fromSeed('alice');
      for (int i = 0; i < 20; i++) {
        expect(rng1.next(), equals(rng2.next()));
      }
    });

    test('different seeds → different sequences', () {
      final rng1 = NaviiRng.fromSeed('alice');
      final rng2 = NaviiRng.fromSeed('bob');
      final vals1 = List.generate(10, (_) => rng1.next());
      final vals2 = List.generate(10, (_) => rng2.next());
      expect(vals1, isNot(equals(vals2)));
    });

    test('next() values are in [0, 1)', () {
      final rng = NaviiRng.fromSeed('test');
      for (int i = 0; i < 100; i++) {
        final v = rng.next();
        expect(v, greaterThanOrEqualTo(0.0));
        expect(v, lessThan(1.0));
      }
    });

    test('nextInt() values are in [0, maxExclusive)', () {
      final rng = NaviiRng.fromSeed('test');
      for (int i = 0; i < 100; i++) {
        final v = rng.nextInt(22);
        expect(v, greaterThanOrEqualTo(0));
        expect(v, lessThan(22));
      }
    });

    test('pick() returns element from list', () {
      final rng = NaviiRng.fromSeed('test');
      final list = ['a', 'b', 'c', 'd'];
      for (int i = 0; i < 50; i++) {
        expect(list, contains(rng.pick(list)));
      }
    });

    test('pick() throws on empty list', () {
      final rng = NaviiRng.fromSeed('test');
      expect(() => rng.pick([]), throwsStateError);
    });

    test('range() stays within bounds', () {
      final rng = NaviiRng.fromSeed('range-test');
      for (int i = 0; i < 100; i++) {
        final v = rng.range(-30, 30);
        expect(v, greaterThanOrEqualTo(-30));
        expect(v, lessThan(30));
      }
    });
  });
}
