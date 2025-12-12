## Tic-Tac-Toe (Flutter)

A simple, polished Tic‑Tac‑Toe built with Flutter using a clean, feature‑first architecture. It supports 1v1 local multiplayer, smooth animations, haptics, and automatic game persistence.

## Demo

https://github.com/user-attachments/assets/dfd20997-95e8-40f8-a8f6-28aa0baa1316

## Quick start

### 1) Install dependencies

```bash
flutter pub get
```

### 2) Generate code (Freezed, JSON serialization, Riverpod)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3) Run the application

```bash
flutter run
```

## Architecture

- **Style**: Clean Architecture, **feature‑first** organization
- **Layers per feature**: presentation ⟶ domain ⟶ data
- **Shared**: reusable UI, services, router, storage, utils

```
lib/
  core/
    router/           // go_router setup
    services/
      local_storage/  // SharedPreferences-backed storage service
    utils/            // haptics, logger, etc.
  features/
    game/             // game feature (data/domain/presentation)
    menu/             // menu feature
    splash/           // splash feature
```

## State management

- **Riverpod** (with code generation via `riverpod_generator` and `riverpod_annotation`)

## Routing

- **go_router** with fade page transitions and named routes

## Serialization

- **Freezed** for immutable models + unions
- **json_serializable** for JSON (de)serialization
- Codegen command:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Haptics

- **Gaimon** provides richer haptic patterns (e.g., win pattern), with platform fallbacks via `HapticFeedback`
- Toggle and helpers centralized in `core/utils/haptics_utils.dart`

## Persistence

- Ongoing match is saved locally using **SharedPreferences** (see `core/services/local_storage`)
- Game in progress is restored on app reopen

## Features

- 1v1 local multiplayer
- Smooth board animations
- In‑progress game is cached and automatically resumed

## Notes / Future work

- VS Bot (AI) mode
- Online multiplayer mode
