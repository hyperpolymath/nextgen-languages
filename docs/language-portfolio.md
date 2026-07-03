<!--
SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Hyperpolymath Language Portfolio

**Last updated:** 2026-07-02

This is a cross-language index. `nextgen-languages` is a **pure coordinator**: it does not
contain any language. Each language is its own standalone `hyperpolymath/<lang>` repo.
**Per-language status, completion, and tech-stack detail are not duplicated here** — they
live in each language's own repo and in the coordinator's canonical trackers:

- **`.machine_readable/LANGUAGES.a2ml`** — the machine-readable language registry
- **`language-status-tracker.jl`** — the script that computes cross-language status
- **`TOOLING-STATUS.adoc`** — the per-language grade matrix (CRG/TRG/ARG/FRG/RSR)
- **`PROOF-NEEDS.md` / `TEST-NEEDS.md`** — cross-language proof/test gaps

## General-purpose languages

| Language | Repo | One-line role |
|----------|------|---------------|
| Phronesis | `hyperpolymath/phronesis` | Formal, auditable agent ethics |
| Eclexia | `hyperpolymath/eclexia` | Resource-first / green computing |
| WokeLang | `hyperpolymath/wokelang` | Consent & well-being as primitives |
| AffineScript | `hyperpolymath/affinescript` | Affine types targeting WasmGC |
| Ephapax | `hyperpolymath/ephapax` | Dyadic linear/affine types → WasmGC |
| My-Lang | `hyperpolymath/my-lang` | Solo → Duet → Ensemble dialect family |
| JtV | `hyperpolymath/jtv` | Systems language, Harvard architecture |
| Error-Lang | `hyperpolymath/error-lang` | Pedagogical, systems thinking via errors |
| Haec | `hyperpolymath/haec` | Trope-particularity: graded property-instance loss, use-checked |
| Oblíbený | `hyperpolymath/oblibeny` | Turing-incomplete secure deployment |
| Anvomidav | `hyperpolymath/anvomidav` | Hard real-time / formal verification |
| betlang | `hyperpolymath/betlang` | Foundational / probabilistic experiment |
| Tangle | `hyperpolymath/tangle` | Topological (knot/braid) language; TangleIR feeds the separate KRL stack |
| 007 | `The-Metadatastician/007` (private) | Agent meta-language (anti-scrape; index-only) |

## Specialised & DSL

| Language | Repo | One-line role |
|----------|------|---------------|
| KitchenSpeak | `hyperpolymath/kitchenspeak` | Experimental kitchen-orchestration DSL |

## Proposed (repo not yet created)

- **TypeFix Zero (TF0)** — proposed `hyperpolymath/typefix-zero` (not yet created). A
  universe-stratified simply-typed lambda calculus that separates a total, proof-like
  fragment from a partial computational fragment (a single `fix` primitive). The design
  spec is parked at `../extraction-queue/typefix-zero/SPEC.adoc`; it is registered as
  `status = "proposed"` in `../.machine_readable/LANGUAGES.a2ml`.

## Related query/database languages (separate scope)

These are tracked by the database estate, not this coordinator, and are listed only for
discoverability:

- **VQL / VQL-DT** — `hyperpolymath/verisimdb` (VeriSim Query Language)
- **GQL / GQL-DT** — `hyperpolymath/lithoglyph` + `hyperpolymath/gql-dt`
- **FBQL-DT** — `hyperpolymath/fbql-dt` (FormDB query language, dependent types)

---

> Historical note: an earlier version of this file was a pre-pivot planning snapshot that
> listed in-tree `/var/.../REPOS` paths and hour estimates. That content is obsolete under
> the pure-coordinator model and has been replaced by the pointer above. Planning and
> status now live in each language's own repo and in the canonical trackers listed at the
> top.
