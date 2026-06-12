<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# betlang

> Probabilistic programming for sampling and inference.

## Invariant

**All uncertainty must be explicitly modeled—no hidden randomness.**

## Example

```racket
(define coin (bernoulli 0.5))
(define outcome (if coin 'heads 'tails))
(observe (= outcome 'heads))
(sample coin)
```

## Run

```bash
racket main.rkt
```

## Status

🟡 TO VERIFY - Check sync with GitLab
