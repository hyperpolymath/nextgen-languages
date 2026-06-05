<!-- SPDX-License-Identifier: MPL-2.0 -->
# Changelog

All notable changes to the nextgen-languages parent repository.

## 2026-06-02

### Added

- KitchenSpeak elevated to standalone-repo-ready and listed as a DSL in
  `README.adoc` / `EXPLAINME.adoc`; `scripts/elevate-kitchenspeak.sh` performs
  the repo split + submodule conversion.
- KitchenSpeak proofs commenced: `PoachedEgg.agda` (Linear+Tropical+Echo),
  `EchoBridge.agda`, and a proof harness (`proofs/Makefile`,
  `kitchenspeak.agda-lib`).
- KitchenSpeak ADRs 0002–0004: standalone elevation; `echo-types` dependency;
  Echo attaches to Linear/Dyadic (B-now / C-later / A-shim).
- Hypatia accepted-findings registry in `.machine_readable/6a2/NEUROSYM.a2ml`
  `[waivers]`, with gitbot runbook in `PLAYBOOK.a2ml` and agent contract in
  `AGENTIC.a2ml`.
- `6a2` machine-readable state refreshed (STATE/META/ECOSYSTEM/NEUROSYM/
  PLAYBOOK/AGENTIC); `MUST.contractile` project-specific invariants.

### Changed

- CI hygiene: `timeout-minutes` on all real jobs; CodeQL matrix
  `javascript-typescript` → `actions`; scorecard publish job split from an
  unprivileged score-gate; `instant-sync` dispatch gated on secret presence;
  fixed pre-existing invalid YAML in `instant-sync.yml`.
- `Trustfile` reconciled: deleting merged PR branches is permitted
  (force-push, CI-secret modification, and publish remain denied).

### Removed

- Spurious `nuget` ecosystem from `.github/dependabot.yml` (no .NET projects).
- Stale merged feature branches.

## 2026-03-15

### Changed

- Moved 6 design documents to `docs/design/` and `docs/` for cleaner root.
- Deleted 14 stale status snapshots, executed plans, and duplicate files.
- Renamed `AI.a2ml` to `0-AI-MANIFEST.a2ml` (RSR standard).
- Deleted `CONTRIBUTING.adoc` (content subset of `CONTRIBUTING.md`).

### Removed

- `COMPLETION-STATUS-2026-02-07.md` (stale snapshot)
- `CONSOLIDATION-COMPLETE.md` (executed plan)
- `CONSOLIDATION-PLAN.md` (executed plan)
- `FINAL-STATUS-2026-02-07.md` (stale snapshot)
- `LANGUAGE-STATUS-MASTER.md` (superseded)
- `LANGUAGE-STATUS-VERIFIED-2026-02-07.md` (stale snapshot)
- `OBLIBENY-COMPLETION-2026-02-07.md` (stale snapshot)
- `MY-LANG-VERIFICATION-BLOCKED.md` (resolved issue)
- `MIGRATION-STATUS.md` (stale, from 2025-12)
- `MIGRATION-STRATEGY.md` (executed plan)
- `MANIFEST.md` (superseded by 0-AI-MANIFEST.a2ml)
- `PALIMPSEST.adoc` (redundant with LICENSE)
- `CLAUDE-INSTRUCTIONS.md` (superseded by .claude/CLAUDE.md)
- `CONTRIBUTING.adoc` (subset of CONTRIBUTING.md)

## 2026-02-07

### Added

- Consolidation of scattered language repos into canonical locations.
- Updated .machine_readable/6a2/STATE.a2ml with verified completion percentages.
