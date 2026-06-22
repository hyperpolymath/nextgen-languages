<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Haec

> Every quality-loss is graded and checked against its use.

**Canonical repository:** [hyperpolymath/haec](https://github.com/hyperpolymath/haec)

Haec is a Turing-complete language whose type discipline is *trope-particularity*:
every operation on a *property-instance* (a quality as borne by _this_ entity, in
_this_ context) carries a *loss-shape grade*, and the surviving residue is judged
against a declared *use-model*. Haec is one **front-end** of a three-repo system —
it lowers programs to a language-neutral **Trope IR**; it defines neither the
checker nor the vocabulary:

- [hyperpolymath/trope-checker](https://github.com/hyperpolymath/trope-checker) —
  the portable checker (Idris2 verified core + executable) that consumes the Trope
  IR and returns a verdict (`p-sufficient` / `p-insufficient`) with a witness edge.
- [hyperpolymath/trope-particularity-workbench](https://github.com/hyperpolymath/trope-particularity-workbench) —
  the informal vocabulary (the nine named effects, the residual, the verdict).

Shares the *irreversible-transformation-with-retained-residue* substrate with
[`echo-types`](https://github.com/hyperpolymath/echo-types) (the graded-loss reading
the calculus builds on).

This coordinator only *indexes* the language. The implementation, specification,
grammar, examples, and live status live in the canonical repositories above — not
here. See also [`../.machine_readable/LANGUAGES.a2ml`](../.machine_readable/LANGUAGES.a2ml)
and [`../TOOLING-STATUS.adoc`](../TOOLING-STATUS.adoc).
