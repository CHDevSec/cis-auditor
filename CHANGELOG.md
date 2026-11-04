# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses
[Semantic Versioning](https://semver.org/).

## [1.0.0] — 2026-11-03

### Fixed
- **Phase 02 was reported as 100% FAIL.** The engine only understood `** PASS **` / `** FAIL **`, while 43 of the 44 Phase 02 scripts print `✅/✔` and `❌/✘/✖`. Every control came back as "invalid output format". The parser now understands all markers.
- **Checks ending in a `grep` with no match were reported as `ERROR`.** A non-zero exit code is no longer treated as a failure to execute.
- **Disabled services were reported as enabled** in 19 service checks (2.1.x): `grep 'enabled'` also matched `disabled`. Now `grep '^enabled'`.
- **The Makefile pointed to `scripts/Fase-02/`** (the folder is `fase-02`) and to a non-existent network folder, so no Phase 02 target worked.
- **Two profiles run in the same second overwrote each other's JSON.** The file name now includes the profile.
- The HTML report always suggested a `scripts/Fase-01/...` fix path, even for Phase 02 controls, and did not escape script output.

### Added
- `MANUAL` status for checks that only collect evidence.
- Parallel execution (`--workers`, one per CPU by default), keeping profile order.
- `--strict` (exit code 2 on failures) and `make ci`; `--version`.
- `title` and `scripts_dir` in every profile: `--profile` alone is enough.
- Full JSON report (metadata + summary + controls) and a redesigned HTML report with a compliance score.
- `make help`, `lint`, `docs`, `audit_fase02`, `audit_all`; `audit_id`/`fix_id` search every phase.
- `tools/gendocs`: generates `docs/CONTROLS.md` and every scripts-folder README from the profiles.
- Unit tests for the engine, GitHub Actions CI (lint, tests and a real audit on Ubuntu 22.04).
- README (EN + pt-BR), LICENSE, CONTRIBUTING, SECURITY, CHANGELOG.

### Removed
- Committed IDE files (`.idea/`) and sample results containing a hostname.

## [0.1.0] — 2025-10-12

- Initial version: Go engine, 8 Phase 01 controls, Phase 02 scripts (services, AppArmor, UFW, network), HTML report.

[1.0.0]: https://github.com/CHDevSec/cis-auditor/compare/v0.1.0...v1.0.0
[0.1.0]: https://github.com/CHDevSec/cis-auditor/releases/tag/v0.1.0
