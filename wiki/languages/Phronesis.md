# Phronesis

> Formal specification of ethical AI frameworks

**Status:** 📝 Placeholder - contributions welcome

## Overview

Named after the Aristotelian concept of practical wisdom, Phronesis provides a formal, auditable language for specifying AI agent ethics. It enables transparent reasoning about values, constraints, and decision-making.

## Core Invariant

**Every AI decision must be traceable to explicitly declared values.**

## Key Features

- `Agent.` - Formal agent specification
- `Values:` - Explicit value hierarchy declaration
- `EVALUATE(...)` - Decision evaluation framework

## Example

```phronesis
Agent.SafetyBot
  Identity:
    role: "Safety monitoring assistant"
    scope: "Industrial automation"

  Values:
    human_safety > property_protection > task_efficiency
    transparency > speed
    reversibility > finality

  Constraints:
    MUST NOT take actions that risk human harm
    MUST explain reasoning when asked
    SHOULD prefer reversible actions

  EVALUATE(action) WHERE
    risk_assessment(action) < acceptable_threshold
    AND stakeholder_consent(action) = true
    AND audit_log(action) = complete
```

## Use Cases

- AI safety research and alignment verification
- Regulatory compliance auditing
- Constitutional AI specification
- Ethical AI certification

## Getting Started

```bash
cd phronesis
mix deps.get
mix run
```

## See Also

- [[AGENTIC.scm]] - Agent-oriented specifications
- [[Eclexia]] - Resource constraints (complementary)
- [[Anvomidav]] - Formal verification (complementary)
