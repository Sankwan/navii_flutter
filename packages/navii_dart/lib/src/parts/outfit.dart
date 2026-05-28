import 'dart:math' as math;
import '../types.dart';
import 'anchor.dart';

String renderOutfit(OutfitId id, FaceAnchor anchor, Palette palette) {
  if (id == OutfitId.none) return '';

  final cx = anchor.cx;
  final cy = anchor.mouthY + (anchor.groundY - anchor.mouthY) * 0.55;
  final ink = palette.ink;
  final accent = palette.accent;

  switch (id) {
    case OutfitId.none:
      return '';

    case OutfitId.collar:
      return '<path d="M${cx - 9} $cy L${cx - 2} ${cy - 4} L${cx - 2} ${cy + 5} Z" fill="$accent" stroke="$ink" stroke-width="0.7" />'
          '<path d="M${cx + 9} $cy L${cx + 2} ${cy - 4} L${cx + 2} ${cy + 5} Z" fill="$accent" stroke="$ink" stroke-width="0.7" />'
          '<circle cx="$cx" cy="${cy + 4}" r="0.9" fill="$ink" />';

    case OutfitId.scarf:
      return '<path d="M${cx - 14} ${cy - 2} Q$cx ${cy + 3} ${cx + 14} ${cy - 2} L${cx + 14} ${cy + 3} Q$cx ${cy + 8} ${cx - 14} ${cy + 3} Z" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.6" />'
          '<path d="M${cx - 6} ${cy + 5} L${cx - 9} ${cy + 12} L${cx - 4} ${cy + 12} L${cx - 2} ${cy + 5} Z" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.5" />'
          '<path d="M${cx + 1} ${cy + 6} L${cx + 4} ${cy + 13} L${cx - 1} ${cy + 13} L${cx - 2} ${cy + 6} Z" fill="${palette.bodyFrom}" stroke="$ink" stroke-width="0.5" />';

    case OutfitId.bowtie:
      return '<path d="M${cx - 1} $cy L${cx - 9} ${cy - 4} L${cx - 9} ${cy + 4} Z" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.7" />'
          '<path d="M${cx + 1} $cy L${cx + 9} ${cy - 4} L${cx + 9} ${cy + 4} Z" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.7" />'
          '<rect x="${cx - 1.4}" y="${cy - 2.4}" width="2.8" height="4.8" rx="0.8" fill="${palette.bodyFrom}" stroke="$ink" stroke-width="0.5" />';

    case OutfitId.sunflower:
      final fx = cx - 8;
      final fy = cy + 2;
      final petals = StringBuffer();
      for (int i = 0; i < 8; i++) {
        final a = (i / 8) * math.pi * 2;
        final px = fx + math.cos(a) * 3.2;
        final py = fy + math.sin(a) * 3.2;
        final deg = (a * 180 / math.pi).toStringAsFixed(1);
        petals.write(
            '<ellipse cx="${px.toStringAsFixed(2)}" cy="${py.toStringAsFixed(2)}" rx="2.4" ry="1.3" fill="#FACC15" stroke="$ink" stroke-width="0.35" transform="rotate($deg ${px.toStringAsFixed(2)} ${py.toStringAsFixed(2)})" />');
      }
      return '<path d="M${fx + 2} ${fy + 2} Q${fx + 4} ${fy + 6} ${fx + 1} ${fy + 10}" stroke="#16A34A" stroke-width="1.1" fill="none" stroke-linecap="round" />'
          '<path d="M${fx + 3} ${fy + 6} Q${fx + 7} ${fy + 4} ${fx + 6} ${fy + 8} Q${fx + 4} ${fy + 8} ${fx + 3} ${fy + 6} Z" fill="#22C55E" stroke="$ink" stroke-width="0.35" />'
          '$petals'
          '<circle cx="$fx" cy="$fy" r="2" fill="#92400E" stroke="$ink" stroke-width="0.4" />'
          '<circle cx="${fx - 0.6}" cy="${fy - 0.5}" r="0.4" fill="#451A03" />'
          '<circle cx="${fx + 0.7}" cy="${fy + 0.3}" r="0.4" fill="#451A03" />'
          '<circle cx="${fx - 0.4}" cy="${fy + 0.8}" r="0.4" fill="#451A03" />';

    case OutfitId.necklace:
      return '<path d="M${cx - 10} $cy Q$cx ${cy + 8} ${cx + 10} $cy" stroke="$accent" stroke-width="0.8" fill="none" stroke-linecap="round" />'
          '<circle cx="$cx" cy="${cy + 7}" r="1.6" fill="$accent" stroke="$ink" stroke-width="0.5" />'
          '<circle cx="$cx" cy="${cy + 7}" r="0.7" fill="${palette.blush}" />';

    case OutfitId.tie:
      final knotTop = cy - 3;
      final knotBot = cy + 1;
      return '<path d="M${cx - 11} ${cy - 2} L${cx - 3} $knotBot L${cx + 3} $knotBot L${cx + 11} ${cy - 2} L${cx + 6} ${cy + 6} L${cx - 6} ${cy + 6} Z" fill="$accent" stroke="$ink" stroke-width="0.55" />'
          '<path d="M${cx - 3.2} $knotTop L${cx + 3.2} $knotTop L${cx + 2.4} $knotBot L${cx - 2.4} $knotBot Z" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.5" />'
          '<path d="M${cx - 2.4} $knotBot L${cx + 2.4} $knotBot L${cx + 3.4} ${cy + 6} L${cx + 2.8} ${cy + 12} L$cx ${cy + 15} L${cx - 2.8} ${cy + 12} L${cx - 3.4} ${cy + 6} Z" fill="${palette.bodyTo}" stroke="$ink" stroke-width="0.5" />'
          '<path d="M$cx ${knotBot + 0.5} L$cx ${cy + 13.5}" stroke="$ink" stroke-width="0.35" opacity="0.35" />';
  }
}
