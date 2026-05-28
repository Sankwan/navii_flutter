# navii_dart

[![pub package](https://img.shields.io/pub/v/navii_dart.svg)](https://pub.dev/packages/navii_dart)
[![CI](https://github.com/Sankwan/navii_flutter/actions/workflows/ci.yml/badge.svg)](https://github.com/Sankwan/navii_flutter/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

Pure-Dart deterministic mascot avatar generator. Feed it a string — any string — and get back a complete, self-contained SVG. Same string → identical SVG on every platform, every time, with no network, no database, no state.

> A Dart port of [navii](https://github.com/uxderrick/navii) by uxderrick.  
> For the Flutter widget, see [`navii_flutter`](https://pub.dev/packages/navii_flutter).

---

## Features

- 🎭 **22M+ unique avatars** — 22 palettes × 8 bodies × 10 eyes × 10 mouths × 5 antennae × 7 accessories × 3 backgrounds × 13 toppers
- 🔒 **Deterministic** — same seed always produces byte-identical SVG output
- 📴 **Fully offline** — no network calls, no external assets
- 🪶 **Zero dependencies** — pure Dart, no runtime packages
- 🌐 **All platforms** — native, web, server, Flutter

---

## Installation

```yaml
dependencies:
  navii_dart: ^0.1.0
```

---

## Quick start

```dart
import 'package:navii_dart/navii_dart.dart';

// Returns a complete, self-contained SVG string
final String svg = createAvatar('user-123');

// Same seed → identical output, every time
assert(createAvatar('alice') == createAvatar('alice'));

// Use it anywhere SVG strings are accepted
final String svgString = createAvatar('bob@example.com');
```

---

## Usage

### Basic avatar

```dart
final svg = createAvatar('alice');
// → '<svg xmlns="http://www.w3.org/2000/svg" ...>...</svg>'
```

### Force a specific palette

```dart
final svg = createAvatar('alice', AvatarOptions(paletteId: 'violet'));
```

Available palette IDs:
`indigo` `mint` `amber` `sky` `violet` `cyan` `rose` `lime`
`peach` `teal` `sand` `plum` `coral` `forest` `slate` `fuchsia`
`terracotta` `navy` `lavender` `charcoal` `butter` `aqua`

### Override the background shape

```dart
final svg = createAvatar('alice', AvatarOptions(background: BackgroundId.ring));
final svg = createAvatar('alice', AvatarOptions(background: BackgroundId.square));
final svg = createAvatar('alice', AvatarOptions(background: BackgroundId.circle));
```

### Custom size

```dart
final svg = createAvatar('alice', AvatarOptions(size: 128));
```

### Lower-level API

```dart
// Resolve the spec without rendering
final AvatarSpec spec = selectAvatar('alice');
print(spec.body);         // e.g. BodyShapeId.tall
print(spec.palette.id);   // e.g. 'violet'

// Render a pre-resolved spec
final String svg = renderAvatar(spec);
```

---

## Seed guidance

| Use as seed | Notes |
|---|---|
| Database user ID | ✅ Best — stable, unique |
| UUID | ✅ Great |
| Email address | ✅ Fine — changes if email changes |
| Display name | ⚠️ OK — changes if user renames |

If the seed changes, the avatar changes. Choose something stable.

---

## How it works

1. The seed string is hashed with **cyrb53** → two 32-bit integers
2. Those seed the **sfc32** PRNG
3. The PRNG picks one variant from each of 8 part categories, in order
4. The parts are composed into a single inline SVG string

The algorithm is a faithful port of the original JavaScript navii engine. Output is byte-identical across Dart native, web, and the original JS implementation.

---

## License

MIT — see [LICENSE](LICENSE).  
Original navii artwork and algorithms © [uxderrick](https://github.com/uxderrick/navii).
