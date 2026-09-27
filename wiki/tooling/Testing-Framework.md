<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000018
parent: 0199a001-0000-7000-8000-000000000001
position: 55
kind: page
tags:
  - tooling
  - testing
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
# Testing a Language Project

There is no shared test framework or conformance suite for the portfolio as a whole. Each canonical language repository defines its own tests and supported commands.

When assessing evidence, distinguish:

- unit tests for individual components;
- parser/type-checker or interpreter conformance tests;
- property-based, fuzz, or differential tests;
- end-to-end tests of a compiler or runtime;
- proof checking and correspondence between a formal model and implementation.

A passing test suite only supports the claims it actually exercises. Check the project's CI workflow, test instructions, and proof notes. Cross-language needs and known gaps are tracked in [TEST-NEEDS](../../TEST-NEEDS.adoc) and [PROOF-NEEDS](../../PROOF-NEEDS.adoc).
