<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000014
parent: 0199a001-0000-7000-8000-000000000001
position: 51
kind: page
tags:
  - tooling
  - interpreter
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
# Interpreter Implementation: A General Orientation

This is a language-agnostic overview. The portfolio has no common interpreter API, runtime, or shared value model; consult a language repository before assuming that it has an interpreter.

An interpreter may evaluate a syntax tree directly, compile to bytecode and run a virtual machine, or combine interpretation with other execution strategies. Implementation questions include:

- Which syntax and semantic checks are completed before execution?
- How are environments, scopes, values, and errors represented?
- How do effects, resource ownership, or nondeterminism appear at runtime?
- Are diagnostics and execution limits explicit?
- Which tests compare runtime behavior with the language specification?

A runtime is part of the language's own evidence story. Do not infer memory safety, termination, or equivalence to a formal model from the word “interpreter.” See the canonical project repository via the [language index](../../languages/README.adoc).
