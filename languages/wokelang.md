<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# WokeLang

> Human-centric programming focused on consent and well-being.

## Invariant

**No sensitive operation executes without explicit user consent.**

## Example

```
only if okay "May I access your location?" {
  location = get_location()
}

attempt {
  send_data(payload)
} or reassure "Don't worry, we'll try again later."
```

## Run

```bash
cargo run
```

## Status

🔴 DIVERGED - GitLab has original design, GitHub has Rust bytecode VM
