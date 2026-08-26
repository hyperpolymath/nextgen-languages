## CRITICAL: This Is a Pure Coordinator, Not a Monorepo

`nextgen-languages` coordinates a language family; it does **not** contain it. Each language
is its own standalone `hyperpolymath/<lang>` repo, referenced — never vendored, never a
submodule. **Do not add language implementations, specs, grammars, proofs, compilers, or
per-language wiki/design docs here.** If you are about to create such content, it belongs in
that language's own repo. This boundary is enforced by
`hooks/validate-coordinator-boundary.sh` (CI job `coordinator-boundary`). See
`0-AI-MANIFEST.a2ml` (COORDINATOR BOUNDARY) and `EXTRACTION-MANIFEST.md`.

## CRITICAL: Pedagogy Lives Outside This Repo

Curriculum, syllabus, aspect-agents, kin framework, and the Me runtime projector all live
in the top-level `tentacles-agentic-syllabus` repo (previously `hyperpolymath/7-tentacles`,
which was a submodule of this repo until it was pulled out to the top level). **Do not
audit it as a language.** Do not look for grammar / AST / parser / type system inside it.

**Per-language applied learner materials** for my-lang live in `my-lang/frontier-practices/`
(previously `my-lang/7-tentacles/`). That directory is the my-lang-specific applied layer
that consumes the common curriculum — *not* a language, *not* a dialect. Skip it in
language audits.

**My-Lang dialects are three, nested**: `Solo ⊂ Duet ⊂ Ensemble`. **Me is not a fourth
dialect** — it is an on-the-fly agent-generated projection over the dialect hierarchy,
specified in `tentacles-agentic-syllabus/me/README.adoc`. Do not audit Me as a static
compiler. Two earlier exploratory attempts to build Me as a static dialect have been
retired:

- `hyperpolymath/me-dialect` on GitHub — archived.
- `my-lang/dialects/me/` in-tree — sidelined to `my-lang/_exploratory/me-scaffolding/`
  with a `SIDELINED.adoc` explaining the architectural pivot.

## Machine-Readable Artefacts

The following files in `.machine_readable/` contain structured project metadata:

- `.machine_readable/6a2/STATE.a2ml` - Current project state and progress
- `.machine_readable/6a2/META.a2ml` - Architecture decisions and development practices
- `.machine_readable/6a2/ECOSYSTEM.a2ml` - Position in the ecosystem and related projects
- `.machine_readable/6a2/AGENTIC.a2ml` - AI agent interaction patterns
- `.machine_readable/6a2/NEUROSYM.a2ml` - Neurosymbolic integration config
- `.machine_readable/6a2/PLAYBOOK.a2ml` - Operational runbook

---

# CLAUDE.md - AI Assistant Instructions

## Language Policy (Hyperpolymath Standard)

### ALLOWED Languages & Tools

| Language/Tool | Use Case | Notes |
|---------------|----------|-------|
| **AffineScript** | Primary application code | Affine-typed, compiles to typed-wasm or ESM |
| **Bun** | JS runtime & package management (tier 1) | Default for all new work. Runs compiled ESM/JS directly — no bundler step. Uses an npm-compatible `package.json` plus `bun.lock` — both are expected, not anti-patterns. |
| **Rust** | Performance-critical, systems, WASM | Preferred for CLI tools |
| **Tauri 2.0+** | Mobile apps (iOS/Android) | Rust backend + web UI |
| **Dioxus** | Mobile apps (native UI) | Pure Rust, React-like |
| **Gleam** | Backend services | Runs on BEAM or compiles to JS |
| **Bash/POSIX Shell** | Scripts, automation | Keep minimal |
| **JavaScript** | Only where AffineScript cannot | MCP protocol glue, Bun APIs |
| **Nickel** | Configuration language | For complex configs |
| **Guile Scheme** | State/meta files | .machine_readable/6a2/STATE.a2ml, .machine_readable/6a2/META.a2ml, .machine_readable/6a2/ECOSYSTEM.a2ml |
| **Julia** | Batch scripts, data processing | Per RSR |
| **OCaml** | AffineScript compiler | Language-specific |
| **Ada** | Safety-critical systems | Where required |

### BANNED - Do Not Use

| Banned | Replacement |
|--------|-------------|
| TypeScript | AffineScript |
| ReScript | AffineScript |
| Deno | Bun |
| Node.js | Bun |
| npm | Bun |
| pnpm/yarn | Bun |
| Go | Rust |
| Python | Julia/Rust |
| Java/Kotlin | Rust/Tauri/Dioxus |
| Swift | Tauri/Dioxus |
| React Native | Tauri/Dioxus |
| Flutter/Dart | Tauri/Dioxus |

### Mobile Development

**No exceptions for Kotlin/Swift** - use Rust-first approach:

1. **Tauri 2.0+** - Web UI (AffineScript) + Rust backend, MIT/Apache-2.0
2. **Dioxus** - Pure Rust native UI, MIT/Apache-2.0

Both are FOSS with independent governance (no Big Tech).

### Enforcement Rules

1. **No new TypeScript or ReScript files** - Convert existing TS/ReScript (`.ts`/`.tsx`/`.res`/`.resi`) to AffineScript
2. **Use `package.json` + `bun.lock` for JS runtime deps** - Bun is npm-compatible; a manifest is REQUIRED
3. **`bun install --production` for production deps** - resolved from `package.json`, pinned via `bun.lock`
4. **No Go code** - Use Rust instead
5. **No Python anywhere** - Use Julia for data/batch, Rust for systems, AffineScript for apps
6. **No Kotlin/Swift for mobile** - Use Tauri 2.0+ or Dioxus

### Package Management

- **Primary**: Guix (guix.scm)
- **Fallback**: Nix (flake.nix)
- **JS deps**: Bun (`package.json` + `bun.lock`). Declare tooling as a devDependency and run `bunx --no-install --bun <tool>` — a bare `bunx <tool>` can fetch an unpinned package and may start Node via its shebang.

### Security Requirements

- No MD5/SHA1 for security (use SHA256+)
- HTTPS only (no HTTP URLs)
- No hardcoded secrets
- SHA-pinned dependencies
- SPDX license headers on all files

