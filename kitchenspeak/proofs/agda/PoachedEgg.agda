-- SPDX-License-Identifier: MPL-2.0
-- Copyright (c) 2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
--
-- =====================================================================
-- KitchenSpeak — Poached Egg Proof (Agda)
-- =====================================================================
--
-- Lowers `examples/poached-egg.ks`, the minimum KitchenSpeak program
-- that exercises all three of Linear (the egg), Tropical (the water
-- temperature), and Echo (the visual witnesses) together. It is the
-- second proof in the core library after `Dough.agda`, and the first
-- to discharge a *Tropical* refinement obligation.
--
-- The source program (see examples/poached-egg.ks) has two sync blocks:
--
--     sync(Delia_Hob) proving @water_shimmer {
--         Delia_Hob.Heat(target: 82C, slope: GENTLE)
--             until ~ temp >= 80C
--             max_duration 8min
--             on_fail ABORT;
--     }
--     sync(Delia_Hob) proving @white_set {
--         Delia_Hob.Poach(Egg, acidulant: Vinegar, depth: 4cm)
--             until @white_set == true
--             max_duration 4min
--             on_fail RECOVER;
--     }
--
-- Obligations discharged (per COMMENTARY.adoc):
--
--   1. Termination  — both `heat` and `poach` are structurally
--                     recursive on a fuel parameter. Agda's termination
--                     checker accepts them; no separate theorem needed.
--
--   2. Safety       — every branch of `heat` returns a HeatResult
--                     (Shimmered or Aborted, the `on_fail ABORT` image)
--                     and every branch of `poach` returns a PoachResult
--                     (Set or Recovered, the `on_fail RECOVER` image).
--                     Shown by `heat-exhaustive` / `poach-exhaustive`.
--
--   3. Echo witness — a successful Heat carries an existential witness
--                     that @water_shimmer fired; a successful Poach
--                     carries one that @white_set fired. Shown by
--                     `shimmer-gives-witness` / `white-gives-witness`.
--
--   4. Tropical     — NEW relative to Dough.agda. The GENTLE controller
--                     never crosses the forbidden boil envelope: at the
--                     shimmer time the water is in [80C, 82C], hence
--                     strictly below boiling. Shown by `tropical-safe`.
--
-- Linearity (Egg, Vinegar consumed exactly once) is enforced by
-- inspection of signatures, exactly as in Dough.agda §3: `poach`
-- consumes both Egg and Vinegar and returns neither, and no function
-- in this file duplicates either input. A QTT-Agda port would make
-- this machine-checked without changing the proof shape.
--
-- ---------------------------------------------------------------------
-- Agda version assumed: 2.6.4+ with stdlib 2.0+.
-- Pragma notes:
--   - We do NOT use {-# OPTIONS --safe #-}: §4 and §5 introduce
--     physical-world postulates (the sensor streams and the GENTLE
--     controller envelope) that a production lowering would replace
--     with HAL bindings.
-- ---------------------------------------------------------------------

module PoachedEgg where

open import Data.Nat
  using (ℕ; zero; suc; _≥_; _≥?_; _≤_; _<_; _<?_)
open import Data.Nat.Properties
  using (<-transʳ)
open import Data.Sum
  using (_⊎_; inj₁; inj₂)
open import Data.Product
  using (_×_; _,_; Σ-syntax)
open import Relation.Binary.PropositionalEquality
  using (_≡_; refl)
open import Relation.Nullary
  using (yes; no)
open import Relation.Nullary.Decidable
  using (True; toWitness)


-- =====================================================================
-- § 1. Physical primitives.
-- =====================================================================
--
-- As in Dough.agda we use ℕ stand-ins with unit suffixes in the type
-- name to signal the real dimension. A production (or QTT-Agda) port
-- substitutes a dimension-indexed ℚ for each.

Celsius : Set
Celsius = ℕ

Minutes : Set
Minutes = ℕ

-- The poach `until ~ temp >= 80C` threshold, per SPEC / the .ks source.
shimmer-threshold : Celsius
shimmer-threshold = 80

-- The Heat action's GENTLE setpoint cap (`target: 82C`). The GENTLE
-- slope is configured so the controller approaches, but never
-- overshoots, this cap. See the postulate in §5.
target-cap : Celsius
target-cap = 82

-- The forbidden envelope: a rolling boil at standard pressure. The
-- Tropical obligation is that the trajectory never reaches it.
boil-envelope : Celsius
boil-envelope = 100

-- The Heat action's wall-clock budget (`max_duration 8min`).
heat-budget : Minutes
heat-budget = 8

-- The Poach action's wall-clock budget (`max_duration 4min`).
poach-budget : Minutes
poach-budget = 4

-- The target cap sits strictly below the boil envelope. This is a
-- configuration fact about the chosen setpoint, computed by the
-- decision procedure rather than postulated.
cap<boil : target-cap < boil-envelope
cap<boil = toWitness {a? = target-cap <? boil-envelope} _


-- =====================================================================
-- § 2. Ingredient states.
-- =====================================================================
--
-- Egg carries a typestate (RAW → POACHED). Water carries a thermal
-- state (COLD → AT_POACH_TEMP). The state index makes the transition
-- visible in the type system.

data EggState : Set where
  RAW     : EggState
  POACHED : EggState

data WaterState : Set where
  COLD          : WaterState
  AT-POACH-TEMP : WaterState

record Egg (s : EggState) : Set where
  constructor mkEgg

record Water (s : WaterState) : Set where
  constructor mkWater

record Vinegar : Set where
  constructor mkVinegar


-- =====================================================================
-- § 3. Echo oracles (@water_shimmer, @white_set).
-- =====================================================================
--
-- Two postulated sensor streams. At each minute they report a reading.
-- They are the physical world, not derivable terms; the proof assumes
-- their values exist and discharges the surrounding control flow. See
-- COMMENTARY.adoc §Echo.
--
--   temp-at        — the hob thermometer, in °C, sampled per minute.
--   white-set-at   — the visual albumen-coagulation classifier; reports
--                    a coagulation score, "set" once it crosses 1.
--
-- AXIOM: these are postulated echo-oracle sensor streams — the physical
-- world, not derivable terms. The proof trusts the classifier pipeline
-- and discharges the surrounding control flow; a production lowering
-- replaces each with a verified HAL binding. This is the deliberate
-- proven/postulated trusted-base boundary (COMMENTARY.adoc §Echo; §9(a)
-- below). Trusted base contribution: 2 sensor postulates.
postulate
  temp-at      : Minutes → Celsius
  white-set-at : Minutes → ℕ

-- The albumen is judged "set" once the visual score reaches this value.
set-threshold : ℕ
set-threshold = 1


-- =====================================================================
-- § 4. The Heat step (Tropical + Echo, on_fail ABORT).
-- =====================================================================
--
-- A bounded feedback loop. At each minute, sample the thermometer; if
-- it has reached the shimmer threshold, emit Shimmered with a witness;
-- otherwise decrement fuel and recurse; if fuel hits zero, emit Aborted
-- (the `on_fail ABORT` branch).

-- The shimmer witness: the minute at which temp first met threshold,
-- together with the proof.
ShimmerWitness : Set
ShimmerWitness = Σ[ t ∈ Minutes ] temp-at t ≥ shimmer-threshold

data HeatResult : Set where
  Shimmered : Water AT-POACH-TEMP → ShimmerWitness → HeatResult
  Aborted   : HeatResult

heat : Water COLD → (fuel : ℕ) → (elapsed : Minutes) → HeatResult
heat _ zero    _ = Aborted
heat w (suc n) t with temp-at t ≥? shimmer-threshold
... | yes pf = Shimmered (mkWater) (t , pf)
... | no  _  = heat w n (suc t)


-- =====================================================================
-- § 5. The Poach step (Linear + Echo, on_fail RECOVER).
-- =====================================================================
--
-- Consumes the Egg and the Vinegar. The `on_fail RECOVER` contract
-- means the failure image is `Recovered`, not `Aborted`: a timeout on
-- @white_set in a poach is recoverable (extend under supervisor
-- override) rather than catastrophic. Egg and Vinegar still leave the
-- linear context either way — Recovered does not return them.

WhiteWitness : Set
WhiteWitness = Σ[ t ∈ Minutes ] white-set-at t ≥ set-threshold

data PoachResult : Set where
  -- `WhiteSet`, not `Set`: `Set` is an Agda keyword (the sort of types).
  WhiteSet  : Egg POACHED → WhiteWitness → PoachResult
  Recovered : PoachResult

-- poach consumes Egg RAW and Vinegar; returns neither.
poach : Egg RAW → Vinegar → (fuel : ℕ) → (elapsed : Minutes) → PoachResult
poach _ _ zero    _ = Recovered
poach e v (suc n) t with white-set-at t ≥? set-threshold
... | yes pf = WhiteSet (mkEgg) (t , pf)
... | no  _  = poach e v n (suc t)


-- =====================================================================
-- § 6. The Tropical envelope (GENTLE controller spec).
-- =====================================================================
--
-- The GENTLE slope is what keeps the poach from boiling. We model its
-- guarantee as the controller's specification: under GENTLE, the
-- emitted trajectory never exceeds the target cap. This is the
-- analogue of the sensor postulate — it is the controller's contract,
-- supplied by the HAL, not derived here. A production lowering proves
-- it from an integrator bound on the slope.
--
-- AXIOM: the GENTLE controller's specification, supplied by the HAL and
-- trusted here rather than derived. A production lowering discharges it
-- from an integrator bound on the slope (§9(b)). Trusted base
-- contribution: 1 controller postulate.
postulate
  gentle-bounded : ∀ (t : Minutes) → temp-at t ≤ target-cap


-- =====================================================================
-- § 7. The poached-egg program.
-- =====================================================================
--
-- Direct lowering of the two-stage mission. Stage 1 heats the water;
-- on success the AT-POACH-TEMP water and the shimmer witness are in
-- scope. Stage 2 poaches the egg. The result records both stages.

data ProgramResult : Set where
  -- both stages succeeded: egg poached, both echo witnesses captured.
  Served    : ShimmerWitness → WhiteWitness → ProgramResult
  -- stage 2 hit its budget and recovered.
  HeldWarm  : ShimmerWitness → ProgramResult
  -- stage 1 never reached poach temperature: hardware fault, aborted.
  ColdAbort : ProgramResult

poached-egg : Water COLD → Egg RAW → Vinegar → ProgramResult
poached-egg w e v with heat w heat-budget 0
... | Aborted               = ColdAbort
... | Shimmered _ sw with poach e v poach-budget 0
... | WhiteSet _ ww = Served sw ww
... | Recovered = HeldWarm sw


-- =====================================================================
-- § 8. Obligations, discharged.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Obligation 1 — Termination.
-- ---------------------------------------------------------------------
--
-- Discharged by the structural recursion of `heat` and `poach` on
-- their fuel parameters. Agda's termination checker accepts both; no
-- explicit theorem is required. If this file type-checks, both loops
-- terminate. The measures are the natural numbers passed as `fuel`,
-- i.e. the `max_duration` budgets.

-- ---------------------------------------------------------------------
-- Obligation 2 — Safety (on_fail totality).
-- ---------------------------------------------------------------------
--
-- Every HeatResult is Shimmered or Aborted; every PoachResult is Set
-- or Recovered. Each is a single pattern match — the `on_fail` branch
-- is inhabited and no step gets stuck.

heat-exhaustive : ∀ (r : HeatResult) →
  (Σ[ w ∈ Water AT-POACH-TEMP ] Σ[ s ∈ ShimmerWitness ] r ≡ Shimmered w s)
  ⊎ (r ≡ Aborted)
heat-exhaustive (Shimmered w s) = inj₁ (w , s , refl)
heat-exhaustive Aborted         = inj₂ refl

poach-exhaustive : ∀ (r : PoachResult) →
  (Σ[ e ∈ Egg POACHED ] Σ[ w ∈ WhiteWitness ] r ≡ WhiteSet e w)
  ⊎ (r ≡ Recovered)
poach-exhaustive (WhiteSet e w) = inj₁ (e , w , refl)
poach-exhaustive Recovered      = inj₂ refl

-- ---------------------------------------------------------------------
-- Obligation 3 — Echo witness extraction.
-- ---------------------------------------------------------------------
--
-- A served egg carries both witnesses; held-warm carries the shimmer
-- witness it had already earned. No success exists without its proof.

served-gives-witnesses :
  ∀ (w : Water COLD) (e : Egg RAW) (v : Vinegar)
    {sw : ShimmerWitness} {ww : WhiteWitness} →
  poached-egg w e v ≡ Served sw ww →
  ShimmerWitness × WhiteWitness
served-gives-witnesses _ _ _ {sw = sw} {ww = ww} _ = sw , ww

heldwarm-gives-witness :
  ∀ (w : Water COLD) (e : Egg RAW) (v : Vinegar)
    {sw : ShimmerWitness} →
  poached-egg w e v ≡ HeldWarm sw →
  ShimmerWitness
heldwarm-gives-witness _ _ _ {sw = sw} _ = sw

-- ---------------------------------------------------------------------
-- Obligation 4 — Tropical safety envelope.
-- ---------------------------------------------------------------------
--
-- At every sampled minute the GENTLE controller keeps the water below
-- the boil envelope. Composing the controller spec (§6) with the
-- configuration fact (§1), `temp-at t ≤ 82 < 100`, so `temp-at t < 100`
-- for all t — in particular at the shimmer witness time. The water is
-- never in the forbidden state. This is the Tropical refinement
-- obligation the class's type table requires (`Prevents Binary
-- Overheat`).

tropical-safe : ∀ (t : Minutes) → temp-at t < boil-envelope
tropical-safe t = <-transʳ (gentle-bounded t) cap<boil

-- And, specialised to the witness the program actually produces: a
-- served egg's shimmer fired at a temperature inside the safe band
-- [80, 100).
served-is-safe :
  ∀ (w : Water COLD) (e : Egg RAW) (v : Vinegar)
    {sw : ShimmerWitness} {ww : WhiteWitness} →
  poached-egg w e v ≡ Served sw ww →
  Σ[ t ∈ Minutes ] (temp-at t ≥ shimmer-threshold × temp-at t < boil-envelope)
served-is-safe _ _ _ {sw = (t , ge)} _ = t , ge , tropical-safe t


-- =====================================================================
-- § 9. What is *not* proved here, and what replaces it in production.
-- =====================================================================
--
-- Not proved:
--
--   (a) That `temp-at` / `white-set-at` are sound classifiers. The
--       postulated-oracle boundary: the proof trusts the sensor
--       pipeline (COMMENTARY.adoc §Echo).
--
--   (b) That `gentle-bounded` holds of a real controller. v1.0
--       postulates it as the GENTLE slope's contract; a production
--       port discharges it from an integrator bound on the slope.
--
--   (c) Linearity as a *type-level* discipline. Plain Agda is not
--       linear; Egg and Vinegar single-use holds by inspection of
--       signatures (see header), machine-checked under a QTT-Agda port.
--
--   (d) That ℕ stand-ins for Celsius / Minutes carry their real
--       dimensional content. A production port substitutes
--       dimension-indexed rationals.
--
-- What the file *does* prove:
--
--   (1) `poached-egg` is a total function from Water × Egg × Vinegar
--       to ProgramResult. Termination and exhaustiveness both hold.
--
--   (2) Every Served / HeldWarm return carries the echo witness(es)
--       the caller can extract. No success exists without proof.
--
--   (3) The GENTLE trajectory never reaches the boil envelope — the
--       Tropical "no binary overheat" obligation, discharged for the
--       whole sampled trajectory and specialised to the served egg.
--
-- These correspond to the termination, safety, echo, and tropical
-- obligations named for the Poached Egg in SPEC.adoc §2–§4.
