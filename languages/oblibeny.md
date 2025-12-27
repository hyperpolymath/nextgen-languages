# Oblíbený

> Provably secure code for hostile environments.

## Invariant

**All programs must provably terminate—no unbounded recursion, no infinite loops.**

## Example

```scheme
(forbid recursion)

(bounded-for i 0 100
  (process-byte (read-input i)))
```

## Run

```bash
cargo run
```

## Status

🔴 DIVERGED - 40+ commits on GitLab, 30 on GitHub, needs manual merge
