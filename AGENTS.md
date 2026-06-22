# AGENTS.md — svu_helper

## Constraints

- **Material Design only.** Never use Cupertino (iOS-style) widgets.
- When adding new UI code, always `import 'package:flutter/material.dart'` and use Material widgets exclusively.

## Commands

| Task | Command |
|------|---------|
| Run app | `flutter run` |
| Run tests | `flutter test` |
| Analyze | `flutter analyze` |
| Get deps | `flutter pub get` |

## Architecture

- Standard Flutter scaffold (via `flutter create`). Single entrypoint: `lib/main.dart`.
- Targets all 6 platforms: Android, iOS, web, Windows, Linux, macOS.

## Dart MCP

Dart MCP server is configured in `opencode.json`. One-time setup:

    dart pub global activate dart_mcp

Then OpenCode will start the `dart_mcp` server automatically. Provides Dart/Flutter analysis tools.
