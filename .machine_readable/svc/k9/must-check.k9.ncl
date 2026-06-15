K9!
# SPDX-License-Identifier: MPL-2.0
# K9 Yard-level validator: MUST-check
# Security Level: Yard (Nickel evaluation with contracts; no I/O)
#
# Runnable surface of the hard invariants declared in
# ../../MUST.contractile and ../../contractiles/must/Mustfile.a2ml.
# CI (quality.yml) runs this on every PR; `error`-severity failures block
# merge. Keep the check IDs aligned with Mustfile.a2ml section names.

{
  pedigree = {
    schema_version = "1.0.0",
    component_type = "must-validator",
    security = {
      leash = 'Yard,
      trust_level = "validated-config",
      allow_network = false,
      allow_filesystem_write = false,
      allow_subprocess = false,
    },
    metadata = {
      name = "must-check",
      version = "1.0.0",
      description = "Machine-checks the nextgen-languages MUST invariants (hub-level hygiene; submodule trees are each repo's own concern).",
      author = "Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>",
      paired_files = [
        "../../MUST.contractile",
        "../../contractiles/must/Mustfile.a2ml",
      ],
    },
  },

  # Each check declares a severity and a shell predicate (exit 0 = pass).
  # A K9 'Yard runner evaluates these; it does not itself run the shell —
  # the predicate string is handed to the CI executor named in `run`.
  checks = {
    license_present = {
      description = "LICENSE file must exist",
      severity = 'error,
      predicate = "test -f LICENSE",
    },

    ai_manifest_present = {
      description = "0-AI-MANIFEST.a2ml entry point must exist",
      severity = 'error,
      predicate = "test -f 0-AI-MANIFEST.a2ml",
    },

    machine_readable_dir = {
      description = ".machine_readable/ directory preserved",
      severity = 'error,
      predicate = "test -d .machine_readable",
    },

    no_root_scm_duplication = {
      description = "No STATE/META/ECOSYSTEM state file orphaned in repo root (canonical home is .machine_readable/6a2/)",
      severity = 'error,
      predicate = "! ls STATE.* META.* ECOSYSTEM.* 2>/dev/null | head -1 | grep -q .",
    },

    six_a_two_complete = {
      description = "The 6a2 metadata set is complete (>= 6 .a2ml files)",
      severity = 'warning,
      predicate = "test $(ls .machine_readable/6a2/*.a2ml 2>/dev/null | wc -l) -ge 6",
    },

    spdx_on_machine_readable = {
      description = "Every .a2ml under .machine_readable/ carries an SPDX header",
      severity = 'warning,
      predicate = "! grep -rL 'SPDX-License-Identifier' .machine_readable --include='*.a2ml' 2>/dev/null | head -1 | grep -q .",
    },

    no_agpl = {
      description = "No AGPL references in dotfiles (estate policy is MPL-2.0)",
      severity = 'error,
      predicate = "! grep -rE 'AGPL-3[.]0' .gitignore .gitattributes .editorconfig 2>/dev/null | head -1 | grep -q .",
    },

    actions_sha_pinned = {
      description = "Third-party GitHub Actions are SHA-pinned (reusable callers to hyperpolymath/standards excepted)",
      severity = 'warning,
      predicate = "! grep -rEn 'uses:[[:space:]]+[^#]+@(main|master|v[0-9]+)[[:space:]]*$' .github/workflows 2>/dev/null | grep -v 'hyperpolymath/standards' | head -1 | grep -q .",
    },

    hypatia_waiver_registry = {
      description = "Hypatia accepted-findings registry exists (NEUROSYM.a2ml)",
      severity = 'warning,
      predicate = "grep -q '\\[accepted-findings\\]' .machine_readable/6a2/NEUROSYM.a2ml",
    },

    kitchenspeak_postulate_axiom = {
      description = "KitchenSpeak Agda postulates remain annotated as trusted base (AXIOM marker)",
      severity = 'warning,
      predicate = "test ! -d kitchenspeak/proofs/agda || ! grep -rl 'postulate' kitchenspeak/proofs/agda --include='*.agda' 2>/dev/null | xargs -r grep -L 'AXIOM' 2>/dev/null | head -1 | grep -q .",
    },
  },

  run = {
    executor = "ci:quality.yml",
    on_error_severity = "exit-nonzero",   # error-severity failures block merge
    on_warning_severity = "report-only",
    report_format = "a2ml",
  },
}
