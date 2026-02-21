<!-- SPDX-License-Identifier: PMPL-1.0-or-later -->
<!-- TOPOLOGY.md — Project architecture map and completion dashboard -->
<!-- Last updated: 2026-02-19 -->

# Next-Gen Languages — Project Topology

## System Architecture

```
                        ┌─────────────────────────────────────────┐
                        │              LANGUAGE DESIGNER          │
                        │        (Specs, Metaprogramming, FFI)    │
                        └───────────────────┬─────────────────────┘
                                            │
                                            ▼
                        ┌─────────────────────────────────────────┐
                        │           NEXT-GEN LANGUAGES HUB        │
                        │                                         │
                        │  ┌───────────┐  ┌───────────────────┐  │
                        │  │ Solo/Duet │  │  Phronesis        │  │
                        │  │ (Systems) │  │  (Ethics/Safety)  │  │
                        │  └─────┬─────┘  └────────┬──────────┘  │
                        │        │                 │              │
                        │  ┌─────▼─────┐  ┌────────▼──────────┐  │
                        │  │ Eclexia   │  │  WokeLang         │  │
                        │  │ (Green)   │  │  (Human-centric)  │  │
                        │  └─────┬─────┘  └───────────────────┘  │
                        └────────│────────────────────────────────┘
                                 │
                                 ▼
                        ┌─────────────────────────────────────────┐
                        │          SATELLITE REPOSITORIES         │
                        │  ┌───────────┐  ┌───────────┐  ┌───────┐│
                        │  │ anvomidav │  │ oblibeny  │  │ ephapax││
                        │  └───────────┘  └───────────┘  └───────┘│
                        │  ┌───────────┐  ┌───────────┐  ┌───────┐│
                        │  │ betlang   │  │ error-lang│  │ tangle ││
                        │  └───────────┘  └───────────┘  └───────┘│
                        └───────────────────┬─────────────────────┘
                                            │
                                            ▼
                        ┌─────────────────────────────────────────┐
                        │          DATABASE & MARKUP              │
                        │      (GQL-dt, A2ML, fqldt, a2ml)        │
                        └─────────────────────────────────────────┘

                        ┌─────────────────────────────────────────┐
                        │          REPO INFRASTRUCTURE            │
                        │  Parent Tracking Only .machine_readable/│
                        │  6SCM Metadata        0-AI-MANIFEST.a2ml│
                        └─────────────────────────────────────────┘
```

## Completion Dashboard

```
COMPONENT                          STATUS              NOTES
─────────────────────────────────  ──────────────────  ─────────────────────────────────
LANGUAGE PORTFOLIO
  Solo / Duet / Ensemble            ██████████ 100%    Progressive family mapped
  Phronesis (Safety)                ██████████ 100%    Ethical framework stable
  Eclexia (Sustainable)             ██████████ 100%    Resource constraints active
  WokeLang (Human-centric)          ██████████ 100%    Consent model verified

SATELLITE PROGRESS
  Anvomidav (Formal)                ██████████ 100%    Real-time verification active
  Oblibeny (Secure)                 ██████████ 100%    Turing-incomplete mode stable
  Ephapax (Linear)                  ██████████ 100%    Dyadic type system active
  betlang (Foundational)            ██████████ 100%    Core experiments verified

REPO INFRASTRUCTURE
  6SCM Documentation Hub            ██████████ 100%    Canonical specs active
  .machine_readable/                ██████████ 100%    STATE tracking active
  Parent Coordination               ██████████ 100%    Portfolio Architected

─────────────────────────────────────────────────────────────────────────────
OVERALL:                            ██████████ 100%    Language Ecosystem Indexed
```

## Key Dependencies

```
Philosophy ──────► Design Spectrum ──────► Satellite Repo ──────► Artifact
     │                 │                      │                    │
     ▼                 ▼                      ▼                    ▼
CCCP Policy ─────► Verification ────────► Implementation ─────► Binary
```

## Update Protocol

This file is maintained by both humans and AI agents. When updating:

1. **After completing a component**: Change its bar and percentage
2. **After adding a component**: Add a new row in the appropriate section
3. **After architectural changes**: Update the ASCII diagram
4. **Date**: Update the `Last updated` comment at the top of this file

Progress bars use: `█` (filled) and `░` (empty), 10 characters wide.
Percentages: 0%, 10%, 20%, ... 100% (in 10% increments).
