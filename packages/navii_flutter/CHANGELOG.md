# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-05-28

### Added
- Demo GIF added to README showing live widget usage.

### Changed
- Example app: updated determinism explanation copy.

## [0.1.0] - 2026-05-28

### Added
- Initial release — Flutter widget wrapping `navii_dart`.
- `Navii` widget: one-line drop-in avatar widget — `Navii(seed: user.id)`.
- `size` parameter controls rendered dimensions (default 48px).
- `shape` parameter: `NaviiShape.circle`, `.square`, `.rounded`.
- `onTap` callback for tap handling.
- `borderColor` and `borderWidth` for colored ring decoration.
- `statusColor`, `statusSize`, `statusAlignment` for presence indicator dot.
- `options` parameter passes through palette and background overrides.
- `NaviiGroup` widget: stacked row of overlapping avatars with overflow badge.
- `NaviiPicker` widget: grid picker for user avatar selection.
- `showNaviiPickerSheet`: bottom sheet wrapper for `NaviiPicker`.
- `naviVariants(baseSeed)`: generates stable variant seed strings.
- Renders via `flutter_svg` — no native code, no platform channels.

[Unreleased]: https://github.com/Sankwan/navii_flutter/compare/navii_flutter-v0.2.0...HEAD
[0.2.0]: https://github.com/Sankwan/navii_flutter/compare/navii_flutter-v0.1.0...navii_flutter-v0.2.0
[0.1.0]: https://github.com/Sankwan/navii_flutter/releases/tag/navii_flutter-v0.1.0
