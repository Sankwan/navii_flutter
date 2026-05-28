import '../types.dart';
import 'anchor.dart';

String renderAntenna(AntennaStyleId id, FaceAnchor anchor, Palette palette) {
  if (id == AntennaStyleId.none) return '';

  final cx = anchor.topperX;
  final topY = anchor.topperY;
  final color = palette.accent;
  final ink = palette.ink;

  switch (id) {
    case AntennaStyleId.none:
      return '';
    case AntennaStyleId.classic:
      return '<path d="M$cx $topY Q${cx + 1} ${topY - 5} ${cx + 2.5} ${topY - 9}" stroke="$ink" stroke-width="1.2" stroke-linecap="round" fill="none" opacity="0.55" />'
          '<circle cx="${cx + 2.5}" cy="${topY - 10}" r="2.6" fill="$color" stroke="$ink" stroke-width="0.6" opacity="0.95" />';

    case AntennaStyleId.curl:
      return '<path d="M$cx $topY Q${cx + 6} ${topY - 4} ${cx + 1} ${topY - 8} Q${cx - 4} ${topY - 11} ${cx + 1} ${topY - 14}" stroke="$ink" stroke-width="1.2" stroke-linecap="round" fill="none" opacity="0.55" />'
          '<circle cx="${cx + 1}" cy="${topY - 14}" r="2.2" fill="$color" stroke="$ink" stroke-width="0.6" opacity="0.95" />';

    case AntennaStyleId.double_:
      return '<path d="M${cx - 4} $topY Q${cx - 5} ${topY - 4} ${cx - 5.5} ${topY - 8}" stroke="$ink" stroke-width="1.1" stroke-linecap="round" fill="none" opacity="0.55" />'
          '<path d="M${cx + 4} $topY Q${cx + 5} ${topY - 4} ${cx + 5.5} ${topY - 8}" stroke="$ink" stroke-width="1.1" stroke-linecap="round" fill="none" opacity="0.55" />'
          '<circle cx="${cx - 5.5}" cy="${topY - 9}" r="2.1" fill="$color" stroke="$ink" stroke-width="0.5" opacity="0.95" />'
          '<circle cx="${cx + 5.5}" cy="${topY - 9}" r="2.1" fill="$color" stroke="$ink" stroke-width="0.5" opacity="0.95" />';

    case AntennaStyleId.spike:
      return '<path d="M${cx - 2.5} ${topY - 1} L${cx + 1} ${topY - 11} L${cx + 4.5} ${topY - 1} Z" fill="$color" stroke="$ink" stroke-width="0.6" opacity="0.95" />';
  }
}
