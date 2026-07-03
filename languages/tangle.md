<!--
SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Tangle

> Programs are braids; equivalence is topological isotopy.

**Canonical repository:** [hyperpolymath/tangle](https://github.com/hyperpolymath/tangle)

A topologically inspired language: programs are represented as knots/braids and
program equivalence is defined by isotopy. The core type system is mechanised in
Lean. Tangle's IR (**TangleIR**) is also the canonical representation consumed by
the separate **KRL resolution stack** (`krl → TangleIR → VeriSimCore → Skein.jl /
quandledb`) — that database/resolution stack is tracked by the database estate, not
by this coordinator.

This coordinator only *indexes* the language. The implementation, specification, grammar,
examples, and live status live in the canonical repository above — not here. See also
[`../.machine_readable/LANGUAGES.a2ml`](../.machine_readable/LANGUAGES.a2ml) and
[`../TOOLING-STATUS.adoc`](../TOOLING-STATUS.adoc).
