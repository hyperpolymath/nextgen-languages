# julia-the-viper

> Systems programming with Harvard Architecture

**Status:** 📝 Placeholder - contributions welcome

## Overview

julia-the-viper is a systems programming language that enforces Harvard Architecture principles: strict separation between code and data memory spaces.

## Core Invariant

**Data and code occupy strictly separate memory spaces—no self-modifying code.**

## Key Features

- Code/data separation at language level
- Provably halting data transformations
- Static memory layout
- No runtime code generation

## Example

```rust
// Data segment - immutable at runtime
data {
  lookup_table: [u8; 256] = precomputed_values(),
  constants: Config = load_config(),
}

// Code segment - cannot write to data at runtime
code {
  fn transform(input: u8) -> u8 {
    data::lookup_table[input as usize]
  }

  fn process(buffer: &[u8]) -> Vec<u8> {
    buffer.iter().map(|b| transform(*b)).collect()
  }
}
```

## Security Benefits

| Property | Benefit |
|----------|---------|
| No code injection | Data can't become code |
| Predictable memory | Static layout analysis |
| Cache optimization | Separate I-cache/D-cache |
| Formal verification | Simpler memory model |

## Use Cases

- Embedded systems
- Security-critical code
- High-performance computing
- Firmware development

## Getting Started

```bash
cd julia-the-viper
cargo run
```

## See Also

- [[Oblíbený]] - Security guarantees
- [[Anvomidav]] - Formal verification
- [[Solo Language]] - Systems foundation
