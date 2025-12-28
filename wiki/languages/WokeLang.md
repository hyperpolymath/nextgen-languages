# WokeLang

> Human-centric programming focused on consent and well-being

**Status:** 📝 Placeholder - contributions welcome

## Overview

WokeLang prioritizes the human experience in programming. It uses natural language constructs, explicit consent mechanisms, and supportive error handling to make programming accessible and psychologically safe.

## Core Invariant

**No sensitive operation executes without explicit user consent.**

## Key Features

- `only if okay "..."` - Explicit consent for operations
- `attempt ... or reassure` - Supportive error recovery
- Natural language syntax
- Accessibility-first design

## Example

```wokelang
// Consent-based data access
only if okay "May I access your location to show nearby events?" {
  location = get_location()
  events = find_events_near(location)
  display(events)
}

// Supportive error handling
attempt {
  data = fetch_from_server()
  process(data)
} or reassure "That's okay! The server seems busy right now. Would you like to try again, or shall we use cached data?"

// Inclusive variable naming
let user_preference = ask "How would you like to be addressed?"
greet using user_preference
```

## Design Principles

1. **Consent is explicit** - Never assume permission
2. **Errors are supportive** - No blame, offer help
3. **Language is inclusive** - Accessible to all
4. **Feedback is constructive** - Guide, don't criticize

## Use Cases

- Educational programming for beginners
- Accessibility-focused applications
- Mental health technology
- Personal scripting
- Gentle introduction to coding

## Getting Started

```bash
cd wokelang
cargo run
```

## See Also

- [[My-Language Family]] - Educational progression
- [[Tutorial: Hello World]]
- [[AGENTIC.scm]] - Human-agent interaction patterns
