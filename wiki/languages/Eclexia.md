# Eclexia

> Sustainable Software Engineering through resource-first constraints

**Status:** 📝 Placeholder - contributions welcome

**Note:** Priority sync from GitLab required - 70-page white paper exists there.

## Overview

Eclexia makes resource consumption a first-class concern in software design. Energy budgets, memory limits, and computational constraints are expressed declaratively.

## Core Invariant

**No computation proceeds without an explicit resource budget.**

## Key Features

- `(energy budget ...)` - Energy consumption constraints
- `(resource ...)` - Resource requirement specification
- Compile-time resource analysis
- Carbon-aware scheduling

## Example

```eclexia
(program sensor-aggregation
  (energy budget 100mJ per-invocation)
  (resource memory 64KB)
  (resource cpu-cycles 10000)

  (define (aggregate readings)
    (resource memory 1KB)
    (fold + 0 readings))

  (define (transmit data)
    (energy budget 50mJ)
    (radio-send data)))

;; Compiler rejects if budget exceeded
```

## Use Cases

- Green computing / sustainable software
- IoT and embedded systems
- Cloud cost optimization (FinOps)
- Battery-constrained devices
- Carbon-aware computing

## Getting Started

```bash
cd eclexia
cargo run
```

## Related Work

- Green Software Foundation principles
- Carbon-aware SDK
- Energy-proportional computing research

## See Also

- [[Oblíbený]] - Security constraints (complementary)
- [[Anvomidav]] - Timing constraints (complementary)
