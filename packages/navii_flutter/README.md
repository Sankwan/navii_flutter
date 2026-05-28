# navii_flutter

[![pub package](https://img.shields.io/pub/v/navii_flutter.svg)](https://pub.dev/packages/navii_flutter)
[![CI](https://github.com/Sankwan/navii_flutter/actions/workflows/ci.yml/badge.svg)](https://github.com/Sankwan/navii_flutter/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

Drop-in deterministic mascot avatar widget for Flutter. Same seed = same mascot, every time. No database, no uploads, no state required.

Mascots are abstract, friendly characters generated entirely on-device — similar in spirit to GitHub identicons or DiceBear, but with a consistent illustrated style across all users.

> A Flutter widget wrapping [`navii_dart`](https://pub.dev/packages/navii_dart),  
> a Dart port of [navii](https://github.com/uxderrick/navii) by uxderrick.

---

## Preview

<p>
  <img src="https://raw.githubusercontent.com/Sankwan/navii_flutter/main/packages/navii_flutter/screenshots/navii_demo.gif" width="32%" alt="Live demo" />
  <img src="https://raw.githubusercontent.com/Sankwan/navii_flutter/main/packages/navii_flutter/screenshots/chat.png" width="24%" alt="Chat list with avatars" />
  <img src="https://raw.githubusercontent.com/Sankwan/navii_flutter/main/packages/navii_flutter/screenshots/picker.png" width="24%" alt="Avatar picker" />
  <img src="https://raw.githubusercontent.com/Sankwan/navii_flutter/main/packages/navii_flutter/screenshots/customize.png" width="24%" alt="Shapes, status and groups" />
  <img src="https://raw.githubusercontent.com/Sankwan/navii_flutter/main/packages/navii_flutter/screenshots/customize_2.png" width="24%" alt="Sizes and palettes" />
</p>

---

## Features

- **22M+ unique mascots** — every user gets a distinct character
- **Deterministic** — same seed always produces the same avatar
- **Fully offline** — no network calls, no external assets, no CDN
- **Shape options** — circle, square, or rounded rectangle clip
- **Status indicator** — online/away/busy dot with position control
- **Border ring** — colored ring around the avatar
- **Tap callback** — `onTap` for navigation or selection
- **Group avatars** — stacked row with overflow count badge (`NaviiGroup`)
- **Picker widget** — grid picker + bottom sheet for user avatar selection

---

## Installation

```yaml
dependencies:
  navii_flutter: ^0.1.0
```

---

## Quick start

```dart
import 'package:navii_flutter/navii_flutter.dart';

// Basic 48×48 avatar
Navii(seed: user.id)

// With size and shape
Navii(seed: user.id, size: 64, shape: NaviiShape.rounded)

// With online indicator
Navii(seed: user.id, size: 48, statusColor: Colors.green)

// Tappable with border ring
Navii(
  seed: user.id,
  size: 48,
  borderColor: Colors.indigo,
  onTap: () => Navigator.push(context, profileRoute),
)
```

---

## Widgets

### `Navii` — single avatar

```dart
Navii(
  seed: 'user-123',          // required — stable unique identifier
  size: 48.0,                // logical pixels (default: 48)
  shape: NaviiShape.circle,  // circle | square | rounded (default: circle)
  onTap: () {},              // optional tap callback
  borderColor: Colors.blue,  // optional colored ring
  borderWidth: 2.0,          // border thickness (default: 2.0)
  statusColor: Colors.green, // optional status dot
  statusSize: 10.0,          // dot diameter (default: 10)
  statusAlignment: Alignment.bottomRight, // dot position (default)
  options: AvatarOptions(paletteId: 'violet'), // override palette
)
```

### `NaviiGroup` — stacked row of avatars

```dart
NaviiGroup(
  seeds: memberIds,    // list of seed strings
  size: 36,            // each avatar size
  overlap: 10,         // px each avatar overlaps the previous
  maxVisible: 4,       // show 4 avatars, then "+N" badge
  shape: NaviiShape.circle,
)
```

### `NaviiPicker` — grid picker for user avatar selection

```dart
NaviiPicker(
  baseSeed: user.id,
  count: 9,              // number of variants to show
  onSelected: (seed) {
    // store `seed` in your database
    // render anywhere with Navii(seed: seed)
  },
)
```

### `showNaviiPickerSheet` — bottom sheet wrapper

```dart
final chosen = await showNaviiPickerSheet(
  context,
  baseSeed: user.id,
  initialSeed: user.avatarSeed,  // pre-select their current choice
);
if (chosen != null) updateUserAvatar(chosen);
```

---

## Palette IDs

Pass any of these to `AvatarOptions(paletteId: ...)`:

`indigo` `mint` `amber` `sky` `violet` `cyan` `rose` `lime`
`peach` `teal` `sand` `plum` `coral` `forest` `slate` `fuchsia`
`terracotta` `navy` `lavender` `charcoal` `butter` `aqua`

---

## Seed guidance

| Source | Recommendation |
|---|---|
| Database user ID | ✅ Best — stable, unique |
| UUID | ✅ Great |
| Email address | ✅ Fine — avatar changes if email changes |
| Display name | ⚠️ Avatar changes if user renames |

If the seed changes, the avatar changes. Store the seed in your database alongside the user record.

---

## Seed stability guarantee

Once a seed produces a mascot in `0.x`, it will produce the **same mascot** in all future `0.x` and `1.x` releases. We treat the seed → avatar mapping as a contract — your users' avatars will not change after an update.

New variants (palettes, body styles, etc.) may be added in future releases, but only ever appended. Existing seeds are never reassigned.

---

## Accessibility

Pass a `semanticsLabel` so screen readers can identify the avatar:

```dart
Navii(
  seed: user.id,
  size: 48,
  semanticsLabel: 'Avatar for ${user.name}',
)
```

---

## Platform support

| Platform | Support |
|---|---|
| Android | ✅ |
| iOS | ✅ |
| Web | ✅ |
| macOS | ✅ |
| Windows | ✅ |
| Linux | ✅ |

---

## License

MIT — see [LICENSE](LICENSE).  
Original navii artwork and algorithms © [uxderrick](https://github.com/uxderrick/navii).
