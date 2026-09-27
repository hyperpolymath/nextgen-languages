# Assistant guidance for nextgen-languages

## Start here

1. Read `0-AI-MANIFEST.a2ml` and `.machine_readable/descriptiles/STATE.a2ml`.
2. Read `README.adoc`, then `EXPLAINME.adoc` for scope and navigation.
3. Use `.machine_readable/LANGUAGES.a2ml` as the scoped portfolio registry and `docs/ecosystem-map.adoc` for adjacent-project discovery.

## Coordinator boundary

This repository is a pure coordinator, not a language monorepo. Do not add language implementations, detailed language specs, grammars, proofs, or per-language tutorials here. Those belong in the canonical project repository. Portfolio-level indexes, evidence-scoped cross-language analysis, governance, and aggregate wiki navigation belong here. The wiki is BerryWiki-compatible Markdown but intentionally avoids per-language source pages.

The boundary and registry are checked with:

```sh
bash hooks/validate-language-registry.sh
bash hooks/validate-coordinator-boundary.sh
```

## Relationship and evidence rules

- A link is for discovery; it does not prove a dependency, shared ABI, conformance, or implementation status.
- Distinguish a core language from a syntax surface, substrate, tool, curriculum, and research neighbor.
- Do not infer production readiness or assign a standards grade from a design goal, repository description, or isolated proof.
- Keep private 007 and TypeFix Zero material index-only and respect upstream visibility policies.
- My-Lang has nested dialects Solo ⊂ Duet ⊂ Ensemble. “Me” is a runtime projection, not a fourth dialect. Its teaching materials live in the external repositories, not in this checkout.
- “Ziz” and the relationship between `hyperpolymath/jtv` and `hyperpolymath/jtv-lang` are unresolved. Do not invent project facts or canonical links; ask for an owner-confirmed URL and scope.

## Registry changes

A committed member addition must be reflected consistently in `languages/`, `.machine_readable/LANGUAGES.a2ml`, the boundary guard, `.machine_readable/descriptiles/ECOSYSTEM.a2ml`, and `language-status-tracker.jl`. Run the registry validator after any such change. Keep adjacent projects in `docs/ecosystem-map.adoc` and the `[portfolio-adjacent]` metadata instead of inflating the core registry.

## External project references

My-Lang's applied learning materials and retired Me scaffolding are maintained in the external `hyperpolymath/my-lang` repository. They are not submodules or paths in this checkout. See that repository's `frontier-practices/` and `_exploratory/me-scaffolding/` when relevant, and do not copy their contents here.

## Change discipline

- Read current upstream documentation before changing a claim about another repository.
- Preserve private information and never publish secret URLs or source.
- Keep `.machine_readable/descriptiles/STATE.a2ml` current after material coordinator changes.
- Run the two boundary/registry checks and `git diff --check` before completion.
- Repository-wide language and tooling policy comes from the current Hyperpolymath Standards repository; do not restate or locally broaden that policy here.
