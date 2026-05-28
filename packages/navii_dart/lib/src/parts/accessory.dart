import '../types.dart';
import 'anchor.dart';

String renderAccessory(AccessoryId id, Palette palette, FaceAnchor anchor) {
  switch (id) {
    case AccessoryId.none:
      return '';

    case AccessoryId.blush:
      final lx = anchor.cx - anchor.cheekOffset;
      final rx = anchor.cx + anchor.cheekOffset;
      final y = anchor.cheekY;
      return '<ellipse cx="$lx" cy="$y" rx="3.6" ry="2.2" fill="${palette.blush}" opacity="0.5" />'
          '<ellipse cx="$rx" cy="$y" rx="3.6" ry="2.2" fill="${palette.blush}" opacity="0.5" />';

    case AccessoryId.freckles:
      final lx = anchor.cx - 8;
      final rx = anchor.cx + 8;
      final y = anchor.cheekY;
      return _dot(lx, y, palette.ink) +
          _dot(lx + 3, y + 1.5, palette.ink) +
          _dot(rx, y, palette.ink) +
          _dot(rx - 3, y + 1.5, palette.ink);

    case AccessoryId.sparkle:
      return _sparkle(76, anchor.eyeY - 18, 3, palette) +
          _sparkle(24, anchor.eyeY - 16, 2.5, palette) +
          _sparkle(82, anchor.cheekY + 2, 2, palette);

    case AccessoryId.glasses:
      final lx = anchor.cx - anchor.eyeOffset;
      final rx = anchor.cx + anchor.eyeOffset;
      final y = anchor.eyeY;
      const r = 6.0;
      return '<circle cx="$lx" cy="$y" r="$r" fill="none" stroke="${palette.ink}" stroke-width="1.2" />'
          '<circle cx="$rx" cy="$y" r="$r" fill="none" stroke="${palette.ink}" stroke-width="1.2" />'
          '<line x1="${lx + r}" y1="$y" x2="${rx - r}" y2="$y" stroke="${palette.ink}" stroke-width="1.2" />'
          '<circle cx="$lx" cy="$y" r="${r - 1}" fill="#FFFFFF" opacity="0.18" />'
          '<circle cx="$rx" cy="$y" r="${r - 1}" fill="#FFFFFF" opacity="0.18" />';

    case AccessoryId.eyepatch:
      final rx = anchor.cx + anchor.eyeOffset;
      final y = anchor.eyeY;
      return '<ellipse cx="$rx" cy="$y" rx="6" ry="5.2" fill="${palette.ink}" />'
          '<path d="M${rx - 6} ${y - 4} L${anchor.cx - 18} ${anchor.eyeY - 8}" stroke="${palette.ink}" stroke-width="0.9" />'
          '<path d="M${rx + 6} ${y - 3} L${anchor.cx + 22} ${anchor.eyeY - 6}" stroke="${palette.ink}" stroke-width="0.9" />';

    case AccessoryId.mole:
      return '<circle cx="${anchor.cx - anchor.cheekOffset * 0.6}" cy="${anchor.cheekY + 2}" r="0.9" fill="${palette.ink}" />';
  }
}

String _dot(double cx, double cy, String color) =>
    '<circle cx="$cx" cy="$cy" r="0.85" fill="$color" opacity="0.55" />';

String _sparkle(double cx, double cy, double s, Palette p) =>
    '<path d="M$cx ${cy - s} L${cx + s * 0.3} ${cy - s * 0.3} L${cx + s} $cy L${cx + s * 0.3} ${cy + s * 0.3} L$cx ${cy + s} L${cx - s * 0.3} ${cy + s * 0.3} L${cx - s} $cy L${cx - s * 0.3} ${cy - s * 0.3} Z" fill="${p.accent}" stroke="${p.ink}" stroke-width="0.3" opacity="0.9" />';
