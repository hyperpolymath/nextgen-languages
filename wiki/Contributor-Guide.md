<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000004
parent: 0199a001-0000-7000-8000-000000000001
position: 30
kind: page
tags:
  - contributing
  - coordinator
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk> -->
# Contributor Guide: Work on the Coordinator

This repository is a *pure coordinator*. Do not add compilers, language source, grammars, formal proofs, detailed language specifications, or per-language tutorials here. Work on those in the appropriate canonical project repository.

## Changes that belong here

- cross-language navigation, indexes, status, and evidence audits;
- documentation that genuinely spans projects or describes a relationship;
- governance, coordinator tooling, and registry validation;
- BerryWiki-compatible portfolio-level wiki pages.

## Before changing the registry

1. Check `.machine_readable/LANGUAGES.a2ml` and `languages/`.
2. Confirm the repository URL, project owner, status, and visibility with the canonical repository.
3. Decide whether the item is actually a language-family member or a *surface, library, target, tool, curriculum, or adjacent research project*.
4. If it is a member, update all registry surfaces together and run `bash hooks/validate-language-registry.sh`.
5. Never expose private project URLs or details without authorization.

## Checks

From the repository root:

```sh
bash hooks/validate-language-registry.sh
bash hooks/validate-coordinator-boundary.sh
```

See [CONTRIBUTING](../.github/CONTRIBUTING.md) and [GOVERNANCE](../GOVERNANCE.adoc) for the repository's contribution and decision processes. This page is an orientation, not a replacement for them.

## Editing the wiki with BerryWiki

The Markdown pages use BerryWiki's hidden metadata block. They remain normal Markdown files and do not need BerryWiki to read or edit them. BerryWiki is an optional tool maintained in the Metadatastician estate; this coordinator does not depend on that application being available.
