# Contributing

Thanks for taking a look. Issues and pull requests are welcome.

## Setup

```sh
flutter --version   # 3.44.2 stable
flutter pub get
flutter run         # demo mode, no key needed
```

To run against Gemini, see [Using Gemini](README.md#using-gemini).

## Before you open a pull request

```sh
dart run build_runner build --delete-conflicting-outputs   # if you touched freezed, json or drift code
dart format .
flutter analyze --fatal-infos
flutter test --exclude-tags golden
flutter test --tags golden                                 # macOS only, see below
dart run tool/coverage_gate.dart coverage/lcov.info 85     # after flutter test --coverage
```

Generated files (`*.g.dart`, `*.freezed.dart`, `lib/l10n/gen`) are committed
so the app builds straight after `pub get`. CI regenerates them and fails if
they differ, so commit them with the change that caused them.

## Golden tests

Goldens render with real Roboto from the Flutter SDK so they are readable.
Glyph rasterisation differs between macOS and Linux, so goldens are recorded
and compared on macOS only. To update them after an intentional visual change:

```sh
flutter test --tags golden --update-goldens
```

Look at every changed image before committing it.

## Adding a catalog widget

1. Add a typed model in `lib/genui/catalog/models/` (freezed + json).
2. Write the view in `lib/genui/catalog/widgets/` using the shared primitives
   in `lib/core/ui/`. It should take the typed model and plain callbacks, with
   no genui types.
3. Add the `CatalogItem` in `lib/genui/catalog/items/` with a schema whose
   descriptions tell the model when to use it, and at least one example.
4. Register it in `FixitCatalog.items`. The catalog example tests will check
   the example against both genui's schema and the app validator.
5. Add widget tests and light and dark goldens.

## Commits

[Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`,
`test:`, `docs:`, `ci:`, `build:`, `refactor:`. Keep each commit buildable.
