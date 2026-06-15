<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Eclexia

> Sustainable Software Engineering through resource-first constraints.

## Invariant

**No computation proceeds without an explicit resource budget.**

## Example

```scheme
(energy budget 100mJ
  (resource memory 64KB)
  (compute matrix-multiply A B))
```

## Run

```bash
cargo run
```

## Status

🔴 NOT SYNCED (Priority 1) - 70-page white paper and Rust compiler exist only on GitLab
