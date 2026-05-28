import '../types.dart';
import 'anchor.dart';

String renderTopper(TopperId id, FaceAnchor anchor, Palette palette) {
  if (id == TopperId.none) return '';

  final cx = anchor.topperX;
  final topY = anchor.topperY;
  final ink = palette.ink;

  switch (id) {
    case TopperId.none:
      return '';

    case TopperId.ears:
      return '<path d="M${cx - 16} ${topY + 6} L${cx - 11} ${topY - 5} L${cx - 6} ${topY + 8} Z" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.6" opacity="0.95" />'
          '<path d="M${cx + 6} ${topY + 8} L${cx + 11} ${topY - 5} L${cx + 16} ${topY + 6} Z" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.6" opacity="0.95" />'
          '<path d="M${cx - 14} ${topY + 4} L${cx - 11} ${topY - 1} L${cx - 8} ${topY + 5} Z" fill="${palette.blush}" opacity="0.65" />'
          '<path d="M${cx + 8} ${topY + 5} L${cx + 11} ${topY - 1} L${cx + 14} ${topY + 4} Z" fill="${palette.blush}" opacity="0.65" />';

    case TopperId.roundEars:
      return '<circle cx="${cx - 13}" cy="${topY + 2}" r="6" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.6" />'
          '<circle cx="${cx + 13}" cy="${topY + 2}" r="6" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.6" />'
          '<circle cx="${cx - 13}" cy="${topY + 2}" r="3" fill="${palette.blush}" opacity="0.6" />'
          '<circle cx="${cx + 13}" cy="${topY + 2}" r="3" fill="${palette.blush}" opacity="0.6" />';

    case TopperId.horn:
      return '<path d="M${cx - 1} ${topY + 2} Q$cx ${topY - 6} ${cx + 4} ${topY - 10} Q${cx + 6} ${topY - 4} ${cx + 3} ${topY + 2} Z" fill="${palette.accent}" stroke="$ink" stroke-width="0.6" />';

    case TopperId.horns:
      return '<path d="M${cx - 7} ${topY + 4} Q${cx - 8} ${topY - 4} ${cx - 4} ${topY - 7} Q${cx - 2} ${topY - 1} ${cx - 3} ${topY + 4} Z" fill="${palette.accent}" stroke="$ink" stroke-width="0.6" />'
          '<path d="M${cx + 3} ${topY + 4} Q${cx + 2} ${topY - 1} ${cx + 4} ${topY - 7} Q${cx + 8} ${topY - 4} ${cx + 7} ${topY + 4} Z" fill="${palette.accent}" stroke="$ink" stroke-width="0.6" />';

    case TopperId.tuft:
      return '<path d="M$cx ${topY + 2} Q${cx - 2} ${topY - 4} ${cx + 1} ${topY - 8} Q${cx + 6} ${topY - 5} ${cx + 4} ${topY + 1} Z" fill="$ink" opacity="0.85" />';

    case TopperId.cap:
      return '<path d="M${cx - 16} ${topY + 6} Q${cx - 16} ${topY - 8} $cx ${topY - 8} Q${cx + 16} ${topY - 8} ${cx + 16} ${topY + 6} Z" fill="${palette.ink}" opacity="0.92" />'
          '<rect x="${cx - 16}" y="${topY + 5}" width="32" height="2.5" rx="1" fill="${palette.accent}" opacity="0.85" />'
          '<circle cx="$cx" cy="${topY - 9}" r="2.2" fill="${palette.accent}" stroke="$ink" stroke-width="0.5" />';

    case TopperId.leaf:
      return '<path d="M${cx - 1} ${topY + 2} Q${cx - 6} ${topY - 4} ${cx - 1} ${topY - 8} Q${cx + 3} ${topY - 4} ${cx - 1} ${topY + 2} Z" fill="#22C55E" stroke="$ink" stroke-width="0.4" opacity="0.95" />'
          '<path d="M${cx + 1} ${topY + 2} Q${cx + 5} ${topY - 2} ${cx + 6} ${topY - 6}" stroke="#16A34A" stroke-width="1" fill="none" stroke-linecap="round" />';

    case TopperId.headband:
      return '<path d="M${cx - 18} ${topY + 8} Q$cx ${topY + 2} ${cx + 18} ${topY + 8} L${cx + 18} ${topY + 12} Q$cx ${topY + 6} ${cx - 18} ${topY + 12} Z" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.6" />'
          '<rect x="${cx - 2}" y="${topY + 4}" width="4" height="4" rx="1" fill="${palette.accent}" stroke="$ink" stroke-width="0.4" />';

    case TopperId.halo:
      return '<ellipse cx="$cx" cy="${topY - 6}" rx="11" ry="2.5" fill="none" stroke="#FACC15" stroke-width="2" opacity="0.95" />'
          '<ellipse cx="$cx" cy="${topY - 6}" rx="8.5" ry="1.6" fill="none" stroke="#FDE68A" stroke-width="0.6" opacity="0.7" />';

    case TopperId.crown:
      return '<path d="M${cx - 11} ${topY + 4} L${cx - 11} ${topY - 4} L${cx - 6} ${topY + 1} L$cx ${topY - 7} L${cx + 6} ${topY + 1} L${cx + 11} ${topY - 4} L${cx + 11} ${topY + 4} Z" fill="#FACC15" stroke="$ink" stroke-width="0.7" />'
          '<circle cx="${cx - 11}" cy="${topY - 4}" r="1.4" fill="#EF4444" stroke="$ink" stroke-width="0.3" />'
          '<circle cx="$cx" cy="${topY - 7}" r="1.6" fill="#EF4444" stroke="$ink" stroke-width="0.3" />'
          '<circle cx="${cx + 11}" cy="${topY - 4}" r="1.4" fill="#EF4444" stroke="$ink" stroke-width="0.3" />';

    case TopperId.antlers:
      return '<path d="M${cx - 5} ${topY + 4} L${cx - 6} ${topY - 4} M${cx - 6} ${topY - 4} L${cx - 10} ${topY - 6} M${cx - 6} ${topY - 4} L${cx - 6} ${topY - 9} M${cx - 6} ${topY - 9} L${cx - 8} ${topY - 11} M${cx - 6} ${topY - 9} L${cx - 3} ${topY - 11}" stroke="$ink" stroke-width="1.3" stroke-linecap="round" fill="none" />'
          '<path d="M${cx + 5} ${topY + 4} L${cx + 6} ${topY - 4} M${cx + 6} ${topY - 4} L${cx + 10} ${topY - 6} M${cx + 6} ${topY - 4} L${cx + 6} ${topY - 9} M${cx + 6} ${topY - 9} L${cx + 8} ${topY - 11} M${cx + 6} ${topY - 9} L${cx + 3} ${topY - 11}" stroke="$ink" stroke-width="1.3" stroke-linecap="round" fill="none" />';

    case TopperId.bob:
      final eyeY = anchor.eyeY;
      final tt = topY - 4;
      final bt = eyeY + 6;
      return '<path d="M${cx - 24} $bt Q${cx - 26} ${eyeY - 4} ${cx - 22} ${tt + 4} Q${cx - 14} ${tt - 2} $cx ${tt - 3} Q${cx + 14} ${tt - 2} ${cx + 22} ${tt + 4} Q${cx + 26} ${eyeY - 4} ${cx + 24} $bt Q${cx + 18} ${eyeY + 2} ${cx + 14} ${eyeY - 2} Q$cx ${eyeY - 8} ${cx - 14} ${eyeY - 2} Q${cx - 18} ${eyeY + 2} ${cx - 24} $bt Z" fill="$ink" opacity="0.92" />'
          '<path d="M${cx - 14} ${tt + 4} Q${cx - 6} ${tt + 2} ${cx + 2} ${tt + 6}" stroke="${palette.accent}" stroke-width="0.6" fill="none" opacity="0.25" />';

    case TopperId.bun:
      final baseY = topY + 4;
      final bunY = topY - 8;
      return '<path d="M${cx - 16} $baseY Q$cx ${topY - 4} ${cx + 16} $baseY Q${cx + 12} ${baseY - 4} $cx ${baseY - 6} Q${cx - 12} ${baseY - 4} ${cx - 16} $baseY Z" fill="$ink" opacity="0.92" />'
          '<ellipse cx="$cx" cy="$bunY" rx="6" ry="5" fill="$ink" opacity="0.95" />'
          '<ellipse cx="$cx" cy="${bunY - 0.5}" rx="3.5" ry="2.5" fill="none" stroke="${palette.accent}" stroke-width="0.4" opacity="0.4" />';

    case TopperId.ponytail:
      final eyeY2 = anchor.eyeY;
      final fh = eyeY2 - 7;
      final crownY = topY;
      final baseX = cx + 18;
      final baseY2 = crownY + 6;
      return '<path d="M${cx - 22} $fh Q${cx - 24} ${crownY - 2} ${cx - 12} ${crownY - 4} L${cx + 14} ${crownY - 4} Q${cx + 24} $crownY ${cx + 22} $fh Q${cx + 10} ${fh - 1} $cx ${fh + 2} Q${cx - 10} ${fh - 1} ${cx - 22} $fh Z" fill="$ink" opacity="0.94" />'
          '<ellipse cx="$baseX" cy="$baseY2" rx="3" ry="2.4" fill="$ink" opacity="0.95" />'
          '<path d="M${baseX - 1} ${baseY2 + 2} Q${baseX + 5} ${baseY2 + 10} ${baseX + 8} ${baseY2 + 20} Q${baseX + 9} ${baseY2 + 28} ${baseX + 4} ${baseY2 + 30} Q${baseX + 1} ${baseY2 + 22} ${baseX - 3} ${baseY2 + 12} Z" fill="$ink" opacity="0.92" />';
  }
}
