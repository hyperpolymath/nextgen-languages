<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# KitchenSpeak

> Formally-verified, hardware-agnostic orchestration for the domestic kitchen.

## Invariant

**Every ingredient is consumed exactly once, every loop terminates on a wall-clock bound, and every physical step is witnessed by a local sensor.**

## Example

```kitchenspeak
sync(Delia_Hob) proving @white_set {
    Delia_Hob.Poach(Egg, acidulant: Vinegar, depth: 4cm)
        until @white_set == true
        max_duration 4min
        on_fail RECOVER;
}
```

The `Egg` is a linear resource consumed by this call; `@white_set` is a
postulated visual witness; `max_duration` is the termination measure;
`on_fail RECOVER` is the total failure handler.

## Run

```bash
# This snapshot is specification-only at v1.0.
# Canonical home + runnable v2.0 toolchain: https://github.com/hyperpolymath/kitchenspeak
```

## Status

**EXTRACTED — canonical home is the standalone repository
[`hyperpolymath/kitchenspeak`](https://github.com/hyperpolymath/kitchenspeak).**
The `kitchenspeak/` subtree in this monorepo is a frozen v1.0 snapshot (see
`kitchenspeak/MOVED.adoc`); the **v2.0 elevation** (physics-in-the-types — curdle,
scorch, bake-the-spatula and over-torque are compile errors — plus a reference
OCaml compiler and machine-checked proofs) lives in the standalone repo.
