;; SPDX-License-Identifier: PMPL-1.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

;;; PLAYBOOK.scm — Operational Playbook for Development
;;; nextgen-languages
;;; Reference: https://github.com/hyperpolymath/nextgen-languages

(define-module (nextgen-languages playbook)
  #:export (workflows
            runbooks
            checklists
            templates))

;;;============================================================================
;;; WORKFLOWS
;;; Standard development workflows
;;;============================================================================

(define workflows
  '((new-language
     ((description . "Adding a new language to the ecosystem")
      (steps
       ((1 . "Create repository from template-repo")
        (2 . "Add to .gitmodules in nextgen-languages")
        (3 . "Add entry to LANGUAGES.scm")
        (4 . "Create README in languages/ directory")
        (5 . "Add to MANIFEST.md")
        (6 . "Update ECOSYSTEM.scm satellites")
        (7 . "Create wiki page stub")
        (8 . "Add playground if applicable")))))

    (new-feature
     ((description . "Adding a feature to an existing language")
      (steps
       ((1 . "Create feature branch: feature/<language>-<feature>")
        (2 . "Implement with tests")
        (3 . "Update language documentation")
        (4 . "Create PR with conventional commit message")
        (5 . "Await review and CI pass")
        (6 . "Merge and update STATE.scm if significant")))))

    (release
     ((description . "Releasing a new version")
      (steps
       ((1 . "Ensure all tests pass")
        (2 . "Update CHANGELOG.md")
        (3 . "Bump version in Cargo.toml/deno.json")
        (4 . "Create git tag: v<major>.<minor>.<patch>")
        (5 . "Push tag to trigger release workflow")
        (6 . "Verify release artifacts")
        (7 . "Update STATE.scm with release info")))))

    (sync-from-gitlab
     ((description . "Syncing a repo from GitLab to GitHub")
      (steps
       ((1 . "Clone from GitLab: git clone git@gitlab.com:maa-framework/...")
        (2 . "Add GitHub remote: git remote add github git@github.com:hyperpolymath/...")
        (3 . "Review commit history for sensitive data")
        (4 . "Push to GitHub: git push github main")
        (5 . "Update MIGRATION-STATUS.md")
        (6 . "Update submodule reference if needed")
        (7 . "Set up mirror workflow")))))))

;;;============================================================================
;;; RUNBOOKS
;;; Operational procedures for common tasks
;;;============================================================================

(define runbooks
  '((submodule-update
     ((description . "Updating all submodules to latest")
      (commands
       ("git submodule update --init --recursive"
        "git submodule foreach git pull origin main"
        "git add -A && git commit -m 'chore: update submodules'"))))

    (add-satellite
     ((description . "Adding a new satellite repository")
      (commands
       ("git submodule add <url> <path>"
        "git commit -m 'feat: add <name> as satellite'"))
      (post-actions
       ("Update ECOSYSTEM.scm"
        "Update MANIFEST.md"
        "Update README.adoc if language"))))

    (verify-links
     ((description . "Check for broken links in documentation")
      (commands
       ("grep -r '\\[.*\\](.*)'  wiki/ | grep -v '#'"
        "# Verify each external URL is accessible"
        "# Check wiki links have corresponding files"))))

    (run-language
     ((description . "Running each language")
      (commands
       ((rust . "cargo run")
        (racket . "racket main.rkt")
        (elixir . "mix run")
        (ocaml . "dune exec")
        (scheme . "guile main.scm")))))))

;;;============================================================================
;;; CHECKLISTS
;;; Verification checklists for quality gates
;;;============================================================================

(define checklists
  '((pr-review
     ((items
       ("[ ] Code follows style guide"
        "[ ] Tests added/updated"
        "[ ] Documentation updated"
        "[ ] No security vulnerabilities introduced"
        "[ ] SPDX headers present"
        "[ ] Conventional commit message"
        "[ ] CI passes"))))

    (language-readiness
     ((items
       ("[ ] Lexer complete"
        "[ ] Parser complete"
        "[ ] Type checker (if applicable)"
        "[ ] Interpreter or compiler working"
        "[ ] REPL functional"
        "[ ] Core stdlib implemented"
        "[ ] Documentation in wiki"
        "[ ] Examples in playground"
        "[ ] README with invariant"))))

    (release-ready
     ((items
       ("[ ] All tests pass"
        "[ ] CHANGELOG updated"
        "[ ] Version bumped"
        "[ ] No TODO/FIXME in critical paths"
        "[ ] Documentation current"
        "[ ] Migration guide if breaking"))))

    (repo-hygiene
     ((items
       ("[ ] SPDX license headers on all files"
        "[ ] No secrets in code"
        "[ ] .gitignore appropriate"
        "[ ] CI/CD configured"
        "[ ] README exists and current"
        "[ ] LANGUAGES.scm entry (if language)"))))))

;;;============================================================================
;;; TEMPLATES
;;; Templates for common files
;;;============================================================================

(define templates
  '((language-readme
     ((format . markdown)
      (sections
       ((title . "# <Language Name>")
        (tagline . "> <One-line description>")
        (invariant . "## Invariant\n\n**<Core principle>**")
        (example . "## Example\n\n```<lang>\n<code>\n```")
        (run . "## Run\n\n```bash\n<command>\n```")
        (status . "## Status\n\n<emoji> <STATUS>")))))

    (wiki-page
     ((format . markdown)
      (sections
       ((title . "# <Page Title>")
        (overview . "## Overview\n\n<Brief description>")
        (content . "## <Main Section>\n\n<Content>")
        (examples . "## Examples\n\n<Code examples>")
        (see-also . "## See Also\n\n- [[Related Page]]")))))

    (scm-file
     ((format . guile-scheme)
      (sections
       ((header . ";; SPDX-License-Identifier: AGPL-3.0-or-later\n;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell")
        (docstring . ";;; <FILENAME>.scm — <Description>")
        (module . "(define-module (nextgen-languages <name>)\n  #:export (<exports>))")
        (sections . ";;;===...\n;;; SECTION NAME\n;;;===...")))))))

;;; End of PLAYBOOK.scm
