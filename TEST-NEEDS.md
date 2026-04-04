# TEST-NEEDS.md — nextgen-languages

> Generated 2026-03-29 by punishing audit.

## CRG Grade: C — ACHIEVED 2026-04-04

| Sub-project | Tests | Status |
|-------------|-------|--------|
| ephapax (Rust workspace) | 330 | CRG C complete 2026-04-04 |
| tangle (OCaml) | 94 | Existing coverage adequate |
| affinescript (OCaml) | 64 tested (22 pre-existing failures) | Pre-existing, not regressions |

Added test categories for ephapax-linear and ephapax-lexer:
- P2P property tests: loop-based invariant checks (20+ iterations each)
- E2E tests: full pipeline tests (lexer->tokens, module->discipline check)
- Aspect tests: robustness, statelessness, edge cases, crash resistance

## Current State

| Category     | Count | Notes |
|-------------|-------|-------|
| Unit tests   | ~50   | affinescript: test_lexer.ml, test_golden.ml, test_e2e.ml + ~119 .as test files (borrow, codegen). tangle: test_parser.ml, test_typecheck.ml, test_eval.ml |
| Integration  | ~5    | tangle FFI integration_test.zig, ephapax tests.rs, 7-tentacles structure_test.ts |
| E2E          | ~3    | affinescript test_e2e.ml + integration tests |
| Benchmarks   | 4     | tangle: bench_lexer.ml, bench_lexer.rs, bench_parser.ml, bench_parser_rust.rs. betlang: bench_lexer.rs |

**Source modules:** ~772 across 14+ language implementations. Major: affinescript (~87 ML), ephapax (~488 Rust across 19 crates), tangle, eclexia, betlang, anvomidav, wokelang, 7-tentacles, error-lang, julia-the-viper.

## What's Missing

### P2P (Property-Based) Tests
- [ ] affinescript: borrow checker property tests (arbitrary program shapes)
- [ ] ephapax: linear type checker property tests — CRITICAL (19 crates, only tests.rs)
- [ ] tangle: parser roundtrip property tests
- [ ] All languages: lexer/parser fuzzing for crash resistance

### E2E Tests
- [ ] Each language: source -> lex -> parse -> typecheck -> codegen -> execute
- [ ] affinescript: full compile pipeline with borrow checking
- [ ] ephapax: full linear type checking pipeline (19 crates, needs integration)
- [ ] tangle: full compilation to target
- [ ] Cross-language: shared concepts verified across implementations

### Aspect Tests
- **Security:** No tests for code injection through language constructs, unsafe memory in codegen, sandbox escape in interpreters
- **Performance:** tangle has lexer/parser benchmarks (good). affinescript: ZERO benchmarks. ephapax: ZERO benchmarks for 19 crates
- **Concurrency:** No tests for parallel compilation, concurrent type checking
- **Error handling:** affinescript has test files for error cases (good). Most other languages: ZERO error handling tests

### Build & Execution
- [ ] OCaml build + test for affinescript, tangle
- [ ] `cargo test` for ephapax (19 crates!)
- [ ] Zig build for tangle FFI
- [ ] Test runners for each language

### Benchmarks Needed
- [ ] ephapax: type checking time, compilation time, memory usage (19 crates, ZERO benchmarks)
- [ ] affinescript: compilation pipeline benchmarks
- [ ] eclexia: parsing/evaluation benchmarks
- [ ] All languages: parse time vs source size

### Self-Tests
- [ ] Each language: self-hosting test (can it compile its own test suite?)
- [ ] Grammar consistency checks
- [ ] Type system soundness verification

### CRITICAL GAPS

| Language | Source Files | Tests | Status |
|----------|-------------|-------|--------|
| affinescript | ~87 ML | ~50 unit + 119 .as | **Good coverage** |
| ephapax | ~488 Rust (19 crates) | 1 tests.rs | **0.2% — CATASTROPHIC** |
| tangle | moderate | 3 ML + 1 Zig + 4 bench | Adequate for size |
| eclexia | unknown | 0 | **Untested** |
| betlang | unknown | 1 bench | **Untested** |
| anvomidav | unknown | 0 | **Untested** |
| wokelang | unknown | 0 | **Untested** |
| 7-tentacles | unknown | 1 | Minimal |
| error-lang | unknown | 0 | **Untested** |
| julia-the-viper | unknown | 0 | **Untested** |

## Priority

**CRITICAL.** Ephapax at 488 Rust source files across 19 crates with effectively 1 test file is catastrophic — this is a compiler with linear types that needs rigorous testing above all else. affinescript is the only well-tested language. At least 6 language implementations have ZERO tests. The tangle benchmarks are a good model for the rest.

## FAKE-FUZZ ALERT

- `tests/fuzz/placeholder.txt` is a scorecard placeholder inherited from rsr-template-repo — it does NOT provide real fuzz testing
- Replace with an actual fuzz harness (see rsr-template-repo/tests/fuzz/README.adoc) or remove the file
- Priority: P2 — creates false impression of fuzz coverage
