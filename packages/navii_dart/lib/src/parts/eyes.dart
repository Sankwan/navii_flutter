import '../types.dart';
import 'anchor.dart';

String renderEyes(EyeStyleId id, Palette palette, FaceAnchor anchor) {
  final lx = anchor.cx - anchor.eyeOffset;
  final rx = anchor.cx + anchor.eyeOffset;
  final y = anchor.eyeY;
  final s = anchor.eyeScale;
  final ink = palette.ink;

  switch (id) {
    case EyeStyleId.round:
      return _sclera(lx, y, 4 * s, 4.5 * s) +
          _sclera(rx, y, 4 * s, 4.5 * s) +
          _pupil(lx, y, 2.2 * s, ink) +
          _pupil(rx, y, 2.2 * s, ink) +
          _glint(lx + 1, y - 1) +
          _glint(rx + 1, y - 1);

    case EyeStyleId.wide:
      return _sclera(lx, y, 5 * s, 5.5 * s) +
          _sclera(rx, y, 5 * s, 5.5 * s) +
          _pupil(lx, y + 0.5, 3 * s, ink) +
          _pupil(rx, y + 0.5, 3 * s, ink) +
          _glint(lx + 1.2, y - 0.5) +
          _glint(rx + 1.2, y - 0.5);

    case EyeStyleId.squint:
      return _arc(lx - 4.5, y, lx, y - 3.5, lx + 4.5, y, ink, 1.8) +
          _arc(rx - 4.5, y, rx, y - 3.5, rx + 4.5, y, ink, 1.8);

    case EyeStyleId.wink:
      return _sclera(lx, y, 4 * s, 4.5 * s) +
          _pupil(lx, y, 2.2 * s, ink) +
          _glint(lx + 1, y - 1) +
          _arc(rx - 4, y, rx, y - 3.5, rx + 4, y, ink, 1.8);

    case EyeStyleId.sleepy:
      return '<path d="M${lx - 4} ${y - 0.5} Q$lx ${y + 2} ${lx + 4} ${y - 0.5}" stroke="$ink" stroke-width="1.7" stroke-linecap="round" fill="none" />'
          '<path d="M${rx - 4} ${y - 0.5} Q$rx ${y + 2} ${rx + 4} ${y - 0.5}" stroke="$ink" stroke-width="1.7" stroke-linecap="round" fill="none" />'
          '<circle cx="$lx" cy="${y + 0.5}" r="0.9" fill="$ink" />'
          '<circle cx="$rx" cy="${y + 0.5}" r="0.9" fill="$ink" />';

    case EyeStyleId.star:
      return _starEye(lx, y, ink) + _starEye(rx, y, ink);

    case EyeStyleId.heart:
      return _heartEye(lx, y, ink) + _heartEye(rx, y, ink);

    case EyeStyleId.oval:
      return '${_sclera(lx, y, 4.5 * s, 5 * s)}'
          '${_sclera(rx, y, 4.5 * s, 5 * s)}'
          '<ellipse cx="$lx" cy="$y" rx="${1.6 * s}" ry="${3 * s}" fill="$ink" />'
          '<ellipse cx="$rx" cy="$y" rx="${1.6 * s}" ry="${3 * s}" fill="$ink" />'
          '${_glint(lx + 0.8, y - 1.5)}'
          '${_glint(rx + 0.8, y - 1.5)}';

    case EyeStyleId.dot:
      return '<circle cx="$lx" cy="$y" r="${1.4 * s}" fill="$ink" />'
          '<circle cx="$rx" cy="$y" r="${1.4 * s}" fill="$ink" />';

    case EyeStyleId.cross:
      return _crossEye(lx, y, ink) + _crossEye(rx, y, ink);
  }
}

String _sclera(double cx, double cy, double rx, double ry) =>
    '<ellipse cx="$cx" cy="$cy" rx="$rx" ry="$ry" fill="#FFFFFF" />';

String _pupil(double cx, double cy, double r, String color) =>
    '<circle cx="$cx" cy="$cy" r="$r" fill="$color" />';

String _glint(double cx, double cy) =>
    '<circle cx="$cx" cy="$cy" r="0.8" fill="#FFFFFF" />';

String _arc(double x1, double y1, double cx, double cy, double x2, double y2,
        String stroke, double width) =>
    '<path d="M$x1 $y1 Q$cx $cy $x2 $y2" stroke="$stroke" stroke-width="$width" stroke-linecap="round" fill="none" />';

String _starEye(double cx, double cy, String color) {
  const s = 3.0;
  return '<path d="M$cx ${cy - s} L${cx + s * 0.35} ${cy - s * 0.35} L${cx + s} $cy L${cx + s * 0.35} ${cy + s * 0.35} L$cx ${cy + s} L${cx - s * 0.35} ${cy + s * 0.35} L${cx - s} $cy L${cx - s * 0.35} ${cy - s * 0.35} Z" fill="$color" />';
}

String _heartEye(double cx, double cy, String color) {
  const s = 2.0;
  return '<path d="M$cx ${cy + s * 1.4} L${cx - s * 1.8} ${cy - s * 0.2} A$s $s 0 0 1 $cx ${cy - s * 0.6} A$s $s 0 0 1 ${cx + s * 1.8} ${cy - s * 0.2} Z" fill="$color" />';
}

String _crossEye(double cx, double cy, String color) {
  const s = 2.4;
  return '<g stroke="$color" stroke-width="1.6" stroke-linecap="round">'
      '<line x1="${cx - s}" y1="${cy - s}" x2="${cx + s}" y2="${cy + s}" />'
      '<line x1="${cx - s}" y1="${cy + s}" x2="${cx + s}" y2="${cy - s}" />'
      '</g>';
}
