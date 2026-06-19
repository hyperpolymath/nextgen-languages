<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# NextGen Languages Wiki

Welcome to the NextGen Languages ecosystem documentation.

## Quick Navigation

### Getting Started
- [[Installation]]
- [[Your First Program]]
- [[Choosing a Language]]
- [[IDE Setup]]

### Languages
Per-language guides live in each language's **own repo** — this coordinator no longer hosts
them (see [External Repositories](#external-repositories) below). Quick map:
- **My-Lang family** (`hyperpolymath/my-lang`): Solo → Duet → Ensemble. *Me* is not a fourth
  dialect — it is an agent-generated projection over that hierarchy.
- **Foundational**: betlang (probabilistic), jtv (systems / Harvard architecture)
- **Specialized**: Phronesis, Eclexia, Oblíbený, Anvomidav, WokeLang, AffineScript, Ephapax

### Tooling
- [[Lexer Design]]
- [[Parser Architecture]]
- [[Compiler Pipeline]]
- [[Interpreter Implementation]]
- [[REPL Guide]]
- [[Language Server Protocol]]
- [[Package Manager]]
- [[Build System]]

### Frameworks & Libraries
- [[Standard Library]]
- [[Web Framework]]
- [[GUI Framework]]
- [[Game Framework]]
- [[Data Science Libraries]]

### Tutorials
- [[Tutorial: Hello World]]
- [[Tutorial: Variables and Types]]
- [[Tutorial: Control Flow]]
- [[Tutorial: Functions]]
- [[Tutorial: Modules]]
- [[Tutorial: Testing]]
- [[Tutorial: Building Projects]]

### Reference
- [[Grammar Specifications]]
- [[AST Node Reference]]
- [[Standard Library API]]
- [[Error Messages]]
- [[Configuration]]

### Contributing
- [[How to Contribute]]
- [[Code Style Guide]]
- [[Testing Guidelines]]
- [[Documentation Guide]]
- [[Release Process]]

---

## About the Project

NextGen Languages is a family of programming languages designed to grow with learners from age 8 through professional practice. The ecosystem includes:

- **Educational progression**: Me → Solo → Duet → Ensemble
- **Specialized tools**: Languages for probabilistic programming, real-time systems, creative synthesis, and more
- **Unified tooling**: Shared infrastructure for all languages
- **Open ecosystem**: Community-driven development

## Repository Structure

```
nextgen-languages/          # This coordinator (references languages; contains none)
├── wiki/                   # Cross-language, language-agnostic docs (you are here)
├── docs/                   # Cross-language design & disambiguation notes
├── scripts/                # Coordinator utility scripts
├── language-status-tracker.jl     # Cross-language status tracker
├── ROADMAP.adoc            # Coordinator roadmap
├── .machine_readable/LANGUAGES.a2ml  # Language registry (points at the repos)
└── README.adoc             # Project overview
```

Each language is its own standalone repo — see **External Repositories** below. The
coordinator boundary (no language code in-tree) is enforced by
`hooks/validate-coordinator-boundary.sh`.

## External Repositories

| Repository | Description |
|------------|-------------|
| [my-lang](https://github.com/hyperpolymath/my-lang) | My-Lang — Solo / Duet / Ensemble dialect family |
| [affinescript](https://github.com/hyperpolymath/affinescript) | AffineScript — affine types → WASM |
| [ephapax](https://github.com/hyperpolymath/ephapax) | Ephapax — dyadic linear/affine types |
| [phronesis](https://github.com/hyperpolymath/phronesis) | Phronesis — agent ethics |
| [eclexia](https://github.com/hyperpolymath/eclexia) | Eclexia — resource-first computing |
| [oblibeny](https://github.com/hyperpolymath/oblibeny) | Oblíbený — Turing-incomplete deployment |
| [anvomidav](https://github.com/hyperpolymath/anvomidav) | Anvomidav — hard real-time |
| [wokelang](https://github.com/hyperpolymath/wokelang) | WokeLang — consent-first |
| [betlang](https://github.com/hyperpolymath/betlang) | betlang — probabilistic |
| [jtv](https://github.com/hyperpolymath/jtv) | JtV — systems, Harvard architecture |
| [error-lang](https://github.com/hyperpolymath/error-lang) | error-lang — pedagogical |
| [tangle](https://github.com/hyperpolymath/tangle) | Tangle (KRL) — topological |
| [kitchenspeak](https://github.com/hyperpolymath/kitchenspeak) | KitchenSpeak — experimental DSL |

## Project Status (2026-06-12)

- **KitchenSpeak** (experimental kitchen-orchestration DSL) was extracted to its own canonical
  repo [hyperpolymath/kitchenspeak](https://github.com/hyperpolymath/kitchenspeak); the in-tree
  snapshot has been removed. Per-language content now lives in each language's own repo
  (enforced by `hooks/validate-coordinator-boundary.sh`).
- **ReScript banned estate-wide** per the Hyperpolymath Standard (PR #69).
- **Estate standardization merged** (2026-06-12): flat contractiles under
  `.machine_readable/contractiles/` are now canonical (root `contractiles/` and
  `.machine_readable/*.contractile` retired, content ported), governance docs
  (GOVERNANCE.adoc, MAINTAINERS.adoc, CODEOWNERS) added, `agent_instructions/`
  renamed `bot_directives/`, `flake.nix` removed (Guix is the package manifest).
- **CodeQL cron** reduced weekly → monthly (standards#288).

## Getting Help

- [GitHub Issues](https://github.com/hyperpolymath/nextgen-languages/issues)
- [Discussions](https://github.com/hyperpolymath/nextgen-languages/discussions)
