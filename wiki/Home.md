<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000001
parent: null
position: 0
kind: page
tags:
  - index
  - portfolio
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk> -->
# Next-Generation Languages — Wiki Home

This wiki is the *orientation layer* for the Next-Generation Languages portfolio. It does not contain language implementations or replace project documentation. Each language's canonical repository is the source of truth for its grammar, compiler, proofs, examples, and current status.

## Start here

- [[Portfolio]] — the indexed projects, grouped by research area.
- [[Ecosystem-Connections]] — how languages, syntax surfaces, libraries, tools, and teaching projects relate.
- [[Contributor-Guide]] — what belongs in this coordinator and where work should go.

For the main repository front door, see [README.adoc](../README.adoc). The deeper architectural explanation is [EXPLAINME.adoc](../EXPLAINME.adoc).

## Quick orientation

`nextgen-languages` is a *coordinator*, not a monorepo. Its registry has 17 records: 16 committed portfolio entries plus one exploratory/private TypeFix Zero record. Adjacent language surfaces, foundations, tools, and curriculum projects are kept distinct. A project link means “go here to learn more,” not “these projects are integrated.”

- [Canonical language index](../languages/README.adoc)
- [Machine-readable registry](../.machine_readable/LANGUAGES.a2ml)
- [Portfolio map](../docs/ecosystem-map.adoc)
- [Tooling and evidence status](../TOOLING-STATUS.adoc)
- [Dated portfolio audit](../docs/audits/2026-09-07-language-portfolio.md)

## BerryWiki compatibility

These pages are plain Markdown with BerryWiki's hidden metadata block. They remain readable in ordinary Markdown viewers; BerryWiki is an optional authoring and navigation layer, not a runtime dependency. With BerryWiki installed, browse this local folder using `berrywiki serve ./wiki --no-commit`. This coordinator repository's `wiki/` folder is a BerryWiki-compatible notebook source, not the separate `metadatastician/berrywiki` application repository or a claim that content has been published to a GitHub `.wiki.git` remote. The pages intentionally stay portfolio-level rather than copying per-language specifications into the coordinator.

## Scope note

The public estate search on 2026-09-26 did not identify a public language repository named `ziz`. The name remains an unresolved discovery item, not an invented portfolio entry. If it refers to a private project, do not publish a link or private details here without an approved visibility-safe pointer.
