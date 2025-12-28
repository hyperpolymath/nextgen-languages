;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

;;; STATE.scm — Project Checkpoint (state.scm format)
;;; nextgen-languages
;;; Reference: https://github.com/hyperpolymath/state.scm

(define-module (nextgen-languages state)
  #:export (state))

;;;============================================================================
;;; STATE — Checkpoint for AI conversation context persistence
;;; Format: https://github.com/hyperpolymath/state.scm
;;;============================================================================

(define state
  '((metadata
     ((format-version . "0.1.0")
      (schema-version . "2025-12-28")
      (created-at . "2025-10-01T00:00:00Z")
      (last-updated . "2025-12-28T00:00:00Z")
      (generator . "claude-code")))

    (user
     ((name . "Jonathan D.A. Jewell")
      (roles . (maintainer architect))
      (preferences
       ((language-policy . "hyperpolymath-standard")
        (primary-languages . (Rust ReScript Gleam Guile))
        (banned . (TypeScript Node npm Go))))))

    (session
     ((conversation-id . "claude/add-language-manifest-rDBhd")
      (started-at . "2025-12-28T00:00:00Z")
      (focus . "ecosystem-expansion")))

    (focus
     ((current-project . "nextgen-languages")
      (current-phase . "consolidation")
      (blocking-projects . (eclexia-sync gitlab-migration))))

    (projects
     ;; Core 8 Languages
     ((my-lang
       ((name . "My-Lang Family")
        (status . to-verify)
        (completion . 20)
        (category . educational)
        (phase . design)
        (dialects . (me solo duet ensemble))
        (implementation . Rust)
        (next . ("Set up dialect subfolders" "Define progression curriculum"))))

      (phronesis
       ((name . "Phronesis")
        (status . diverged)
        (completion . 30)
        (category . ai-safety)
        (blockers . ("GitLab has original design" "GitHub has Elixir impl"))
        (next . ("Evaluate both implementations" "Decide merge strategy"))))

      (eclexia
       ((name . "Eclexia")
        (status . not-synced)
        (completion . 40)
        (category . sustainable-computing)
        (blockers . ("70-page white paper only on GitLab" "Rust compiler only on GitLab"))
        (next . ("PRIORITY: Sync from GitLab"))))

      (oblibeny
       ((name . "Oblíbený")
        (status . diverged)
        (completion . 35)
        (category . security-critical)
        (blockers . ("40 commits on GitLab" "30 commits on GitHub" "Manual merge needed"))))

      (anvomidav
       ((name . "Anvomidav")
        (status . active)
        (completion . 15)
        (category . real-time-systems)
        (next . ("Define type system" "Implement scheduler"))))

      (wokelang
       ((name . "WokeLang")
        (status . diverged)
        (completion . 25)
        (category . human-centric)
        (blockers . ("GitLab has original" "GitHub has Rust VM"))))

      (betlang
       ((name . "betlang")
        (status . to-verify)
        (completion . 50)
        (category . probabilistic)
        (implementation . Racket)))

      (julia-the-viper
       ((name . "julia-the-viper")
        (status . to-verify)
        (completion . 20)
        (category . systems)
        (implementation . Rust)))

      (affinescript
       ((name . "AffineScript")
        (status . to-verify)
        (completion . 15)
        (category . type-systems)
        (implementation . OCaml)))

      (ephapax
       ((name . "Ephapax")
        (status . to-verify)
        (completion . 10)
        (category . linear-semantics)
        (implementation . TBD)))))

    (critical-next
     ((1 . "Sync eclexia from GitLab (70-page white paper + Rust compiler)")
      (2 . "Resolve phronesis divergence (GitLab original vs GitHub Elixir)")
      (3 . "Resolve wokelang divergence (GitLab original vs GitHub Rust)")
      (4 . "Merge oblibeny branches (40 GitLab + 30 GitHub commits)")
      (5 . "Set up my-lang dialect subfolders (me/solo/duet/ensemble)")))

    (issues
     ((migration
       ((id . "issue-001")
        (title . "GitLab → GitHub migration incomplete")
        (severity . critical)
        (description . "Original work from Aug-Oct 2025 on GitLab not synced")
        (affected . (eclexia phronesis wokelang oblibeny))))

      (structure
       ((id . "issue-002")
        (title . "my-lang needs dialect subfolders")
        (severity . medium)
        (description . "me/solo/duet/ensemble should be subfolders of my-lang")))))

    (history
     ((velocity
       ((2025-12-28 . ((tasks-completed . 15) (files-created . 28)))
        (2025-12-16 . ((tasks-completed . 5) (focus . "migration-planning")))
        (2025-10-01 . ((tasks-completed . 10) (focus . "initial-design")))))))))

;;; End of STATE.scm
