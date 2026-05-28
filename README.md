# navii — deterministic mascot avatars for Dart & Flutter

[![CI](https://github.com/Sankwan/navii_flutter/actions/workflows/ci.yml/badge.svg)](https://github.com/Sankwan/navii_flutter/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

A Dart/Flutter port of [navii](https://github.com/uxderrick/navii) by uxderrick.
Feed any string into the engine and always get the same unique mascot back — no server, no database, no blank circles.

---

## Packages

| Package | pub.dev | Description |
|---|---|---|
| [`navii_dart`](packages/navii_dart) | [![pub](https://img.shields.io/pub/v/navii_dart.svg)](https://pub.dev/packages/navii_dart) | Pure-Dart SVG generator — zero dependencies |
| [`navii_flutter`](packages/navii_flutter) | [![pub](https://img.shields.io/pub/v/navii_flutter.svg)](https://pub.dev/packages/navii_flutter) | Flutter widget, picker, group, and status indicator |

---

## Quick look

```dart
// Dart (server, CLI, web)
import 'package:navii_dart/navii_dart.dart';
final svg = createAvatar('user-123');

// Flutter
import 'package:navii_flutter/navii_flutter.dart';
Navii(seed: user.id, size: 48)
Navii(seed: user.id, size: 48, statusColor: Colors.green, onTap: openProfile)
NaviiGroup(seeds: memberIds, size: 36, maxVisible: 4)
```

---

## Repository layout

```
packages/
  navii_dart/          Pure-Dart engine (zero deps)
  navii_flutter/       Flutter widgets
    example/           Full showcase app (5-tab demo)
.github/workflows/
  ci.yml               Analyze + test on every push / PR
  publish.yml          Auto-publish to pub.dev on git tag
```

---

## Contributing

Issues and PRs welcome at [github.com/Sankwan/navii_flutter](https://github.com/Sankwan/navii_flutter/issues).

## License

MIT — see [LICENSE](LICENSE).
Original navii artwork and algorithms © [uxderrick](https://github.com/uxderrick/navii).
