# Brief for AI assistants

Flutter app using feature-first Clean Architecture (Riverpod 3, Dio, Freezed,
auto_route). Before changing code read, in order:
`docs/PROJECT_OVERVIEW.md`, `docs/RULEBOOK.md`, `docs/GUIDELINE.md`.

Non-negotiables (full list in the rulebook):
- Dependency direction: `presentation -> domain <- data`; `di/` is the only
  place binding data impls to domain contracts; `core` never imports features.
- Repositories return `ResultFuture<T>` (`Either<Failure, T>`); data sources
  throw `AppException`; map with `ExceptionMapper.guard`.
- Notifiers call use cases only; no UI strings or API constants in state.
- Use package imports; never edit `*.g.dart`, `*.freezed.dart`, `*.gr.dart`.
- Verify with `dart run build_runner build --delete-conflicting-outputs`,
  `flutter analyze`, `flutter test` (includes `test/architecture`).
