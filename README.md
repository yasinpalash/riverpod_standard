# riverpod_standard

Production-ready Flutter template: **feature-first Clean Architecture** with
Riverpod 3, Dio, Freezed, auto_route and secure session storage.

Demo backend: [dummyjson.com](https://dummyjson.com) (login + product list/search).

## Documentation (read in this order)

| Doc | Read it to learn |
|---|---|
| [docs/PROJECT_OVERVIEW.md](docs/PROJECT_OVERVIEW.md) | What the app does, architecture diagrams, folder map, request/session flows |
| [docs/RULEBOOK.md](docs/RULEBOOK.md) | The non-negotiable rules (enforced by tests/CI) |
| [docs/GUIDELINE.md](docs/GUIDELINE.md) | Conventions, how to add a feature, testing, Git, troubleshooting |
| [CLAUDE.md](CLAUDE.md) | Short brief for AI coding assistants |

## Quick start

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # Freezed / JSON / routes
flutter run -t lib/flavors/main_dev.dart                   # or main_staging / main_prod
```

| Task | Command |
|---|---|
| Analyze | `flutter analyze` |
| Format | `dart format lib test` |
| Test | `flutter test` |
| Coverage | `flutter test --coverage` |
| Regenerate code (watch) | `dart run build_runner watch --delete-conflicting-outputs` |

Requirements: Flutter stable (3.44+), Dart ^3.7.2. On Apple Silicon, Rosetta is
needed for `flutter test` with this Flutter install
(`softwareupdate --install-rosetta`).

## Architecture at a glance

```
presentation ──► domain ◄── data          (di/ wires data → domain)
```

- `domain`: pure Dart (entities, repository contracts, use cases)
- `data`: DTOs, data sources (throw), repository impls (return `Either<Failure, T>`)
- `presentation`: screens + Riverpod `Notifier`s that call use cases only
- `core`: shared infrastructure; never imports features

Details and diagrams: [docs/PROJECT_OVERVIEW.md](docs/PROJECT_OVERVIEW.md).

## Features

| Feature | What it does |
|---|---|
| `splash` | Checks for a saved session, routes to Home or Login |
| `authentication` | Login (username/password) and session start |
| `session` | Persists/reads/clears the logged-in user (secure storage) |
| `home` | Paginated product list, search, drawer with user + logout |

## Flavors

Entry points: `lib/flavors/main_{dev,staging,prod}.dart`. Config lives in
`lib/config/app_config.dart` (base URL, timeouts, logging) and is validated at
startup.

## CI

`.github/workflows/ci.yml`: codegen freshness, format, `analyze --fatal-infos`,
tests with coverage.
