import 'prng.dart';
import 'types.dart';
import 'parts/parts.dart';

/// Seed → AvatarSpec.
///
/// PRNG draws happen in a fixed order so adding new parts in future
/// releases never shifts existing seeds' selections.
AvatarSpec selectAvatar(String seed, [AvatarOptions? options]) {
  final opts = options ?? const AvatarOptions();
  final rng = NaviiRng.fromSeed(seed);

  // Palette: explicit object > id lookup > seed-random
  final Palette? paletteOverride = opts.palette ??
      (opts.paletteId != null ? kPaletteById[opts.paletteId] : null);
  final Palette palette =
      paletteOverride ?? rng.pick(List<Palette>.from(kPalettes));

  final body = rng.pick(List<BodyShapeId>.from(kBodyIds));
  final eyes = rng.pick(List<EyeStyleId>.from(kEyeIds));
  final mouth = rng.pick(List<MouthStyleId>.from(kMouthIds));
  final antenna = rng.pick(List<AntennaStyleId>.from(kAntennaIds));
  final accessory = rng.pick(List<AccessoryId>.from(kAccessoryIds));

  final BackgroundId background;
  if (opts.background != null) {
    background = opts.background!;
  } else {
    background = rng.pick(List<BackgroundId>.from(kBackgroundIds));
  }

  final topperRaw = rng.pick(List<TopperId>.from(kTopperIds));
  // Suppress topper when antenna already occupies the apex to avoid collision.
  final topper = (antenna != AntennaStyleId.none &&
          topperRaw != TopperId.none &&
          topperRaw != TopperId.leaf)
      ? TopperId.none
      : topperRaw;

  // Continuous tweaks — appended to the stream so existing seeds keep
  // the selections above unchanged if new tweaks are added later.
  final hueShift = rng.range(-30, 30).round();
  final bodyScale = double.parse(rng.range(0.92, 1.08).toStringAsFixed(3));
  final eyeGapShift = double.parse(rng.range(-2, 2).toStringAsFixed(2));
  final mouthCurveScale =
      double.parse(rng.range(0.85, 1.15).toStringAsFixed(3));
  final antennaTilt = rng.range(-8, 8).round();

  // Outfit: not drawn from base seed — plain chest by default.
  final outfit = rng.pick(List<OutfitId>.from(kOutfitIds));

  return AvatarSpec(
    seed: seed,
    palette: palette,
    body: body,
    eyes: eyes,
    mouth: mouth,
    antenna: antenna,
    accessory: accessory,
    background: background,
    topper: topper,
    outfit: outfit,
    hueShift: hueShift,
    bodyScale: bodyScale,
    eyeGapShift: eyeGapShift,
    mouthCurveScale: mouthCurveScale,
    antennaTilt: antennaTilt,
  );
}
