;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; ECOSYSTEM.scm — nextgen-languages

(ecosystem
  (version "1.0.0")
  (name "nextgen-languages")
  (type "project")
  (purpose "*Experimental programming language projects*")

  (position-in-ecosystem
    "Part of hyperpolymath ecosystem. Follows RSR guidelines.")

  (related-projects
    (project (name "rhodium-standard-repositories")
             (url "https://github.com/hyperpolymath/rhodium-standard-repositories")
             (relationship "standard")))

  (what-this-is "*Experimental programming language projects*")
  (what-this-is-not "- NOT exempt from RSR compliance"))
