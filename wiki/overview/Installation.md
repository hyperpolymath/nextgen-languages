<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000011
parent: 0199a001-0000-7000-8000-000000000001
position: 41
kind: page
tags:
  - overview
  - setup
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
# Installation and Setup

There is no unified `nextgen` installer, package, compiler, or runtime in this coordinator. Install and build an individual language only by following its own canonical repository's current instructions.

## Find the right instructions

1. Select a project from [the language index](../../languages/README.adoc).
2. Open its canonical repository and follow its README and supported toolchain versions.
3. Check its own release and security notes before installing binaries or dependencies.

The coordinator itself needs Git and Bash for its registry and boundary checks; it does not install language implementations. See the [contributor quick start](../../QUICKSTART-DEV.adoc) for those checks.

No `curl | bash` installer or all-languages package is provided by this repository.
