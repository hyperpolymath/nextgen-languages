<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Phronesis

> Formal specification of ethical AI frameworks.

## Invariant

**Every AI decision must be traceable to explicitly declared values.**

## Example

```
Agent.SafetyBot
  Values:
    human_safety > task_completion
    transparency > efficiency

  EVALUATE(action) WHERE
    action.risk_level < threshold
```

## Run

```bash
mix deps.get
mix run
```

## Status

🔴 DIVERGED - GitLab has original design, GitHub has Elixir implementation
