# Language Manifest

> Quick reference for all languages in the NextGen Languages ecosystem.

## Summary

| Language | Status | Domain | Implementation | Run Command |
|----------|--------|--------|----------------|-------------|
| [Solo](#solo) | 🟡 TO VERIFY | Systems Programming | Rust | `cargo run` |
| [Duet](#duet) | 🟡 TO VERIFY | AI-Assisted Dev | Rust | `cargo run` |
| [Ensemble](#ensemble) | 🟡 TO VERIFY | AI-Native Apps | Rust | `cargo run` |
| [Phronesis](#phronesis) | 🔴 DIVERGED | AI Ethics/Safety | Elixir | `mix run` |
| [Eclexia](#eclexia) | 🔴 NOT SYNCED | Sustainable Computing | Rust | `cargo run` |
| [Oblíbený](#oblíbený) | 🔴 DIVERGED | Security-Critical | Rust | `cargo run` |
| [Anvomidav](#anvomidav) | ⚠️ NAMING ISSUE | Real-Time Systems | LLVM/Rust | `cargo run` |
| [WokeLang](#wokelang) | 🔴 DIVERGED | Human-Centric | Rust | `cargo run` |
| [betlang](#betlang) | 🟡 TO VERIFY | Probabilistic | Racket | `racket main.rkt` |
| [julia-the-viper](#julia-the-viper) | 🟡 TO VERIFY | Systems (Harvard Arch) | Rust | `cargo run` |
| [AffineScript](#affinescript) | 🟡 TO VERIFY | Type-Safe WASM | OCaml | `dune exec` |
| [Ephapax](#ephapax) | 🟡 TO VERIFY | Linear Semantics | Scheme-like | TBD |

### Status Legend
- 🟢 **SYNCED** - GitHub is up-to-date, ready to use
- 🟡 **TO VERIFY** - Needs sync verification
- 🔴 **DIVERGED** - GitLab and GitHub have different implementations
- 🔴 **NOT SYNCED** - Only exists on GitLab
- ⚠️ **NAMING ISSUE** - Naming conflict between forges

---

## Core Languages (The Eight)

### Solo
**Dependable foundation for systems programming**

| Property | Value |
|----------|-------|
| Status | 🟡 TO VERIFY |
| Paradigm | Imperative, Concurrent, Contract-Based |
| Implementation | Rust |
| Submodule | `my-lang/` (part of family) |

**Key Features:**
- `effect { ... }` - Explicit effect tracking
- `go { ... }` - Structured concurrency
- `where { pre: ..., post: ... }` - Design-by-contract

**Run:**
```bash
cd my-lang && git submodule update --init
cargo run
```

---

### Duet
**AI-assisted development for verifiable software**

| Property | Value |
|----------|-------|
| Status | 🟡 TO VERIFY |
| Paradigm | Imperative, Contract-Based, Neuro-Symbolic |
| Implementation | Rust |
| Submodule | `my-lang/` (part of family) |

**Key Features:**
- `@synth` - AI-powered code synthesis
- `@verify` - Formal verification
- `intent("...")` - Natural language intent

**Run:**
```bash
cd my-lang && git submodule update --init
cargo run --bin duet
```

---

### Ensemble
**AI as a first-class, native component**

| Property | Value |
|----------|-------|
| Status | 🟡 TO VERIFY |
| Paradigm | Imperative, AI-as-Effect |
| Implementation | Rust |
| Submodule | `my-lang/` (part of family) |

**Key Features:**
- `ai_model { ... }` - First-class AI models
- `prompt { ... }` - Type-safe prompts
- `AI<T>` - AI operations as typed effects

**Run:**
```bash
cd my-lang && git submodule update --init
cargo run --bin ensemble
```

---

### Phronesis
**Formal specification of ethical AI frameworks**

| Property | Value |
|----------|-------|
| Status | 🔴 DIVERGED |
| Paradigm | Declarative, Logic-Based, Agent-Oriented |
| Implementation | Elixir (GitHub), Original design (GitLab) |
| Submodule | `phronesis/` |

**Key Features:**
- `Agent.` - Formal agent specification
- `Values:` - Explicit value hierarchy
- `EVALUATE(...)` - Ethical decision evaluation

**Run:**
```bash
cd phronesis && git submodule update --init
mix deps.get && mix run
```

---

### Eclexia
**Sustainable Software Engineering through resource-first constraints**

| Property | Value |
|----------|-------|
| Status | 🔴 NOT SYNCED (Priority 1) |
| Paradigm | Declarative, Constraint-Driven |
| Implementation | Rust (on GitLab only) |
| Submodule | `eclexia/` |
| Notes | Has 70-page white paper on GitLab |

**Key Features:**
- `(energy budget ...)` - Energy consumption constraints
- `(resource ...)` - Resource requirement specs

**Run:**
```bash
# First sync from GitLab!
cd eclexia && git submodule update --init
cargo run
```

---

### Oblíbený
**Provably secure code for hostile environments**

| Property | Value |
|----------|-------|
| Status | 🔴 DIVERGED |
| Paradigm | Turing-Incomplete-Deploy, Metaprogramming |
| Implementation | Rust |
| Submodule | `oblibeny/` |

**Key Features:**
- `(forbid recursion)` - Guaranteed termination
- `(bounded-for ...)` - Bounded iteration only

**Run:**
```bash
cd oblibeny && git submodule update --init
cargo run
```

---

### Anvomidav
**Maximalist formal verification for hard real-time systems**

| Property | Value |
|----------|-------|
| Status | ⚠️ NAMING ISSUE (GitLab calls it "betlang") |
| Paradigm | Functional, Concurrent, Formal-Linear-Session-Types |
| Implementation | LLVM/Rust |
| Submodule | TBD |

**Key Features:**
- `task @sched(EDF)` - Real-time scheduling
- `Linear<T>` - Linear resource tracking
- `Π (...) . T` - Dependent types

**Run:**
```bash
# Resolve naming issue first
cargo run
```

---

### WokeLang
**Human-centric programming focused on consent and well-being**

| Property | Value |
|----------|-------|
| Status | 🔴 DIVERGED |
| Paradigm | Imperative, Natural-Language |
| Implementation | Rust (GitHub), Original design (GitLab) |
| Submodule | `wokelang/` |

**Key Features:**
- `only if okay "..."` - Explicit consent
- `attempt ... or reassure` - Supportive error handling

**Run:**
```bash
cd wokelang && git submodule update --init
cargo run
```

---

## Additional Languages

### betlang
**Probabilistic programming language**

| Property | Value |
|----------|-------|
| Status | 🟡 TO VERIFY |
| Paradigm | Probabilistic |
| Implementation | Racket |
| Submodule | `betlang/` |

**Run:**
```bash
cd betlang && git submodule update --init
racket main.rkt
```

---

### julia-the-viper
**Systems programming with Harvard Architecture**

| Property | Value |
|----------|-------|
| Status | 🟡 TO VERIFY |
| Paradigm | Systems, Provably Halting |
| Implementation | Rust |
| Submodule | `julia-the-viper/` |

**Run:**
```bash
cd julia-the-viper && git submodule update --init
cargo run
```

---

### AffineScript
**Affine types and dependent types for WASM**

| Property | Value |
|----------|-------|
| Status | 🟡 TO VERIFY |
| Paradigm | Functional, Type-Safe |
| Implementation | OCaml |
| Submodule | `affinescript/` |

**Run:**
```bash
cd affinescript && git submodule update --init
dune build && dune exec affinescript
```

---

### Ephapax
**Once-only evaluation with linear semantics**

| Property | Value |
|----------|-------|
| Status | 🟡 TO VERIFY |
| Paradigm | Linear, Security-Focused |
| Implementation | Scheme-like |
| Submodule | `ephapax/` |

**Run:**
```bash
cd ephapax && git submodule update --init
# Implementation-specific command TBD
```

---

## Tooling

### 7-tentacles
**Orchestration and satellite coordination tool**

| Property | Value |
|----------|-------|
| Status | Active |
| Submodule | `7-tentacles/` |

---

## Quick Start

```bash
# Clone with all submodules
git clone --recursive https://github.com/hyperpolymath/nextgen-languages.git

# Or initialize submodules after clone
git submodule update --init --recursive

# Check a specific language
cd <language-dir>
# Follow language-specific run instructions above
```

## Language Family Progression

The **my-lang** family provides an educational progression:

```
Me (ages 6-8)      → Visual/block-based programming
    ↓
Solo (ages 8-10)   → First text-based, simple syntax
    ↓
Duet (ages 11-14)  → AI-assisted, collaborative features
    ↓
Ensemble (ages 15-18) → Full-featured, AI-native, professional
```

---

## See Also

- `LANGUAGES.scm` - Detailed language specifications (Guile Scheme)
- `MIGRATION-STATUS.md` - Sync status between GitLab and GitHub
- `wiki/` - Full documentation
