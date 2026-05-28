import '../types.dart';
import 'anchor.dart';

const Map<BodyShapeId, String> _kBodyPaths = {
  BodyShapeId.orb:
      'M50 20 C72 20 84 36 84 54 C84 73 70 86 50 86 C30 86 16 73 16 54 C16 36 28 20 50 20 Z',
  BodyShapeId.tall:
      'M50 15 C66 15 74 30 74 48 C74 70 66 91 50 91 C34 91 26 70 26 48 C26 30 34 15 50 15 Z',
  BodyShapeId.squat:
      'M50 28 C74 28 88 42 88 60 C88 78 74 86 50 86 C26 86 12 78 12 60 C12 42 26 28 50 28 Z',
  BodyShapeId.pear:
      'M50 18 C62 18 70 32 70 46 C70 56 80 66 80 76 C80 86 68 90 50 90 C32 90 20 86 20 76 C20 66 30 56 30 46 C30 32 38 18 50 18 Z',
  BodyShapeId.pebble:
      'M52 19 C72 21 86 36 84 56 C82 73 68 85 50 85 C30 85 16 72 16 54 C16 35 32 17 52 19 Z',
  BodyShapeId.dumpling:
      'M50 30 C62 30 70 38 70 48 C70 56 78 64 80 72 C82 82 70 88 50 88 C30 88 18 82 20 72 C22 64 30 56 30 48 C30 38 38 30 50 30 Z',
  BodyShapeId.taro:
      'M50 14 C58 14 64 22 64 30 C64 36 60 40 60 46 C60 54 76 60 78 76 C80 88 66 91 50 91 C34 91 20 88 22 76 C24 60 40 54 40 46 C40 40 36 36 36 30 C36 22 42 14 50 14 Z',
  BodyShapeId.wisp:
      'M50 12 C60 12 66 24 66 40 C66 60 74 78 70 90 C64 96 36 96 30 90 C26 78 34 60 34 40 C34 24 40 12 50 12 Z',
};

String renderBodyDefs(BodyShapeId id, Palette palette, String gradId) {
  return '<radialGradient id="$gradId" cx="42%" cy="32%" r="68%">'
      '<stop offset="0%" stop-color="${palette.bodyFrom}" />'
      '<stop offset="100%" stop-color="${palette.bodyTo}" />'
      '</radialGradient>';
}

String renderBody(BodyShapeId id, Palette palette, String gradId) {
  final d = _kBodyPaths[id]!;
  final a = kAnchors[id]!;
  final outlineColor = _withAlpha(palette.ink, 0.18);
  return '<ellipse cx="${a.cx}" cy="${a.groundY + 4}" rx="22" ry="2.6" fill="${palette.ink}" opacity="0.16" />'
      '<path d="$d" fill="url(#$gradId)" stroke="$outlineColor" stroke-width="0.7" />'
      '<ellipse cx="${a.cx - 12}" cy="${a.eyeY - 14}" rx="11" ry="7" fill="#FFFFFF" opacity="0.22" transform="rotate(-18 ${a.cx - 12} ${a.eyeY - 14})" />';
}

String _withAlpha(String hex, double alpha) {
  final h = hex.replaceFirst('#', '');
  final full = h.length == 3 ? h.split('').map((c) => c + c).join() : h;
  final r = int.parse(full.substring(0, 2), radix: 16);
  final g = int.parse(full.substring(2, 4), radix: 16);
  final b = int.parse(full.substring(4, 6), radix: 16);
  return 'rgba($r,$g,$b,$alpha)';
}
