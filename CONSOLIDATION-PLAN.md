# Language Consolidation Plan

**Date:** 2026-02-07
**Status:** Ready for execution
**Goal:** Consolidate all language implementations into single canonical repos, eliminate fragmentation

---

## Executive Summary

**Problem:** Language development has been scattered across multiple repos, causing "lost development" syndrome where months of work appears to vanish because STATE.scm files don't reflect reality.

**Solution:** Consolidate all related code into canonical repos, update tracking files, establish nextgen-languages as parent repo only.

**Affected Languages:**
- julia-the-viper (60% → 100%): 40% work remaining
- oblibeny (45% → 100%): 55% work remaining
- my-lang (75% → 100%): 25% work remaining

---

## Repository Architecture (Target State)

```
~/Documents/hyperpolymath-repos/
├── nextgen-languages/          # PARENT REPO ONLY - no embedded code
│   ├── README.adoc             # Overview of all languages
│   ├── .machine_readable/STATE.scm  # Central tracking (syncs with individual repos)
│   └── docs/                   # Cross-language documentation
├── julia-the-viper/            # CANONICAL - all jtv code here
│   ├── crates/                 # Existing crates
│   ├── playground/             # ← MOVE jtv-playground/ here
│   └── ffi/zig/                # ← MOVE julia-zig-ffi/ here
├── oblibeny/                   # CANONICAL - all oblibeny code here
│   ├── lib/                    # Existing OCaml code
│   ├── ffi/zig/                # Existing Zig FFI
│   ├── transpiler/             # ← MOVE obli-transpiler-framework/ here
│   ├── fs/                     # ← MOVE obli-fs/ here
│   ├── riscv-dev-kit/          # ← MOVE obli-riscv-dev-kit/ here
│   ├── ssg/                    # ← MOVE obli-ssg/ here
│   └── examples/               # ← MOVE examples from boinc-boinc here
└── my-lang/                    # CANONICAL - all my-lang code here
    ├── crates/                 # Existing 12 crates
    ├── dialects/               # NEW - consolidate all dialects
    │   ├── solo/               # ← MOVE my-newsroom/solo-compiler/ here
    │   ├── duet/               # ← MOVE mylang-playground duet code here
    │   ├── ensemble/           # Future
    │   └── me/                 # ← MOVE mylang-playground me code here
    ├── playground/             # ← MOVE mylang-playground/hives/ here
    └── examples/               # ← MOVE my-newsroom/examples/ here
```

---

## Phase 1: Julia-the-Viper Consolidation

**Current State:**
- Canonical: `julia-the-viper/` (666M, 22 files, 4,589 LOC) ✓
- Scattered: `jtv-playground/` (2.1M, examples)
- Scattered: `julia-zig-ffi/` (472K, 1 Zig file)
- OUTDATED: `nextgen-languages/julia-the-viper/` (696K, 12 files)

### Actions

**1.1 Move jtv-playground into main repo**
```bash
cd ~/Documents/hyperpolymath-repos
mkdir -p julia-the-viper/playground
rsync -av jtv-playground/ julia-the-viper/playground/
# Verify, then remove
rm -rf jtv-playground
```

**1.2 Move julia-zig-ffi into main repo**
```bash
mkdir -p julia-the-viper/ffi/zig
rsync -av julia-zig-ffi/ julia-the-viper/ffi/zig/
# Verify, then remove
rm -rf julia-zig-ffi
```

**1.3 Remove outdated embedded code**
```bash
cd nextgen-languages
rm -rf julia-the-viper/
# Add README stub pointing to canonical repo
echo "# Julia the Viper

This code has been moved to the canonical repository:
https://github.com/hyperpolymath/julia-the-viper

This directory is kept as a reference only." > julia-the-viper/README.md
```

**1.4 Update documentation**
- Update `julia-the-viper/README.adoc` to document new structure
- Update `julia-the-viper/.claude/CLAUDE.md` with directory structure
- Add `julia-the-viper/ARCHITECTURE.md` explaining playground/ and ffi/zig/

**Effort:** 3-5 hours
**Verification:** All tests pass, examples run, cargo build succeeds

---

## Phase 2: Oblibeny Consolidation

**Current State:**
- Canonical: `oblibeny/` (57M, 44 OCaml + 3 Zig files, 1,677 LOC) ✓
- Scattered: `obli-transpiler-framework/` (1.6M, 11 Rust files)
- Scattered: `obli-fs/` (1.3M, 1 file)
- Scattered: `obli-riscv-dev-kit/` (1.4M)
- Scattered: `obli-ssg/` (1.3M)
- Scattered: `boinc-boinc/examples/crypto-xor.obl` and `temperature-monitor.obl`
- Scattered: `security-audit/repos/oblibeny-playground/`
- OUTDATED: `nextgen-languages/oblibeny/` (436K, 0 OCaml files)

### Actions

**2.1 Move obli-transpiler-framework**
```bash
cd ~/Documents/hyperpolymath-repos
mkdir -p oblibeny/transpiler
rsync -av obli-transpiler-framework/ oblibeny/transpiler/
# Update Cargo.toml workspace if needed
rm -rf obli-transpiler-framework
```

**2.2 Move obli-fs**
```bash
mkdir -p oblibeny/fs
rsync -av obli-fs/ oblibeny/fs/
rm -rf obli-fs
```

**2.3 Move obli-riscv-dev-kit**
```bash
mkdir -p oblibeny/riscv-dev-kit
rsync -av obli-riscv-dev-kit/ oblibeny/riscv-dev-kit/
rm -rf obli-riscv-dev-kit
```

**2.4 Move obli-ssg**
```bash
mkdir -p oblibeny/ssg
rsync -av obli-ssg/ oblibeny/ssg/
rm -rf obli-ssg
```

**2.5 Consolidate examples**
```bash
# Move from boinc-boinc
cp boinc-boinc/examples/crypto-xor.obl oblibeny/examples/
cp boinc-boinc/examples/temperature-monitor.obl oblibeny/examples/
# Note: Keep boinc-boinc examples but add note they're also in oblibeny

# Move from security-audit (if not duplicates)
rsync -av security-audit/repos/oblibeny-playground/examples/ oblibeny/examples/
```

**2.6 Remove outdated embedded code**
```bash
cd nextgen-languages
rm -rf oblibeny/
echo "# Oblibeny

This code has been moved to the canonical repository:
https://github.com/hyperpolymath/oblibeny

This directory is kept as a reference only." > oblibeny/README.md
```

**2.7 Update documentation**
- Update `oblibeny/README.adoc` with new structure
- Update `oblibeny/.claude/CLAUDE.md` with directory layout
- Add `oblibeny/ARCHITECTURE.md` documenting:
  - `lib/` - OCaml compiler
  - `ffi/zig/` - Zig FFI bindings
  - `transpiler/` - Rust transpiler framework
  - `fs/` - Filesystem features
  - `riscv-dev-kit/` - RISC-V tooling
  - `ssg/` - Static site generator

**Effort:** 5-8 hours
**Verification:** dune build succeeds, all examples compile and run

---

## Phase 3: My-Lang Consolidation (MOST COMPLEX)

**Current State:**
- Canonical: `my-lang/` (3.6G, 77 files, 8,220 LOC, 12 crates) ✓
- Scattered: `my-newsroom/` (1.9M, has solo-compiler/ + examples/duet/ + examples/solo/)
- Scattered: `mylang-playground/` (4.0M, has hives/me/ with duet/LSP/typechecker/codegen)
- Archive: `my-lang-archive/` (534M, 75 files) - CONSIDER REMOVING
- OUTDATED: `nextgen-languages/my-lang/` (212K, 9 files)

### Actions

**3.1 Create dialects/ directory structure**
```bash
cd ~/Documents/hyperpolymath-repos/my-lang
mkdir -p dialects/{solo,duet,ensemble,me}
```

**3.2 Move solo dialect from my-newsroom**
```bash
# Move solo compiler
rsync -av ../my-newsroom/solo-compiler/ dialects/solo/compiler/

# Move solo examples
rsync -av ../my-newsroom/examples/solo/ dialects/solo/examples/

# Update workspace Cargo.toml to include dialects/solo/compiler
```

**3.3 Move duet dialect from my-newsroom and mylang-playground**
```bash
# Move duet examples from my-newsroom
rsync -av ../my-newsroom/examples/duet/ dialects/duet/examples/

# Move duet compiler from mylang-playground
rsync -av ../mylang-playground/hives/me/crates/duet/ dialects/duet/compiler/
```

**3.4 Move me dialect from mylang-playground**
```bash
# Move me crates (codegen, lsp, typechecker, parser)
rsync -av ../mylang-playground/hives/me/crates/ dialects/me/crates/

# Move me examples
rsync -av ../mylang-playground/hives/me/examples/ dialects/me/examples/
```

**3.5 Move remaining playground content**
```bash
mkdir -p playground
rsync -av ../mylang-playground/ playground/
# Exclude what we already moved to dialects
```

**3.6 Consolidate all examples**
```bash
# Merge my-newsroom examples into main examples/
rsync -av ../my-newsroom/examples/ examples/newsroom/
```

**3.7 Update workspace structure**
```toml
# Add to my-lang/Cargo.toml [workspace.members]
members = [
    # ... existing 12 crates ...
    "dialects/solo/compiler",
    "dialects/duet/compiler",
    "dialects/me/crates/codegen",
    "dialects/me/crates/lsp",
    "dialects/me/crates/typechecker",
    "dialects/me/crates/parser",
]
```

**3.8 Archive or remove old versions**
```bash
# Option 1: Keep archive as-is for historical reference
# (No action needed)

# Option 2: Remove archive after verifying all code consolidated
# rm -rf my-lang-archive

# Recommendation: Keep for now, add .archived marker
touch my-lang-archive/.archived
echo "# Archived

This is an archived version of my-lang.
Current canonical version: ~/Documents/hyperpolymath-repos/my-lang/" > my-lang-archive/README.archived
```

**3.9 Clean up scattered repos**
```bash
# After consolidation verified:
rm -rf my-newsroom       # All code moved to my-lang
rm -rf mylang-playground # All code moved to my-lang
```

**3.10 Remove outdated embedded code**
```bash
cd ~/Documents/hyperpolymath-repos/nextgen-languages
rm -rf my-lang/
echo "# My-Lang

This code has been moved to the canonical repository:
https://github.com/hyperpolymath/my-lang

This directory is kept as a reference only." > my-lang/README.md
```

**3.11 Update documentation**
- Update `my-lang/README.adoc` with new structure
- Update `my-lang/.claude/CLAUDE.md` with dialect layout
- Add `my-lang/ARCHITECTURE.md` documenting:
  - `crates/` - Core 12-crate workspace
  - `dialects/solo/` - Solo dialect (systems programming)
  - `dialects/duet/` - Duet dialect (AI-assisted verification)
  - `dialects/ensemble/` - Ensemble dialect (AI-native)
  - `dialects/me/` - Me dialect (personal AI agent)
  - `playground/` - Experimental code
  - `examples/` - All examples organized by dialect

**Effort:** 10-15 hours
**Verification:** cargo test --all passes, all dialect compilers build, examples run

---

## Phase 4: Update nextgen-languages Parent Repo

### Actions

**4.1 Remove embedded code directories**
```bash
cd ~/Documents/hyperpolymath-repos/nextgen-languages
# Keep README stubs created above
# Remove actual code directories (already done in phases 1-3)
```

**4.2 Update README.adoc**
```adoc
= Next-Gen Languages

*Parent repository for tracking and coordinating experimental language development*

== Repository Structure

This is a **parent repository only** - it contains documentation and tracking but NO implementation code.

All language implementations are in their respective canonical repositories:

* *julia-the-viper*: https://github.com/hyperpolymath/julia-the-viper
* *oblibeny*: https://github.com/hyperpolymath/oblibeny
* *my-lang*: https://github.com/hyperpolymath/my-lang
* *eclexia*: https://github.com/hyperpolymath/eclexia
* *phronesis*: https://github.com/hyperpolymath/phronesis
* *ephapax*: https://github.com/hyperpolymath/ephapax
* *wokelang*: https://github.com/hyperpolymath/wokelang
* *affinescript*: https://github.com/hyperpolymath/affinescript
* *betlang*: https://github.com/hyperpolymath/betlang
* *anvomidav*: https://github.com/hyperpolymath/anvomidav

== What This Repo Contains

* `.machine_readable/STATE.scm` - Central tracking of ALL language progress
* `docs/` - Cross-language documentation, comparisons, integration guides
* `CONSOLIDATION-PLAN.md` - Plan for consolidating scattered code (this file)

== Language Status

See `.machine_readable/STATE.scm` for detailed status of each language.

*Last updated:* 2026-02-07
```

**4.3 Update .claude/CLAUDE.md**
```markdown
# nextgen-languages - CLAUDE.md

## Repository Purpose

**CRITICAL:** This is a PARENT REPOSITORY ONLY for tracking and documentation.

**DO NOT add implementation code here.**

All language implementations belong in their own canonical repositories.

## Canonical Repository Locations

| Language | Repository | Completion |
|----------|-----------|-----------|
| julia-the-viper | ~/Documents/hyperpolymath-repos/julia-the-viper | 60% |
| oblibeny | ~/Documents/hyperpolymath-repos/oblibeny | 45% |
| my-lang | ~/Documents/hyperpolymath-repos/my-lang | 75% |
| eclexia | ~/Documents/hyperpolymath-repos/eclexia | 100% |
| phronesis | ~/Documents/hyperpolymath-repos/phronesis | 100% |
| ... | ... | ... |

## When Working on Languages

1. **Always work in the canonical repo**, not here
2. Update STATE.scm in the language's repo first
3. Sync changes to `nextgen-languages/.machine_readable/STATE.scm`
4. Keep this repo focused on cross-language concerns only
```

**4.4 Add migration notes**
Create `nextgen-languages/MIGRATION-COMPLETE.md`:
```markdown
# Migration Complete: 2026-02-07

All language implementations have been moved to canonical repositories.

## What Changed

**Before:** Language code embedded in nextgen-languages/ subdirectories
**After:** Each language in its own canonical repo, this repo tracks only

## Canonical Locations

See README.adoc for full list.

## If You Find Old Embedded Code

If you discover old embedded code in nextgen-languages subdirectories:
1. Check if it exists in the canonical repo
2. If missing from canonical, move it there
3. Remove the embedded copy
4. Update tracking in STATE.scm

## STATE.scm Synchronization

The central `nextgen-languages/.machine_readable/STATE.scm` syncs from individual repos.

**Process:**
1. Update language's STATE.scm in canonical repo
2. Run sync script (TODO: create) to update central tracking
3. Commit both changes together
```

**Effort:** 2-3 hours

---

## Phase 5: Establish Synchronization Process

### Create Sync Script

**5.1 Create `nextgen-languages/scripts/sync-state-files.sh`**
```bash
#!/usr/bin/env bash
# SPDX-License-Identifier: PMPL-1.0-or-later
# Sync STATE.scm from canonical repos to central tracking

set -euo pipefail

REPOS=(
    "julia-the-viper"
    "oblibeny"
    "my-lang"
    "eclexia"
    "phronesis"
    "ephapax"
    "wokelang"
    "affinescript"
    "betlang"
    "anvomidav"
)

BASE_DIR="$HOME/Documents/hyperpolymath-repos"
CENTRAL_STATE="$BASE_DIR/nextgen-languages/.machine_readable/STATE.scm"

echo "Syncing STATE.scm files from canonical repos..."

for repo in "${REPOS[@]}"; do
    REPO_STATE="$BASE_DIR/$repo/.machine_readable/STATE.scm"

    if [[ -f "$REPO_STATE" ]]; then
        echo "  ✓ $repo"
        # Extract completion percentage and update central tracking
        # (TODO: Implement extraction and update logic)
    else
        echo "  ✗ $repo - STATE.scm missing"
    fi
done

echo "Sync complete."
```

**5.2 Add git pre-commit hook to canonical repos**
```bash
#!/usr/bin/env bash
# .git/hooks/pre-commit in each canonical repo
# Reminds to sync STATE.scm changes to central tracking

if git diff --cached --name-only | grep -q "^.machine_readable/STATE.scm$"; then
    echo ""
    echo "⚠️  STATE.scm modified!"
    echo ""
    echo "Remember to sync to central tracking:"
    echo "  cd ~/Documents/hyperpolymath-repos/nextgen-languages"
    echo "  ./scripts/sync-state-files.sh"
    echo ""
fi
```

**Effort:** 3-5 hours to create automation

---

## Phase 6: Verification and Testing

### Verification Checklist

**For each language:**
- [ ] All tests pass in canonical repo
- [ ] Documentation updated with new structure
- [ ] .claude/CLAUDE.md reflects new layout
- [ ] STATE.scm accurate and detailed
- [ ] AI.a2ml lists canonical locations
- [ ] Old scattered repos removed or archived
- [ ] Examples run successfully
- [ ] Build succeeds (cargo/dune/etc.)

**For nextgen-languages:**
- [ ] No embedded code directories (except README stubs)
- [ ] Central STATE.scm accurate
- [ ] README.adoc updated
- [ ] Migration documentation complete
- [ ] Sync script functional

---

## Execution Timeline

| Phase | Focus | Duration | Dependencies |
|-------|-------|----------|-------------|
| Phase 1 | julia-the-viper | 3-5 hours | None |
| Phase 2 | oblibeny | 5-8 hours | None |
| Phase 3 | my-lang | 10-15 hours | None |
| Phase 4 | nextgen-languages | 2-3 hours | Phases 1-3 complete |
| Phase 5 | Sync automation | 3-5 hours | Phase 4 complete |
| Phase 6 | Verification | 5-8 hours | All phases complete |
| **Total** | | **28-44 hours** | |

**Recommended:** Execute phases 1-3 in parallel if multiple developers available.

---

## Risk Mitigation

### Backup Strategy

**Before executing any phase:**
```bash
cd ~/Documents/hyperpolymath-repos
tar -czf ~/backups/pre-consolidation-$(date +%Y%m%d).tar.gz \
    julia-the-viper oblibeny my-lang \
    jtv-playground julia-zig-ffi \
    obli-* my-newsroom mylang-playground my-lang-archive \
    nextgen-languages
```

### Rollback Plan

If consolidation fails:
1. Extract backup: `tar -xzf ~/backups/pre-consolidation-*.tar.gz`
2. Verify repos restored
3. Investigate failure cause
4. Fix and retry

### Incremental Approach

Instead of all at once:
1. Start with julia-the-viper (simplest)
2. Verify thoroughly
3. Proceed to oblibeny
4. Verify thoroughly
5. Finally tackle my-lang (most complex)
6. Each phase can be rolled back independently

---

## Post-Consolidation: Path to 100%

Once consolidation complete, focus on blockers per language:

### Julia-the-Viper (60% → 100%): ~40 hours
1. Complete WASM backend (15-20h)
2. Add LSP server (20-25h)
3. Add debugger (12-15h)
4. Documentation (10-15h)

### Oblibeny (45% → 100%): ~75 hours
1. Complete crypto FFI (10-15h)
2. Add LSP server (20-25h)
3. Complete package manager (15-20h)
4. Idris2 ABI proofs (8-12h)
5. Documentation (12-18h)
6. Consolidate deployment (5-8h)

### My-Lang (75% → 100%): ~60 hours
1. Complete LLVM backend (15-20h)
2. Unify AI integration (10-15h)
3. Add debugger (15-20h)
4. VS Code extension (8-12h)
5. Expand stdlib (10-15h)
6. Documentation (15-20h)

**Total to 100%:** ~175 hours (~22 days of focused work)

---

## Success Criteria

**Consolidation successful when:**
- ✅ Each language has ONE canonical repo with ALL related code
- ✅ nextgen-languages contains NO embedded implementation code
- ✅ All STATE.scm files accurate (±5% of reality)
- ✅ All tests pass in canonical repos
- ✅ Scattered repos removed or clearly archived
- ✅ Documentation reflects new structure
- ✅ Sync process established

**Ready to push to 100% when:**
- ✅ Consolidation complete
- ✅ All blockers identified and prioritized
- ✅ Development can proceed linearly without confusion
- ✅ No more "lost development" syndrome

---

## Questions for User

Before execution:
1. Should we keep my-lang-archive or remove it?
2. Should we remove boinc-boinc examples after copying to oblibeny?
3. Preference for execution: Sequential (safe) or parallel (fast)?
4. Git commit strategy: One big commit or incremental?

---

**Next Steps:** Review this plan, answer questions above, then execute Phase 1 as proof of concept.
