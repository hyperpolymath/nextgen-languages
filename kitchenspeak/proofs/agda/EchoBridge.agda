-- SPDX-License-Identifier: MPL-2.0
-- Copyright (c) 2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
--
-- =====================================================================
-- KitchenSpeak — Echo Bridge to the echo-types library
-- =====================================================================
--
-- STATUS (per decisions/0004-echo-attaches-to-linear-dyadic.adoc):
-- TEMPORARY SMOKE-TEST BRIDGE — not the canonical Echo attachment.
-- Q1 is decided B-now / C-later / A-shim: echo-types attaches *primarily*
-- to KitchenSpeak's Linear/Dyadic consumption types (irreversible
-- transformation with retained provenance: Flour ⊗ Water → Dough), with
-- the @/sensor-witness demoted to a secondary adapter/example. The Boolean
-- classifier below is the degenerate fiber the global Echo principle warns
-- against (a yes/no tag, not retained-loss lineage); it stands only as a
-- smoke-test until the real lineage/residue attachment is built against
-- echo-types' decorated modules (EchoLinear / EchoResidue /
-- EchoResidueTaxonomy), which requires the echo-types repo in scope.
-- Do NOT treat this Bool/@ bridge as canon.
--
-- KitchenSpeak's Echo (@) type is a *postulated-oracle witness*: a
-- dependent pair of a sensor sample time and a proof the sensor met its
-- threshold there (Dough.agda's `Witness`, PoachedEgg.agda's
-- `ShimmerWitness` / `WhiteWitness`).
--
-- The hyperpolymath/echo-types library (module `Echo`) gives the
-- canonical, mechanised form of exactly this structure — the *fiber*:
--
--     Echo : (f : A → B) → B → Set
--     Echo f y = Σ A (λ x → f x ≡ y)
--
-- i.e. "which inputs map to y", the proof-relevant record of structured
-- loss (a non-injective classifier forgets *which* sample fired, but the
-- Echo retains that one did). This module wires KitchenSpeak's Echo type
-- onto that library type so the planned type checker (ROADMAP Phase 3)
-- and the proofs share a single, mechanised notion of Echo rather than
-- an ad-hoc Σ. See decisions/0003-echo-types-dependency.adoc.
--
-- The reconciliation. KitchenSpeak's witness is a fiber over a
-- *predicate* (`sensor t ≥ thr`); echo-types' Echo is a fiber over an
-- *equality* (`f x ≡ y`). We bridge by viewing each threshold oracle as
-- a Boolean *classifier* `fired s thr t = ⌊ s t ≥? thr ⌋`, whose Echo
-- over `true` is the KitchenSpeak witness. The classifier is the lossy
-- function; the Echo is its structured-loss witness.
--
-- ---------------------------------------------------------------------
-- STATUS: MACHINE-CHECKED (2026-06-12). This module now typechecks against
-- the real echo-types library (module `Echo`), with echo-types +
-- absolute-zero + agda-stdlib v2.3 registered, under Agda 2.6.3. The
-- earlier "hand-verified by careful reading" caveat is retired: the
-- `Echo` import and the witness⇔echo bridge below are confirmed by the
-- type checker, not by eye. The flag stance (this module is left at
-- Agda's default discipline, importing the `--safe --without-K` `Echo`)
-- is confirmed: a default-discipline module may import the `--safe
-- --without-K` `Echo`.
--
-- Reproduce (matching echo-types' own CI toolchain, Agda 2.6.3):
--   LC_ALL=C.UTF-8 agda --no-libraries \
--     -i . -i <echo-types>/proofs/agda -i <agda-stdlib>/src EchoBridge.agda
-- (The `make echobridge` target uses kitchenspeak.agda-lib, whose `--`
-- comments require Agda ≥ 2.6.4; on the 2.6.3 CI toolchain use the
-- explicit `-i` form above. See proofs/README.adoc.)
-- ---------------------------------------------------------------------

module EchoBridge where

open import Data.Bool       using (Bool; true; false)
open import Data.Nat        using (ℕ; _≥_; _≥?_)
open import Data.Product    using (Σ; _,_; Σ-syntax)
open import Data.Empty      using (⊥-elim)
open import Relation.Nullary using (yes; no)
open import Relation.Nullary.Decidable using (⌊_⌋)
open import Relation.Binary.PropositionalEquality using (_≡_; refl)

-- The Echo (fiber) type from hyperpolymath/echo-types (module `Echo`):
--   Echo f y = Σ A (λ x → f x ≡ y)
open import Echo using (Echo)


-- =====================================================================
-- § 1. The threshold oracle as a Boolean classifier.
-- =====================================================================
--
-- A KitchenSpeak echo-oracle samples a sensor `s : ℕ → ℕ` (reading per
-- minute) and asks whether it has met a threshold `thr`. As a function
-- into Bool this is the (generally non-injective) classifier whose Echo
-- carries the structured loss: many minutes map to `true`, and the Echo
-- records that *some* qualifying minute exists without pinning which.

fired : (ℕ → ℕ) → ℕ → ℕ → Bool
fired s thr t = ⌊ s t ≥? thr ⌋


-- =====================================================================
-- § 2. The two presentations of a KitchenSpeak Echo witness.
-- =====================================================================
--
-- ThresholdWitness — the form used inline in Dough.agda / PoachedEgg.agda
--                    (`Σ[ t ] sensor t ≥ thr`).
-- SensorEcho       — the echo-types form: the fiber `Echo (fired …) true`.

ThresholdWitness : (ℕ → ℕ) → ℕ → Set
ThresholdWitness s thr = Σ[ t ∈ ℕ ] s t ≥ thr

SensorEcho : (ℕ → ℕ) → ℕ → Set
SensorEcho s thr = Echo (fired s thr) true


-- =====================================================================
-- § 3. The bridge: KitchenSpeak's @-witness IS an echo-types Echo.
-- =====================================================================
--
-- The two lemmas establish `s t ≥ thr  ⟺  fired s thr t ≡ true`, lifted
-- to the Σ/Echo level. Stating the goal with `⌊ s t ≥? thr ⌋` (which is
-- `fired s thr t` by definition) keeps the `with`-abstraction robust.

≥⇒fired : ∀ (s : ℕ → ℕ) (thr t : ℕ) → s t ≥ thr → ⌊ s t ≥? thr ⌋ ≡ true
≥⇒fired s thr t pf with s t ≥? thr
... | yes _ = refl
... | no ¬p = ⊥-elim (¬p pf)

fired⇒≥ : ∀ (s : ℕ → ℕ) (thr t : ℕ) → ⌊ s t ≥? thr ⌋ ≡ true → s t ≥ thr
fired⇒≥ s thr t eq with s t ≥? thr
... | yes p = p
... | no  _ with eq
...           | ()

-- KitchenSpeak threshold witness  →  echo-types Echo.
witness⇒echo : ∀ {s thr} → ThresholdWitness s thr → SensorEcho s thr
witness⇒echo {s} {thr} (t , pf) = t , ≥⇒fired s thr t pf

-- echo-types Echo  →  KitchenSpeak threshold witness.
echo⇒witness : ∀ {s thr} → SensorEcho s thr → ThresholdWitness s thr
echo⇒witness {s} {thr} (t , eq) = t , fired⇒≥ s thr t eq


-- =====================================================================
-- § 4. Usage from the recipe proofs.
-- =====================================================================
--
-- Dough.agda and PoachedEgg.agda keep their inline `Σ[ t ] sensor t ≥
-- thr` witnesses (so their structural-recursion proofs are unchanged),
-- and may present them as echo-types Echoes through `witness⇒echo`:
--
--     viscosity-echo : Witness → SensorEcho viscosity-at kneaded-threshold
--     viscosity-echo = witness⇒echo
--
-- The planned KitchenSpeak type checker (ROADMAP Phase 3) takes
-- `Echo (fired sensor thr) true` as the canonical typing of an `@`
-- witness, with EchoTypes.jl as the finite-domain runtime/HAL model.
