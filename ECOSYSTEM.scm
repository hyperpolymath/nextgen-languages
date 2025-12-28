;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

;;; ECOSYSTEM.scm — Project Ecosystem Relationships
;;; nextgen-languages
;;; Reference: https://github.com/hyperpolymath/nextgen-languages

(define-module (nextgen-languages ecosystem)
  #:export (repository-map
            satellites
            playgrounds
            dependencies
            integrations))

;;;============================================================================
;;; REPOSITORY MAP
;;; Complete map of all repositories in the ecosystem
;;;============================================================================

(define repository-map
  '((hub
     ((name . "nextgen-languages")
      (url . "https://github.com/hyperpolymath/nextgen-languages")
      (role . "Central coordination, documentation, specifications")
      (contains . (wiki scripts languages .scm-files))))

    (language-satellites
     ((my-lang
       ((url . "https://github.com/hyperpolymath/my-lang")
        (description . "Progressive language family: me → solo → duet → ensemble")
        (dialects . (me solo duet ensemble))
        (implementation . Rust)
        (playground . "https://github.com/hyperpolymath/language-playgrounds")))
      (phronesis
       ((url . "https://github.com/hyperpolymath/phronesis")
        (description . "AI ethics and safety specification language")
        (implementation . Elixir)))
      (eclexia
       ((url . "https://github.com/hyperpolymath/eclexia")
        (description . "Sustainable computing with resource-first constraints")
        (implementation . Rust)))
      (oblibeny
       ((url . "https://github.com/hyperpolymath/oblibeny")
        (description . "Provably secure, Turing-incomplete for hostile environments")
        (implementation . Rust)))
      (anvomidav
       ((url . "https://github.com/hyperpolymath/anvomidav")
        (description . "Formally verified hard real-time systems")
        (implementation . Rust/LLVM)))
      (wokelang
       ((url . "https://github.com/hyperpolymath/wokelang")
        (description . "Human-centric programming with consent and well-being")
        (implementation . Rust)))
      (betlang
       ((url . "https://github.com/hyperpolymath/betlang")
        (description . "Probabilistic programming language")
        (implementation . Racket)))
      (julia-the-viper
       ((url . "https://github.com/hyperpolymath/julia-the-viper")
        (description . "Systems programming with Harvard Architecture")
        (implementation . Rust)))
      (affinescript
       ((url . "https://github.com/hyperpolymath/affinescript")
        (description . "Affine types and dependent types for WASM")
        (implementation . OCaml)))
      (ephapax
       ((url . "https://github.com/hyperpolymath/ephapax")
        (description . "Once-only evaluation with linear semantics")
        (implementation . "TBD")))))

    (tooling-satellites
     ((7-tentacles
       ((url . "https://github.com/hyperpolymath/7-tentacles")
        (description . "Orchestration and satellite coordination tool")
        (role . "Multi-repo management")))
      (language-playgrounds
       ((url . "https://github.com/hyperpolymath/language-playgrounds")
        (description . "Experimentation sandboxes for language learning")
        (role . "Interactive language exploration")))))))

;;;============================================================================
;;; SATELLITES
;;; Submodule configuration for all satellites
;;;============================================================================

(define satellites
  '((configured
     ((betlang . "git@github.com:hyperpolymath/betlang.git")
      (julia-the-viper . "git@github.com:hyperpolymath/julia-the-viper.git")
      (affinescript . "https://github.com/hyperpolymath/affinescript.git")
      (eclexia . "https://github.com/hyperpolymath/eclexia.git")
      (ephapax . "https://github.com/hyperpolymath/ephapax.git")
      (my-lang . "https://github.com/hyperpolymath/my-lang.git")
      (oblibeny . "https://github.com/hyperpolymath/oblibeny.git")
      (phronesis . "https://github.com/hyperpolymath/phronesis.git")
      (wokelang . "https://github.com/hyperpolymath/wokelang.git")
      (7-tentacles . "git@github.com:hyperpolymath/7-tentacles.git")
      (anvomidav . "https://github.com/hyperpolymath/anvomidav.git")
      (language-playgrounds . "https://github.com/hyperpolymath/language-playgrounds.git")))

    (to-add . ())))

;;;============================================================================
;;; PLAYGROUNDS
;;; Language playground relationships
;;;============================================================================

(define playgrounds
  '((hub . "https://github.com/hyperpolymath/language-playgrounds")

    (language-mapping
     ((my-lang . "language-playgrounds/my-lang/")
      (solo . "language-playgrounds/solo/")
      (duet . "language-playgrounds/duet/")
      (ensemble . "language-playgrounds/ensemble/")
      (phronesis . "language-playgrounds/phronesis/")
      (eclexia . "language-playgrounds/eclexia/")
      (wokelang . "language-playgrounds/wokelang/")))

    (features
     ((repl . "Browser-based REPL for each language")
      (examples . "Curated example programs")
      (tutorials . "Interactive tutorials")
      (share . "Share code snippets")))))

;;;============================================================================
;;; DEPENDENCIES
;;; Cross-project dependencies
;;;============================================================================

(define dependencies
  '((shared-infrastructure
     ((echidna
       ((url . "https://github.com/hyperpolymath/echidna")
        (role . "Neurosymbolic theorem proving platform")
        (used-by . (anvomidav oblibeny duet))))
      (instant-sync
       ((role . "Automatic forge propagation")
        (used-by . all)))))

    (language-dependencies
     ((my-lang
       ((depends-on . ())
        (depended-by . ())))
      (duet
       ((depends-on . (solo))
        (note . "Duet extends Solo with AI features")))
      (ensemble
       ((depends-on . (duet))
        (note . "Ensemble extends Duet with native AI")))))))

;;;============================================================================
;;; INTEGRATIONS
;;; External system integrations
;;;============================================================================

(define integrations
  '((forges
     ((primary . GitHub)
      (mirrors . (GitLab Codeberg Bitbucket))
      (sync-tool . "instant-sync")))

    (ci-cd
     ((GitHub-Actions . "Primary CI/CD")
      (workflows . (test build release mirror))))

    (documentation
     ((wiki . "GitHub Wiki format")
      (api-docs . "Language-specific (rustdoc, etc.)")
      (specs . ".scm files in repo root")))))

;;; End of ECOSYSTEM.scm
