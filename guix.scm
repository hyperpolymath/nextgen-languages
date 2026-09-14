;; SPDX-License-Identifier: MPL-2.0
;; Copyright (c) 2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
;; Coordinator maintenance environment; language toolchains belong to their repos.
;; Usage: guix shell -m guix.scm -- bash hooks/validate-language-registry.sh
(use-modules (guix profiles))

(specifications->manifest
 '("bash" "git-minimal" "coreutils" "findutils" "grep" "gawk" "sed"
   "diffutils" "julia"))
