<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Ephapax

> Once-only evaluation with linear semantics.

## Invariant

**Every value can be consumed exactly once—enforced statically.**

## Example

```scheme
(define token (create-one-time-token secret))

(consume token verification-service)
;; token is now invalid - cannot be reused

;; This would be a compile error:
;; (consume token another-service)
```

## Run

```bash
# Implementation-specific - TBD
```

## Status

🟡 TO VERIFY - Check sync with GitLab
