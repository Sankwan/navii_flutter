import '../types.dart';
import 'anchor.dart';

String renderMouth(
    MouthStyleId id, Palette palette, FaceAnchor anchor, double curveScale) {
  final cx = anchor.cx;
  final y = anchor.mouthY;
  final w = anchor.mouthSpan * curveScale;
  final ink = palette.ink;

  switch (id) {
    case MouthStyleId.smile:
      return '<path d="M${cx - w} $y Q$cx ${y + 5} ${cx + w} $y" stroke="$ink" stroke-width="1.8" stroke-linecap="round" fill="none" />';

    case MouthStyleId.grin:
      return '<path d="M${cx - w - 1} ${y - 2} Q$cx ${y + 7} ${cx + w + 1} ${y - 2}" stroke="$ink" stroke-width="1.8" stroke-linecap="round" fill="none" />';

    case MouthStyleId.open:
      return '<path d="M${cx - w - 1} ${y - 2} Q$cx ${y + 9} ${cx + w + 1} ${y - 2}" stroke="$ink" stroke-width="1.8" stroke-linecap="round" fill="$ink" fill-opacity="0.55" />'
          '<ellipse cx="$cx" cy="${y + 3}" rx="${w * 0.55}" ry="1.8" fill="#F472B6" opacity="0.75" />';

    case MouthStyleId.flat:
      return '<path d="M${cx - w + 1} $y L${cx + w - 1} $y" stroke="$ink" stroke-width="1.8" stroke-linecap="round" fill="none" />';

    case MouthStyleId.smirk:
      return '<path d="M${cx - w} $y Q$cx ${y + 3} ${cx + w + 1} ${y - 2}" stroke="$ink" stroke-width="1.8" stroke-linecap="round" fill="none" />';

    case MouthStyleId.awe:
      return '<ellipse cx="$cx" cy="${y + 1}" rx="${w * 0.45}" ry="3.2" fill="$ink" opacity="0.85" />';

    case MouthStyleId.tongue:
      return '<path d="M${cx - w} $y Q$cx ${y + 6} ${cx + w} $y" stroke="$ink" stroke-width="1.8" stroke-linecap="round" fill="none" />'
          '<path d="M${cx - 2} ${y + 4} Q$cx ${y + 9} ${cx + 2} ${y + 4} Z" fill="#F472B6" stroke="$ink" stroke-width="0.6" />';

    case MouthStyleId.tooth:
      return '<path d="M${cx - w} $y Q$cx ${y + 5} ${cx + w} $y" stroke="$ink" stroke-width="1.8" stroke-linecap="round" fill="none" />'
          '<rect x="${cx - 1.2}" y="${y + 0.4}" width="2.4" height="2.6" rx="0.4" fill="#FFFFFF" stroke="$ink" stroke-width="0.4" />';

    case MouthStyleId.wave:
      return '<path d="M${cx - w} ${y + 1} Q${cx - w / 2} ${y - 1.5} $cx ${y + 1} Q${cx + w / 2} ${y + 3.5} ${cx + w} ${y + 1}" stroke="$ink" stroke-width="1.8" stroke-linecap="round" fill="none" />';

    case MouthStyleId.dot:
      return '<circle cx="$cx" cy="${y + 1}" r="1.2" fill="$ink" />';
  }
}
