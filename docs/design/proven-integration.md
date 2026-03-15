# Proven Library Integration Plan

This document outlines how the [proven](https://github.com/hyperpolymath/proven) library's formally verified modules integrate with the Next-Gen Languages ecosystem.

**Note:** Several Next-Gen Languages (especially Anvomidav and Duet) have formal verification as core features. The proven library provides shared verification infrastructure.

## Per-Language Integration

### Anvomidav (Formal Verification Focus)

| Module | Use Case | Formal Guarantee |
|--------|----------|------------------|
| `SafeThm` | Theorem statement management | Well-typed propositions |
| `SafeLinear` | Linear type enforcement | Resource linearity |
| `SafeSession` | Session type checking | Protocol conformance |
| `SafeRealTime` | WCET analysis | Bounded execution time |

Anvomidav's type system directly corresponds to proven modules:
- `Linear<T>` → SafeLinear
- `Session<Protocol>` → SafeSession
- `@sched(EDF)` → SafeRealTime

### Duet (AI-Assisted Verification)

| Module | Use Case | Formal Guarantee |
|--------|----------|------------------|
| `SafeProperty` | Property synthesis targets | Valid specifications |
| `SafeThm` | AI-generated proof validation | Proof soundness |
| `SafeOracle` | AI verification oracle | Trusted computation |

Duet's `@verify` and `@synth` annotations use proven as the verification backend.

### Phronesis (AI Ethics/Alignment)

| Module | Use Case | Formal Guarantee |
|--------|----------|------------------|
| `SafePolicy` | Ethical policy specification | Policy consistency |
| `SafeConstraint` | Value constraint checking | Constraint satisfaction |
| `SafeProvenance` | Decision audit trails | Accountability |

Phronesis agents use SafePolicy for ethical framework specification.

### Oblíbený (Secure Code)

| Module | Use Case | Formal Guarantee |
|--------|----------|------------------|
| `SafeBounded` | Turing-incomplete enforcement | Termination guarantee |
| `SafeFlow` | Information flow control | No data leakage |
| `SafeCrypto` | Cryptographic operations | Correct algorithm usage |

Oblíbený's `(forbid recursion)` maps to SafeBounded's termination proofs.

### Eclexia (Resource-Constrained)

| Module | Use Case | Formal Guarantee |
|--------|----------|------------------|
| `SafeResource` | Resource budget tracking | Budget compliance |
| `SafeEnergy` | Energy consumption proofs | Bounded energy use |
| `SafeMetric` | Resource metric validation | Valid measurements |

Eclexia's `(energy budget ...)` uses SafeEnergy for compile-time verification.

### Solo (Foundation Language)

| Module | Use Case | Formal Guarantee |
|--------|----------|------------------|
| `SafeContract` | Pre/post conditions | Contract satisfaction |
| `SafeConcurrent` | Concurrency safety | Race-freedom |
| `SafeEffect` | Effect tracking | Effect containment |

Solo's `where { pre: ..., post: ... }` uses SafeContract.

### Ensemble (AI-Native)

| Module | Use Case | Formal Guarantee |
|--------|----------|------------------|
| `SafeOracle` | AI model invocation | Trusted AI calls |
| `SafeEffect` | AI effect isolation | Effect boundaries |
| `SafeSchema` | Prompt validation | Well-formed prompts |

### WokeLang (Human-Centric)

| Module | Use Case | Formal Guarantee |
|--------|----------|------------------|
| `SafeConsent` | Consent tracking | Explicit consent |
| `SafePrivacy` | Privacy enforcement | Data protection |
| `SafeAccessibility` | A11y compliance | Accessibility checks |

## Shared Infrastructure

All Next-Gen Languages share these proven modules:

| Module | Shared Use Case |
|--------|-----------------|
| `SafeAST` | Common AST representation |
| `SafeType` | Type system foundations |
| `SafeCompile` | Compilation pipeline |
| `SafeError` | Error handling patterns |

## Implementation Strategy

1. **Core types**: Define common types in proven (SafeAST, SafeType)
2. **Per-language extensions**: Each language adds its specific modules
3. **Shared backend**: Compile proven modules to target runtimes
4. **Cross-language proofs**: Use proven as proof interchange format

## Status

- [ ] Define SafeAST for common representation
- [ ] Implement SafeLinear for Anvomidav
- [ ] Add SafePolicy for Phronesis
- [ ] Integrate SafeBounded for Oblíbený
- [ ] Create SafeEnergy for Eclexia
