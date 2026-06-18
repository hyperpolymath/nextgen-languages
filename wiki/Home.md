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
- [[My-Language Family]]
  - [[Solo Language]] - Ages 8-10, first text-based programming
  - [[Duet Language]] - Ages 11-14, collaborative programming
  - [[Ensemble Language]] - Ages 15-18, full-featured
  - [[Me Language]] - not a fourth dialect: an agent-generated projection over the Solo / Duet / Ensemble hierarchy
- [[Foundational Languages]]
  - [[betlang]] - Probabilistic programming
  - [[jtv]] - Systems programming, Harvard Architecture
- [[Specialized Languages]]
  - [[Phronesis]] - Practical wisdom
  - [[Eclexia]] - Creative synthesis
  - [[Oblíbený]] - Preference modeling
  - [[Anvomidav]] - Real-time systems
  - [[WokeLang]] - Social awareness

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
nextgen-languages/          # This hub repository
├── betlang/                # Submodule: Probabilistic language
├── jtv/        # Submodule: Systems language
├── kitchenspeak/           # In-tree DSL: kitchen orchestration, Agda proofs-first
├── wiki/                   # Documentation (you are here)
├── scripts/                # Utility scripts
├── ROADMAP.adoc            # Development roadmap
├── .machine_readable/LANGUAGES.a2ml  # Language registry
└── README.adoc             # Project overview
```

## External Repositories

| Repository | Description |
|------------|-------------|
| [solo](https://github.com/hyperpolymath/solo) | Solo language implementation |
| [duet](https://github.com/hyperpolymath/duet) | Duet language implementation |
| [ensemble](https://github.com/hyperpolymath/ensemble) | Ensemble language implementation |
| [phronesis](https://github.com/hyperpolymath/phronesis) | Phronesis language |
| [eclexia](https://github.com/hyperpolymath/eclexia) | Eclexia language |
| [oblibeny](https://github.com/hyperpolymath/oblibeny) | Oblíbený language |
| [anvomidav](https://github.com/hyperpolymath/anvomidav) | Anvomidav language |
| [wokelang](https://github.com/hyperpolymath/wokelang) | WokeLang |

## Project Status (2026-06-12)

- **KitchenSpeak** (in-tree kitchen-orchestration DSL) is developing proofs-first:
  Agda proofs (`Dough.agda`, `PoachedEgg.agda`, `EchoBridge.agda`) lead the
  implementation (ADR 0001), the Echo type attaches to Linear/Dyadic (ADR 0004),
  and the language is registered in `.machine_readable/LANGUAGES.a2ml` (PR #68).
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
