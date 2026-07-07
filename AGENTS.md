# YaadHai — Codex Agent Rules

> Rules source of truth: `.ai/rules/`
> Read `.ai/rules/00-index.md` first, then follow rule files in order.
> Project context: `.ai/context/project-overview.md`
> Workflows: `.ai/workflows/`

## Build & Run Commands
```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run

# Monorepo wrapper commands
melos run get
melos run analyze
melos run test
melos run build_runner
melos run run
```
