<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000016
parent: 0199a001-0000-7000-8000-000000000001
position: 53
kind: page
tags:
  - tooling
  - parser
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
# Parser Architecture: A General Orientation

A parser recognises a language's syntax and often constructs an AST or another representation. Parser architecture, grammar, error recovery, and source-location strategy are specific to each language; this coordinator does not define them.

When reading a parser, check how precedence and associativity are expressed, how ambiguous or malformed input is handled, whether error messages retain source spans, and how the parser's accepted language is tested against its specification.

This is a conceptual guide, not a grammar or implementation recipe. See the canonical project repository from the [language index](../../languages/README.adoc).
