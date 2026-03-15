# Ephapax: Dyadic Language Architecture

**Date:** 2026-02-07
**Status:** Architectural clarification

---

## Critical Understanding

**Ephapax is NOT a single language.**

**Ephapax is TWO sister languages** working together in a dyadic relationship:
1. **Ephapax-Linear** - Linear type system language
2. **Ephapax-Affine** - Affine type system language

They share common infrastructure but have distinct type systems and semantics.

---

## Dyadic Design Principles

### What "Dyadic" Means

- **Two languages, one repository**
- **Common core** shared by both
- **Language-specific features** for each
- **Unified tooling** with modes for each language
- **Interoperability** between the two languages

---

## Proposed Repository Structure

```
ephapax/
├── common/                    # SHARED infrastructure
│   ├── lexer/                 # Common lexer (both share syntax base)
│   ├── parser/                # Common parser structure
│   ├── ast/                   # Common AST types
│   ├── ir/                    # Common intermediate representation
│   ├── runtime/               # Common runtime features
│   └── stdlib-common/         # Shared standard library functions
│
├── linear/                    # EPHAPAX-LINEAR language
│   ├── typechecker/           # Linear type checker
│   ├── semantics/             # Linear semantics
│   ├── codegen/               # Linear-specific code generation
│   ├── stdlib/                # Linear-specific stdlib
│   └── examples/              # Linear examples (.eph-linear or .ephl)
│
├── affine/                    # EPHAPAX-AFFINE language
│   ├── typechecker/           # Affine type checker
│   ├── semantics/             # Affine semantics
│   ├── codegen/               # Affine-specific code generation
│   ├── stdlib/                # Affine-specific stdlib
│   └── examples/              # Affine examples (.eph-affine or .epha)
│
├── interop/                   # INTEROPERABILITY layer
│   ├── bridge/                # Linear ↔ Affine conversions
│   ├── ffi/                   # Foreign function interface
│   └── examples/              # Mixed linear+affine programs
│
├── tools/                     # UNIFIED tooling
│   ├── debugger/              # Common debugger
│   │   ├── linear-mode/       # Debugger mode for Linear
│   │   └── affine-mode/       # Debugger mode for Affine
│   ├── lsp/                   # Language server
│   │   ├── linear-support/    # LSP for Linear
│   │   └── affine-support/    # LSP for Affine
│   ├── formatter/             # Common formatter
│   ├── linter/                # Common linter with type-system-specific rules
│   └── repl/                  # REPL with language selection
│       ├── linear-repl/       # Linear REPL
│       └── affine-repl/       # Affine REPL
│
├── formal/                    # FORMAL verification
│   ├── coq/                   # Coq proofs
│   │   ├── Linear.v           # Linear type system soundness
│   │   ├── Affine.v           # Affine type system soundness
│   │   └── Dyadic.v           # Dyadic relationship proofs
│   └── idris2/                # Idris2 ABI definitions
│       ├── LinearABI.idr      # Linear ABI
│       ├── AffineABI.idr      # Affine ABI
│       └── CommonABI.idr      # Shared ABI
│
├── examples/                  # EXAMPLES
│   ├── linear/                # Pure linear examples
│   ├── affine/                # Pure affine examples
│   └── mixed/                 # Programs using both
│
└── docs/                      # DOCUMENTATION
    ├── linear-guide.md        # Linear language guide
    ├── affine-guide.md        # Affine language guide
    ├── dyadic-programming.md  # How to use both together
    └── type-system-comparison.md
```

---

## File Extension Strategy

**Option 1: Single extension with mode markers**
```
program.eph              # Default (Linear)
#!ephapax-linear         # Linear mode marker
#!ephapax-affine         # Affine mode marker
```

**Option 2: Distinct extensions**
```
program.ephl             # Ephapax Linear
program.epha             # Ephapax Affine
program.eph              # Mixed (both)
```

**Recommendation:** Use Option 2 for clarity

---

## Debugger Architecture

### Common Debugger Core
```rust
pub struct EphapaxDebugger {
    common: CommonDebugState,
    mode: LanguageMode,
}

pub enum LanguageMode {
    Linear(LinearDebugger),
    Affine(AffineDebugger),
    Mixed(MixedDebugger),
}
```

### Mode-Specific Features

**Linear Mode:**
- Track linear resources (must be used exactly once)
- Show linearity violations
- Inspect consumption points
- Verify no duplication or dropping

**Affine Mode:**
- Track affine resources (used at most once)
- Show borrowing relationships
- Inspect drop points
- Verify no duplication (dropping allowed)

**Mixed Mode:**
- Switch between modes
- Show interop boundaries
- Track conversions between Linear ↔ Affine

---

## Compiler CLI Interface

```bash
# Compile Linear program
ephapax compile --lang=linear program.ephl -o output

# Compile Affine program
ephapax compile --lang=affine program.epha -o output

# Compile mixed program
ephapax compile --lang=mixed program.eph -o output

# REPL for Linear
ephapax repl --lang=linear

# REPL for Affine
ephapax repl --lang=affine

# Debugger with Linear mode
ephapax debug --lang=linear program.ephl

# Debugger with Affine mode
ephapax debug --lang=affine program.epha
```

---

## State.scm Structure for Ephapax

```scheme
(state
  (metadata
    (project "ephapax")
    (architecture "dyadic")
    (languages 2))

  (project-context
    (name "ephapax")
    (tagline "Dyadic linear/affine type system languages")
    (dyadic-design
      ((linear (status 55) (description "Linear type system - use exactly once"))
       (affine (status 55) (description "Affine type system - use at most once"))
       (common (status 60) (description "Shared infrastructure"))
       (interop (status 30) (description "Linear ↔ Affine bridge")))))

  (components
    ((common
      ((lexer (status complete))
       (parser (status complete))
       (ast (status complete))
       (ir (status partial) (completion 60))
       (runtime (status partial) (completion 50))))
     (linear
      ((typechecker (status partial) (completion 60))
       (semantics (status partial) (completion 55))
       (codegen (status partial) (completion 40))
       (stdlib (status partial) (completion 50))))
     (affine
      ((typechecker (status partial) (completion 60))
       (semantics (status partial) (completion 55))
       (codegen (status partial) (completion 40))
       (stdlib (status partial) (completion 50))))
     (interop
      ((bridge (status partial) (completion 30))
       (ffi (status missing))))
     (tools
      ((debugger (status partial) (completion 40))
       (debugger-linear-mode (status partial) (completion 35))
       (debugger-affine-mode (status partial) (completion 35))
       (lsp (status missing))
       (formatter (status missing))
       (repl (status complete))))))

  (blockers
    (critical
      (typechecker-incomplete
        (impact "Cannot verify type safety for either language")
        (description "Both Linear and Affine typecheckers at 60%")))
    (high
      (interop-bridge-minimal
        (impact "Cannot mix Linear and Affine code effectively")
        (description "Bridge between languages at 30%")))))
```

---

## Development Priorities

### Phase 1: Complete Common Infrastructure (5-10 hours)
- Finish shared IR (60% → 100%)
- Complete common runtime (50% → 100%)

### Phase 2: Complete Typecheckers (15-20 hours)
- Linear typechecker (60% → 100%)
- Affine typechecker (60% → 100%)

### Phase 3: Unify Debugger (10-15 hours)
- Linear mode (35% → 100%)
- Affine mode (35% → 100%)
- Mode switching

### Phase 4: Interoperability (10-15 hours)
- Bridge (30% → 100%)
- FFI implementation
- Mixed program examples

### Phase 5: Tooling (15-20 hours)
- LSP with dual language support
- Formatter
- Linter

**Total to 100%:** ~55-80 hours

---

## Critical Insights

1. **Not dialects** - These are sister languages, not variants of one language
2. **Dyadic = Two working together** - They complement each other
3. **Common ≠ Identical** - Share infrastructure but distinct type systems
4. **Unified tooling** - One debugger with two modes, not two debuggers
5. **Interop is critical** - Must be able to use both in same program

---

## Questions for User

1. Should we rename ephapax to reflect dyadic nature? (e.g., "ephapax-dyad")?
2. File extensions: Prefer .ephl/.epha or .eph with markers?
3. Should Linear and Affine be callable from each other (interop), or separate runtimes?
4. Priority: Complete typecheckers first, or build interop bridge?

---

**This document clarifies Ephapax's unique dyadic architecture for AI agents.**
