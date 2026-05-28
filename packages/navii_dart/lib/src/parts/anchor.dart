import '../types.dart';

/// Face anchor — where each feature attaches for a given body shape.
/// All coordinates are in the 100×100 viewBox.
class FaceAnchor {
  final double cx;
  final double eyeY;
  final double eyeOffset;
  final double eyeScale;
  final double mouthY;
  final double mouthSpan;
  final double topperX;
  final double topperY;
  final double groundY;
  final double cheekY;
  final double cheekOffset;

  const FaceAnchor({
    required this.cx,
    required this.eyeY,
    required this.eyeOffset,
    required this.eyeScale,
    required this.mouthY,
    required this.mouthSpan,
    required this.topperX,
    required this.topperY,
    required this.groundY,
    required this.cheekY,
    required this.cheekOffset,
  });
}

const Map<BodyShapeId, FaceAnchor> kAnchors = {
  BodyShapeId.orb: FaceAnchor(cx: 50, eyeY: 52, eyeOffset: 10, eyeScale: 1.0, mouthY: 62, mouthSpan: 7, topperX: 50, topperY: 22, groundY: 86, cheekY: 58, cheekOffset: 18),
  BodyShapeId.tall: FaceAnchor(cx: 50, eyeY: 49, eyeOffset: 8, eyeScale: 1.05, mouthY: 60, mouthSpan: 6, topperX: 50, topperY: 18, groundY: 91, cheekY: 55, cheekOffset: 14),
  BodyShapeId.squat: FaceAnchor(cx: 50, eyeY: 56, eyeOffset: 11, eyeScale: 0.95, mouthY: 66, mouthSpan: 8, topperX: 50, topperY: 30, groundY: 86, cheekY: 62, cheekOffset: 20),
  BodyShapeId.pear: FaceAnchor(cx: 50, eyeY: 51, eyeOffset: 9, eyeScale: 1.0, mouthY: 60, mouthSpan: 6.5, topperX: 50, topperY: 24, groundY: 90, cheekY: 57, cheekOffset: 15),
  BodyShapeId.pebble: FaceAnchor(cx: 50, eyeY: 54, eyeOffset: 10.5, eyeScale: 1.0, mouthY: 63, mouthSpan: 7.5, topperX: 53, topperY: 23, groundY: 85, cheekY: 59, cheekOffset: 19),
  BodyShapeId.dumpling: FaceAnchor(cx: 50, eyeY: 58, eyeOffset: 11, eyeScale: 0.98, mouthY: 68, mouthSpan: 8, topperX: 50, topperY: 32, groundY: 88, cheekY: 64, cheekOffset: 21),
  BodyShapeId.taro: FaceAnchor(cx: 50, eyeY: 50, eyeOffset: 9, eyeScale: 1.02, mouthY: 60, mouthSpan: 6.5, topperX: 50, topperY: 14, groundY: 91, cheekY: 55, cheekOffset: 14),
  BodyShapeId.wisp: FaceAnchor(cx: 50, eyeY: 47, eyeOffset: 7.5, eyeScale: 1.08, mouthY: 58, mouthSpan: 5.5, topperX: 50, topperY: 12, groundY: 94, cheekY: 53, cheekOffset: 12),
};
