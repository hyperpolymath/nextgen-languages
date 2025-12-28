;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

;;; META.scm — Architecture Decisions and Development Practices
;;; nextgen-languages
;;; Reference: https://github.com/hyperpolymath/nextgen-languages

(define-module (nextgen-languages meta)
  #:export (architecture-decisions
            development-practices
            technology-stack
            governance))

;;;============================================================================
;;; ARCHITECTURE DECISIONS
;;; Key architectural choices and their rationale
;;;============================================================================

(define architecture-decisions
  '((decisions
     ((ADR-001
       ((title . "Hub and Satellite Repository Structure")
        (status . accepted)
        (date . "2025-10")
        (context . "Need to manage 8+ languages with shared tooling")
        (decision . "Central hub repo with git submodules for each language")
        (rationale . "Enables independent development while maintaining cohesion")
        (consequences
         ((positive . ("Independent versioning" "Clear ownership" "Focused PRs"))
          (negative . ("Submodule complexity" "Cross-repo coordination"))))))

      (ADR-002
       ((title . "Guile Scheme for Configuration and State")
        (status . accepted)
        (date . "2025-10")
        (context . "Need machine-readable, human-editable project metadata")
        (decision . "Use Guile Scheme (.scm) for all project configuration")
        (rationale . "Homoiconic, version-controllable, tooling-friendly")
        (consequences
         ((positive . ("Programmatic access" "Git-friendly diffs" "Self-documenting"))
          (negative . ("Learning curve for non-Lisp users"))))))

      (ADR-003
       ((title . "Rust as Primary Implementation Language")
        (status . accepted)
        (date . "2025-10")
        (context . "Need performant, safe language for compiler implementations")
        (decision . "Rust for all language compilers/interpreters")
        (rationale . "Memory safety, performance, excellent tooling")
        (consequences
         ((positive . ("Safety guarantees" "Cross-platform" "WASM target"))
          (negative . ("Steep learning curve" "Compile times"))))))

      (ADR-004
       ((title . "GitHub as Single Source of Truth")
        (status . accepted)
        (date . "2025-12")
        (context . "Work split across GitLab, GitHub, Codeberg")
        (decision . "Consolidate on GitHub with push mirrors to other forges")
        (rationale . "Simplify collaboration, reduce confusion")
        (consequences
         ((positive . ("Single workflow" "Clear authority" "Easier onboarding"))
          (negative . ("Platform dependency" "Migration effort"))))))))))

;;;============================================================================
;;; DEVELOPMENT PRACTICES
;;; Standards and conventions for development
;;;============================================================================

(define development-practices
  '((coding-standards
     ((rust
       ((edition . "2021")
        (formatter . "rustfmt")
        (linter . "clippy")
        (documentation . "rustdoc with examples")))
      (scheme
       ((style . "Guile conventions")
        (indentation . 2)
        (max-line-length . 100)))
      (general
       ((commits . "Conventional Commits format")
        (branches . "feature/, fix/, docs/, chore/")
        (reviews . "Required for main branch")))))

    (testing
     ((unit-tests . "Required for all public APIs")
      (integration-tests . "Required for language features")
      (property-tests . "Recommended for type systems")
      (fuzzing . "Required for parsers")
      (coverage-target . "80% minimum")))

    (documentation
     ((inline . "All public items documented")
      (examples . "Every module has runnable examples")
      (wiki . "User-facing documentation in wiki/")
      (adr . "Architecture decisions in META.scm")))

    (versioning
     ((scheme . "Semantic Versioning 2.0.0")
      (pre-1.0 . "Breaking changes allowed with minor bump")
      (changelog . "Keep a CHANGELOG format")))))

;;;============================================================================
;;; TECHNOLOGY STACK
;;; Approved technologies per Hyperpolymath Standard
;;;============================================================================

(define technology-stack
  '((allowed
     ((languages
       ((ReScript . "Primary application code")
        (Rust . "Compilers, CLI tools, WASM")
        (Gleam . "Backend services")
        (Guile-Scheme . "Configuration, metaprogramming")
        (OCaml . "AffineScript compiler")
        (Julia . "Batch scripts, data processing")
        (Ada . "Safety-critical systems")
        (Bash . "Scripts, automation")))
      (runtimes
       ((Deno . "JavaScript/TypeScript runtime")
        (BEAM . "Gleam/Elixir backend")))
      (frameworks
       ((Tauri . "Desktop/mobile apps")
        (Dioxus . "Native UI in Rust")))
      (tools
       ((Guix . "Primary package management")
        (Nix . "Fallback package management")
        (Nickel . "Complex configuration")))))

    (banned
     ((TypeScript . "Use ReScript")
      (Node.js . "Use Deno")
      (npm . "Use Deno")
      (Bun . "Use Deno")
      (Go . "Use Rust")
      (Python . "SaltStack only")
      (Java . "Use Rust/Tauri")
      (Kotlin . "Use Rust/Tauri")
      (Swift . "Use Rust/Dioxus")
      (React-Native . "Use Tauri/Dioxus")
      (Flutter . "Use Tauri/Dioxus")))))

;;;============================================================================
;;; GOVERNANCE
;;; Project governance and decision-making
;;;============================================================================

(define governance
  '((maintainers
     ((primary . "Jonathan D.A. Jewell")
      (contact . "hyperpolymath")))

    (decision-process
     ((minor . "Maintainer discretion")
      (major . "ADR required, documented in META.scm")
      (breaking . "Community discussion, migration guide")))

    (licensing
     ((code . "MIT OR AGPL-3.0-or-later")
      (documentation . "CC-BY-SA-4.0")
      (requirement . "SPDX headers on all files")))

    (contribution
     ((cla . "None required")
      (dco . "Sign-off recommended")
      (first-time . "Good first issues labeled")))))

;;; End of META.scm
