;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

;;; STATE.scm — Project Checkpoint and Session History
;;; nextgen-languages
;;; Reference: https://github.com/hyperpolymath/nextgen-languages

(define-module (nextgen-languages state)
  #:export (project-checkpoint
            session-history
            migration-state
            blockers))

;;;============================================================================
;;; PROJECT CHECKPOINT
;;; Current state of the project as of last update
;;;============================================================================

(define project-checkpoint
  '((last-updated . "2025-12-28")
    (updated-by . "claude/add-language-manifest-rDBhd")

    (languages-status
     ((my-lang
       ((status . to-verify)
        (dialects . (me solo duet ensemble))
        (implementation . Rust)
        (submodule . "my-lang/")))
      (phronesis
       ((status . diverged)
        (gitlab . "Original design")
        (github . "Elixir implementation")
        (action-needed . "Evaluate and merge")))
      (eclexia
       ((status . not-synced)
        (priority . 1)
        (gitlab . "70-page white paper + Rust compiler")
        (github . "Template only")
        (action-needed . "Sync from GitLab immediately")))
      (oblibeny
       ((status . diverged)
        (gitlab-commits . 40)
        (github-commits . 30)
        (action-needed . "Manual merge")))
      (anvomidav
       ((status . active)
        (url . "https://github.com/hyperpolymath/anvomidav")
        (note . "Recently added as satellite")))
      (wokelang
       ((status . diverged)
        (gitlab . "Original design")
        (github . "Rust bytecode VM")
        (action-needed . "Evaluate and merge")))
      (betlang
       ((status . to-verify)
        (implementation . Racket)))
      (julia-the-viper
       ((status . to-verify)
        (implementation . Rust)))
      (affinescript
       ((status . to-verify)
        (implementation . OCaml)))
      (ephapax
       ((status . to-verify)
        (implementation . "TBD")))))

    (infrastructure-status
     ((hub-repo . active)
      (wiki . "12 pages, 70+ stubs needed")
      (ci-cd . configured)
      (mirrors . pending)))))

;;;============================================================================
;;; SESSION HISTORY
;;; Record of significant development sessions
;;;============================================================================

(define session-history
  '((sessions
     ((session-2025-12-28-manifest
       ((branch . "claude/add-language-manifest-rDBhd")
        (changes
         ("Created MANIFEST.md with language index"
          "Created languages/ directory with per-language READMEs"
          "Added core invariants for each language"
          "Created META.scm, STATE.scm, ECOSYSTEM.scm"
          "Added anvomidav and language-playgrounds as satellites"
          "Updated README.adoc with actual repo links"))
        (commits . TBD)))

      (session-2025-12-16-migration
       ((focus . "Migration planning")
        (changes
         ("Created MIGRATION-STATUS.md"
          "Created MIGRATION-STRATEGY.md"
          "Identified diverged repos"))
        (outcome . "Strategy documented, execution pending")))

      (session-2025-10-original
       ((focus . "Initial language design")
        (changes
         ("Created LANGUAGES.scm"
          "Defined 8 core languages"
          "Established design philosophy"))
        (platform . "GitLab")))))))

;;;============================================================================
;;; MIGRATION STATE
;;; Status of GitLab → GitHub migration
;;;============================================================================

(define migration-state
  '((source-of-truth . GitHub)
    (target-mirrors . (GitLab Codeberg Bitbucket))

    (phase . 1)
    (phase-description . "Language repos sync")

    (repos
     ((synced . ())
      (to-verify . (betlang julia-the-viper my-lang affinescript ephapax))
      (diverged . (phronesis wokelang oblibeny))
      (not-synced . (eclexia))
      (naming-issue . (anvomidav))))

    (priority-queue
     ((1 . eclexia)
      (2 . phronesis)
      (3 . wokelang)
      (4 . oblibeny)))))

;;;============================================================================
;;; BLOCKERS
;;; Current issues blocking progress
;;;============================================================================

(define blockers
  '((active
     ((blocker-001
       ((title . "Eclexia not synced from GitLab")
        (severity . critical)
        (description . "70-page white paper and Rust compiler only on GitLab")
        (resolution . "Manual sync required with GitLab access")
        (owner . "maintainer")))

      (blocker-002
       ((title . "Diverged implementations need decisions")
        (severity . high)
        (description . "phronesis, wokelang, oblibeny have different work on GitLab vs GitHub")
        (resolution . "Review both implementations, decide which to keep/merge")
        (owner . "maintainer")))))

    (resolved . ())))

;;; End of STATE.scm
