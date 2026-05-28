import 'types.dart';
import 'parts/parts.dart';

/// AvatarSpec → SVG string.
///
/// Output is a self-contained <svg> element. Gradient ids are namespaced
/// with a hash of the seed so multiple avatars can coexist on one page.
String renderAvatar(AvatarSpec spec, [AvatarOptions? options]) {
  final opts = options ?? const AvatarOptions();
  final size = opts.size ?? 96.0;
  final id = _stableId(spec.seed);
  final gradId = 'navii-grad-$id';
  final hueId = 'navii-hue-$id';

  final baseAnchor = kAnchors[spec.body]!;
  final anchor = FaceAnchor(
    cx: baseAnchor.cx,
    eyeY: baseAnchor.eyeY,
    eyeOffset: baseAnchor.eyeOffset + spec.eyeGapShift,
    eyeScale: baseAnchor.eyeScale,
    mouthY: baseAnchor.mouthY,
    mouthSpan: baseAnchor.mouthSpan,
    topperX: baseAnchor.topperX,
    topperY: baseAnchor.topperY,
    groundY: baseAnchor.groundY,
    cheekY: baseAnchor.cheekY,
    cheekOffset: baseAnchor.cheekOffset,
  );

  final bodyMarkup = renderBody(spec.body, spec.palette, gradId);
  final bodyTransform = _transformBody(spec.bodyScale, anchor);
  final bodyFilter =
      spec.hueShift != 0 ? ' filter="url(#$hueId)"' : '';
  final bodyWrapped =
      '<g$bodyTransform$bodyFilter><g class="body">$bodyMarkup</g></g>';

  final antennaSvg = renderAntenna(spec.antenna, anchor, spec.palette);
  final antennaTransform = _transformAntenna(spec.antennaTilt, anchor);
  final antennaWrapped = antennaSvg.isNotEmpty
      ? '<g$antennaTransform><g class="antenna">$antennaSvg</g></g>'
      : '';

  final defs = renderBodyDefs(spec.body, spec.palette, gradId) +
      (spec.hueShift != 0
          ? '<filter id="$hueId" color-interpolation-filters="sRGB"><feColorMatrix type="hueRotate" values="${spec.hueShift}" /></filter>'
          : '');

  final eyesSvg = renderEyes(spec.eyes, spec.palette, anchor);
  final parts = '${renderBackground(spec.background, spec.palette)}'
      '$bodyWrapped'
      '${renderOutfit(spec.outfit, anchor, spec.palette)}'
      '${renderTopper(spec.topper, anchor, spec.palette)}'
      '<g class="eyes">$eyesSvg</g>'
      '${renderMouth(spec.mouth, spec.palette, anchor, spec.mouthCurveScale)}'
      '$antennaWrapped'
      '${renderAccessory(spec.accessory, spec.palette, anchor)}';

  return '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" '
      'width="$size" height="$size" aria-hidden="true">'
      '<defs>$defs</defs>'
      '$parts'
      '</svg>';
}

String _transformBody(double scale, FaceAnchor anchor) {
  if ((scale - 1).abs() < 0.001) return '';
  return ' transform="translate(${anchor.cx} ${anchor.groundY}) scale($scale) translate(${-anchor.cx} ${-anchor.groundY})"';
}

String _transformAntenna(int deg, FaceAnchor anchor) {
  if (deg == 0) return '';
  return ' transform="rotate($deg ${anchor.topperX} ${anchor.topperY + 2})"';
}

/// djb2-style hash → base36 id for stable gradient namespacing.
String _stableId(String seed) {
  int h = 5381;
  for (int i = 0; i < seed.length; i++) {
    h = (((h << 5) & 0xFFFFFFFF) + h + seed.codeUnitAt(i)) & 0xFFFFFFFF;
  }
  return (h & 0xFFFFFFFF).toRadixString(36);
}
