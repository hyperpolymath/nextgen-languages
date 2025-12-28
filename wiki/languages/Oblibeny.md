# Oblíbený

> Provably secure code for hostile environments

**Status:** 📝 Placeholder - contributions welcome

## Overview

Oblíbený (Czech for "favorite" or "beloved") produces provably secure, intentionally Turing-incomplete code for deployment in hostile environments. By restricting expressiveness, it guarantees termination and eliminates entire classes of vulnerabilities.

## Core Invariant

**All programs must provably terminate—no unbounded recursion, no infinite loops.**

## Key Features

- `(forbid recursion)` - Explicit recursion prohibition
- `(bounded-for ...)` - Bounded iteration only
- Turing-incomplete by design
- Formal termination proofs

## Example

```oblibeny
(module crypto-verify
  (forbid recursion)
  (forbid dynamic-allocation)

  (define (verify-signature sig msg key)
    (bounded-for i 0 256
      (let byte (get-byte msg i))
      (accumulate (hash-step byte))))

  (define (constant-time-compare a b)
    (bounded-for i 0 32
      (xor-accumulate (get-byte a i) (get-byte b i)))
    (is-zero? accumulator)))
```

## Use Cases

- Hardware Security Modules (HSMs)
- Secure enclaves (SGX, TrustZone)
- Smart card programming
- Cryptographic implementations
- High-assurance embedded systems

## Guarantees

| Property | Guarantee |
|----------|-----------|
| Termination | Proven at compile time |
| Memory safety | No dynamic allocation |
| Timing safety | Constant-time operations |
| Control flow | No indirect jumps |

## Getting Started

```bash
cd oblibeny
cargo run
```

## See Also

- [[Anvomidav]] - Real-time guarantees
- [[Eclexia]] - Resource constraints
- [[NEUROSYM.scm]] - Verification framework
