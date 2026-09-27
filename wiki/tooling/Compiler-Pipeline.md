<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000013
parent: 0199a001-0000-7000-8000-000000000001
position: 50
kind: page
tags:
  - tooling
  - compiler
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
# Compiler Pipeline: A General Orientation

There is no shared compiler pipeline or common intermediate representation across this portfolio. Individual repositories choose their own architecture and may not implement every stage below.

A compiler or interpreter project commonly contains some of these conceptual stages:

1. **Source handling** — text, files, modules, and diagnostics.
2. **Lexing and parsing** — tokens and a syntax tree, unless another representation is used.
3. **Elaboration and checking** — name resolution, types, effects, resources, or domain-specific constraints.
4. **Lowering** — one or more internal representations, if useful to the implementation.
5. **Execution or code generation** — interpreter, virtual machine, native or portable target.

This list is a vocabulary for reading an implementation, not a claim that a particular language has these components. Follow that project's build instructions and architectural docs. See [[Lexer-Design]], [[Parser-Architecture]], and the [ecosystem map](../../docs/ecosystem-map.adoc).
