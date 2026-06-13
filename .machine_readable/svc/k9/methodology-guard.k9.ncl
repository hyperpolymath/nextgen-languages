# SPDX-License-Identifier: MPL-2.0
# Copyright (c) 2026 Jonathan D.A. Jewell (hyperpolymath) <j.d.a.jewell@open.ac.uk>
#
# K9 Validator: Methodology Guard (nextgen-languages)
# Security Level: Yard (Nickel evaluation; no I/O)
#
# Checks that agent work respects the methodology constraints declared in
# ../../agent_instructions/methodology.a2ml.
#
# Usage: k9 validate methodology-guard

let methodology_guard = {
  name = "methodology-guard",
  version = "1.0.0",
  description = "Validates that agent work respects declared methodology constraints",

  source_of_truth = ".machine_readable/agent_instructions/methodology.a2ml",

  checks = {
    believe_me_ceiling = {
      description = "believe_me count must not exceed the declared ceiling",
      severity = "error",
      pattern = "believe_me",
      ceiling_key = "methodology.divergent-invariants.believe-me-ceiling",
      default_ceiling = 0,
      note = "Hub-level scan; submodule trees enforce their own ceilings.",
    },

    assert_total_ceiling = {
      description = "assert_total count must not exceed the declared ceiling",
      severity = "error",
      pattern = "assert_total",
      ceiling_key = "methodology.divergent-invariants.assert-total-ceiling",
      default_ceiling = 0,
    },

    state_not_template = {
      description = "STATE.a2ml must not contain template placeholders",
      severity = "warning",
      file = ".machine_readable/6a2/STATE.a2ml",
      reject_patterns = ["{{PLACEHOLDER}}", "{{PROJECT}}", "rsr-template-repo"],
      reject_key = "methodology.state-validation.reject-if-contains",
    },

    state_not_stale = {
      description = "STATE.a2ml last-updated should be within the staleness threshold",
      severity = "info",
      file = ".machine_readable/6a2/STATE.a2ml",
      staleness_key = "methodology.state-validation.staleness-threshold-days",
      default_staleness_days = 90,
    },

    coverage_updated = {
      description = "coverage.a2ml should be refreshed within 30 days",
      severity = "info",
      file = ".machine_readable/agent_instructions/coverage.a2ml",
      staleness_days = 30,
    },

    spike_required = {
      description = "Sessions must ship code, not only designs (methodology.spike-required)",
      severity = "info",
      key = "methodology.spike-required",
      expected = true,
    },
  },

  # KNOWN GAP: methodology.a2ml still carries template defaults for
  # unique-strength, divergent-invariants.rules, and known-constraints.
  # Until those are filled, the divergent-mode checks fall back to defaults.
  open_gaps = [
    "methodology.unique-strength.description == {{PROJECT_UNIQUE_STRENGTH}}",
    "methodology.divergent-invariants.rules == []",
    "methodology.known-constraints.constraints == []",
  ],
}
in methodology_guard
