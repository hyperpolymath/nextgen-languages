<!--
SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Extraction Manifest

`nextgen-languages` is a **pure coordinator**. This file records language-specific content
that had leaked into the coordinator and where it belongs, so it can be landed in each
language's own `hyperpolymath/<lang>` repo and then removed from here.

**Why a manifest instead of a direct move:** the session that produced this change had GitHub
access scoped to `hyperpolymath/nextgen-languages` only — it could not push into the sibling
repos. So content that is **not already superseded upstream** was *staged* under
`extraction-queue/` (excluded from the coordinator-boundary guard) rather than deleted, to
avoid data loss. Git history preserves everything regardless.

## How to land a staged item (for a maintainer / cross-repo session)

```sh
# Example: AffineScript's wiki page → the affinescript repo
#   (in a checkout/session that has hyperpolymath/affinescript in scope)
git mv extraction-queue/affinescript/wiki-AffineScript.md \
       <affinescript-repo>/wiki/AffineScript.md     # or docs/, per that repo's convention
# ...repeat for each row below, then:
git rm -r extraction-queue/<lang>/                  # once that language's items have landed
```

When `extraction-queue/` is empty, delete it. The `coordinator-boundary` CI check keeps new
language content from reappearing.

---

## A. Deleted here (already superseded upstream — no action needed)

| Removed path | Canonical home | Why safe to delete |
|---|---|---|
| `kitchenspeak/**` (entire subtree: SPEC, grammar.ebnf, proofs/agda/*.agda, examples/*.ks, decisions/*, ROADMAP, CHANGELOG, COMMENTARY, MOVED.adoc) | `hyperpolymath/kitchenspeak` | Was a frozen v1.0 snapshot; the standalone repo carries a superseding v2.0 (physics-in-types, OCaml compiler, machine-checked Agda). Its own `MOVED.adoc` pre-authorized removal. |
| `scripts/elevate-kitchenspeak.sh` | n/a | One-shot elevation tool; elevation is complete. |
| `languages/kitchenspeak.md` | `hyperpolymath/kitchenspeak` | Orphan coordinator stub (not in the `languages/` index); content superseded upstream. |

## B. Staged in `extraction-queue/` — pending landing in the sibling repo

Each was moved out of the coordinator's active surface (`wiki/languages/`, `docs/design/`,
or the README) into `extraction-queue/<lang>/`. **These are NOT yet in their destination
repos** — land them, then delete the staged copy.

| Staged path | Destination repo | Suggested target | Notes |
|---|---|---|---|
| `extraction-queue/affinescript/wiki-AffineScript.md` | `hyperpolymath/affinescript` | `wiki/AffineScript.md` | from `wiki/languages/` |
| `extraction-queue/ephapax/wiki-Ephapax.md` | `hyperpolymath/ephapax` | `wiki/Ephapax.md` | from `wiki/languages/` |
| `extraction-queue/ephapax/design/dyadic-architecture.md` | `hyperpolymath/ephapax` | `docs/design/dyadic-architecture.md` | from `docs/design/` |
| `extraction-queue/ephapax/design/proven-integration.md` | `hyperpolymath/ephapax` | `docs/design/proven-integration.md` | from `docs/design/` |
| `extraction-queue/anvomidav/wiki-Anvomidav.md` | `hyperpolymath/anvomidav` | `wiki/Anvomidav.md` | from `wiki/languages/` |
| `extraction-queue/eclexia/wiki-Eclexia.md` | `hyperpolymath/eclexia` | `wiki/Eclexia.md` | from `wiki/languages/` |
| `extraction-queue/eclexia/design/next-steps.md` | `hyperpolymath/eclexia` | `docs/design/next-steps.md` | from `docs/design/` |
| `extraction-queue/betlang/wiki-betlang.md` | `hyperpolymath/betlang` | `wiki/betlang.md` | from `wiki/languages/` |
| `extraction-queue/jtv/wiki-jtv.md` | `hyperpolymath/jtv` | `wiki/jtv.md` | from `wiki/languages/` |
| `extraction-queue/jtv/design/007-reversibility-fork.adoc` | `hyperpolymath/jtv` | `docs/design/007-reversibility-fork.adoc` | from `docs/design/` |
| `extraction-queue/oblibeny/wiki-Oblibeny.md` | `hyperpolymath/oblibeny` | `wiki/Oblibeny.md` | from `wiki/languages/` |
| `extraction-queue/phronesis/wiki-Phronesis.md` | `hyperpolymath/phronesis` | `wiki/Phronesis.md` | from `wiki/languages/` |
| `extraction-queue/wokelang/wiki-WokeLang.md` | `hyperpolymath/wokelang` | `wiki/WokeLang.md` | from `wiki/languages/` |
| `extraction-queue/my-lang/wiki-My-Language-Family.md` | `hyperpolymath/my-lang` | `wiki/My-Language-Family.md` | from `wiki/languages/` |
| `extraction-queue/my-lang/wiki-Solo.md` | `hyperpolymath/my-lang` | `wiki/Solo.md` | dialect |
| `extraction-queue/my-lang/wiki-Duet.md` | `hyperpolymath/my-lang` | `wiki/Duet.md` | dialect |
| `extraction-queue/my-lang/wiki-Ensemble.md` | `hyperpolymath/my-lang` | `wiki/Ensemble.md` | dialect |
| `extraction-queue/my-lang/wiki-Me.md` | `hyperpolymath/my-lang` | `wiki/Me.md` | **FIX on landing:** this page models "Me" as a fourth dialect. Me is an *agent-generated projection* over Solo/Duet/Ensemble (see `tentacles-agentic-syllabus/me/README.adoc`), not a static dialect. |
| `extraction-queue/typefix-zero/SPEC.adoc` | `hyperpolymath/typefix-zero` *(proposed; not yet created, not in ECOSYSTEM.a2ml)* | `SPEC.adoc` | Was a headingless spec dump pasted into `README.adoc`. Create the repo or fold into the relevant design repo. |

## C. Kept in the coordinator (cross-language — correctly belongs here)

| Path | Why it stays |
|---|---|
| `docs/disambiguation/ephapax-vs-affinescript.md` | Cross-language anti-confusion doc; its whole purpose is to span two repos. |
| `wiki/overview/`, `wiki/tooling/`, `wiki/tutorials/`, `wiki/frameworks/` | Language-*agnostic* education. Candidate for later relocation to `hyperpolymath/tentacles-agentic-syllabus` (curriculum), but not language-specific leakage. |
| `docs/design/verisim-parallel-dev.adoc` | Cross-cutting language↔VeriSim co-development note. Could later move to `hyperpolymath/verisimdb`. |
| `TEST-NEEDS.md`, `PROOF-NEEDS.md`, `TOOLING-STATUS.adoc`, `language-status-tracker.jl` | Cross-language trackers — the coordinator's core job. |
