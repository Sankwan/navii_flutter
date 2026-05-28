# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-05-28

### Added
- Initial release — Dart port of the navii deterministic avatar engine.
- `createAvatar(seed)` returns a self-contained SVG string.
- `selectAvatar(seed)` resolves an `AvatarSpec` without rendering.
- `renderAvatar(spec)` renders a resolved spec to SVG.
- 22 palettes × 8 body shapes × 10 eye styles × 10 mouth styles × 5 antennae
  × 7 accessories × 3 backgrounds × 13 toppers = 22M+ combinations.
- Determinism guaranteed: same seed → byte-identical SVG on all platforms.
- Full `AvatarOptions` API: override palette, background shape, and size.
- Zero runtime dependencies — works on Dart native, web, and server.

[Unreleased]: https://github.com/Sankwan/navii_flutter/compare/navii_dart-v0.1.0...HEAD
[0.1.0]: https://github.com/Sankwan/navii_flutter/releases/tag/navii_dart-v0.1.0
