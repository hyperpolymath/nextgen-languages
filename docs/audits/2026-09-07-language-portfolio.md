<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
<!-- Copyright (c) 2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk> -->

# Language portfolio audit — 7 September 2026

## Decision

The portfolio contains substantial executable and formal work, but its main
constraint is the connection between a claimed guarantee, the precise fragment
proved, the implementation that enforces it, and the artifact a consumer runs.
More syntax, scaffolding, badges, or percentage-complete tables will not close
that connection. The immediate work is to repair demonstrable failures, make
claims describe their evidence, and gate the actual language-specific boundaries.

The strongest directly exercised slices in this audit are Tangle's Lean core,
KitchenSpeak's positive/negative compiler corpus, My's QTT checker, Anytype's
kernel matrix, Ephapax's rebuilt parser, WokeLang's interpreter/typechecker
library, and Eclexia's conformance harness. These are different accomplishments.
None is a portfolio-wide production or soundness certification.

The highest-priority integration investigation is Eclexia/OikosBot. The highest
priority foundations investigations are Ephapax's L1 preservation frontier,
TypeLL's lossy language bridges and conditional check results, and typed-wasm's
relationship between the proved model, optional metadata, and real producer bytes.
Kategoria and TypeFix Zero need sharper research questions, not the same delivery
checklist as a compiler approaching release.

## Horizon and method

This audit enumerated 63 selected local checkout records, including duplicate
checkouts and coordinators, and 389 repositories returned by a complete GitHub
account repository listing. Those are observation denominators, **not counts of
languages**. It inspected the 25 entries in the local nextgen-language group and
27 entries in the iser group, followed canonical references into top-level and
typing repositories, and checked selected published sources against local ones.
The subsequent requested typing review added `nextgen-typing`, `kategoria`, and
`typell`; `typed-wasm` was already included. Source coverage varies and is stated
below. This is a source-backed portfolio and boundary audit, not an exhaustive
security review of every function in every repository.

The local snapshots frequently contain unpublished commits, divergent branches,
or working-tree edits. A source observation is about that snapshot unless
explicitly confirmed against current main. The [companion checkout inventory](2026-09-07-checkout-horizon.md)
records starting HEADs and dirty status. A successful local test is not evidence
that GitHub main, a release, or another checkout passed it. Main-based repair
worktrees are separate from these observations.

Evidence was collected from specifications, implementation paths, proof statements
and dependencies, tests, CI definitions, and live repository metadata. Workspace
files were scanned with the required Sonar secrets scanner before inspection.
Existing authoritative build/proof tools were used; test failures caused by a
toolchain shim or unavailable dependency are identified as such.

Database-specific language implementations are boundary references here because
they are being audited separately. No VQL/GQL/KRL/SQL-family readiness verdict is
inferred from this audit. Likewise, a language's face, compiler target, library,
research calculus, and augmentation adapter are not counted as interchangeable
products.

## Canonical identity and lineage

| Identity | Role and audit treatment |
|---|---|
| AffineScript | Canonical application language. Inspect current compiler and `docs/SOUNDNESS.adoc`; version-two work supersedes the old foundation in situ. |
| RattleScript, JaffaScript, CafeScripto, LucidScript, PseudoScript | AffineScript faces. Each lowering needs semantic and rejection conformance; these are not five independent soundness stories. |
| Panoply | Owner-described repurposing of former AffineScript v1. Current repo is an envelope/evidence/manifest charter with mechanisms explicitly unimplemented. Historical lineage does not transfer a proof or working compiler. |
| Ephapax | Independent rebuilt language; its internal affine sublanguage is not AffineScript. Preserve the falsified v1 and counterexample as fenced historical evidence. |
| JtV | Distinguish v1 additive construction/control separation from v2 reversible-token behavior; do not combine their evidence. |
| My-Lang | Three nested dialects: Solo, Duet, Ensemble. Me is an agent-generated projection, with a retired static-compiler experiment. |
| Oikos economics/accounting DSL | Independent stock-flow/accounting language targeting Ephapax. It is not OikosBot. |
| OikosBot | Ecological/economic analysis consumer. Eclexia integration is a separate contract, not the Oikos DSL compiler. |
| TypeFix Zero / μType₀ / TF0 | The likely identity meant by “typezero”; small calibration calculus beside the typing pipeline, not a required production dependency. |
| Anvomidav | The likely identity meant by “avomodalv”; choreography/skating design language. |
| nextgen-languages / nextgen-typing | Coordinators. They should index evidence and relationships, never vendor single-language implementations. |
| SystemET / Anytype | Semantic foundations and executable kernel respectively. Conceptual adoption by AffineScript must be distinguished from integration into its existing OCaml compiler. |
| Kategoria / TypeLL / typed-wasm | Research routes, verification kernel, and target/verifier infrastructure respectively. Their numbered type-property scales are not interchangeable. |
| aggregate-library | aLib semantic-overlap library/methodology. Distinct from typed-wasm's binary-layout “aggregate library” role. |
| isers | Augmentations of existing languages/toolchains; assess preservation across the adapter and actual target execution. |
| Haec | Language design using trope-particularity; a working separate trope checker is not a working Haec compiler. |
| cut-calculus / echo-types | Formal substrates with explicit assumption and fragment boundaries, not additional end-user languages. |
| bunsenite | Inspected README describes Nickel parser bindings; inventory descriptions calling it a new language should not determine classification. |
| Firmboot | Located after the initial enumeration through concurrent coordinator PR #149. Continuity research with Agda/Lean models and an Elixir reference implementation; general language toolchain and arbitrary-code hot loading remain open. |

The published My/Me archive claim and GitHub archive metadata disagree: the
enumerated `me-dialect` repository was not marked archived. Architectural
retirement and the forge's archive flag are different facts.

## Standards: apply the axes without collapsing them

The applicable sources are the standards repository's
[TRG](https://github.com/hyperpolymath/standards/blob/main/toolchain-readiness-grades/TOOLCHAIN-READINESS-GRADES.adoc),
[CRG](https://github.com/hyperpolymath/standards/blob/main/component-readiness-grades/COMPONENT-READINESS-GRADES.adoc),
[FRG](https://github.com/hyperpolymath/standards/blob/main/foundations-readiness-grades/FOUNDATIONS-READINESS-GRADES.adoc),
and [ARG](https://github.com/hyperpolymath/standards/blob/main/adoption-readiness-grades/ADOPTION-READINESS-GRADES.adoc).

* CRG assesses a component; TRG covers the required toolchain. An absent or
  unaudited required component cannot be averaged away by a strong parser.
* FRG measures the mathematical foundation. A proved model is not automatically
  a proof of the compiler, parser, optimizer, FFI, or emitted program.
* ARG is independent adoption evidence, bounded by the standards' cross-axis
  rules. In particular, ARG-A requires FRG at least B. Tests and stars do not
  establish external adoption.
* X means unassessed under the relevant standard. F concerns harmful failure;
  an honestly fenced experiment or retracted failed theorem is not automatically
  F. An informal “B-” in a status document is not an official TRG/CRG grade.
* Profiles can tighten requirements; old profiles are dated assessments, not
  perpetual current facts. My's May FRG-X rationale differs from later
  local Coq/Idris development. The local proof registry is absent from fetched
  main; reconcile and validate unpublished work before assigning main a new grade.

The [RSR template](https://github.com/hyperpolymath/rsr-template-repo) supplies
repository governance and structural conventions. A template ABI, a directory
named `proofs`, or a green file-presence check earns no compiler correctness
claim. Record these separately: **specified, implemented, wired, tested, proved,
deployed**. No one state implies the next.

For every material guarantee, maintain: owning repo/version, source fragment,
assumptions, theorem and dependency closure, executable enforcement point,
accepted example, rejected counterexample, actual test command, CI job, consumer,
and remaining frontier. This is more useful than a single maturity percentage.

## Language assessments

| Language | Concrete evidence | Frontier and next discriminating milestone |
|---|---|---|
| Tangle | Real OCaml compiler modules; `proofs/Tangle.lean` checked successfully. Contains progress, preservation, determinism, type-safety and inference-agreement development. Published README explicitly retracts the Tangle/KRL conflation. | Connect compiler semantics to the formal core with positive and negative conformance. Keep knot equivalence, operational equivalence, and compiler correctness as separate obligations. Remove coordinator claims about a KRL-consuming TangleIR stack. |
| Oblíbený | OCaml constrained checking and 27-case conformance suite pass. Factory/deployment phase separation is a useful concrete guarantee. | README's debugger/profiler/static-analyzer 100% claims exceed implementation: debugger stepping advances an index without execution, continue is unimplemented, profiler counts/time are placeholders, calls and structure sizes have incomplete analysis. Gate the constrained deployment boundary and correct tooling claims. |
| KitchenSpeak | Reference OCaml compiler; 15 corpus cases passed, including physical/dimensional/resource rejection examples. | Agda `NoCurdle` uses sensor/controller assumptions (`temp-at`, `gentle-bounded`) and is not a closed hardware guarantee. Separate static model, HAL trace, sensor freshness, controller overshoot, and actual equipment. Next: assumption-sensitive trace conformance with a failing sensor/controller case. |
| Eclexia | Implemented Rust compiler/interpreter ecosystem; existing conformance test target passed. The coordinator's “implementation not started” is false. | Resource accounting, units, adaptive choice, observation, and optimization need separate evidence. Next: a pinned OikosBot policy contract consuming real analysis inputs with explicit provenance and budget behavior. See integration section. |
| Ephapax | Rebuild is substantive: parser suite passed 62 unit tests and a doctest. v1 counterexample and v1-to-v2 rationale are retained. | `formal/Semantics_L1.v` still has admitted preservation in the inspected snapshot; later layers depending on it are conditional. Close structural L1 lemmas/preservation first, rerun the counterexample as a regression, then assess modality, echo, dyadic composition and codegen independently. |
| AffineScript | Current compiler has a detailed `docs/SOUNDNESS.adoc` and capability matrix, with explicit failures and repairs. Broader local `dune runtest` failed on missing res-to-affine fixtures. | Existing interpreter non-tail single-shot resume defect is pinned in the ledger (5 versus expected 105); compiled effect paths reject unsupported features. Preserve that honesty. Recover/validate fixtures and run ledger freshness, then fix continuation semantics at the right abstraction. Faces require lowering tests. |
| My-Lang | `my-qtt` passed 25 unit tests. `proofs/STATUS.md` records Coq/Idris core and surface development plus differential testing. | Conventional parser/checker only enters QTT for opted-in safe functions and skips out-of-fragment bodies. Abstract Me-surface semantics and conventional runtime are not identical; borrowing/async paths have known gaps. Replace stale “no formalisation” profile with a dated reassessment boundary. |
| Betlang | Real probabilistic ternary Racket implementation, with Rust/Lean/Julia work. Hard-real-time description in coordinator is incorrect. | `racket tests/basics.rkt` loads without running its test submodule. Correct `raco test` exposed `check-true(member ...)` misuse and invalid numeric format directives, aborting after 10/15 reported failures. Repair harness, seed stochastic tests, then test lazy effects and cross-backend distributions; do not call load-only CI conformance. |
| JtV | Real implementation and Lean artifacts; README/STATUS distinguish core work and missing executable/model coupling. | Keep v1 and v2 test envelopes separate. Require forward/inverse roundtrips, token reuse rejection, boundary effects, and explicit loss/residue cases. Do not carry addition-only guarantees unchanged into reversible-token v2. |
| WokeLang | 188 Rust library tests passed. Consent blocks have runtime checks. | Typechecker visits consent block bodies without establishing a static authority proof; runtime care-off mode auto-grants. Define the claim per mode. Test denied, revoked, delegated, consumed, and escaped capabilities and ensure production configuration cannot silently weaken the stated contract. |
| Phronesis | Elixir/BEAM ethical-policy implementation, not just a charter. Source checker and interpreter inspected. | Unknown names/fields can become `:any`; policy conditions accept `:any`; REPORT prints to stdout. Distinguish uncertainty, conflict, provenance and mandatory action delivery. Tests did not run in this audit due toolchain/dependency problems. Consensus gives agreement, not truth or ethical justification. |
| Oikos DSL | Rust parser/checker workspace tests pass. Local implementation is ahead of published scaffold language. | Godley checker sums entry signs, not symbolic amounts. Desugaring is explicitly `EphapaxNotAvailable`. Therefore the advertised arbitrary accounting-identity guarantee is not yet an executable end-to-end contract. Next: amount-sensitive identity examples and rejection, then real Ephapax lowering. |
| TypeFix Zero / μType₀ | Substantial design of declarative meaning, imperative observation, stratified universes, and explicit partiality; inspected verification status is template-level. | Specify the order/domain behind least fixed points and the exact total fragment. Next: an executable bounded observer plus replayable evidence checker for one tiny calculus; do not equate timeout with proven divergence or put unrestricted evaluation into definitional equality. |
| Anvomidav | Choreography design and roadmap; inspected ExUnit “spec tests” assert literals/counts rather than invoking a language validator. | Begin with a useful parse/roundtrip vocabulary and versioned rulepacks. Separate choreographic expression, competition rules, and physical feasibility. Seven free-program jump elements is not timeless: Skate Canada reduced the relevant 2026–27 categories to six. |
| Error-Lang | Distinct pedagogical design, including intentional error behavior; repository makes very strong production/formal-completeness claims. | No whole-implementation proof or production certification was established here. Define intentional object-language errors versus host failures, then test diagnostics, positional semantics and accessibility behavior. Treat broad “100% verified” claims as requiring component-specific evidence. |
| 007 | Indexed agent language with a Rust implementation and dated component/proof audit documents. Private-source boundary is explicit in coordinator instructions. | This pass did not rerun the full 007 toolchain or certify its network deployment. Keep actual private implementation evidence private; link its dated audit and preserve its own proof frontier rather than importing grade claims into the whole estate. |
| Haec | Grammar/elaboration design refers to independent trope-checker and echo substrates. | Demonstrate a real Haec source → checked IR → execution/rejection path before inheriting the separate checker's status. |
| Firmboot | Continuity contracts and finite executable witnesses. | Preserve model assumptions, test rejection as well as acceptance, and distinguish finite model agreement from arbitrary-run runtime refinement. |

### Eclexia and OikosBot: the actual connection needed

The published bot adapter and inspected Eclexia CLI do not agree: the bot invokes
`eclexia run POLICY --input JSON`, but the CLI's Run command has no `--input`.
The bot's `eclexia-native` feature has no compiler dependencies while its source
references those crates; enabling it failed with three unresolved-crate errors.
The native sketch also built a budgeted interpreter but called a different
interpreter through `run`, and did not inject the supplied analysis results.

Before the audit repair, malformed successful-process stdout became boolean
`false` via `unwrap_or(false)` and therefore a Pass. The built-in path is already
loud about its limitation: it dispatches on the file stem, never parses `.ecl`
contents, and uses hardcoded thresholds that can disagree with those files.
Placeholder evaluation energy/carbon/time were not measurements. The audit repair
rejects malformed output, removes those invented measurements, and makes the
reserved native feature report unavailable. It does **not** claim to implement
the missing language protocol.

The intended integration should preserve the bot's special purpose:

1. Freeze a versioned input carrying independent resource axes, units, coverage,
   measurement/calibration confidence, and provenance. Separate analyzed-code
   costs from policy-evaluation costs.
2. Choose and implement a real Eclexia entry point with a typed result:
   pass/warn/fail/unknown, explanation, evidence references and required actions.
   Missing/malformed input, unsupported versions and missing policies are explicit.
3. Bind inputs and budgets to the **same** interpreter instance. Bound time and
   output, propagate resource exhaustion, and preserve deterministic replay.
4. Keep Pareto/DEA tradeoffs visible. Do not collapse several objectives into a
   score and call it an optimization proof. Shadow prices need stable measured
   evidence, not merely a plausible API.
5. Preserve the existing rule that estimated per-file evidence cannot become a
   hard measured regression verdict. Confidence belongs to individual facts.
6. Pin both repositories in CI and execute the real policy. Include changing
   `.ecl` contents without renaming the file, denied/unknown inputs, budget
   exhaustion, malformed output, and a planted violation. A fake executable can
   test subprocess mechanics but cannot establish Eclexia integration.

OikosBot's Rust analysis workspace, its AffineScript webhook surface, its
VeriSimDB plans, and the Oikos accounting DSL remain separate delivery surfaces.

### TypeFix Zero and Anvomidav: productive next experiments

For μType₀, the important contribution to investigate is the evidence boundary
between meaning and observation. A tiny typed language with explicit fixed
points is already a well-understood starting point; compare
[Plotkin's original PCF semantics paper](https://homepages.inf.ed.ac.uk/gdp/publications/LCF.pdf).
The interesting new obligation is what finite observations justify reifying into
the declarative layer. Specify observations as prefixes with fuel, distinguish
“unknown after n steps” from divergence, and require replayable evidence before
moving a claim across the boundary. Adequacy, monotonic extension of observations,
and the inability to turn partial execution into arbitrary proof are better
first milestones than a large language feature list.

For Anvomidav, start with a small authored routine that a choreographer can read,
edit and roundtrip. Give rules a governing body, discipline, category and season.
The [official Skate Canada 2026–27 change notice](https://noticeboard.skatecanada.ca/2026/03/26/2026-2027-season-updates-to-the-podium-pathway-singles-pairs-and-ice-dance-program-requirements/)
changes novice/junior/senior free-program jump counts from seven to six; the notice
itself directs users to full requirements for authoritative details. This is a
concrete reason to version rules, not encode an unqualified global `max = 7`.
Artistic validity, rule compliance and biomechanical feasibility need distinct
results. First execute accepted/rejected routines through a real validator;
literal-only ExUnit assertions do not test that capability.

## Typing and shared foundations

### SystemET and Anytype

SystemET supplies a layered semantic proposal; Anytype implements a kernel.
Anytype's inspected checker covers a real L1/L2 slice with quantities and
conversion. Its 19-case executable matrix passed, including affine weakening
and the contrasting exact-discipline rejection. That distinction must survive
language adaptation. L0 runtime and later guarded/effect layers are separate
frontiers. The generic Justfile's “Build complete” echo is not kernel validation;
use the actual Idris package and test executable.

AffineScript's current OCaml compiler does not become Anytype-backed because a
roadmap names the kernel. A canonical embedding needs an explicit AST/typing
mapping, preservation of quantities and effects, rejection agreement, erasure
contract, and executable integration. This also applies to faces: common AST
ownership reduces duplicate core proof work but leaves each face's elaboration
obligations intact.

### nextgen-typing and Kategoria

The coordinator correctly separates research, kernel, target, and environment,
and places TF0 beside that chain. Its “TypeLL-grounded” language description
needs the same implementation evidence as any other dependency claim.

Kategoria's five routes are useful comparative experiments: extend, dyadic,
aspect, aggregate, and clean-slate. Its ten “known levels” are a project taxonomy,
not an established universal total order. For example, dependent, linear,
refinement, effect, and session properties interact without a single automatic
promotion relation. Its “L10 cubical” is not typed-wasm's “L10 linearity.”
Publish named properties, counterexamples, and assumptions per route; compare
common challenges without treating equal numbers as equal guarantees.

The inspected Route Alpha cubical file overstates its negative result. It says
Idris cannot transport a value along equality of types without an unsafe escape,
and cannot even state univalence. Ordinary equality transport is supported by
Idris's [official `Builtin` equality operations](https://idris-lang.org/Idris2/prelude/source/Builtin.html).
An audit control defining equality transport by matching `Refl` was actually
checked by Idris2 (`Building TransportControl`), including a reflexive reduction
example. Lacking a native computational cubical implementation is a defensible boundary;
the stronger “proven architectural impossibility” is not established by the
file's commentary. Retain the experiment and correct the premise. Do not
replace it with a claim that univalence has thereby been implemented.

### TypeLL

The root README still says scaffolding, but the inspected repository has fourteen
Rust workspace members including a core, server and language bridges. The core
has inference, unification, quantities, linearity, sessions, dimensions and
obligation data. Its Idris Soundness model is a simply typed core; its concrete
`Ty` constructors do not cover the entire advertised dependent/session/resource
system. Source comments about formerly open renaming holes are also stale beside
the completed helper bodies.

Two concrete boundaries deserve immediate tests:

* `typell-affinescript/src/bridge.rs` drops record/variant labels, lowers type-level
  natural expressions to the same argument-free `Named("Nat")`, and discards
  dependent-arrow effects in that representation. This contradicts its
  “preserves all information” description. A projection may be useful, but it
  cannot certify distinctions it erases. Pin the language version: the bridge's
  refinement/dependent claims describe features removed from current AffineScript.
* `typell-core/src/check.rs::finish` produces an `ok` result when `errors` is
  empty while also returning proof obligations and linearity issues. Consumers
  must not interpret `ok` alone as unconditional verification. External proof
  integration in `proof.rs` is explicitly TODO; setting a status field is not a
  checked certificate.

The next milestone is a result contract distinguishing checked, conditional,
refuted and unsupported, plus discriminating tests for bridge collisions. Then
trace every PanLL/language consumer to its handling of that contract. The
database-specific backend semantics remain in the separate database audit.

### typed-wasm

There is meaningful post-codegen verification and a developed proof library.
The audit must nevertheless separate four layers: Idris discipline, source
checker, producer-emitted carrier metadata, and verifier operating on real bytes.

`VerifierSpec.idr` defines SpecAccepts, VerifierAccepts and SourceAccepts around
the same structural `FunctionsAccepted` witness; a TrustedFixture also contains
that witness. The agreement lemmas correctly transport those witnesses. They
do not by themselves mechanise Rust execution or prove that arbitrary emitted
bytes parse to the claimed summary. Preserve the explicit trust model and its
negative discrimination proofs; add the missing executable correspondence,
rather than deleting the witness or rebranding structural agreement as a
verified Rust compiler.

`verify_from_module` explicitly accepts modules with no ownership section
trivially. That can be an intentional compatibility mode, but “accepted” must
not mean “L7/L10 certified.” A consumer requiring ownership assurance needs an
evidence-presence requirement and tests removing the section from an otherwise
identical module. Likewise L2/L15/L13 passes have feature and producer gates.
Schema correctness alone does not prove every machine access obeys that schema.

The detailed level ledger records that L11/L12 are in the proof package while
their surface semantics/FFI are still research; other README/status paragraphs
say they are excluded drafts. Reconcile these precise states. Do not choose the
highest number or the shortest README as authority.

Require producer-pair tests for AffineScript and Ephapax independently, stale or
forged metadata, metadata stripping, overflow/alignment, alias/lifetime crossings,
feature-disabled behavior, malformed modules and import/link mismatches. The
typed-wasm binary convention library is distinct from aLib's semantic overlap.

### aggregate-library and other substrates

aLib is an optional shared-semantics library and methodology, not a mandate to
combine every language's best-looking feature. Record the common meaning of an
operation, numeric/overflow behavior, error and effect behavior, and ownership
contract. Require shared vectors across consumers and face lowering. No fresh
aLib runtime validation was performed in this pass.

Echo/residue and cut-calculus proofs have scoped meanings: retained provenance is
not generally an inverse; a finite cut model or conditional SoundWarrant theorem
is not all transfinite or operational cases. Cross-project composition needs a
statement that genuinely relates the projects, not duplicated similarly named
types. The coordinator boundary explicitly permits such cross-project proofs.

## Augmentation portfolio

The inspected grouped iser inventory is:
`affinescriptiser`, `alloyiser`, `anvomidaviser`, `atsiser`, `betlangiser`,
`bqniser`, `chapeliser`, `dafniser`, `eclexiaiser`, `ephapaxiser`, `futharkiser`,
`halideiser`, `idrisiser`, `iseriser`, `julianiser`, `k9iser`, `lustreiser`,
`mylangiser`, `nimiser`, `oblibeniser`, `otpiser`, `phronesiser`, `ponyiser`,
`tlaiser`, `typedqliser`, `verisimiser`, and `wokelangiser`.

This list is a local grouped inventory, not the total estate count: the top-level
iseriser hub and other satellites can have different membership and revisions.
README-level inspection covers the group; code and executable checks were
deeper for Chapeliser and Halideiser. Do not extend those two conclusions to all
adapters. Many entries explicitly remain scaffold/codegen-pending.

Chapeliser had a concrete relative-path defect: it entered `generated/chapeliser`
and then attempted `generated/chapeliser/build.sh` from there. Compiler-version
probes checked spawn success but ignored failing exit status. The repair fixes
both and adds process regression tests. Its existing Provable workflow is the
correct kind of target-specific gate: Idris, Zig, golden drift, and actual Chapel
compile/run. A successful Rust template-generation suite alone is insufficient.

Halideiser's build/run commands printed instructions and returned success without
executing anything. The repair invokes CMake and the runner, validates the
manifest, preserves argument boundaries, and propagates nonzero exits. Regression
tests use real CMake and a host C fixture, including a planted compilation error.
They establish orchestration, **not correctness of generated Halide algorithms**.
The generated CMake has additional suspicious details (including a literal
`${{HALIDE_TARGET}}`) that require a real pinned-Halide compile gate before
claiming end-to-end target support or performance improvements.

For every iser, gate manifest rejection, generation, actual target compilation,
ABI layout/calling convention, runtime behavior, and failure propagation.
Resource/session/proof wrappers cannot retrospectively prove arbitrary foreign
code correct. “10–100×” needs a workload, baseline, hardware and reproducible
measurement, not an inherited package description.

## Executed validation and limits

These results describe the starting local snapshots, before audit repairs.

| Target | Command / result | What it establishes |
|---|---|---|
| Tangle | `lean Tangle.lean` in `proofs/`: exit 0 | The inspected Lean core checks with the available toolchain. |
| KitchenSpeak | `bash tests/run-corpus.sh`: 15 passed | Positive and negative compiler corpus, not hardware execution. |
| Oblíbený | `dune runtest`: conformance suite passes | Core corpus; no debugger completeness inference. |
| My | `cargo test --offline --locked -p my-qtt`: 25 unit tests pass | QTT crate; not all language semantics. |
| WokeLang | `cargo test --offline --locked --lib`: 188 pass | Rust library tests; not static consent proof. |
| Ephapax | Parser target: 62 unit tests plus 1 doctest pass | Rebuilt parser; not closure of L1 preservation. |
| Eclexia | `cargo test --offline --locked -p eclexia --test conformance_tests`: two harness tests pass | The existing conformance harness; no whole-workspace count inferred. |
| Anytype | `idris2 --build anytype-tests.ipkg`, then `build/exec/anytype-tests`: 19 cases, 0 failures | Executable kernel matrix including negative cases. |
| Oikos DSL | `cargo test --offline --locked --workspace`: exit 0 | Existing Rust tests; lowering remains unavailable. |
| OikosBot | Default adapter: 6 tests pass; native feature fails compilation | The feature gap is reproduced, not inferred. |
| Halideiser | Rust suite passes: 24 unit tests in each of lib/bin plus 8 integration tests | Duplicated unit execution is not 48 independent properties; target compilation was absent. |
| Chapeliser | Initial offline run could not resolve `assert_cmd` | No initial test-failure inference from absent cache. Repair run resolves dependencies and executes tests. |
| AffineScript | `dune runtest`: failure, 32 walker cases cannot find fixtures | A merge blocker in this checkout; distinguish missing data from semantic failures. |
| Betlang | Load-only invocation passes; `raco test` fails/aborts | Harness defects and previously unexecuted test submodule. |
| Phronesis | Mise trust/config, incompatible cached Hex, then missing dependencies | Tests did not run; no pass/fail claim about language behavior. |
| TypeLL | `cargo test --offline --locked -p typell-core`: exit 0 | Core tests; does not prove bridge information preservation. |
| typed-wasm | Offline attempt lacked `wasmi`; online locked retry exposed a feature-resolution conflict | `typed-wasm-codegen` requires `unstable-l13-imports`, absent from this checkout's verifier manifest (only default/unstable-l2). Workspace tests did not execute. |

## CI and merge acceptance

Repository safety gates must accompany semantic gates. Keep action dependencies
resolved by the authoritative `gh actions-lock`, minimal job permissions, bounded
jobs, dependency/security analysis and secret scanning. Inspect actual required
checks and code-scanning state on the PR head. Do not disable or bypass a check
to turn a known failure green. A zero-step startup failure is not a source test
failure, and a pending required context is not a pass.

| Surface | Required discriminating checks |
|---|---|
| Coordinator | Canonical identity/relationship consistency; coordinator-boundary guard; no copied language implementations; dated source evidence and no invented ratings. |
| Parser/checker | Accepted and rejected source programs, malformed input, recursion/resource boundaries and stable diagnostics. |
| Formal foundation | Actual pinned prover invocation, explicit assumptions/dependency closure, counterexample regression and soundness-ledger freshness. Banned-token grep alone is insufficient. |
| Compiler/backend | Source→IR→target semantics; optimizer/erasure agreement; unsupported feature rejection; artifact verifier requiring the promised evidence. |
| Language bridge / face | Distinct labels, quantities, effects and indices remain distinct where required; source/kernel rejection agreement; no silent loss presented as proof. |
| Runtime/FFI | Invalid handles, alias/lifetime behavior, layout/alignment, resource exhaustion, subprocess failures, and real consumer execution. |
| Policy/agent language | Unknown/conflict/denied decisions, provenance, capability boundaries and required-action delivery. |
| Release | Locked inputs, provenance, executable smoke test, vulnerability findings triage, actual deployment evidence where claimed. |

The main-based repair batch is deliberately scoped to reproduced failures and
evidence corrections. Preserve divergent local work and review unpublished
commits by semantic change; never stage all local modifications just because
the audit found them. Existing bulk fixture/source deletions must be understood
before incorporation. Commit and merge only the reviewed batch after its actual
CI succeeds. Larger research milestones above remain tracked work, not claims
that this audit has implemented every language or closed every theorem.

## Audit repair validation

The isolated repair branches start from GitHub main, preserving divergent local
work. The full Oikosbot Rust workspace and Eclexia adapter with all features,
both adapters’ Rust suites, and Oblíbený’s OCaml conformance suite pass locally.
The first PR run also compiled and ran Chapel’s golden program, checked its
Idris2 ABI and Zig implementation, and passed the regenerated golden comparison.
These results establish the tested surfaces, not whole-language soundness.

CI exposed additional inherited defects: misplaced licence headers, missing
workflow permissions, absent secret-presence guards, unauthenticated shell
installers, malformed A2ML identity metadata, and unrendered K9 deployment
templates presented as live contracts. Repairs retain the templates as `.in`
inputs, remove placeholder credential assignments, and make environment setup
syntactically valid. Halideiser reuses Chapeliser’s existing Julia structural
ABI/FFI validator; it confirms 15 exports and eight matching result codes.

The optional Hypatia gate also counted historical GitHub alert summaries before
baseline filtering, creating a cycle in which a fix could not merge until its
old main-branch alert closed. Standards PR #742 gates the scanner’s authoritative
SARIF projection after baseline filtering, while preserving raw historical
findings. It rejects malformed/missing output and requires explicit successful
filtering for a present baseline. My’s existing dated baseline is activated
with the authoritative validator; its entries are not broadened. Oikosbot’s
false “no tests” finding is addressed with an explicit root test entry point
that runs the real all-features adapter tests in CI. The attempted exemption
was removed; no new test exemption remains. No blanket alert dismissal
or branch-protection bypass is part of this repair.

Repair PRs: [coordinator #148](https://github.com/hyperpolymath/nextgen-languages/pull/148),
[Oikosbot #86](https://github.com/hyperpolymath/oikosbot/pull/86),
[Chapeliser #71](https://github.com/hyperpolymath/chapeliser/pull/71),
[Halideiser #64](https://github.com/hyperpolymath/halideiser/pull/64),
[My #182](https://github.com/hyperpolymath/my-lang/pull/182),
[Oblíbený #127](https://github.com/hyperpolymath/oblibeny/pull/127), and
[shared gate #742](https://github.com/hyperpolymath/standards/pull/742).
The PR records are the authority for final CI and merge status; the validation
observations above do not assert that a pending PR has merged.


## Toolchain atlas and subsequent component review

The [toolchain atlas](toolchain-atlas/README.md) adds 67 selected rows across
28 component questions, with a [whole-grid image](toolchain-atlas/atlas.png),
[lossless SVG](toolchain-atlas/atlas.svg), and [per-cell evidence browser](toolchain-atlas/atlas.html).
Filename-only and unassessed cells remain explicit; this is not a claim that all
1,876 components are implemented or fully reviewed. Faces, version lineages,
research foundations, private scope and augmentation tools retain their roles.

Additional source observations:

- Phronesis has a real judgement/evidence graph and six-stage invariant paths.
  ClaimExtractor's compiler, proof and benchmark extraction paths still return
  empty lists. A proof-obligation edge is an asserted claim, not proof discharge.
- Ephapax's Zig coprocessor shim is explicitly a stub reporting unavailable
  capabilities. JtV's lowering emits Zig/Idris/C artifacts with placeholder Zig
  kernel bodies. AffineScript's multi-target gate checks emitted artifacts; it
  does not demonstrate execution on each accelerator.
- WokeLang's aLib bridge implements basic operations but map/filter/fold and
  ifThenElse report that interpreter context is required. Full aggregate-library
  semantic conformance must not be inferred from the operation names.
- The augmentation review inspected build/run bodies across the iser group.
  Several print plans and return success; the grid records each observed case.
  Idrisiser repeats the relative build-script/cwd defect repaired in Chapeliser;
  Nimiser attempts to launch a shared library directly; K9iser skips missing
  source configuration while strict validation can still report success. These
  additional findings are recorded, not silently marked repaired by the two
  augmentation PRs in this audit.
- Firmboot's published baseline is `fcf8e2e15cf7178818c9fe375c596956ee3ce3c9`.
  The local working tree contains an uncommitted water-leak extension. Its actual
  Elixir suite passed 43 tests after rerunning outside the sandbox so Mix could
  open its local coordination socket. This result includes that local extension.
  Agda/Lean proof and rejection harnesses were inspected, not freshly run here.
  Finite agreement and transition models do not establish arbitrary-code hot
  loading, arbitrary-run refinement, physical uptime or actuator safety.

The CI follow-up added My's proof-boundary register for 15 Coq module-interface
laws; these are not automatically 15 global axioms. The authoritative trusted-
base gate passes the documented boundary. My's new label-job timeouts and
immutable action references close the observed baseline-policy gaps. Halideiser
restricts toolchain downloads and redirects to HTTPS after the exact SonarCloud
PR query identified the security finding hidden by the local organisation filter.

Standards #742 has passed all reported checks and is set to merge automatically
when the remaining branch-policy requirements are satisfied. An ordinary merge
was refused by GitHub; no protection was disabled or bypassed. Consult the live
PRs for final merge status rather than inferring it from local commits or images.
