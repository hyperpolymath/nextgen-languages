<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000021
parent: 0199a001-0000-7000-8000-000000000001
position: 80
kind: page
tags:
  - contributing
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
# Contributing

First choose the correct canonical repository. This coordinator accepts cross-language maps, registry and status maintenance, evidence audits, navigation, and governance changes. Compiler, grammar, proof, language-specific tutorial, and implementation changes belong in their owning repositories.

## For this coordinator

1. Read the repository's [CONTRIBUTING](../../.github/CONTRIBUTING.md) and [GOVERNANCE](../../GOVERNANCE.adoc) documents.
2. Keep registry and human-pointer surfaces synchronized; run `bash hooks/validate-language-registry.sh`.
3. Run `bash hooks/validate-coordinator-boundary.sh` and `git diff --check`.
4. Scope claims to their evidence and date; do not expose private-project information.

For practical boundaries, see [[Contributor-Guide]].
