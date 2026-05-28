export 'palette.dart';
export 'anchor.dart';
export 'body.dart';
export 'eyes.dart';
export 'mouth.dart';
export 'antenna.dart';
export 'accessory.dart';
export 'background.dart';
export 'topper.dart';
export 'outfit.dart';

import '../types.dart';

/// Base selection pools — duplicates are intentional to weight 'none' higher.
const List<BodyShapeId> kBodyIds = [
  BodyShapeId.orb, BodyShapeId.tall, BodyShapeId.squat, BodyShapeId.pear,
  BodyShapeId.pebble, BodyShapeId.dumpling, BodyShapeId.taro, BodyShapeId.wisp,
];

const List<EyeStyleId> kEyeIds = [
  EyeStyleId.round, EyeStyleId.wide, EyeStyleId.squint, EyeStyleId.wink,
  EyeStyleId.sleepy, EyeStyleId.star, EyeStyleId.heart, EyeStyleId.oval,
  EyeStyleId.dot, EyeStyleId.cross,
];

const List<MouthStyleId> kMouthIds = [
  MouthStyleId.smile, MouthStyleId.grin, MouthStyleId.open, MouthStyleId.flat,
  MouthStyleId.smirk, MouthStyleId.awe, MouthStyleId.tongue, MouthStyleId.tooth,
  MouthStyleId.wave, MouthStyleId.dot,
];

const List<AntennaStyleId> kAntennaIds = [
  AntennaStyleId.none, AntennaStyleId.classic, AntennaStyleId.curl,
  AntennaStyleId.double_, AntennaStyleId.spike,
];

const List<AccessoryId> kAccessoryIds = [
  AccessoryId.none, AccessoryId.blush, AccessoryId.freckles,
  AccessoryId.sparkle, AccessoryId.glasses, AccessoryId.eyepatch,
  AccessoryId.mole,
];

const List<BackgroundId> kBackgroundIds = [
  BackgroundId.none, BackgroundId.solid, BackgroundId.ring,
];

/// 'none' appears twice to reduce topper frequency (matches original).
const List<TopperId> kTopperIds = [
  TopperId.none, TopperId.none, TopperId.ears, TopperId.roundEars,
  TopperId.horn, TopperId.horns, TopperId.tuft, TopperId.cap,
  TopperId.leaf, TopperId.headband, TopperId.halo, TopperId.crown,
  TopperId.antlers,
];

/// 'none' appears three times — most avatars have plain chests.
const List<OutfitId> kOutfitIds = [
  OutfitId.none, OutfitId.none, OutfitId.none,
  OutfitId.collar, OutfitId.scarf, OutfitId.bowtie,
  OutfitId.sunflower, OutfitId.necklace, OutfitId.tie,
];
