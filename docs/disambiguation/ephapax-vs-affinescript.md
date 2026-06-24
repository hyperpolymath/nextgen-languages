<!--
SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
<!-- Copyright (c) 2026 Jonathan D.A. Jewell (hyperpolymath) <j.d.a.jewell@open.ac.uk> -->

# Ephapax vs AffineScript — these are different languages

> ⚠️ **STOP.** If you arrived here because you were about to apply a lesson, snippet, fact, or tactic learned in one of these two repos to the other — **don't**. They share zero source-level structure. The only thing in common is the compile target.

## The one-sentence rule

**Ephapax** and **AffineScript** are two unrelated languages from the same author. They both happen to use type systems with *affine-flavored* substructural properties — which is true of nearly every modern resource-safe language — and the lexical overlap of the word "affine" is the entire reason agents and humans confuse them.

| | Ephapax | AffineScript |
|---|---|---|
| **What it is** | Research language for compile-time WebAssembly memory safety | Successor to JS / TypeScript / ReScript |
| **Repo** | `hyperpolymath/ephapax` | `hyperpolymath/affinescript` |
| **Audience** | Formal-methods researchers, systems verifiers | Application developers, JS-ecosystem users |
| **Surface syntax** | `.eph` (Coq-like / ML-shaped) | `.affine`, plus brand-faces: jaffascript / rattlescript / lucidscript / cafescripto / pseudoscript |
| **AST/IR** | `src/ephapax-syntax/src/lib.rs`, `src/ephapax-ir` | `lib/ast.ml`, `lib/borrow.ml` |
| **Type checker** | `ephapax-linear/src/{linear,affine}.rs` (Rust, dyadic — see below) | `lib/borrow.ml` (OCaml, single discipline with capabilities) |
| **Structural rule** | Linear (strict) + Affine (companion) — same AST, two checkers | Affine with explicit borrow/copy/drop, NLL-style scopes |
| **Binding forms** | `let-linear`, `region r in …`, regions/exits | `let`, `borrow`/`copy`/`drop`, no first-class regions |
| **Effects** | Region-typed; tracked in type system | Capabilities (`io`, `dom`, `pixi`, `tea`, …); host-facing |
| **Compiler stack** | Cargo workspace; Rust + Idris2 + Coq | Dune project; OCaml + ReScript runtime |
| **Codegen** | typed-wasm via `src/ephapax-wasm`, formal correctness lemma WIP | typed-wasm via `lib/tw_*.ml`, plus Deno-ESM and Node-CJS direct emit |
| **Faces / frontends** | None — one surface syntax | Many (jaffascript, rattlescript, lucidscript, cafescripto, pseudoscript) — all desugar to the same core |
| **Formal semantics** | Mechanized in Coq (`formal/Semantics.v`, `formal/Linearity.v`) + Idris2 ABI (`src/abi/Ephapax/…`) | Operational; soundness arguments in `lib/borrow.ml` comments + `docs/CAPABILITY-MATRIX.adoc`; tracking via `docs/TECH-DEBT.adoc` and issue #177 (CORE-01) |
| **Proof obligations** | `formal/PRESERVATION-HANDOFF.md`, `ROADMAP.adoc` § "Preservation closure plan", PR ephapax#146 | None mechanized; `verification/proofs/` dirs are RSR template scaffolding only |
| **Standard library** | `ephapax-linear/src/`, `examples/` | `stdlib/`, `vendor/`, bindings (`affinescript-dom`, `affinescript-pixijs`, `affinescript-tea`) |
| **Editor support** | `editors/`, `idris2/` LSP work | `vscode-ext/`, NPM-published `@hyperpolymath/affine-vscode` |
| **Status** | Research-active; preservation theorem in flight | Application-active; multiple PRs/release cycle |

## What is shared

**Two things, both via `hyperpolymath/typed-wasm`:**

1. Both languages compile (or are moving towards compiling) to typed-wasm.
2. Both languages interface with the same Rust verifier crate `crates/typed-wasm-verify/` inside the typed-wasm repo.

That is the entire shared surface. They are **sibling languages standing on a common verification substrate** — not an implementation ↔ proof pair, not a parent ↔ dialect pair, not a frontend ↔ backend pair.

## The dyadic-ephapax internal naming trap

Ephapax is *itself* dyadic. Inside the ephapax repo there are two sublanguages:

- **ephapax-linear** — the strict, formally-verified core.
- **ephapax-affine** — a more versatile prototyping companion that works **with** ephapax-linear.

Both are *ephapax-internal*. They share one AST, one Rust crate (`ephapax-linear/`), one grammar directory (`ephapax-linear/grammar/{linear,affine}.ebnf`). The "affine" in "ephapax-affine" names the *structural discipline* — one of two type-checking modes in one crate.

**ephapax-affine is NOT AffineScript.** The word `affine` overlapping in both names is a coincidence of substructural-logic terminology, not a relationship. AffineScript is a separate language with its own AST, its own borrow checker, its own faces.

## Why the confusion happens

Three traps stacked on each other:

1. **Lexical**: both names contain `affine`.
2. **Conceptual**: both use type systems with affine-logic properties, because nearly every resource-safe language does (Rust, Linear Haskell, F*, Idris with QTT, Granule, …). The mere presence of "affine" in a description is not a fingerprint.
3. **Single-author**: both projects come from the same author, so cross-references and shared idioms appear in commit messages, docs, and chat. Don't read those as evidence of structural relationship.

## How to tell which you're in

Quick visual signals, in priority order:

| Signal | Ephapax | AffineScript |
|---|---|---|
| Repo URL | `github.com/hyperpolymath/ephapax` | `github.com/hyperpolymath/affinescript` |
| Build tool | `Cargo.toml` at root | `dune-project` at root |
| Main language | Rust (+ Coq + Idris2) | OCaml (+ ReScript runtime) |
| File extension under work | `.eph`, `.v`, `.idr` | `.affine`, `.ml`, `.res` |
| Top-level dirs | `formal/`, `idris2/`, `ephapax-linear/`, `src/` | `lib/`, `vendor/`, `stdlib/`, face-directories |
| Headline file | `formal/Semantics.v`, `ROADMAP.adoc` | `lib/borrow.ml`, `docs/CAPABILITY-MATRIX.adoc` |
| Open soundness ticket | preservation 11 admits (Brief C / PR ephapax#146) | issue affinescript#177 (CORE-01) |

If you can't tell from the repo URL alone, you are in the wrong context for the work.

## Specific guidance for AI agents

**Do:**
- When switching context between the two, state it explicitly: "switching context from AffineScript to ephapax" (or vice versa). This forces the user-visible audit trail.
- Treat memory entries written about one as inadmissible for the other unless the cross-reference is explicit and recent.
- When you read a snippet mentioning "affine", look at *which file path* it lives in before assuming you know which language is meant.
- Cross-reference the canonical disambiguation memory entry: `feedback_affinescript_ephapax_siblings_not_impl_proof.md`.

**Don't:**
- Apply borrow-checker tactics from `lib/borrow.ml` (OCaml, AffineScript) to `formal/Semantics.v` (Coq, ephapax) or vice versa.
- Re-use proof-obligation framings across the two. Ephapax has Coq/Idris2 mechanized proofs; AffineScript has compiler-correctness arguments.
- Conflate `ephapax-affine` (the sublanguage *inside* ephapax) with `AffineScript`. They have nothing in common beyond the syllable.
- Assume that a typed-wasm-side change in one repo implies anything about the other. The verifier crate is shared, but the consumers are independent.

## Cross-pointers

- **Ephapax**: `hyperpolymath/ephapax` — README.adoc, ROADMAP.adoc, formal/PRESERVATION-HANDOFF.md.
- **AffineScript**: `hyperpolymath/affinescript` — README.adoc, docs/ECOSYSTEM.adoc, docs/CAPABILITY-MATRIX.adoc.
- **Shared target**: `hyperpolymath/typed-wasm` — README.adoc. Documents both languages as independent producers.
- **Canonical disambiguation memory entry**: `feedback_affinescript_ephapax_siblings_not_impl_proof.md` (in the user's auto-memory; durable across sessions).

## When this doc is wrong

The canonical statement is the source code. If this doc and the source disagree, update this doc. Keep the disambiguation specific and current:

- If ephapax adds a third sublanguage, update the dyadic-naming-trap section.
- If AffineScript adds a face, update the faces row in the comparison table.
- If the two ever share more than typed-wasm + the Rust verifier, update the "What is shared" section before anything else.
- If a new confusion class emerges (e.g., a third language with `affine` in the name), extend this doc rather than fork.

Last revised: 2026-05-26.
