-- SPDX-License-Identifier: PMPL-1.0-or-later
-- Copyright (c) 2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
--
-- =====================================================================
-- KitchenSpeak — Dough Proof (Agda)
-- =====================================================================
--
-- Proves the three obligations of the dough example from SPEC.adoc:
--
--     resource Flour state RAW_POWDER;
--     resource Water state LIQUID;
--
--     orchestrate {
--         (Flour, Water) <~> Baridi_Robot;
--         sync(Baridi_Robot) {
--             Baridi_Robot.Knead(RPM: 80)
--                 until @viscosity >= 0.8Nm
--                 max_duration 15min
--                 on_fail ABORT;
--         }
--     }
--
-- Obligations discharged (per COMMENTARY.adoc):
--
--     1. Termination  — `knead` is structurally recursive on the fuel
--                       parameter. Agda's termination checker accepts
--                       it automatically; no separate theorem needed.
--
--     2. Safety       — every branch of `knead` returns a KneadResult
--                       (Success or Aborted). Shown explicitly by the
--                       `kr-exhaustive` lemma below. `on_fail ABORT`
--                       lowers to the `Aborted` constructor.
--
--     3. Echo witness — if the program returns Success, the success
--                       certificate carries an existential witness of
--                       the form (t , proof-that-viscosity-fired-at-t).
--                       Shown by `success-gives-witness`.
--
-- Linearity is enforced by inspection of signatures rather than by a
-- linear-type extension of Agda: neither `Flour` nor `Water` appears
-- in any output type, `bind-dough` consumes both and returns neither,
-- and no function in this file duplicates either input. A QTT-Agda
-- encoding would make this machine-checked; the proof shape is the
-- same either way. See the note at the end of §3.
--
-- ---------------------------------------------------------------------
-- Agda version assumed: 2.6.4+ with stdlib 2.0+.
-- Pragma notes:
--   - We do NOT use {-# OPTIONS --safe #-} because §4 introduces a
--     sensor postulate that models the physical world. A production
--     lowering would replace the postulate with a HAL binding.
-- ---------------------------------------------------------------------

module Dough where

open import Data.Nat
  using (ℕ; zero; suc; _≥_; _≥?_)
open import Data.Sum
  using (_⊎_; inj₁; inj₂)
open import Data.Product
  using (_×_; _,_; Σ-syntax)
open import Relation.Binary.PropositionalEquality
  using (_≡_; refl)
open import Relation.Nullary
  using (yes; no)


-- =====================================================================
-- § 1. Physical primitives.
-- =====================================================================
--
-- In the production KitchenSpeak, these would be units-of-measure-
-- indexed types (Torque, Time, etc.). For the teaching proof we use
-- ℕ stand-ins with unit suffixes in the type name to signal the
-- real dimension. The encoding is honest about the abstraction: a
-- production port (or a QTT-Agda port) substitutes a dimension-
-- indexed ℚ for each of these.
--
-- Granularity. SPEC.adoc quotes `0.8 Nm` and `15 min`. We work in
-- deci-Nm (tenths of a Newton-metre) and in integer minutes so every
-- quantity is a ℕ.

Torque-dNm : Set
Torque-dNm = ℕ

Minutes : Set
Minutes = ℕ

-- The kneaded-dough viscosity threshold per SPEC: 0.8 Nm = 8 dNm.
kneaded-threshold : Torque-dNm
kneaded-threshold = 8

-- The Knead action's wall-clock budget per SPEC: max_duration 15 min.
knead-budget : Minutes
knead-budget = 15


-- =====================================================================
-- § 2. Ingredient states.
-- =====================================================================
--
-- Each ingredient carries a state tag. The Dough type is indexed by
-- its DoughState, so the KNEADABLE → KNEADED transition is visible in
-- the type system. `bind-dough` produces `Dough KNEADABLE`; the
-- successful `knead` produces `Dough KNEADED`.

data FlourState : Set where
  RAW-POWDER : FlourState

data WaterState : Set where
  LIQUID : WaterState

data DoughState : Set where
  KNEADABLE : DoughState
  KNEADED   : DoughState

record Flour : Set where
  constructor mkFlour
  field state : FlourState

record Water : Set where
  constructor mkWater
  field state : WaterState

record Dough (s : DoughState) : Set where
  constructor mkDough
  field state : DoughState


-- =====================================================================
-- § 3. Dyadic bind: (Flour, Water) <~> Baridi_Robot.
-- =====================================================================
--
-- The class's `<~>` operator is the tensor product Flour ⊗ Water,
-- consumed by the binding actor and emerging as `Dough KNEADABLE`.
-- Both inputs are consumed here by construction: the signature does
-- not return either one. A subsequent call attempting to reuse the
-- same Flour value is blocked by linearity discipline (at the
-- metalevel — see note below).

bind-dough : Flour → Water → Dough KNEADABLE
bind-dough _ _ = mkDough KNEADABLE

-- Linearity note.
--
-- Plain Agda is not linear: a function `f : A → A × A` with body
-- `λ a → (a , a)` is allowed. The linearity guarantee for the dough
-- program therefore rests on *not writing such a function anywhere
-- in this file*. Inspection:
--
--   - bind-dough : Flour → Water → Dough KNEADABLE
--     Consumes both inputs, returns neither.
--
--   - knead : Dough KNEADABLE → ℕ → Minutes → KneadResult
--     Consumes the dough; the KneadResult type mentions no Flour,
--     Water, or Dough-KNEADABLE on the way out.
--
--   - dough-program : Flour → Water → KneadResult
--     Uses each argument exactly once (threaded into bind-dough).
--
-- No function in this file has a signature of the form
-- `Flour → Flour × X` or `Flour → Flour` or similar duplicating
-- shape. Linearity holds by inspection. A QTT-Agda port would
-- encode this via quantity annotations (`@0`, `@1`, `@ω`) and have
-- the compiler check it.


-- =====================================================================
-- § 4. Echo oracle (@viscosity).
-- =====================================================================
--
-- `@viscosity` is a sensor stream. At each minute t, the torque
-- sensor reports a reading in deci-Nm. We postulate this function:
-- it is the physical world, not a derivable term. The proof
-- *assumes* its values exist and discharges the surrounding control
-- flow. See COMMENTARY.adoc §Echo for the discussion of postulated
-- oracles and the proven/postulated boundary.

postulate
  viscosity-at : Minutes → Torque-dNm


-- =====================================================================
-- § 5. The Knead loop.
-- =====================================================================
--
-- A bounded feedback loop:
--
--   at each minute, sample the torque sensor;
--   if it has crossed threshold, emit Success with a witness;
--   otherwise decrement fuel and recurse;
--   if fuel hits zero, emit Aborted (the `on_fail ABORT` branch).
--
-- Termination.  Structurally recursive on the fuel parameter: the
-- recursive call always uses `n` where the caller had `suc n`.
-- Agda's termination checker accepts this without further hints.
--
-- Safety.       Pattern-exhaustive on fuel (zero vs suc) and on the
-- `Dec` result of the threshold comparison (yes vs no). Every
-- branch returns a KneadResult; no branch is stuck.
--
-- Echo.         The `yes pf` branch captures the proof that the
-- classifier fired, bundling it into the returned Witness.

-- The witness bundle: the minute at which viscosity first met
-- threshold, together with the proof.
Witness : Set
Witness = Σ[ t ∈ Minutes ] viscosity-at t ≥ kneaded-threshold

-- The result of a Knead step, following SPEC.adoc's `on_fail ABORT`
-- contract. The sum {Success ...} ⊎ {Aborted} is the total-function
-- image the class's type table requires.
data KneadResult : Set where
  Success : Dough KNEADED → Witness → KneadResult
  Aborted : KneadResult

-- knead d fuel elapsed:
--   `d`       — the KNEADABLE dough produced by bind-dough,
--   `fuel`    — remaining minutes in the budget,
--   `elapsed` — the current wall-clock minute at which to sample.
--
-- The recursion is on `fuel`. After fuel minutes without the
-- classifier firing, the loop aborts.
knead : Dough KNEADABLE → (fuel : ℕ) → (elapsed : Minutes) → KneadResult
knead _ zero    _ = Aborted
knead d (suc n) t with viscosity-at t ≥? kneaded-threshold
... | yes pf = Success (mkDough KNEADED) (t , pf)
... | no  _  = knead d n (suc t)


-- =====================================================================
-- § 6. The dough program.
-- =====================================================================
--
-- Direct lowering of the SPEC-level program:
--
--     orchestrate {
--         (Flour, Water) <~> Baridi_Robot;
--         sync(Baridi_Robot) {
--             Baridi_Robot.Knead(RPM: 80)
--                 until @viscosity >= 0.8Nm
--                 max_duration 15min
--                 on_fail ABORT;
--         }
--     }
--
-- The dyadic bind is `bind-dough f w`. The sync-block body is
-- `knead · knead-budget · 0`. The whole thing composes to a total
-- function `Flour → Water → KneadResult`.

dough-program : Flour → Water → KneadResult
dough-program f w = knead (bind-dough f w) knead-budget 0


-- =====================================================================
-- § 7. Obligations, discharged.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Obligation 1 — Termination.
-- ---------------------------------------------------------------------
--
-- Discharged by the structural recursion of `knead` on fuel. Agda's
-- termination checker accepts the definition of `knead` above; no
-- explicit theorem is required. The metric is the natural number
-- passed as `fuel`.
--
-- If this file type-checks, termination is proved.

-- ---------------------------------------------------------------------
-- Obligation 2 — Safety (on_fail totality).
-- ---------------------------------------------------------------------
--
-- Every KneadResult is either a Success (carrying a kneaded dough
-- and a witness) or Aborted. The proof is a single pattern match.
-- Makes the class's "total case-split on failure" obligation
-- explicit rather than leaving it implicit in the data declaration.

kr-exhaustive : ∀ (r : KneadResult) →
  (Σ[ d ∈ Dough KNEADED ] Σ[ w ∈ Witness ] r ≡ Success d w)
  ⊎ (r ≡ Aborted)
kr-exhaustive (Success d w) = inj₁ (d , w , refl)
kr-exhaustive Aborted       = inj₂ refl


-- ---------------------------------------------------------------------
-- Obligation 3 — Echo witness extraction.
-- ---------------------------------------------------------------------
--
-- If the dough program returns Success, the success certificate
-- bundles an existential witness time t at which the postulated
-- sensor crossed the threshold. Anyone holding the Success value
-- can project the witness; there is no success-without-proof.
--
-- The proof is a projection — the witness is literally a field of
-- the Success constructor — but stating the theorem documents the
-- contract.

success-gives-witness :
  ∀ (f : Flour) (w : Water)
    {d : Dough KNEADED} {wit : Witness} →
  dough-program f w ≡ Success d wit →
  Σ[ t ∈ Minutes ] viscosity-at t ≥ kneaded-threshold
success-gives-witness _ _ {wit = wit} _ = wit


-- =====================================================================
-- § 8. What is *not* proved here, and what replaces it in production.
-- =====================================================================
--
-- Not proved:
--
--   (a) That `viscosity-at` is a sound classifier. This is the
--       postulated-oracle boundary: the proof trusts the sensor
--       pipeline. A higher-assurance version would pair each call
--       site with an empirical soundness bound, or replace the
--       postulate with a verified classifier.
--
--   (b) That the dough program satisfies linearity as a *type-level*
--       discipline. Plain Agda does not enforce single-use. The
--       property holds by inspection of signatures (see §3 note).
--       A QTT-Agda port enforces it at compile time; the proof
--       shape above is unchanged.
--
--   (c) That the chosen ℕ stand-ins for Torque and Minutes coincide
--       with their real dimensional content. The production port
--       replaces `Torque-dNm` and `Minutes` with dimension-indexed
--       rationals.
--
-- What the file *does* prove:
--
--   (1) The dough program is a total function from Flour × Water
--       to KneadResult. Termination and exhaustiveness both hold.
--
--   (2) Every Success return carries a witness the caller can
--       extract. No success exists without a classifier event.
--
--   (3) Every non-success is Aborted — the `on_fail` branch is
--       inhabited, and the function never gets stuck.
--
-- These three properties correspond one-for-one to the class's
-- termination, safety, and echo obligations in SPEC.adoc §4.
