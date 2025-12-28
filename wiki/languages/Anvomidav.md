# Anvomidav

> Maximalist formal verification for hard real-time systems

**Status:** 📝 Placeholder - contributions welcome

## Overview

Anvomidav combines linear types, session types, and dependent types to provide maximum formal guarantees for hard real-time systems. Every resource is tracked, every protocol is verified, every deadline is statically guaranteed.

## Core Invariant

**Every resource is tracked, every deadline is statically guaranteed.**

## Key Features

- `task @sched(EDF)` - Real-time task scheduling
- `Linear<T>` - Linear resource tracking
- `Π (...) . T` - Dependent type specifications
- Session types for protocol verification

## Example

```anvomidav
// Dependent type: vector of exactly n elements
type Vec(n: Nat, T: Type) = ...

// Linear type: must be used exactly once
fn open_sensor() -> Linear<SensorHandle> { ... }

// Real-time task with deadline
task @sched(EDF) @deadline(10ms) @wcet(5ms)
fn read_sensor(handle: Linear<SensorHandle>) -> Reading {
  let data = handle.read()  // handle consumed here
  process(data)
}

// Session type: protocol specification
session SensorProtocol {
  !Init.           // send init
  ?Ack.            // receive ack
  rec Loop {
    !Request.
    ?Data.
    Loop
  }
}
```

## Use Cases

- Avionics systems (DO-178C compliance)
- Autonomous vehicle control
- Medical device software
- Robotics control systems
- Nuclear and industrial control

## Type System

| Type Feature | Purpose |
|--------------|---------|
| Linear types | Resource safety |
| Session types | Protocol correctness |
| Dependent types | Value-level specs |
| Refinement types | Constraint encoding |

## Getting Started

```bash
cd anvomidav
cargo run
```

## See Also

- [[NEUROSYM.scm]] - Verification framework
- [[Oblíbený]] - Security guarantees
- [[Testing Framework]] - Echidna integration
