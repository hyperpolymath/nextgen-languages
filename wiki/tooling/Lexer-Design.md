<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000015
parent: 0199a001-0000-7000-8000-000000000001
position: 52
kind: page
tags:
  - tooling
  - lexer
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
# Lexer Design: A General Orientation

A lexer (or scanner) turns source characters into tokens. Whether a language uses a separate lexer, parser combinators, scannerless parsing, or another approach is an implementation-specific decision.

When exploring a language implementation, look for rules about identifiers, numbers, strings, comments, whitespace, source positions, malformed input, and Unicode. A useful test suite checks both accepted forms and precise failure locations.

This page describes general concepts only; it does not specify the grammar of any portfolio language. For a real grammar, use that project's canonical repository from the [language index](../../languages/README.adoc).
