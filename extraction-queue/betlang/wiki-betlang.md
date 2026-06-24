<!--
SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# betlang

**Tagline:** A symbolic probabilistic metalanguage — a *probabilistic computer algebra system*, not a betting language.

## Overview

BetLang is built on one idea: **computation is structured choice under uncertainty.**
Its core primitive is the ternary form `(bet A B C)` — a probabilistic, **lazy** choice
between three branches (only the selected branch is evaluated). This makes BetLang closer
to a *probabilistic CAS* than a simulation DSL: it is symbolic-first, compositional, and
treats uncertainty as a first-class **typed** object rather than as noise to average away.

## Philosophy

- **Ternary over binary** — real-world decisions are rarely yes/no; the musical ternary
  form (A–B–A) gives compositional structure, and Dutch-book coherence needs ≥3 outcomes.
- **Uncertainty as structure** — not noise, but a first-class object the type system tracks.
- **Symbolic first** — computation stays inspectable and composable.

## Core Primitive

```racket
#lang betlang

(bet 'win 'draw 'lose)                       ; uniform ternary choice (lazy)
(bet/weighted '(common 7) '(uncommon 2) '(rare 1))  ; non-uniform
(bet/conditional pred A B C)                 ; predicate-driven
(bet (expensive) (cheap-approx) (fallback))  ; only one branch is evaluated
```

## Type System

BetLang's checker (`bet-check`, Rust) is Hindley–Milner with two domain-specific pillars:

- **Echo types** — *structured loss* as a typed object. When a `bet` collapses three
  branches to one (or a `sample` marginalises a draw), `Echo T` retains a proof-relevant
  residue of what was lost; `Echo T` is deliberately **distinct from `T`** (no implicit
  forgetting). The operations form a functor + comonad surface (`echo`, `echo_output`,
  `echo_map`, `echo_duplicate`, `echo_to_residue`, `sample_echo`), the ungraded ghost
  shadow of the graded comonad proved in [`echo-types`](https://github.com/hyperpolymath/echo-types) (Agda).
- **The uncertainty number tower** — 14 uncertainty-aware number systems (Gaussian,
  interval/affine, fuzzy, Bayesian, VaR/CVaR, surreal, p-adic, imprecise, Dempster–Shafer,
  …). These *are* the type system, not add-ons.

## Formal Verification

The core calculus is mechanised in **Lean 4** (`proofs/BetLang.lean`, CI-checked):
**Progress**, **Preservation**, and the **distribution monad laws** — with an
**axiom-free core** (the `substTop_preserves_typing` axiom was discharged) and **zero
`sorry`**. This is BetLang's differentiator versus untyped numeric/CAS tools (R, Octave,
Scilab, Mathematica, Maple): *typed, proof-anchored uncertainty*.

## Architecture

Four layers with separated responsibilities: **Racket** (authoritative semantics) ·
**Julia** (compute kernel / number tower) · **Lean 4** (proofs) · **Rust** (compiler
tooling — `bet-core`, `bet-check`, `bet-parse`).

## Status

Active. Racket frontend authoritative; Lean proofs machine-checked (axiom-free core);
Rust checker handles Echo formers **and** the typed echo operations; Julia backend in
active development.

## See Also

- BetLang repository wiki (in-repo `wiki/`): Home · Type-System · Echo-Types · Formal-Verification · Number-Tower
- [[Ephapax]] — linear/affine once-only semantics (sibling language)
- [[AffineScript]] — affine-typed primary application language
- Upstream: [`echo-types`](https://github.com/hyperpolymath/echo-types) (Agda, source of truth) · [`EchoTypes.jl`](https://github.com/hyperpolymath/EchoTypes.jl) (executable shadow)
