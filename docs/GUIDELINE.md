# Guideline — run the app & build features

This guide is for developers joining this Flutter project.

- Project overview, diagrams, session flow: **[PROJECT_OVERVIEW.md](./PROJECT_OVERVIEW.md)**
- Mandatory rules (compact): **[RULEBOOK.md](./RULEBOOK.md)**
- Run commands: **[README.md](../README.md)**
- This file: **how to implement** features with examples

Living reference features: `lib/features/home/` (API list, search, pagination)
and `lib/features/authentication/` + `lib/features/session/` (login, session).

---

## Table of contents

1. [How to run this project](#1-how-to-run-this-project)
2. [Big picture (2 minutes)](#2-big-picture-2-minutes)
3. [Choose your feature type](#3-choose-your-feature-type)
4. [API feature — how to implement](#4-api-feature--how-to-implement)
5. [Step-by-step: add a new feature](#5-step-by-step-add-a-new-feature)
6. [State management patterns](#6-state-management-patterns)
7. [Session and auth recipes](#7-session-and-auth-recipes)
8. [Testing guide](#8-testing-guide)
9. [Copy-paste checklist](#9-copy-paste-checklist)
10. [Common mistakes](#10-common-mistakes)
11. [Troubleshooting](#11-troubleshooting)
12. [Git and review](#12-git-and-review)

---

## 1. How to run this project

### Prerequisites

- Flutter stable **3.44+** / Dart **^3.7.2** (see `pubspec.yaml`)
- Android and/or iOS toolchain working (`flutter doctor`)
- Apple Silicon: Rosetta is needed for `flutter test` with this Flutter
  install (`softwareupdate --install-rosetta`)

### First-time setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # Freezed, JSON, routes
```

### Run

| Flavor | Command |
|--------|---------|
| dev (default) | `flutter run -t lib/flavors/main_dev.dart` |
| staging | `flutter run -t lib/flavors/main_staging.dart` |
| prod | `flutter run -t lib/flavors/main_prod.dart` |

Flavor values live in `lib/config/app_config.dart`.

### Quality checks

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze --fatal-infos
flutter test
flutter test --coverage
```

### Code generation

| Task | Command |
|------|---------|
| One-off | `dart run build_runner build --delete-conflicting-outputs` |
| Watch | `dart run build_runner watch --delete-conflicting-outputs` |

Generated files (`*.freezed.dart`, `*.g.dart`, `*.gr.dart`) are committed; CI
fails if they drift.

### Where the app starts

`lib/flavors/main_*.dart` → `bootstrap(config)` (`lib/app/bootstrap.dart`):
validate config → apply system UI → `ProviderScope(overrides: appConfig,
observers)` → `MyApp` → router initial route `Splash`.

---

## 2. Big picture (2 minutes)

```text
presentation ──► domain ◄── data        (di/ wires data → domain)
```

```text
Screen → Notifier → UseCase → Repository (contract)
                                  ▲
                    RepositoryImpl (data) → DataSource → ApiService (Dio)
```

| Piece | Where | Job |
|-------|-------|-----|
| Entity | `domain/entities` | Pure business object + rules |
| Repository contract | `domain/repositories` | Returns `ResultFuture<T>` |
| Use case | `domain/usecases` | One action, extends `UseCase<T, P>` |
| DTO | `data/models` | Freezed + JSON, `toEntity()` |
| DataSource | `data/datasources` | Calls API/storage, **throws** |
| RepositoryImpl | `data/repositories` | `ExceptionMapper.guard`, DTO → entity |
| DI | `di/<feature>_di.dart` | datasource → repository → use case providers |
| Notifier | `presentation/providers` | Calls use cases, holds UI state |

Error flow: datasource throws `AppException` → repository returns
`Left(Failure)` → use case passes it up → notifier maps to state → widget shows.

Read the full diagrams in [PROJECT_OVERVIEW.md](./PROJECT_OVERVIEW.md).

---

## 3. Choose your feature type

| Feature type | Needs | Example |
|--------------|-------|---------|
| **API feature** | `domain` + `data` + `di` + `presentation` | `home`, `authentication` |
| **Local storage feature** | Same layers; datasource wraps `SecureStorageService` / `LocalStorageService` | `session` |
| **UI-only feature** | `presentation/` only (+ a provider file if needed) | `splash` |

There is no offline/outbox mode in this template (online-only). If you need
offline, design it first and update the rulebook (see Known gaps).

---

## 4. API feature — how to implement

### When to use

The screen needs data from the backend (list, detail, create, update).

### What you build

```text
features/<name>/
├── data/
│   ├── models/<name>_model.dart               # DTO
│   ├── datasources/<name>_remote_data_source.dart
│   └── repositories/<name>_repository_impl.dart
├── di/<name>_di.dart
├── domain/
│   ├── entities/<name>.dart
│   ├── repositories/<name>_repository.dart
│   └── usecases/<name>_usecases.dart
└── presentation/
    ├── providers/ (notifier + state)
    └── screens/
```

### Pattern (data → domain → UI)

```dart
// data source: throws
Future<OrderModel> fetchOrder(int id) async {
  final result = await networkService.get<OrderModel>(
    '${ApiConstants.orders}/$id',
    parser: (json) => OrderModel.fromJson(coerceJsonMap(json)),
  );
  return result.getOrThrow();
}

// repository impl: returns Failure
@override
ResultFuture<Order> getOrder(int id) => ExceptionMapper.guard(() async {
  final model = await _dataSource.fetchOrder(id);
  return model.toEntity();
});

// use case
class GetOrder extends UseCase<Order, int> {
  const GetOrder(this._repository);
  final OrderRepository _repository;
  @override
  ResultFuture<Order> call(int id) => _repository.getOrder(id);
}

// DI
final getOrderProvider = Provider(
  (ref) => GetOrder(ref.watch(orderRepositoryProvider)),
);
```

### Do **not** add

- `Dio` calls outside `ApiService`
- `try/catch` for `AppException` in notifiers or widgets
- JSON parsing in entities
- UI strings in state

### Example in this repo

`lib/features/home/` — pagination logic lives in the domain
(`ProductListing`), `HomeNotifier` only maps results to UI state.

---

## 5. Step-by-step: add a new feature

Example: feature `orders`, action "get orders".

### Step 1 — Domain
`entities/order.dart` (Equatable), `repositories/order_repository.dart`
(`ResultFuture<List<Order>> getOrders()`), `usecases/get_orders.dart`
(`UseCase<List<Order>, NoParams>`).

### Step 2 — Data
`models/order_model.dart` (`@freezed`, `fromJson`, `toEntity()`),
`datasources/order_remote_data_source.dart` (unwrap with `.getOrThrow()`),
`repositories/order_repository_impl.dart` (`ExceptionMapper.guard`).
Add the endpoint to `core/constants/api_constants.dart`.

### Step 3 — DI
`di/orders_di.dart`: datasource (watches `networkServiceProvider` from
`shared/providers/app_provider.dart`) → repository → use case providers.

### Step 4 — Presentation
A `Notifier`/`AsyncNotifier` that reads the use-case provider. Screen under
`presentation/screens`. Register the route in `core/routes/app_route.dart`.

### Step 5 — Codegen
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Step 6 — Tests
Use case, repository impl, notifier (see §8).

### Step 7 — Verify
```bash
dart format lib test && flutter analyze --fatal-infos && flutter test
```

---

## 6. State management patterns

- `Notifier<S>` / `AsyncNotifier<S>` with `NotifierProvider`; no new `StateNotifier`.
- Read dependencies with `ref.read` inside methods, `ref.watch` in `build`.
- Initial load: `Future.microtask(...)` in `build`.
- Side effects in widgets: `ref.listen` (snackbars, navigation).
- Limit rebuilds with `select`.
- Do not `ref.read` a provider that depends on the same notifier from inside it
  (circular dependency).

Sealed Freezed union (`AuthState`) for distinct states; flat `copyWith` class
(`HomeState`) for lists. State holds enums/flags, not UI strings.

---

## 7. Session and auth recipes

| I want to… | Do this |
|------------|---------|
| Show the logged-in user | `ref.watch(currentUserProvider)` |
| Log out from UI | `await ref.read(logoutProvider)();` then navigate to `LoginRoute` |
| Call a protected API | Nothing; `AuthInterceptor` adds the token |
| Store another secret | Add a key to `StorageKeys`, use `SecureStorageService` |
| Store a non-sensitive pref | `LocalStorageService` |
| React to token expiry | Nothing; the 401 flow in `app/app.dart` logs out and redirects |

Never copy the token into state, logs or other storage.

---

## 8. Testing guide

| What | How |
|------|-----|
| Use case | Mock repository (mocktail); assert result and calls |
| Repository impl | Mock datasource; success → entity, thrown `AppException` → `Left(Failure)` |
| DTO | `fromJson` + `toEntity` with edge values (int vs double, missing keys) |
| Notifier | `ProviderContainer(overrides: [...])`, `container.listen` to keep it alive, await microtasks |
| Architecture | `test/architecture/architecture_test.dart` — do not edit to pass |

- Mirror `lib` under `test/features/<feature>/`.
- Use `registerFallbackValue` for custom types used with `any()`.
- No real network or secure storage in unit tests.

---

## 9. Copy-paste checklist

### New API feature
- [ ] Entity, repository contract, use case(s) in `domain/`
- [ ] DTO (Freezed) with `toEntity()`; datasource throws; repository uses `ExceptionMapper.guard`
- [ ] `di/<name>_di.dart` wires everything
- [ ] Notifier calls use cases only; state has no UI strings
- [ ] Route registered; build_runner run
- [ ] Loading / error / empty states in the screen
- [ ] Tests: use case, repository, notifier
- [ ] `flutter analyze --fatal-infos`, `flutter test` green

### Before opening a PR
- [ ] Format clean, generated files current
- [ ] No unrelated rewrites
- [ ] Docs updated if architecture changed

---

## 10. Common mistakes

| Mistake | Fix |
|---------|-----|
| Notifier calls a repository directly | Go through a use case |
| Datasource returns `Either` | Throw; the repository maps to `Failure` |
| Catching `DioException` in a notifier | Only handle `Failure` |
| Pagination math in the notifier | Put it in a domain entity/use case |
| Importing `features/x/data` from presentation | Use the domain or a public provider |
| UI strings or `ApiConstants` in state | Keep state as enums/flags |
| Editing `*.g.dart` / `*.freezed.dart` | Change the source and rerun build_runner |
| Route added but "Not found" at runtime | Add it to `AppRouter.routes`, rerun build_runner |
| Token saved to SharedPreferences | Use `SecureStorageService` |

---

## 11. Troubleshooting

| Symptom | Fix |
|---------|-----|
| `pub get` version conflict | Don't re-add `test`/`state_notifier`; `flutter_test` is enough |
| Missing `*.freezed.dart` / `*.g.dart` / `*.gr.dart` | Run build_runner |
| Architecture test fails | You added a forbidden import; move code to the right layer |
| Loop back to Login | Token expired/invalid; check secure storage and `AuthInterceptor` |
| `flutter test` cannot start (architecture error) | Install Rosetta |

---

## 12. Git and review

- Branch from `master`; small, focused PRs; CI must be green.
- Commit messages: imperative, explain the why.
- Reviewer checklist: rulebook §1–§6 respected, tests added, docs updated when
  architecture changed, no hand-edited generated files.
