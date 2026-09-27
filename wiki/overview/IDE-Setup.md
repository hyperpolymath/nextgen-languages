<!-- berrywiki
id: 0199a001-0000-7000-8000-000000000012
parent: 0199a001-0000-7000-8000-000000000001
position: 42
kind: page
tags:
  - overview
  - editors
archived: false
-->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
# Editor and IDE Setup

This portfolio does not ship a unified editor extension, language server, debugger, or file-extension standard. Tool support differs by project and may be experimental.

## Configure an editor safely

1. Check the language's canonical repository for an official LSP, formatter, syntax package, or editor extension.
2. Install only the tool and version documented there.
3. Treat community syntax highlighting as presentation support, not evidence of parsing or type-checking.
4. If no official extension is listed, use a plain-text editor and the project's documented CLI rather than assuming a shared `nextgen` command.

For the project's repository, start at the [language index](../../languages/README.adoc). For coordinator development, see the [contributor quick start](../../QUICKSTART-DEV.adoc).
