<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000003
parent: 0199a001-0000-7000-8000-000000000001
position: 20
kind: page
tags:
  - ecosystem
  - relationships
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk> -->
# Ecosystem Connections

Projects around the portfolio have different roles. The link is useful for discovery, but is not itself proof of integration. For a larger directory, see [the ecosystem map](../docs/ecosystem-map.adoc).

## AffineScript syntax surfaces

The estate describes [CafeScripto](https://github.com/hyperpolymath/cafescripto), [JaffaScript](https://github.com/hyperpolymath/jaffascript), [LucidScript](https://github.com/hyperpolymath/lucidscript), [PseudoScript](https://github.com/hyperpolymath/pseudoscript), and [RattleScript](https://github.com/hyperpolymath/rattlescript) as familiar-syntax surface projects in the AffineScript direction. They are not five additional core portfolio entries. Their own repositories are authoritative for what each surface actually implements.

## Foundations and neighboring research

- [typed-wasm](https://github.com/hyperpolymath/typed-wasm) is a WasmGC target and ABI/type-layout project, not a language.
- [echo-types](https://github.com/hyperpolymath/echo-types) and [EchoTypes.jl](https://github.com/hyperpolymath/EchoTypes.jl) provide a formal library and an executable companion model, respectively; the latter is not a proof.
- [Kategoria](https://github.com/hyperpolymath/kategoria) explores approaches and levels in language/type-safety design.
- [Panoply](https://github.com/hyperpolymath/panoply) is an envelope-first safety-claim discipline. It is adjacent to language engineering, not a registered core language here.

## Tools and education

Projects such as [affinescriptiser](https://github.com/hyperpolymath/affinescriptiser), [eclexiaiser](https://github.com/hyperpolymath/eclexiaiser), [ephapaxiser](https://github.com/hyperpolymath/ephapaxiser), and [wokelangiser](https://github.com/hyperpolymath/wokelangiser) apply selected ideas as separate tools. Each has its own status; do not assume an `-iser` has the same capabilities or maturity as its parent language.

[tentacles-agentic-syllabus](https://github.com/hyperpolymath/tentacles-agentic-syllabus) is a curriculum framework, while [nextgen-language-evangeliser](https://github.com/hyperpolymath/nextgen-language-evangeliser) is an educational toolkit. Neither is a language implementation. Teaching content should be followed from its canonical home rather than copied into this coordinator.

## Similar names and uncertain lineage

The portfolio uses [hyperpolymath/jtv](https://github.com/hyperpolymath/jtv) as its JtV canonical pointer. A separate [hyperpolymath/jtv-lang](https://github.com/hyperpolymath/jtv-lang) repository describes related research, but its lineage/canonical status has not been reconciled here. Treat it as an open owner decision, not a confirmed alias or a second language entry.

A public estate search did not resolve `hyperpolymath/ziz` or identify a language project named `ziz`. No language page or registry entry is created from the name alone. Add it when its canonical URL, privacy policy, and relationship to this portfolio can be confirmed.

## Connection vocabulary

| Label | Meaning |
|---|---|
| Dependency | A project declares and exercises another project as a dependency. |
| Shared substrate | A library, target, or standard may be used by more than one project; consumers must be verified individually. |
| Syntax surface | A distinct syntax/front end explores a related language or core. |
| Tool | An external analyzer, adapter, or transformation tool; not the parent language. |
| Curriculum | Teaching framework or material; not a language implementation. |
| Research adjacency | Related question or design space, without asserting a technical dependency. |
