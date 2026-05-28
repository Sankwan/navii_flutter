import '../types.dart';

String renderBackground(BackgroundId id, Palette palette) {
  switch (id) {
    case BackgroundId.none:
      return '';
    case BackgroundId.solid:
      return '<rect x="0" y="0" width="100" height="100" fill="${palette.bodyFrom}" opacity="0.18" />';
    case BackgroundId.ring:
      return '<circle cx="50" cy="50" r="48" fill="${palette.bodyFrom}" opacity="0.14" />'
          '<circle cx="50" cy="50" r="46" fill="none" stroke="${palette.accent}" stroke-width="0.6" opacity="0.4" />';
  }
}
