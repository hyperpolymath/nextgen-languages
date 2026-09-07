;; SPDX-License-Identifier: MPL-2.0
;; Coordinator guard environment: no language implementations are packaged here.
;; Run: guix shell -m manifest.scm -- bash hooks/validate-language-registry.sh
(use-modules (gnu packages))

(specifications->manifest
 '("bash" "coreutils" "diffutils" "findutils" "gawk" "git" "grep" "sed"))
