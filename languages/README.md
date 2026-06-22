<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Language Quick Reference

Each language has one core invariant that defines its design philosophy.

| Language | Invariant |
|----------|-----------|
| [my-lang](my-lang.md) | Each level builds exactly on the previous |
| [phronesis](phronesis.md) | Every AI decision traces to declared values |
| [eclexia](eclexia.md) | No computation without explicit resource budget |
| [oblibeny](oblibeny.md) | All programs must provably terminate |
| [anvomidav](anvomidav.md) | Every deadline is statically guaranteed |
| [wokelang](wokelang.md) | No operation without explicit consent |
| [betlang](betlang.md) | All uncertainty must be explicitly modeled |
| [jtv](jtv.md) | Data and code are strictly separated |
| [affinescript](affinescript.md) | Every resource is used at most once |
| [ephapax](ephapax.md) | Every value can be consumed exactly once |
| [haec](haec.md) | Every quality-loss is graded and checked against its use |

Each row links to a thin pointer; the language itself lives in its own
`hyperpolymath/<lang>` repo. For cross-language status see
[`../TOOLING-STATUS.adoc`](../TOOLING-STATUS.adoc),
[`../.machine_readable/LANGUAGES.a2ml`](../.machine_readable/LANGUAGES.a2ml), and
[`../language-status-tracker.jl`](../language-status-tracker.jl).
