<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000002
parent: 0199a001-0000-7000-8000-000000000001
position: 10
kind: page
tags:
  - index
  - portfolio
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk> -->
# Portfolio

This is a grouped *directory*, not a maturity ranking. The canonical list, IDs, and status values are in [`.machine_readable/LANGUAGES.a2ml`](../.machine_readable/LANGUAGES.a2ml); each linked project owns its own detailed documentation.

## Core registry

| Area | Projects |
|---|---|
| Resource, usage, and execution constraints | [AffineScript](https://github.com/hyperpolymath/affinescript), [Ephapax](https://github.com/hyperpolymath/ephapax), [Eclexia](https://github.com/hyperpolymath/eclexia), [Oblíbený](https://github.com/hyperpolymath/oblibeny) |
| Normative, social, and timing constraints | [Phronesis](https://github.com/hyperpolymath/phronesis), [WokeLang](https://github.com/hyperpolymath/wokelang), [Anvomidav](https://github.com/hyperpolymath/anvomidav) |
| Computation and learning | [My-Lang](https://github.com/hyperpolymath/my-lang), [betlang](https://github.com/hyperpolymath/betlang), [JtV](https://github.com/hyperpolymath/jtv), [Error-Lang](https://github.com/hyperpolymath/error-lang) |
| Equivalence, properties, and change | [Tangle](https://github.com/hyperpolymath/tangle), [Haec](https://github.com/hyperpolymath/haec), [Firmboot](https://github.com/hyperpolymath/firmboot) |
| Domain-specific / restricted entries | [KitchenSpeak](https://github.com/hyperpolymath/kitchenspeak) (experimental DSL); 007 (private, index-only); TypeFix Zero (private, exploratory) |

## Important distinctions

- **Firmboot** is a continuity-research prototype. Its current proof and runner status belongs in its own repository; the coordinator records it without assigning a readiness grade.
- **My-Lang** has nested dialects Solo ⊂ Duet ⊂ Ensemble. “Me” is an agent-generated projection, not an additional dialect.
- **KitchenSpeak** is experimental and standalone; no old in-tree implementation is canonical.
- **007** is private and index-only. This directory deliberately has no private repository link or source details.
- **TypeFix Zero** is exploratory and private, not a committed language-family member.

## Related projects (not additional core entries)

See [[Ecosystem-Connections]] for AffineScript syntax surfaces, Kategoria, Panoply, shared libraries and targets, `*-iser` tools, and educational projects. This keeps the scoped portfolio distinct from the larger estate.

## How to compare projects

1. Start from a language's own README and roadmap.
2. Check its tests and proofs separately; a proof of a model is not automatically proof of a compiler or runtime.
3. Use [Tooling & Integration Status](../TOOLING-STATUS.adoc) and the [dated audit](../docs/audits/2026-09-07-language-portfolio.md) as snapshots, not live build guarantees.
4. Treat `TBD` as “not verified here,” never as a grade or a pass.
