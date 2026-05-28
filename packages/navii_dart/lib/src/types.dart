/// Public types for the Navii avatar engine.
library;

class Palette {
  final String id;
  final String bodyFrom;
  final String bodyTo;
  final String accent;
  final String ink;
  final String blush;

  const Palette({
    required this.id,
    required this.bodyFrom,
    required this.bodyTo,
    required this.accent,
    required this.ink,
    required this.blush,
  });
}

enum BodyShapeId {
  orb, tall, squat, pear, pebble, dumpling, taro, wisp,
}

enum EyeStyleId {
  round, wide, squint, wink, sleepy, star, heart, oval, dot, cross,
}

enum MouthStyleId {
  smile, grin, open, flat, smirk, awe, tongue, tooth, wave, dot,
}

enum AntennaStyleId { none, classic, curl, double_, spike }

enum AccessoryId { none, blush, freckles, sparkle, glasses, eyepatch, mole }

enum BackgroundId { none, solid, ring }

enum TopperId {
  none, ears, roundEars, horn, horns, tuft, cap, leaf,
  headband, halo, crown, antlers, bob, bun, ponytail,
}

enum OutfitId { none, collar, scarf, bowtie, sunflower, necklace, tie }

/// The fully resolved description of a single avatar.
class AvatarSpec {
  final String seed;
  final Palette palette;
  final BodyShapeId body;
  final EyeStyleId eyes;
  final MouthStyleId mouth;
  final AntennaStyleId antenna;
  final AccessoryId accessory;
  final BackgroundId background;
  final TopperId topper;
  final OutfitId outfit;
  final int hueShift;
  final double bodyScale;
  final double eyeGapShift;
  final double mouthCurveScale;
  final int antennaTilt;

  const AvatarSpec({
    required this.seed,
    required this.palette,
    required this.body,
    required this.eyes,
    required this.mouth,
    required this.antenna,
    required this.accessory,
    required this.background,
    required this.topper,
    required this.outfit,
    required this.hueShift,
    required this.bodyScale,
    required this.eyeGapShift,
    required this.mouthCurveScale,
    required this.antennaTilt,
  });
}

/// Options passed to [createAvatar].
class AvatarOptions {
  /// Output size in logical pixels. SVG viewBox is 100×100; this scales it.
  final double? size;

  /// Override the background instead of seed-picking it.
  final BackgroundId? background;

  /// Force a specific palette by id.
  final String? paletteId;

  /// Inject a fully custom palette object.
  final Palette? palette;

  const AvatarOptions({
    this.size,
    this.background,
    this.paletteId,
    this.palette,
  });
}
