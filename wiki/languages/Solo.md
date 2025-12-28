# Solo

> Dependable foundation for systems programming

**Status:** 📝 Placeholder - contributions welcome

## Overview

Solo is the foundational text-based language in the my-lang family, designed for ages 8-10 as their first transition from visual to text-based programming.

## Core Invariant

**Effects are always explicit—no hidden side effects.**

## Key Features

- `effect { ... }` - Explicit effect tracking
- `go { ... }` - Structured concurrency
- `where { pre: ..., post: ... }` - Design-by-contract

## Example

```solo
fn greet(name: String) -> String
  effect { console }
  where { pre: name.length > 0 }
{
  console.print("Hello, ")
  console.print(name)
  return "greeted"
}
```

## Getting Started

```bash
cd my-lang
cargo run --bin solo
```

## Progression

Solo is part of the [[My-Language Family]] progression:

```
Me (ages 6-8) → Solo (ages 8-10) → Duet (ages 11-14) → Ensemble (ages 15-18)
```

## See Also

- [[My-Language Family]]
- [[Duet Language]]
- [[Tutorial: Starting with Solo]]
