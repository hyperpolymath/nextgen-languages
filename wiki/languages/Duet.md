# Duet

> AI-assisted development for verifiable software

**Status:** 📝 Placeholder - contributions welcome

## Overview

Duet extends Solo with AI-assisted features, enabling a collaborative relationship between human programmers and AI systems. Designed for ages 11-14.

## Core Invariant

**AI-generated code is never trusted until formally verified.**

## Key Features

- `@synth` - AI-powered code synthesis with verification
- `@verify` - Formal verification of code properties
- `intent("...")` - Natural language intent specification

## Example

```duet
@synth
fn sort(list: List<Int>) -> List<Int>
where {
  post: is_sorted(result) && is_permutation(result, list)
}
// AI synthesizes implementation, verified against contract

@verify
fn binary_search(arr: List<Int>, target: Int) -> Option<Int>
where {
  pre: is_sorted(arr)
  post: result.is_some() implies arr[result.unwrap()] == target
}
{
  // Human-written, machine-verified
}
```

## Getting Started

```bash
cd my-lang
cargo run --bin duet
```

## Neuro-Symbolic Integration

See [[NEUROSYM.scm]] for details on how Duet bridges neural and symbolic AI.

## See Also

- [[My-Language Family]]
- [[Solo Language]]
- [[Ensemble Language]]
- [[Tutorial: Moving to Duet]]
