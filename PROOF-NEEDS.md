# PROOF-NEEDS.md — nextgen-languages

## Current State

- **src/abi/*.idr**: YES (in oblibeny) — `Interface.idr`
- **Dangerous patterns**: 4 `Admitted` in ephapax/formal/Semantics.v (ctx_transfer 15/24, subst_lemma, preservation)
- **LOC**: ~456,000 (OCaml + Rust + Coq + Idris2 + Lean)
- **Existing proofs**: Ephapax has Coq proofs, Tangle has Lean proofs, Idris2 in multiple sub-languages

## What Needs Proving

| Component | What | Why |
|-----------|------|-----|
| Ephapax ctx_transfer (15/24 cases) | Close remaining 9 context transfer cases in Semantics.v | Core type safety theorem is incomplete |
| Ephapax subst_lemma | Prove substitution lemma | Required for preservation theorem |
| Ephapax preservation | Close preservation theorem (depends on subst_lemma) | Type preservation is THE fundamental safety property |
| Ephapax 4th Admitted | Close the 4th Admitted in Semantics.v | Blocks full formal verification claim |
| AffineScript type safety | Prove OCaml type checker is sound | AffineScript claims affine types but lacks proofs |
| AffineScript runtime (Rust) | GC and allocator correctness | Memory safety of the runtime is critical |
| Betlang type checker | Prove bet-check is sound | Compiler correctness depends on type checking |
| Tangle Lean proofs | Extend Tangle.lean coverage | Existing Lean proofs are partial |
| Oblibeny ABI | Extend Interface.idr with full package proofs | Current ABI is minimal |

## KitchenSpeak Trusted Base (Agda postulates)

KitchenSpeak's proofs are deliberately built on a small, explicit trusted
base: the *postulated echo-oracles* (sensors) and the GENTLE *controller
spec*. These are not soundness gaps to close but documented trust
boundaries (see each proof's final section and `COMMENTARY.adoc §Echo`).
A production lowering replaces each with a verified HAL binding.

| Postulate | File | What it trusts | Production replacement |
|-----------|------|----------------|------------------------|
| `viscosity-at` | `kitchenspeak/proofs/agda/Dough.agda` | Torque sensor stream | Verified HAL torque binding |
| `temp-at` | `kitchenspeak/proofs/agda/PoachedEgg.agda` | Hob thermometer stream | Verified HAL thermal binding |
| `white-set-at` | `kitchenspeak/proofs/agda/PoachedEgg.agda` | Visual albumen classifier | Verified/empirically-bounded classifier |
| `gentle-bounded` | `kitchenspeak/proofs/agda/PoachedEgg.agda` | GENTLE controller never overshoots target cap | Integrator bound on the slope |

## Recommended Prover

**Coq** for Ephapax (existing proof infrastructure). **Lean4** for Tangle (existing). **Idris2** for ABI layers. **OCaml** extraction from Coq for AffineScript type checker verification.

## Priority

**HIGH** — These are programming language compilers. Type safety proofs are the gold standard for language correctness. The 4 Admitted proofs in Ephapax are concrete, known gaps that block the formal verification claim. AffineScript's runtime Rust code (GC, allocator) is safety-critical.
