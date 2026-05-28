/// Deterministic PRNG: cyrb53 hash + sfc32 generator.
///
/// Identical seed → identical float stream on all platforms.
/// Ported from the original navii JavaScript implementation.
library;

/// cyrb53 hash — returns two 32-bit unsigned values.
/// Output must match the JS reference for identical inputs.
(int, int) cyrb53(String input, {int salt = 0}) {
  int h1 = (0xdeadbeef ^ salt) & 0xFFFFFFFF;
  int h2 = (0x41c6ce57 ^ salt) & 0xFFFFFFFF;

  for (int i = 0; i < input.length; i++) {
    final ch = input.codeUnitAt(i);
    h1 = _imul(h1 ^ ch, 2654435761);
    h2 = _imul(h2 ^ ch, 1597334677);
  }

  h1 = _imul(h1 ^ (h1 >>> 16), 2246822507);
  h1 = (h1 ^ _imul(h2 ^ (h2 >>> 13), 3266489909)) & 0xFFFFFFFF;
  h2 = _imul(h2 ^ (h2 >>> 16), 2246822507);
  h2 = (h2 ^ _imul(h1 ^ (h1 >>> 13), 3266489909)) & 0xFFFFFFFF;

  return (h1, h2);
}

/// 32-bit integer multiply — matches JavaScript's Math.imul.
/// Uses 16-bit split to stay within 53-bit safe integer range on web.
int _imul(int a, int b) {
  a &= 0xFFFFFFFF;
  b &= 0xFFFFFFFF;
  final al = a & 0xFFFF;
  final ah = a >>> 16;
  return ((al * b) + (((ah * (b & 0xFFFF)) << 16) & 0xFFFFFFFF)) & 0xFFFFFFFF;
}

/// Seeded PRNG based on sfc32. Produces uniform floats in [0, 1).
class NaviiRng {
  int _s0, _s1, _s2, _s3;

  NaviiRng._(this._s0, this._s1, this._s2, this._s3);

  factory NaviiRng.fromSeed(String seed) {
    final (a, b) = cyrb53(seed, salt: 0);
    final (c, d) = cyrb53(seed, salt: 1);
    return NaviiRng._(a, b, c, d);
  }

  double next() {
    final int t = ((((_s0 + _s1) & 0xFFFFFFFF) + _s3) & 0xFFFFFFFF);
    _s3 = (_s3 + 1) & 0xFFFFFFFF;
    _s0 = (_s1 ^ (_s1 >>> 9)) & 0xFFFFFFFF;
    _s1 = (_s2 + ((_s2 << 3) & 0xFFFFFFFF)) & 0xFFFFFFFF;
    _s2 = (((_s2 << 21) & 0xFFFFFFFF) | (_s2 >>> 11)) & 0xFFFFFFFF;
    _s2 = (_s2 + t) & 0xFFFFFFFF;
    return t / 4294967296.0;
  }

  int nextInt(int maxExclusive) => (next() * maxExclusive).floor();

  T pick<T>(List<T> arr) {
    if (arr.isEmpty) throw StateError('cannot pick from empty list');
    return arr[(next() * arr.length).floor()];
  }

  double range(double min, double max) => min + next() * (max - min);
}
