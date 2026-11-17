# Project Rules

> Canonical engineering rules for **riverpod_standard**.  
> How-to tutorials live in **[GUIDELINE.md](./GUIDELINE.md)**.  
> Architecture, diagrams and session flow live in **[PROJECT_OVERVIEW.md](./PROJECT_OVERVIEW.md)**.  
> Run instructions live in **[README.md](../README.md)**.

**Reference feature:** `lib/features/home/` (API list + search + pagination) and
`lib/features/authentication/` + `lib/features/session/` (login + session).  
**Feature wiring file:** `lib/features/<feature>/di/<feature>_di.dart`  
**App-wide providers:** `lib/shared/providers/app_provider.dart`  
**Tunables / endpoints:** `lib/core/constants/`, `lib/config/app_config.dart`  
**Enforced by test:** `test/architecture/architecture_test.dart`

---

## 0. How to use this book

| Term | Meaning |
|------|---------|
| **MUST / MUST NOT** | Mandatory |
| **SHOULD / SHOULD NOT** | Default; deviation needs a reason |
| **MAY** | Optional |
| **[enforced]** | Fails `flutter test` or CI when broken |

**Conflict order:** security → this rulebook → existing conventions → simplicity → personal preference.

Do not invent abstractions "just in case." Add one when it enforces a boundary,
has a second real use, or is required for testing.

---

## 1. Architecture

### Strict boundaries, consistent layering

Clean Architecture boundaries are **mandatory**. This template keeps the same
layering in every feature that talks to an API or storage, so the pattern is
obvious to copy.

```text
features/<name>/
├── data/          ← models (DTO), datasources, repository impls
├── di/            ← <name>_di.dart: wires data → domain (composition root)
├── domain/        ← entities, repository contracts, use cases
└── presentation/  ← screens, widgets, Notifiers, UI state
```

UI-only features (e.g. `splash`) MAY have only `presentation/`. Do not create
empty folders or `.gitkeep` placeholders.

| Layer | Contains | MUST NOT |
|-------|----------|----------|
| `presentation/` | Screens, widgets, Notifiers, UI state | HTTP, storage, repo impls, business rules |
| `domain/` | Entities, repository contracts, use cases | Flutter, Riverpod, Dio, storage, data, presentation, di |
| `data/` | DTOs, datasources, repository impls | Presentation |
| `di/` | Providers wiring datasource → repository → use case | Logic |
| `core/` | Shared infrastructure + generic widgets | Feature business logic |
| `shared/` | App-wide providers | Feature business logic |
| `app/` | Bootstrap, app widget, observers | Feature business logic |

### Use cases

- Every user action reaches the domain through a **use case** extending
  `UseCase<T, P>` (`NoParams` when there is none).
- Business rules (pagination, "login + start session") live in entities or use
  cases, **never** in a Notifier or widget.
- A use case MAY compose repositories; presentation MUST NOT orchestrate
  several use cases for one user action.

### Import boundaries **[enforced]**

| From | MAY import | MUST NOT import |
|------|------------|-----------------|
| `domain/` | Dart SDK, own domain, other features' domain, `core/{typedefs,usecases,result,errors}` | Flutter, Riverpod, Dio, storage, `data/`, `presentation/`, `di/`, `core/network`, `core/storage` |
| `data/` | Domain, `core/`, own DTOs | `presentation/` |
| `presentation/` | Domain, `core/` UI/utils, **own** feature's `di/`, other features' public presentation providers | Any `features/*/data/*` |
| `di/` | Own data + domain, other features' `di/` providers | Logic |
| `core/` | Framework libs | `features/` (only `core/routes` may) |

Cross-feature work goes through the other feature's **domain**, its public
**presentation provider** (`logoutProvider`, `currentUserProvider`) or
navigation. A feature MUST NOT import another feature's `data/`.

---

## 2. DI and state

- Riverpod 3 only. No GetIt / service locators.
- App-wide infrastructure: `shared/providers/app_provider.dart`.
- Feature wiring: `features/<name>/di/<name>_di.dart` (datasource → repository → use case).
- Feature state: `Notifier` / `AsyncNotifier` with `NotifierProvider`.
  `StateNotifier` is legacy; MUST NOT add new ones.
- Sealed Freezed unions for state with distinct cases (`AuthState`); a flat
  immutable class with `copyWith` for list state (`HomeState`).
- State MUST NOT hold UI strings, API constants or tokens. It carries
  enums/flags; the widget chooses text. A domain `Failure.message` MAY be shown.
- Widgets MUST NOT call APIs, datasources or repositories.
- MUST NOT use `setState` for feature business state (local ephemeral UI state
  such as a text controller is fine).

---

## 3. Networking and errors

- HTTP only through `ApiService` / `ApiClient` (`core/network/`); features never use `Dio` directly.
- Endpoints, header names and query keys live in `core/constants/api_constants.dart`.
- **Datasources throw** (`AppException`) and return DTOs; unwrap `ApiService`
  results with `.getOrThrow()`. They MUST NOT return `Either` or entities.
- **Repositories return `ResultFuture<T>`** (`Future<Either<Failure, T>>`),
  wrapping work in `ExceptionMapper.guard` and mapping DTO → entity.
- Domain and presentation MUST NOT catch `AppException`, `DioException` or
  `SocketException`; they only see `Failure`.
- `Failure` has no dependency on exceptions; mapping lives in `ExceptionMapper` only.
- 401 handling is global (`GlobalErrorInterceptor` → `NetworkEventBus` →
  logout + redirect in `app/app.dart`); features MUST NOT handle it themselves.
- Timeouts and base URLs live in `AppConfig`.
- MUST NOT invent production endpoints or payload fields.
- MUST NOT hardcode secrets or environment base URLs in feature code.

---

## 4. Models and codegen

- DTOs are Freezed + json_serializable, live in `data/models`, and convert via
  `toEntity()` / `fromEntity()`. DTOs MUST NOT leave `data/`.
- Each feature owns its DTOs; DTOs are not shared across features.
- Parse numbers defensively (`num` → `int`/`double`) and give defaults.
- Entities are pure Dart (`Equatable` allowed), immutable, without JSON.
- Generated files (`*.freezed.dart`, `*.g.dart`, `*.gr.dart`) are committed and
  MUST NOT be edited by hand. **[enforced]** CI fails if a fresh build differs.

---

## 5. Storage

| Store | Use for |
|-------|---------|
| `SecureStorageService` (Keychain / Keystore) | Tokens, secrets, the stored user JSON |
| `LocalStorageService` (SharedPreferences) | Small non-sensitive prefs (theme, locale) |

MUST NOT store tokens or user PII in SharedPreferences.  
MUST NOT copy the token into state, logs or another store.  
Only the `session` feature reads/writes the stored user; other features use
`currentUserProvider` / `logoutProvider`.

---

## 6. Session and auth

- Login is one use case: `LoginUser` authenticates **and** saves the session.
- `AuthInterceptor` adds `Authorization: Bearer <token>` to every request; new
  API calls need no token code.
- App start routes by `HasSession` (Splash). Logout clears secure storage via
  `DeleteSession` and resets the router to Login.
- Session expiry (HTTP 401) follows the global flow in §3.

---

## 7. Config, flavors, security, logging

- Flavor entry points: `lib/flavors/main_{dev,staging,prod}.dart` → `bootstrap(config)`.
- `AppConfig.validate()` runs at startup and MUST stay strict.
- MUST NOT enable request/response body logging in prod (`enableLogging` is
  `false` in `prodConfig`); treat staging logs as sensitive.
- MUST NOT commit secrets; use flavor config or CI secrets.
- Provide a real `ErrorReporter` by overriding `errorReporterProvider`
  (the default is a no-op).
- Use `AppLogger`; MUST NOT use `print`.

---

## 8. UI, routing

- auto_route 11 (`RootStackRouter`); a new screen needs an `@RoutePage()`, a
  route entry in `core/routes/app_route.dart`, and a build_runner run.
- Use `ref.listen` in widgets for side effects (snackbars, navigation).
- MUST NOT use `BuildContext` across async gaps without a `mounted` check;
  fire-and-forget futures use `unawaited(...)`.
- Loading, error and empty states MUST exist for every data-driven screen.
- User-facing strings come from `AppStrings` (no localization yet; see §14).

---

## 9. Naming

| Thing | Convention |
|-------|------------|
| Files | `snake_case.dart` |
| Screens / state / notifiers | `*_screen`, `*_state`, `*_notifier` |
| DTO | `*_model` |
| Contracts / impls | `*_repository`, `*_repository_impl`, `*_data_source` |
| Wiring | `<feature>_di.dart` |
| Use cases | Verb phrases: `LoginUser`, `FetchProducts`, `DeleteSession` |
| Imports | Package imports only, sorted **[enforced]** |

---

## 10. Testing and quality

Before merge:

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze --fatal-infos
flutter test
```

- Every use case, repository impl and notifier SHOULD ship with a test.
- Mock at the boundary (mocktail): repositories for use cases/notifiers,
  datasources for repositories. Notifiers are tested with `ProviderContainer`
  overrides; never a real network or secure storage.
- A bug fix includes a regression test.
- `test/architecture` MUST stay green; never weaken it to pass a change.
- Analysis is strict: `strict-casts`, `strict-raw-types`, `always_use_package_imports`.

---

## 11. Prohibited patterns

MUST NOT:

- Put business logic in widgets or Notifiers
- Call APIs, datasources or repositories from widgets or Notifiers
- Import `data/` from `presentation/` or `domain/`
- Import Flutter, Dio or storage into `domain/`
- Import `features/` from `core/` (except `core/routes`)
- Import another feature's `data/`
- Return `Either` from a datasource, or throw from a repository
- Catch `AppException` / `DioException` above the repository
- Put UI strings, API constants or tokens in state
- Store tokens or user PII in SharedPreferences, logs or state
- Use `StateNotifier`, GetIt or global mutable DI
- Hand-edit generated files
- Hardcode secrets or environment URLs in feature code
- Use `print` or leave dead code / empty placeholder files
- Weaken `test/architecture` to make a change pass
- Rewrite unrelated files in the same change

---

## 12. Agent / contributor protocol (short)

1. Read `PROJECT_OVERVIEW.md`, this rulebook and `GUIDELINE.md`.
2. Inspect an existing feature (`home`, `authentication`) before editing.
3. Make the minimum change; match local conventions.
4. Do not invent endpoints or payloads.
5. Run codegen if needed, then format, analyze and tests for the touched area.
6. Keep diffs focused; update these docs in the same PR when architecture changes.

---

## 13. Definition of done

A change is done when:

- Layer boundaries are respected (`test/architecture` green)
- Datasources throw, repositories return `Failure`s
- Loading / error / empty states exist where needed
- Format, analyzer (`--fatal-infos`) and relevant tests pass
- Generated code is current
- No secrets or tokens logged or stored insecurely
- Docs updated when behavior or architecture changed
- No unrelated rewrites

---

## 14. Known gaps

| Area | Gap |
|------|-----|
| Staging URL | Placeholder in `app_config.dart`; set real values before shipping |
| Offline / cache | No local database or offline strategy; online-only |
| Localization | Strings in `AppStrings`; no l10n/ARB yet |
| Token refresh | Only 401 → logout; no refresh-token flow |
| Observability | `ErrorReporter` is a no-op; no crash/analytics adapter |
| Accessibility | No semantics / text-scale tests |
| Tests | New layers covered; widget and integration tests still missing |
| Env config | Flavor values are Dart consts, not `--dart-define-from-file` |

---

## Final principle

Keep the dependency direction `presentation → domain ← data`. If a change needs
to break a boundary, the change is in the wrong layer.
