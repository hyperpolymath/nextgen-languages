// SPDX-License-Identifier: PMPL-1.0-or-later
// Copyright (c) 2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
//
// ============================================================================
// KitchenSpeak — Worked Example: the Poached Egg Proof
// ============================================================================
//
// Purpose.  The minimum KitchenSpeak program that exercises all three of
//     Linear (the egg), Tropical (the water temperature), and Echo (the
//     visual witness that the white has set).
//
// Companion examples in the family:
//     - Dough   — Linear + Dyadic + Choreographic + Echo.
//     - Soup    — Ceremonial + Choreographic + Echo + Tropical.
//     - Sear    — Tropical + Echo + Primitive (later).
//     - Emulsion — Tropical + Linear (later).
//
// This example uses Ceremonial lightly (Breakfast_Brisk) so the class sees
// how a ceremony scopes a mission, but the load-bearing teaching content is
// the three-type triangle Linear / Tropical / Echo.
//
// Every step carries the three production-mandatory constructs:
//     - until       — the postcondition (Tropical or Echo witness)
//     - max_duration — the termination witness
//     - on_fail     — the total failure handler
//
// ============================================================================


// ---------------------------------------------------------------------------
// Ambient declarations.
//
// `Water` and `Egg` are top-level resources — available across missions.
// Declaring `Egg` as `state RAW` is the typestate that the Linear type
// system tracks; the `Poach` action will consume `Egg[state RAW]` and produce
// nothing (it is consumed into a served-egg effect on the hob's plate buffer).
// ---------------------------------------------------------------------------

resource Water state LIQUID;
resource Egg   state RAW;


// ---------------------------------------------------------------------------
// Chef persona.
//
// `chef_decl` is left open in v1.0. The shape used here follows the class's
// Actor Model requirement (SPEC.adoc §3.2): a hardware wrapper carrying a
// style tag. `PRECISION` selects the Delia envelope — low jitter, high
// accuracy — appropriate for poaching, which is unforgiving about
// temperature drift.
// ---------------------------------------------------------------------------

chef Delia_Hob style PRECISION;


// ---------------------------------------------------------------------------
// Echo declarations.
//
// `echo_decl` is left open in v1.0. Each echo names a sensor stream plus
// the modality it lives on. Both witnesses used in this program are VISUAL
// — the poach is judged by eye, not by ear:
//
//     @water_shimmer — the pre-boil shimmer that tells us the water has
//                      reached poach temperature without crossing into a
//                      rolling boil.
//
//     @white_set     — the moment the albumen has coagulated into an
//                      opaque, lightly set mass around the yolk.
//
// Each echo is a *postulated oracle* (see COMMENTARY.adoc §Echo): Agda
// treats the classifier as sound by axiom and discharges the surrounding
// control flow.
// ---------------------------------------------------------------------------

echo @water_shimmer on Delia_Hob.visual;
echo @white_set     on Delia_Hob.visual;


// ---------------------------------------------------------------------------
// Ceremony.
//
// Breakfast_Brisk pictures a weekday morning: the pacing is brisk (we care
// about finishing on time), the alert level is modest (a kitchen, not a
// fire drill), and the optimisation priority is timing rather than, say,
// presentation. This ceremony scopes the orchestrate block below.
// ---------------------------------------------------------------------------

ceremony Breakfast_Brisk {
    pace: BRISK,
    alert_level: 4,
    priority: TIMING
}


// ===========================================================================
// Mission: the poached egg.
// ===========================================================================

orchestrate under Breakfast_Brisk {

    // -----------------------------------------------------------------------
    // Mission-scoped resource.
    //
    // Vinegar is declared inside the orchestrate, so it is born and consumed
    // within this mission only. (Patch 3 in grammar.ebnf permits this.)
    // A small amount of acid nudges the albumen to coagulate faster, which
    // the @white_set classifier downstream is calibrated to exploit.
    // -----------------------------------------------------------------------

    resource Vinegar state LIQUID;

    // -----------------------------------------------------------------------
    // Step 1 — bring water to poach temperature.
    //
    // Types exercised:
    //     Tropical   — setpoint `target: 82C` with a GENTLE slope; the
    //                  `until ~ temp >= 80C` guard refines the trajectory.
    //     Primitive  — 82C and 80C are dimensioned quantities in °C; the
    //                  8min is a quantity in time.
    //     Echo       — `proving @water_shimmer` names the witness that
    //                  releases the synchronisation barrier.
    //
    // Termination is guaranteed by the 8-minute max_duration; safety is
    // guaranteed by the on_fail ABORT (a cold hob at eight minutes is a
    // hardware fault, not a cooking problem).
    // -----------------------------------------------------------------------

    sync(Delia_Hob) proving @water_shimmer {
        Delia_Hob.Heat(target: 82C, slope: GENTLE)
            until ~ temp >= 80C
            max_duration 8min
            on_fail ABORT;
    }

    // -----------------------------------------------------------------------
    // Step 2 — poach.
    //
    // Types exercised:
    //     Linear     — `Egg` is passed as an argument and is consumed by
    //                  this action. A second call to `Poach(Egg, ...)` is a
    //                  type error: the egg no longer exists in the linear
    //                  context after this step. `Vinegar` is likewise
    //                  consumed.
    //     Echo       — the primary postcondition `until @white_set == true`
    //                  is the visual witness, resolved against a local
    //                  classifier (Zero Scams — SPEC.adoc §6 — means no
    //                  cloud round-trip).
    //     Ceremonial — the ambient Breakfast_Brisk ceremony tightens the
    //                  4-minute max_duration's effective budget; a Sunday
    //                  ceremony would relax it.
    //
    // on_fail RECOVER is chosen deliberately: a timeout on @white_set in a
    // poach is more often recoverable (e.g. extend by 30s under a supervisor
    // override) than catastrophic. ABORT here would waste the egg, which
    // Linear semantics correctly model as permanent loss.
    // -----------------------------------------------------------------------

    sync(Delia_Hob) proving @white_set {
        Delia_Hob.Poach(Egg, acidulant: Vinegar, depth: 4cm)
            until @white_set == true
            max_duration 4min
            on_fail RECOVER;
    }
}


// ---------------------------------------------------------------------------
// What Agda sees when this program is lowered.
//
// For each `sync(...) proving @w { step }` block:
//
//   Termination obligation:
//     The `until`-loop's well-founded measure is `max_duration - elapsed`,
//     which is strictly decreasing in wall-clock time. Totality is
//     discharged by the standard measure argument.
//
//   Safety obligation:
//     The `on_fail` branch is inhabited (ABORT, RECOVER, and WARM are all
//     total). The sync_block therefore inhabits a total function into
//     `{success @w} ⊎ {aborted, recovered, warmed}`.
//
//   Witness obligation:
//     The `proving @w` clause introduces an existential `∃ t. @w(t)` which
//     the postulated classifier is assumed to inhabit if and only if the
//     loop exits normally. This is the postulate discussed in
//     COMMENTARY.adoc §Echo.
//
// For the Linear contract:
//
//   After the `Poach` action, `Egg` and `Vinegar` have left the linear
//   context. Any subsequent reference to `Egg` is ill-typed. This is
//   exactly what keeps the class's "no hallucinated ingredients" invariant
//   honest.
//
// For the Tropical contract:
//
//   The Heat step's trajectory is bounded by `slope: GENTLE` and target
//   82C, and the forbidden upper envelope (a rolling boil, around 100C at
//   standard pressure) is never entered. This is a refinement check on the
//   time-indexed temperature stream; the GENTLE slope makes the check a
//   straightforward integral bound.
// ---------------------------------------------------------------------------
