<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000019
parent: 0199a001-0000-7000-8000-000000000001
position: 60
kind: page
tags:
  - libraries
  - overview
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
# Libraries and Runtime Facilities

The portfolio does not define or ship a common standard library. Each language repository documents its own built-in functions, packages, runtime facilities, and compatibility policy (if any).

Before relying on an API, check its owning project for:

- whether it is part of the language, a separate package, or an experiment;
- supported platforms and versions;
- resource, effect, capability, or security assumptions;
- release and compatibility guarantees;
- tests and documentation for the specific behavior you need.

For shared infrastructure that is not itself a language, see [Ecosystem Connections](../Ecosystem-Connections.md). The [language index](../../languages/README.adoc) links to canonical project documentation.
