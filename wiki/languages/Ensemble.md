# Ensemble

> AI as a first-class, native component of the language

**Status:** 📝 Placeholder - contributions welcome

## Overview

Ensemble treats AI models as fundamental building blocks of software, not external services. Designed for ages 15-18 and professional use.

## Core Invariant

**AI operations are tracked in the type system as effects.**

## Key Features

- `ai_model { ... }` - First-class AI model definition
- `prompt { ... }` - Type-safe prompt construction
- `AI<T>` - AI operations as typed effects

## Example

```ensemble
ai_model Assistant {
  provider: "claude"
  capabilities: [text_generation, code_synthesis]
  constraints: { max_tokens: 4096 }
}

fn generate_summary(doc: Document) -> AI<Summary> {
  let prompt = prompt {
    system: "You are a technical writer."
    user: "Summarize: ${doc.content}"
  }

  Assistant.complete(prompt)
}

// AI effects are explicit in the return type
fn main() -> IO<()> {
  let summary = run_ai(generate_summary(doc))
  print(summary)
}
```

## Getting Started

```bash
cd my-lang
cargo run --bin ensemble
```

## Agent Development

See [[AGENTIC.scm]] for agent-oriented patterns in Ensemble.

## See Also

- [[My-Language Family]]
- [[Duet Language]]
- [[Tutorial: Mastering Ensemble]]
